/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.DateGenerator;
import ict.bean.BundleSetBean;
import ict.bean.ComicTypeBean;
import ict.bean.ComicWorks;
import ict.bean.Product;
import ict.bean.contractBean;
import ict.bean.episodes;
import ict.bean.meetingRequestBean;
import ict.db.BundleSetDB;
import ict.db.ComicTypeDB;
import ict.db.ComicWorksDB;
import ict.db.OrderDB;
import ict.db.ProductDB;
import ict.db.comicListDB;
import ict.db.contentDB;
import ict.db.contract;
import ict.db.episode;
import ict.db.meetingRequestDB;
import ict.imageTranslator;
import ict.pdf_Generator;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.ListIterator;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author law
 */
@MultipartConfig
@WebServlet(name = "ProductController", urlPatterns = {"/ProductController"})
public class ProductController extends HttpServlet {

    public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {

        try {
            productController(req, res);
        } catch (JSONException ex) {
            Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {

        try {
            createNewBook(req, res);
        } catch (JSONException ex) {
            Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (FileUploadException ex) {
            Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void createNewBook(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException, JSONException, FileUploadException, SQLException, ParseException {
        List<FileItem> list = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(req);
        int index = list.size() - 1;
        String operation = list.get(index).getString();

        if (operation.equals("createBundle")) {
            createBundle(list, req);
        } else if (operation.equals("createEpisode")) {
            createEpisodeProduct(list, req);
        }

    }

    public void createEpisodeProduct(List<FileItem> list, HttpServletRequest req) throws IOException, SQLException, ParseException {
        List<FileItem> a = list;
        String cid = list.get(0).getString();
        int ep = toInt(list.get(1).getString());
        int point = toInt(list.get(2).getString());
        String date = list.get(5).getString();
        boolean isNull = Boolean.valueOf(list.get(6).getString());
        String eid = null;
        boolean createEvent = false;
        InputStream in = null;
        Timestamp end = null;
        ProductDB pd = new ProductDB();
        String pid = pd.getNextIndex("e");
        String Public = "T";
        System.out.print(isNull);
        if (isNull) {
            in = list.get(3).getInputStream();
            new episode().UpdateEpisodeCover(cid, ep, in);
        }

        if (!date.equals("")) {
            SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            java.util.Date b = (java.util.Date) s.parse(list.get(5).getString());
            System.out.println("The time is " + b.getTime());
            end = new Timestamp(b.getTime());
            createEvent = true;
            eid = pd.getEvent_Id();

        }

        pd.insertEpisodeProduct(pid, cid, ep, point, end, Public, eid);
        if (createEvent) {
            pd.createEvent(eid, end, pid, "F");
        }

    }

    public int toInt(String i) {
        return Integer.valueOf(i);
    }

    public void createBundle(List<FileItem> list, HttpServletRequest req) throws IOException, SQLException {
        List<FileItem> a = list;
        System.out.print("it;s called");

        String name = list.get(0).getString();
        String point = list.get(1).getString();
        InputStream in = list.get(2).getInputStream();
        String ME = list.get(3).getString();
        System.out.print(ME);
        String str = list.get(4).getString();
        String version = list.get(5).getString();
        String[] code = str.split(",");

        ArrayList<InputStream> sl = new ArrayList<InputStream>();

        for (String i : code) {
            String[] sub = i.split("-");
            String cid = sub[0];
            int si = Integer.valueOf(sub[1]);
            InputStream episode = new episode().getEpisodesById_Ep(cid, si);
            sl.add(episode);
        }

        byte[] ins = new pdf_Generator().combineResources(sl);

        BundleSetDB bs = new BundleSetDB();
        int nextId = new BundleSetDB().getMaxBid() + 1;
        bs.insertNewBundleBook(String.valueOf(nextId), name, ME, version, "Electric", in, ins);

        for (String i : code) {
            String[] sub = i.split("-");
            String cid = sub[0];
            int si = Integer.valueOf(sub[1]);
            new contentDB().innsertNewContent(String.valueOf(nextId), cid, si);
        }
        ProductDB pdb = new ProductDB();
        String pid = pdb.getNextIndex("e");
        pdb.insertElectricBundle(pid, String.valueOf(nextId), Integer.valueOf(point), new Timestamp(System.currentTimeMillis()), "T");

    }

    public void productController(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException, JSONException {
        String operation = req.getParameter("operation");
        if (operation.equals("invokeIndex")) {
            invokeElement(req, res);
        } else if (operation.equals("addNewType")) {
            addNewType(req, res);
        } else if (operation.equals("Recent Update")) {
            getNewReleaseEpisode(req, res);
        } else if (operation.equals("New Serialization")) {
            getSerialization(req, res);
        } else if (operation.equals("getFirst8Seri")) {
            getFirst8Seri(req, res);

        } else if (operation.equals("searchBook")) {
            SearchingProduct(req, res);
        } else if (operation.equals("getTopRank")) {
            getTop(req, res);
        } else if (operation.equals("getType")) {
            get_EProduct_ByType(req, res);
        } else if (operation.equals("showProductList")) {
            getProductBySchedule(req, res);
        } else if (operation.equals("showAllEpisode")) {
            getEpisodeByComicName(req, res);
        } else if (operation.equals("showAllRealistic")) {
            getRealistic(req, res);
        }else if(operation.equals("showBundle")){
            getBundleSources(req,res);
        }

    }
    
    
    
    
    
    
    
    
    
    public void getBundleSources(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException, JSONException {
        JSONArray  jr = new JSONArray();
        String bid =req.getParameter("bid");
        BundleSetBean bs = new BundleSetDB().getBundleById(bid).getList().get(0);
        jr.put(bs.getName());
        jr.put(bs.getType());
        jr.put(new imageTranslator().genImage(bs.getCoverPage()));        
        sendJSon(res, jr);
        
          
    }

    public void getRealistic(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException, JSONException {
        Product s = new ProductDB().showAllBundleProduct();
        JSONArray jr = new JSONArray();
        for (Product i : s.getProductList()) {
            JSONObject jb = realisticRow(i);
            String bid = i.getBid();
            BundleSetBean bs = new BundleSetDB().getBundleById(bid).getList().get(0);
            jb.put("cover", new imageTranslator().genImage(bs.getCoverPage()));
            jb.put("name", bs.getName());
            jb.put("desc", bs.getDescription());
            jb.put("type", bs.getType());
            jr.put(jb);

        }

        sendJSon(res, jr);

    }

    public JSONObject realisticRow(Product m) throws JSONException {
        JSONObject jb = new JSONObject();
        jb.put("pid", m.getProduct_id());
        jb.put("bid", m.getBid());
        jb.put("stock", m.getStock());
        jb.put("price", m.getPrice());
        jb.put("Public", m.getPublic());

        jb.put("issue", new DateGenerator().formatDate(m.getsDate(),"dd.MM.YYYY"));

        return jb;
    }

    public void getEpisodeByComicName(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException, JSONException {
        JSONArray jr = new JSONArray();
        ArrayList<String> x = new ArrayList<String>();
        String key = req.getParameter("key");

        for (ComicWorks i : new ComicWorksDB().getComicInfo().getComicList()) {

            if (key.equals(i.getCid()) || key.equals(i.getName())) {
                x.add(i.getCid());
            }
        }
        System.out.print(x.size());

        for (String cid : x) {

            ComicWorks cw = new ComicWorksDB().getComicbyId(cid);
            for (episodes s : new episode().getEpisodeByComicId(cid).getEpisodeByArr()) {
                JSONObject jb = new JSONObject();
                System.out.print("The ep is" + s.getEp());
                jb.put("penName", cw.getPenName());
                jb.put("name", cw.getName());
                jb.put("cid", cw.getCid());
                jb.put("ep", s.getEp());
                jb.put("title", s.getTitle());
                jb.put("cover", new imageTranslator().genImage(s.getCover()));
                jr.put(jb);
            }
        }

        sendJSon(res, jr);

    }

    public void getProductBySchedule(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException, JSONException {
        JSONArray jr = new JSONArray();
        String[] dateSet = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Monthly"};
        for (String date : dateSet) {
            ArrayList<String> ms = new ProductDB().getProductUpdateSchedule(date);

            if (ms.size() > 0) {
                JSONObject jb = new JSONObject();
                JSONArray wkList = new JSONArray();
                jb.put("period", date);

                for (String s : ms) {
                    JSONObject comic = new JSONObject();
                    ComicWorks cw = new ComicWorksDB().getComicbyId(s);
                    comic.put("cid", cw.getCid());
                    comic.put("name", cw.getName());
                    comic.put("image", new imageTranslator().genImage(cw.getCoverPage()));
                    wkList.put(comic);
                }
                jb.put("comic", wkList);

                jr.put(jb);
            }

        }
        System.out.print(jr);

        sendJSon(res, jr);

    }

    public void get_EProduct_ByType(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException, JSONException {

        JSONArray jr = new JSONArray();
        ComicTypeBean sa = new ComicTypeDB().getComicType();

        for (ComicTypeBean s : sa.getTlist()) {
            JSONObject d = new JSONObject();
            d.put("type", s.getComicType());
            d.put("image", new imageTranslator().genImage(s.getCover()));
            jr.put(d);

        }
        sendJSon(res, jr);

    }

    public void getTop(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException, JSONException {
        String comicType = req.getParameter("rankComic");
        JSONArray jr = new JSONArray();
        comicType = comicType.substring(4);
        System.out.print(comicType);
        ArrayList<TopRanker> tr = SortTopRank();
        for (TopRanker ele : tr) {
            String comicId = ele.getComicId();
            ComicWorks mc = new ComicWorksDB().getComicbyId(comicId);
            ict.bean.ComicTypeBean ct = new ict.db.ComicTypeDB().getAllComicInfoById(comicId);
            System.out.println("Comic id" + " : " + comicId);
            for (ComicTypeBean cs : ct.getTlist()) {
                if (cs.getComicType().equals(comicType)) {
                    jr.put(readBookSearch_JS(mc));

                }
            }

        }

        sendJSon(res, jr);

    }

    public void SearchingProduct(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException, JSONException {
        String sources = req.getParameter("data");
        JSONArray jr = null;
        JSONObject jb = new JSONObject(sources);
        String fieldName = jb.getString("mainField");
        ArrayList<String> comicTypeList = getTypeList((JSONArray) jb.get("comicTypeList"));
        String bundle = jb.getString("bundle");
        JSONObject jb1 = (JSONObject) jb.get("buttonList");
        String year = jb.getString("year");
        String timeslot = jb.getString("timeslot");
        HashMap<String, String> btnSet = getBtnSet((JSONObject) jb.get("buttonList"));
        System.out.print(fieldName);
        System.out.print(timeslot);

        if (fieldName.equals("comicType")) {
            jr = ComicTypeSet(comicTypeList, year, timeslot, btnSet);

        } else if (fieldName.equals("TopRank")) {
            jr = TopRankSet(comicTypeList, year, timeslot, btnSet);
        } else if (fieldName.equals("Recent")) {
            jr = RecentSet(comicTypeList, year, timeslot, btnSet);

        } else if (fieldName.equals("Serialize")) {
            jr = SeriSet(comicTypeList, year, timeslot, btnSet);
        } else if (fieldName.equals("timeslot")) {
            jr = timeslotSet(comicTypeList, year, timeslot, btnSet);

        }else if(fieldName.equals("bundle"))
            jr =  getBundle(comicTypeList, year, timeslot, btnSet);

        sendJSon(res, jr);
    }
    
    
    public  JSONArray getBundle(ArrayList<String> cL, String year, String timeslot, HashMap<String, String> btnSet) throws JSONException, IOException {
           JSONArray jr = new JSONArray();   
           ProductDB pd =  new ProductDB();
           ArrayList<String>  sa = new   ArrayList<String>();
            
            for(Product i :pd.getAll_E_Bundle().getProductList()){
                       String bid = i.getBid();
                if(sa.contains(bid))
                    continue ;
               sa.add(bid);
               BundleSetBean  cv =  new  BundleSetDB().getBundleById(bid).getList().get(0);
               JSONObject jb = new JSONObject();
               jb.put("BookName", cv.getName());
               jb.put("date",i.getsDate());
               jb.put("pid",i.getProduct_id());
               jb.put("image",new imageTranslator().genImage(cv.getCoverPage()));
               jb.put("bid", bid);
               jr.put(jb);
                                       
            }
        
    
            System.out.println(jr.length());
    
    
            return jr;
    }

    public JSONArray timeslotSet(ArrayList<String> cL, String year, String timeslot, HashMap<String, String> btnSet) throws JSONException, IOException {
        JSONArray jr = new JSONArray();
        JSONArray ds = new JSONArray();

        if (btnSet.get("Serialize").equals("true")) {
            toSeri(jr);

        } else if (btnSet.get("TopRank").equals("true")) {
            toRank(jr);
        }
        ds = remaker(jr, timeslot);
        return ds;

    }

    public JSONArray remaker(JSONArray jr, String timeslot) throws JSONException {
        JSONArray ds = new JSONArray();
        for (int s = 0; s < jr.length(); s++) {
            JSONObject jb = (JSONObject) jr.get(s);
            String ComicId = jb.getString("cid");
            ComicWorks cm = new ComicWorks().getComicById(ComicId);
            if (cm.getSchedule().equals(timeslot)) {
                ds.put(jr.get(s));
            }

        }
        return ds;

    }

    public JSONArray SeriSet(ArrayList<String> cL, String year, String timeslot, HashMap<String, String> btnSet) throws JSONException, IOException {
        JSONArray jr = new JSONArray();
        if (btnSet.get("comicType").equals("true")) {
            Recent_ComicTypeSet(cL, jr);

        } else {
            toSeri(jr);

        }
        return jr;

    }

    public JSONArray RecentSet(ArrayList<String> cL, String year, String timeslot, HashMap<String, String> btnSet) throws JSONException, IOException {
        JSONArray jr = new JSONArray();
        if (btnSet.get("comicType").equals("true")) {
            Recent_ComicTypeSet(cL, jr);
        } else {
            toRecent(jr);
        }

        return jr;
    }

    public void toRecent(JSONArray jr) throws JSONException, IOException {
        ArrayList<String> dup = new ArrayList<String>();
        for (Product sa : new ProductDB().getNewReleaseProduct().getProductList()) {
            String cid = sa.getComic_id();
            if (dup.contains(cid)) {
                continue;
            }
            dup.add(cid);
            ComicWorks cm = new ComicWorksDB().getComicbyId(cid);
            jr.put(readBookSearch_JS(cm));
        }
    }

    public void toRank(JSONArray jr) throws JSONException, IOException {
        ArrayList<TopRanker> sales = SortTopRank();
        for (int s = 0; s < sales.size(); s++) {
            ComicWorks cm = new ComicWorksDB().getComicbyId(sales.get(s).getComicId());
            jr.put(readBookSearch_JS(cm));
        }

    }

    public void toSeri(JSONArray jr) throws JSONException, IOException {
        for (String comicId : new ProductDB().sortComicBySignDate()) {
            ComicWorks cm = new ComicWorksDB().getComicbyId(comicId);
            jr.put(readBookSearch_JS(cm));
        }
    }

    public ArrayList SortTopRank() throws JSONException, IOException {
        JSONArray jr = new JSONArray();
        ArrayList<TopRanker> sales = new ArrayList<TopRanker>();
        for (String p : new ProductDB().getAllProductComic("T")) {
            String comicId = p;
            int salesAmount = new OrderDB().getProdctSalesAmountById(comicId);
            sales.add(new TopRanker(comicId, salesAmount));
        }

        Collections.sort(sales, new Comparator<TopRanker>() {
            public int compare(TopRanker f, TopRanker s) {
                return s.getSales() - f.getSales();
            }
        });

        return sales;

    }

    public JSONArray TopRankSet(ArrayList<String> cL, String year, String timeslot, HashMap<String, String> btnSet) throws JSONException, IOException {
        JSONArray jr = new JSONArray();

        if (btnSet.get("comicType").equals("true")) {
            topRank_ComicType(cL, jr);

        } else {
            toRank(jr);

        }
        return jr;
    }

    public JSONArray ComicTypeSet(ArrayList<String> cL, String year, String timeslot, HashMap<String, String> btnSet) throws JSONException, IOException {
        JSONArray jr = new JSONArray();
        if (cL.size() == 0) {
            if (btnSet.get("Recent").equals("true")) {
                toRecent(jr);
            } else if (btnSet.get("TopRank").equals("true")) {
                toRank(jr);
            } else if (btnSet.get("Serialize").equals("true")) {
                toSeri(jr);
            }

        } else if (btnSet.get("Serialize").equals("true")) {
            for (String comicId : new ProductDB().sortComicBySignDate()) {
                if (checking(comicId, cL)) {
                    jr.put(readBookSearch_JS(new ComicWorksDB().getComicbyId(comicId)));
                }
            }
        } else if (btnSet.get("TopRank").equals("true")) {
            topRank_ComicType(cL, jr);
        } else if (btnSet.get("Recent").equals("true")) {
            Recent_ComicTypeSet(cL, jr);

        }
        return jr;

    }

    public boolean checking(String comicId, ArrayList<String> cL) {
        ArrayList<ComicTypeBean> ct = new ComicTypeDB().getAllComicInfoById(comicId).getTlist();
        for (ComicTypeBean sa : ct) {
            System.out.print("comicId: " + comicId + ": " + sa.getComicType() + " tid " + sa.getTid());
            if (cL.contains(sa.getTid())) {
                return true;
            }

        }

        return false;

    }

    public ArrayList<String> getTypeList(JSONArray sa) throws JSONException {
        ArrayList<String> comicTypeList = new ArrayList<String>();
        for (int s = 0; s < sa.length(); s++) {
            comicTypeList.add(sa.get(s).toString());
        }
        return comicTypeList;
    }

    public HashMap<String, String> getBtnSet(JSONObject jb1) throws JSONException {
        HashMap<String, String> btnSet = new HashMap<String, String>();
        btnSet.put("Serialize", String.valueOf(jb1.get("Serialize")));
        btnSet.put("TopRank", String.valueOf(jb1.get("TopRank")));
        btnSet.put("Recent", String.valueOf(jb1.get("Recent")));
        btnSet.put("Recommand", String.valueOf(jb1.get("Recommand")));
        btnSet.put("comicType", String.valueOf(jb1.get("comicType")));
        btnSet.put("bundle", String.valueOf(jb1.get("bundle")));
        return btnSet;

    }

    public void Seri_ComicType(ArrayList<String> cL, JSONArray jr) throws JSONException, IOException {

        for (String comicId : new ProductDB().sortComicBySignDate()) {
            ComicWorks cm = new ComicWorksDB().getComicbyId(comicId);
            if (checking(comicId, cL)) {
                jr.put(readBookSearch_JS(cm));
            }
        }

    }

    public void topRank_ComicType(ArrayList<String> cL, JSONArray jr) throws JSONException, IOException {
        ArrayList<TopRanker> sales = SortTopRank();
        for (int s = 0; s < sales.size(); s++) {
            String comicId = sales.get(s).getComicId();
            if (checking(comicId, cL)) {
                ComicWorks cm = new ComicWorksDB().getComicbyId(comicId);
                jr.put(readBookSearch_JS(cm));
            }

        }

    }

    public void Recent_ComicTypeSet(ArrayList<String> cL, JSONArray jr) throws JSONException, JSONException, IOException {
        ArrayList<String> dup = new ArrayList<String>();
        for (Product sa : new ProductDB().getNewReleaseProduct().getProductList()) {
            String cid = sa.getComic_id();
            if (dup.contains(cid)) {
                continue;
            }
            dup.add(cid);
        }
        for (int s = 0; s < dup.size(); s++) {

            if (checking(dup.get(s), cL)) {
                ComicWorks cm = new ComicWorksDB().getComicbyId(dup.get(s));
                jr.put(readBookSearch_JS(cm));
            }

        }

    }

    public void getFirst8Seri(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException, JSONException {
        JSONArray jr = new JSONArray();
        ArrayList<String> comicList = new ProductDB().sortComicBySignDate();
        for (int s = 0; s < comicList.size(); s++) {
            JSONObject jb = null;
            if (s < 8) {
                ComicWorks cm = new ComicWorksDB().getComicbyId(comicList.get(s));
                jb = readBookSearch_JS(cm);
                if (jb != null) {
                    jr.put(jb);
                }
            }

        }
        sendJSon(res, jr);

    }

    /// serualizyion
    public void getSerialization(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException, JSONException {
        JSONArray jr = new JSONArray();
        for (String comicId : new ProductDB().sortComicBySignDate()) {
            ComicWorks cm = new ComicWorksDB().getComicbyId(comicId);
            JSONObject jb = readBookSearch_JS(cm);
            if (jb != null) {
                jr.put(jb);
            }
        }
        sendJSon(res, jr);

    }

    public JSONObject readBookSearch_JS(ComicWorks comic) throws JSONException, IOException {

        JSONObject jb = new JSONObject();
        ComicWorks cm = comic;
        contractBean con = null;
        if (!cm.getStatus().equals("Serialize")) {
            return null;
        }
        con = new contract().getContractByComicId(cm.getCid()).getContract().get(0);
        jb.put("ComicName", cm.getName());
        jb.put("image", new imageTranslator().genImage(cm.getCoverPage()));
        jb.put("cid", cm.getCid());
        jb.put("penName", cm.getPenName());
        jb.put("SerDate", cm.getSchedule());
        jb.put("date", con.getSignDate());

        return jb;
    }

    public void addNewType(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException, JSONException {
        JSONArray jr = new JSONArray();
        int next = new comicListDB().getNextId();
        String newType = req.getParameter("newType");
        new comicListDB().addNewType(next, newType);
        JSONObject sa = new JSONObject();
        sa.put("tid", next);
        sa.put("name", newType);
        jr.put(sa);
        sendJSon(res, jr);

    }

    public void invokeElement(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException, JSONException {
        String field = req.getParameter("field");
        if (field.equals("getNewRelease")) {
            getNewReleaseEpisode(req, res);
        }
    }

    public JSONArray returnComicTypeArray(String cid) {
        JSONArray jr = new JSONArray();

        for (ComicTypeBean cb : new ComicTypeDB().getAllComicInfoById(cid).getTlist()) {
            jr.put(cb.getComicType());
        }

        return jr;
    }

    //////New Serailization : daily Update
    public void getNewReleaseEpisode(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException, JSONException {
        ArrayList<String> dup = new ArrayList<String>();
        JSONArray jr = new JSONArray();
        for (Product sa : new ProductDB().getNewReleaseProduct().getProductList()) {
            String cid = sa.getComic_id();
            if (dup.contains(cid)) {
                continue;
            }
            dup.add(cid);
            ComicWorks cm = new ComicWorksDB().getComicbyId(cid);
            episode epList = new episode();

            episodes sources = epList.getDetailsEpisodesById_Ep(cid, sa.getEp());
            JSONObject jb = new JSONObject();
            jb.put("penName", cm.getPenName());
            jb.put("Latest_EpTitle", sources.getTitle());
            jb.put("ComicName", cm.getName());
            jb.put("image", new imageTranslator().genImage(cm.getCoverPage()));
            jb.put("cid", cm.getCid());
            jb.put("date", sa.getsDate());
            jb.put("typeList", returnComicTypeArray(cid));

            jr.put(jb);
        }
        sendJSon(res, jr);

    }

    public void sendJSon(HttpServletResponse res, JSONArray jr) throws IOException {
        res.setContentType("text/plain");
        res.setCharacterEncoding("UTF-8");
        res.getWriter().write(jr.toString());
    }

    public class TopRanker {

        private String comicId;
        private int sales;

        public TopRanker(String comicId, int sales) {
            this.comicId = comicId;
            this.sales = sales;

        }

        public String getComicId() {
            return comicId;
        }

        public void setComicId(String comicId) {
            this.comicId = comicId;
        }

        public int getSales() {
            return sales;
        }

        public void setSales(int sales) {
            this.sales = sales;
        }

    }

}
