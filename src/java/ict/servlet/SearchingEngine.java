/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.DateGenerator;
import ict.EmailConfig;
import ict.bean.Account;
import ict.bean.ComicTypeBean;
import ict.bean.ComicWorks;
import ict.bean.contractBean;
import ict.bean.episodes;
import ict.db.ComicTypeDB;
import ict.db.ComicWorksDB;
import ict.db.OrderDB;
import ict.db.contract;
import ict.db.episode;
import ict.imageTranslator;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author law
 */
@WebServlet(name = "SearchingEngine", urlPatterns = {"/SearchingEngine"})
public class SearchingEngine extends HttpServlet {

    public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            SerchingController(req, res);
        } catch (JSONException ex) {
            Logger.getLogger(SearchingEngine.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void SerchingController(HttpServletRequest req, HttpServletResponse res) throws JSONException, IOException, ServletException {
        String operation = req.getParameter("operation");

        if (operation.equals("epConfig")) {   //for uplpad
            field(req, res);
        } else if (operation.equals("eBookSearch")) {
            init_E_Book_Searching(req, res);
        } else if (operation.equals("createCustomBook") || req.getAttribute("result").equals("createCustomBook")) //for  getRow data from order
        {
            initalCustomBookSearchEngine(req, res);
        }

    }

    public void init_E_Book_Criteria(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, JSONException {
        ///when the penname and  comicName with the same letter with be show the comicName first
        ArrayList<String> Result = new ArrayList<String>();
        String key = req.getParameter("keyWords");
        HttpSession sa = req.getSession();
        JSONArray jr = new JSONArray();
        ComicWorks cm = (sa.getAttribute("hasSearched") != null)
                ? (ComicWorks) sa.getAttribute("hasSearched")
                : new ComicWorksDB().getComicInfo();
        if (sa.getAttribute("hasSearched") == null) {
            req.getSession().setAttribute("hasSearched", cm);
        }
        for (ComicWorks cms : cm.getComicList()) {
            String penName = cms.getPenName();
            String cmName = cms.getName();
            String output = "";

            if (keywordsMatched(key, penName).equals(penName) || keywordsMatched(key, cmName).equals(cmName)) {
                if (keywordsMatched(key, penName).equals(penName)) {
                    Result.add(penName);
                }

                if (keywordsMatched(key, cmName).equals(cmName)) {
                    Result.add(cmName);
                }
            }
        }

        for (String s : fillter(Result)) {
            jr.put(s);
        }

        sendJSon(res, jr);
    }

    public ArrayList<String> fillter(ArrayList<String> list) {
//            ArrayList<String> sk  = new ArrayList<String>();
        for (int s = 0; s < list.size(); s++) {
            if (Collections.frequency(list, list.get(s)) > 1) {
                list.remove(list.get(s));
            }

        }
        Collections.sort(list);
        return list;
    }

    public String keywordsMatched(String key, String main) {

        Pattern p = Pattern.compile("^" + key, Pattern.CASE_INSENSITIVE | Pattern.COMMENTS); /// user Input
        Matcher m = p.matcher(main);      // row data
        boolean matchFound = m.find();
        return (matchFound) ? main : "";

    }

    public void init_E_Book_Searching(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, JSONException {
        String stage = req.getParameter("stage");

        if (stage.equals("searched")) {
            displayResult(req, res);
        } else {
            init_E_Book_Criteria(req, res);
        }

    }

    public void initalCustomBookSearchEngine(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, JSONException {

        HttpSession session = req.getSession();
        String comic_id = req.getParameter("cid");
        Account member = (Account) req.getSession().getAttribute("member");
        Account admin = (Account) req.getSession().getAttribute("admin");
        Account editor = (Account) req.getSession().getAttribute("editor");
        Account staff = (Account) req.getSession().getAttribute("staff");
        String user = "";
        if (member != null) {
            user = member.geteAddress();
        } else if (admin != null) {
            user = admin.geteAddress();
        } else if (editor != null) {
            user = editor.geteAddress();
        } else if (staff != null) {
            user = staff.geteAddress();
        }
        int epNo = Integer.valueOf(req.getParameter("ep"));
        episodes epSelected = new OrderDB().getEpisodeOrder("approve", user, comic_id, epNo);
        String key = comic_id + "-" + epNo + "-Copy";
        if (session.getAttribute(key) != null) {
            getComicResources(req, res, comic_id, epNo, key);
        } else {
            initComic(req, res, comic_id, epNo);
        }

    }

    public void displayResult(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, JSONException {
        req.getSession().removeAttribute("hasSearched");
        JSONArray jr = new JSONArray();
        String key = req.getParameter("key");
        ComicWorks result = null;
        for (ComicWorks sa : new ComicWorksDB().getComicInfo().getComicList()) {
            if (sa.getName().equals(key) || sa.getPenName().equals(key)) {
                JSONObject jb = new JSONObject();
                jb.put("cover", new imageTranslator().genImage(sa.getCoverPage()));
                jb.put("name", sa.getName());
                jb.put("penName", sa.getPenName());
                jb.put("cid", sa.getCid());
                jr.put(jb);
            }
        }

        RequestDispatcher sender = req.getRequestDispatcher("clientResult.jsp");
        req.setAttribute("jsonResult", jr);
        req.setAttribute("key", key);
        sender.forward(req, res);
//             System.out.print();
//             sendJSon(res, jr);             
    }

    public void getComicResources(HttpServletRequest req, HttpServletResponse res, String comic_id, int ep, String key) throws IOException, JSONException {
        ArrayList<String> itemList = (ArrayList<String>) req.getSession().getAttribute(key);
        JSONArray jr = new JSONArray();
        String fullKey = comic_id + "-" + ep;
        JSONArray sourcesCopy = new JSONArray();
        JSONObject page = new JSONObject();
        JSONObject code = new JSONObject();
        JSONObject cName = new JSONObject();
        JSONObject title = new JSONObject();
        for (String img : itemList) {
            sourcesCopy.put(img);
        }
        page.put("sourcesCopy", sourcesCopy);
        code.put("code", fullKey);
        cName.put("comicName", new ComicWorksDB().getComicbyId(comic_id).getName());
        title.put("title", new episode().getDetailsEpisodesById_Ep(comic_id, ep).getTitle());
        jr.put(page);
        jr.put(code);
        jr.put(cName);
        jr.put(title);
        sendJSon(res, jr);
    }

    public void initComic(HttpServletRequest req, HttpServletResponse res, String comic_id, int ep) throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("/createState");
        req.setAttribute("operation", "initComic");
        req.setAttribute("selectedEpisode", new episode().getDetailsEpisodesById_Ep(comic_id, ep));
        req.setAttribute("Des", req.getServletPath());
        req.setAttribute("result", "createCustomBook");
//        req.setAttribute("response", ep);
//        System.out.print());
        dispatcher.forward(req, res);

    }

    public void field(HttpServletRequest req, HttpServletResponse res) throws JSONException, IOException {
        String field = req.getParameter("field");
        if (field.equals("getYear")) {
            getContractYear(res);
        } else if (field.equals("getAuthor")) {
            getAuthorName(res);
        } else if (field.equals("getComicWorks")) {
            getComicField(res);
        } else if (field.equals("getComicType")) {
            getComicTypeField(res);
        } else if (field.equals("getAuthorByYear")) ////new  for find authorName
        {
            getAuthorNameByYear(res, req);
        } else if (field.equals("getComicByAuthor")) //// new 
        {
            getComicNameByAuthor(res, req);
        } else if (field.equals("getSearchingResult")) {
            getComicResult_EP(res, req);
        }
    }

    public void sendJSon(HttpServletResponse res, JSONArray jr) throws IOException {
        res.setContentType("text/plain");
        res.setCharacterEncoding("UTF-8");
        res.getWriter().write(jr.toString());
    }

    public void getContractYear(HttpServletResponse res) throws JSONException, IOException {
        JSONArray jr = new JSONArray();
        for (String item : new contract().getContractYear()) {
            System.out.print(item);
            JSONObject jb = new JSONObject();
            jb.put("year", item);
            jr.put(jb);
        }
        sendJSon(res, jr);
    }

    public void getAuthorName(HttpServletResponse res) throws JSONException, IOException {
        JSONArray jr = new JSONArray();
        for (ComicWorks item : new ComicWorksDB().getDistinctAuthor().getComicList()) {
            JSONObject jb = new JSONObject();
            jb.put("Author", item.getPenName());
            jr.put(jb);
        }
        sendJSon(res, jr);
    }

    public void getComicNameByAuthor(HttpServletResponse res, HttpServletRequest req) throws IOException {
        String author = req.getParameter("author");
        String year = req.getParameter("year");
        DateGenerator dg = new DateGenerator();

        JSONArray jr = new JSONArray();
        for (ComicWorks sa : new ComicWorksDB().getComicNameByPenName(author).getComicList()) {
            if (!year.equals("-")) {
                String id = sa.getCid();
                Timestamp s = new contract().getContractByComicId(id).getContract().get(0).getSignDate();
                if (dg.getYear(s) + 1900 == Integer.valueOf(year)) {
                    jr.put(sa.getName());
                }

            } else {
                jr.put(sa.getName());
            }

        }
        sendJSon(res, jr);

    }

    public void getComicField(HttpServletResponse res) throws JSONException, IOException {
        JSONArray jr = new JSONArray();
        for (ComicWorks item : new ComicWorksDB().getComicInfo().getComicList()) {
            System.out.print(item.getName());
            JSONObject jb = new JSONObject();
            jb.put("comic", item.getName());
            jr.put(jb);
        }
        sendJSon(res, jr);
    }

    public void getComicTypeField(HttpServletResponse res) throws JSONException, IOException {
        JSONArray jr = new JSONArray();
        for (ComicTypeBean item : new ComicTypeDB().getComicType().getTlist()) {
            System.out.print(item.getComicType());
            JSONObject jb = new JSONObject();
            jb.put("type", item.getComicType());
            jr.put(jb);
        }
        sendJSon(res, jr);
    }

    public void getAuthorNameByYear(HttpServletResponse res, HttpServletRequest req) throws IOException {
        JSONArray jr = new JSONArray();
        String year = req.getParameter("year");
        System.out.print(year);
        for (ComicWorks sa : new ComicWorksDB().getComicByYear(year).getComicList()) {
            jr.put(sa.getPenName());
            System.out.print(sa.getPenName());
        }

        sendJSon(res, jr);

    }

    public void getComicResult_EP(HttpServletResponse res, HttpServletRequest req) throws JSONException, IOException {

        String comicType = req.getParameter("comicTypes");
        ArrayList<String> typeOption = handleComicType(comicType);

        String year = req.getParameter("year");
        String author = req.getParameter("author");
        String cmw = req.getParameter("comicWorks");
        String targetYear = "";
        String targetAuthor = "";
        String targetType = "";
        String targetComic = "";
//          
        String full_query = "Select Name , cw.Descript ,coverPage ,penName ,penId ,cw.comic_id  ,Schedule ,cw.eAddress "
                + " from contract ct , ComicWorks cw "
                + " where  ct.comic_id   =  cw.comic_id ";

//                    
//
        if (!year.equals("-")) {
            full_query += " And YEAR(`signDate`)  = " + year;
        }
//            
        if (!author.equals("-")) {
            full_query += " And `penName` = '" + author + "' ";
        }
//            
        if (!cmw.equals("-")) {
            full_query += " And `Name` = '" + cmw + "' ";
        }
//            
        String str = "";

        ArrayList<ComicWorks> result = (typeOption.size() > 0) ? filter(full_query, typeOption)
                : new ComicWorksDB().getSearching(full_query).getComicList();

//                  
////                 displayResult(full_query,res);
//        String str = "";
        JSONArray jr = CreateSearchingResult(result);
//                for(String item :comicType)
//                        str+= item;
//                    jr.put(str);     
        sendJSon(res, jr);

    }

    public void displayResult(String query, HttpServletResponse res) throws JSONException, IOException {
        JSONArray jr = new JSONArray();
        for (ComicWorks item : new ComicWorksDB().getSearching(query).getComicList()) {
            JSONObject jb = new JSONObject();
            jb.put("penName", item.getPenName());
            jr.put(jb);
        }
        sendJSon(res, jr);
    }

    public ArrayList<String> handleComicType(String comicJson) throws JSONException {
        JSONObject sa = new JSONObject(comicJson);
        ArrayList<String> typeOption = new ArrayList<String>();
        JSONArray list = sa.getJSONArray("comicType");
        for (int s = 0; s < list.length(); s++) {
            if (!list.get(s).equals("")) {
                typeOption.add("" + list.get(s));
            }
        }
        return typeOption;
    }

    public boolean inScope(String id, ArrayList<String> typeOption) {
        String str = "";
        ArrayList<ComicTypeBean> listItem = new ComicTypeDB().getAllComicTypeById(id).getTlist();
        for (int s = 0; s < listItem.size(); s++) {
            if (typeOption.contains(listItem.get(s).getComicType())) {
                return true;
            }

        }
        return false;
    }

    public ArrayList<ComicWorks> filter(String full_query, ArrayList<String> typeOption) {
        ArrayList<ComicWorks> comicList = new ComicWorksDB().getSearching(full_query).getComicList();
        ArrayList<ComicWorks> kList = new ArrayList<ComicWorks>();
        for (ComicWorks comic : comicList) {
            if (inScope(comic.getCid(), typeOption)) {
                kList.add(comic);
            }
        }
        return kList;
    }

    public JSONArray CreateSearchingResult(ArrayList<ComicWorks> result) throws JSONException, IOException {
        JSONArray outside = new JSONArray();

        for (ComicWorks comic : result) {
            JSONArray typeList = new JSONArray();
            JSONObject cm = new JSONObject();
            cm.put("comicName", comic.getName());
            cm.put("penName", comic.getPenName());
            for (ComicTypeBean type : new ComicTypeDB().getAllComicTypeById(comic.getCid()).getTlist()) {
                typeList.put(type.getComicType());
            }
            cm.put("comicTypeMatch", typeList);
            cm.put("coverPage", comic.getBase64CoverPage(comic.getCoverPage()));//
            cm.put("comicId", comic.getCid());
//            cm.put("Desc", comic.getDescription());            
            Timestamp st = new contract().getContractByComicId(comic.getCid()).getContract().get(0).getSignDate();
            cm.put("Date", new DateGenerator().formatDate(st, "dd-MM-yy"));
            outside.put(cm);
        }

        return outside;
    }

}
