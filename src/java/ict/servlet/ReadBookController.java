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
import ict.bean.ContentBean;
import ict.bean.CustomBookBean;
import ict.bean.Product;
import ict.bean.episodes;
import ict.db.BundleSetDB;
import ict.db.ComicTypeDB;
import ict.db.ComicWorksDB;
import ict.db.CustomBook;
import ict.db.ProductDB;
import ict.db.contentDB;
import ict.db.episode;
import ict.imageTranslator;
import ict.pdf_Generator;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name = "ReadBookController", urlPatterns = {"/ReadBookController"})
public class ReadBookController extends HttpServlet {

    public void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {
        try {
            readBookController(req, res);
        } catch (JSONException ex) {
            Logger.getLogger(ReadBookController.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void readBookController(HttpServletRequest req, HttpServletResponse res) throws IOException, JSONException, ServletException {
        String operation = req.getParameter("operation");
        if (operation.equals("init")) {
            getPage(req, res);
        } else if (operation.equals("SelectComic")) {
            showComicWorkDetails(req, res);
        } else if (operation.equals("getComicDetails")) {
            getComicDestailsJSON(req, res);
        } else if (operation.equals("read")) {
            getComicResouces(req, res);
        } else if (operation.equals("SelectBundle")) {
            getBundle(req, res);

        } else if (operation.equals("preView")) {
            previewBundle(req, res);
        } else if (operation.equals("readBundle")) {

            readBundle(req, res);

        } else if (operation.equals("getSources") || req.getAttribute("result").equals("read")) {//get page cookies
            initReadingPage(req, res);
        }

    }

    public void previewBundle(HttpServletRequest req, HttpServletResponse res) throws IOException, JSONException, ServletException {
        String bid = req.getParameter("bid");
        BundleSetBean bb = new BundleSetDB().getBundleById(bid).getList().get(0);

        JSONArray jr = new JSONArray();
        JSONObject jb = new JSONObject();
        JSONArray Final = new JSONArray();
        InputStream in = bb.getPdf();
        byte[] br = new byte[in.available()];
        in.read(br);
        ArrayList<byte[]> i = new pdf_Generator().seperate(br);

        int count = 0;
        for (byte[] s : i) {
            if (count < 3) {
                jr.put(new imageTranslator().genImageWithByte(s));
            }
            count++;
        }

        jb.put("Status", "SessionFounded");
        jb.put("pageNo", "bundle-" + bid);
        jb.put("page", jr);

        Final.put(jb);

        req.getSession().setAttribute("pageSources", Final);
        req.setAttribute("result", "read");
        RequestDispatcher rd = req.getRequestDispatcher("readBookGallery.jsp");
        rd.forward(req, res);

    }

    public void readBundle(HttpServletRequest req, HttpServletResponse res) throws IOException, JSONException, ServletException {
        String bid = req.getParameter("bid");

        BundleSetBean bb = new BundleSetDB().getBundleById(bid).getList().get(0);

        JSONArray jr = new JSONArray();
        JSONObject jb = new JSONObject();
        JSONArray Final = new JSONArray();
        InputStream in = bb.getPdf();
        byte[] br = new byte[in.available()];
        in.read(br);
        ArrayList<byte[]> i = new pdf_Generator().seperate(br);

        int count = 0;
        for (byte[] s : i) {
            jr.put(new imageTranslator().genImageWithByte(s));
            count++;
        }

        jb.put("Status", "SessionFounded");
        jb.put("pageNo", "bundle-" + bid);
        jb.put("page", jr);

        Final.put(jb);

        req.getSession().setAttribute("pageSources", Final);
        req.setAttribute("result", "read");
        RequestDispatcher rd = req.getRequestDispatcher("readBookGallery.jsp");
        rd.forward(req, res);

    }

    public void getBundle(HttpServletRequest req, HttpServletResponse res) throws IOException, JSONException, ServletException {
        JSONArray jr = new JSONArray();
        JSONArray content = new JSONArray();
        JSONObject jb = new JSONObject();

        String bid = req.getParameter("bid");
        System.out.print(bid);
        BundleSetBean bb = new BundleSetDB().getBundleById(bid).getList().get(0);
        System.out.print("it's called");

        Product pd = new ProductDB().getProductWithBid(bid);
        System.out.print(pd.getProduct_id());

        jb.put("cover", new imageTranslator().genImage(bb.getCoverPage()));
        jb.put("date", new DateGenerator().formatDate(pd.getsDate(), "dd.MM.YY"));
        jb.put("name", bb.getName());
        jb.put("type", bb.getType());
        jb.put("point", pd.getPoint());
        jb.put("desc", bb.getDescription());
        jb.put("bid", bb.getBid());
        jb.put("pid", pd.getProduct_id());

        for (ContentBean s : new contentDB().getContentById(bid).getList()) {
            String str = "";
            ComicWorks cw = new ComicWorksDB().getComicbyId(s.getComic_id());
            str += cw.getName() + "-" + cw.getPenName();
            episodes ep = new episode().getDetailsEpisodesById_Ep(cw.getCid(), s.getEp());
            str += "-" + ep.getTitle();
            content.put(str);
        }
        jb.put("content", content);

        jr.put(jb);

        req.setAttribute("json", jr);
        RequestDispatcher sa = req.getRequestDispatcher("BundlePage.jsp");
        sa.forward(req, res);

    }

    public void getComicResouces(HttpServletRequest req, HttpServletResponse res) throws IOException, JSONException, ServletException {
        HttpSession ss = req.getSession();
        String comicId = req.getParameter("comicId");
        String ep = req.getParameter("ep");
        String key = comicId + "-" + ep + "-Copy";
        if (req.getSession().getAttribute(key) != null) {
            getComicSession(req, res, comicId, ep);
        } else {
            getSourcesFromDB(req, res, comicId, ep);
        }

    }

    public void initReadingPage(HttpServletRequest req, HttpServletResponse res) throws IOException {

        JSONArray jr = (JSONArray) req.getSession().getAttribute("pageSources");
        sendJSon(res, jr);

    }

    public void getComicSession(HttpServletRequest req, HttpServletResponse res, String comicId, String ep) throws IOException, JSONException, ServletException {
        String key = comicId + "-" + ep + "-Copy";
        ArrayList<String> comic = (ArrayList<String>) req.getSession().getAttribute(key);
        JSONArray jr = new JSONArray();
        JSONObject jb = new JSONObject();
        JSONArray page = new JSONArray();
        for (String comicPage : comic) {
            page.put(comicPage);
        }
        jb.put("page", page);
        jb.put("Status", "SessionFounded");
        jb.put("pageNo", comic.size());
        jr.put(jb);
//        sendJSon(res,jr);
        req.getSession().setAttribute("pageSources", jr);
        RequestDispatcher re = req.getRequestDispatcher("/readBookGallery.jsp");
        re.forward(req, res);
    }

    public void getSourcesFromDB(HttpServletRequest req, HttpServletResponse res, String comicId, String ep) throws IOException, ServletException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("/createState");
        req.setAttribute("operation", "initComic");
        req.setAttribute("selectedEpisode", new episode().getDetailsEpisodesById_Ep(comicId, Integer.valueOf(ep)));
        req.setAttribute("Des", req.getServletPath());
        req.setAttribute("result", "read");
        dispatcher.forward(req, res);
    }

    public void showComicWorkDetails(HttpServletRequest req, HttpServletResponse res) throws IOException, JSONException, ServletException {
        String comicId = req.getParameter("comicId");
        HttpSession ht = req.getSession();
        JSONArray jr = getComicDetails(req, comicId);
        ht.setAttribute("comic", jr);
        res.sendRedirect(req.getContextPath() + "/selectComicPage.jsp?comicID=" + comicId + "");

    }

    public void getComicDestailsJSON(HttpServletRequest req, HttpServletResponse res) throws IOException {
        HttpSession ht = req.getSession();
        JSONArray jr = (JSONArray) ht.getAttribute("comic");
        sendJSon(res, jr);
    }

    public JSONArray getComicDetails(HttpServletRequest req, String comicId) throws JSONException, IOException {

        ComicWorks s = new ComicWorksDB().getComicbyId(comicId);
        Product p = new ProductDB().getNewUpdateEpisode(comicId);
        JSONArray jr = new JSONArray();
        JSONArray episode = new JSONArray();
        JSONObject jb = new JSONObject();
        jb.put("comicId", s.getCid());
        jb.put("ComicWork", s.getName());
        jb.put("CDesc", s.getDescription());
        jb.put("eAddress", s.geteAddress());
        jb.put("Schedule", s.getSchedule());
        jb.put("coverPage", new imageTranslator().genImage(s.getCoverPage()));
        jb.put("status", s.getStatus());
        jb.put("penName", s.getPenName());
        System.out.println("startDate" + p.getsDate());
        jb.put("latestDate", new DateGenerator().formatDate(p.getsDate(), "dd.MM.YY"));
        jb.put("latestEp", p.getEp());

        jr.put(jb);

        JSONArray typeList = new JSONArray();
        for (ComicTypeBean ct : new ComicTypeDB().getAllComicTypeById(comicId).getTlist()) {
            typeList.put(ct.getComicType());
        }
        jb.put("typeList", typeList);

        //chapter
        for (Product pds : new ProductDB().getAllEpisodeProduct(comicId, "Desc").getProductList()) {
            JSONObject sa = new JSONObject();
            int ep = pds.getEp();
            episodes epi = new episode().getDetailsEpisodesById_Ep(comicId, ep);
            sa.put("pid", pds.getProduct_id());
            sa.put("ep", ep);
            sa.put("point", pds.getPoint());
            sa.put("epTitle", epi.getTitle());
            sa.put("chapterCover", new imageTranslator().genImage(epi.getCover()));
            sa.put("chapterDate", new DateGenerator().formatDate(p.getsDate(), "dd/MM/YYYY"));
            jr.put(sa);
        }

        return jr;

    }

    public void getPage(HttpServletRequest req, HttpServletResponse res) throws IOException {
        int firstPage = parseInt(req.getParameter("pageNum"));
        int incremental = parseInt(req.getParameter("getNumPage"));
        int ep = parseInt(req.getParameter("episode"));
        String comicId = req.getParameter("comic_id");
        InputStream chapter = new episode().getEpisodes(comicId, ep);
        int lastPage = firstPage + incremental;

        JSONArray jr = DoublePageSelect(firstPage, lastPage, comicId, chapter);

        sendJSon(res, jr);

    }

    public JSONArray DoublePageSelect(int first, int last, String comicId, InputStream comic) throws IOException {
        JSONArray jr = new JSONArray();
        imageTranslator it = new imageTranslator();

        ArrayList<byte[]> pageList = new pdf_Generator().getDoublePageByIndex(comic, comicId, first, last);
        for (byte[] page : pageList) {
            jr.put(it.genImageWithByte(page));
        }

        return jr;

    }

    public void sendJSon(HttpServletResponse res, JSONArray jr) throws IOException {
        res.setContentType("text/plain");
        res.setCharacterEncoding("UTF-8");
        res.getWriter().write(jr.toString());
    }

    public int parseInt(String num) {

        return Integer.valueOf(num);
    }

}
