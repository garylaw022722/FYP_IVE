/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.Account;
import ict.bean.ComicTypeBean;
import ict.bean.ComicWorks;
import ict.bean.OrderBean;
import ict.bean.Product;
import ict.bean.episodes;
import ict.bean.userInfo;
import ict.db.AccountDB;
import ict.db.ComicTypeDB;
import ict.db.ComicWorksDB;
import ict.db.OrderDB;
import ict.db.ProductDB;
import ict.db.dbOperation;
import ict.db.episode;
import ict.db.userInformation;
import ict.imageTranslator;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author law
 */
@WebServlet(name = "OrderController", urlPatterns = {"/OrderController"})
public class OrderController extends HttpServlet {

    public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {

        try {
            orderController(req, res);
        } catch (JSONException ex) {
            Logger.getLogger(OrderController.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void orderController(HttpServletRequest req, HttpServletResponse res) throws JSONException, IOException {
        String operation = req.getParameter("operation");
        if (operation.equals("getAllPurchased")) {
            getPurchasedProduct(req, res);
        } else if (operation.equals("getPurchasedChapter")) {
            getPurchasedChapter(req, res);
        } else if (operation.equals("searchBook")) {
            getSearchBook(req, res);
        } else if (operation.equals("purchaseBuyBook")) {
            getPurchase(req, res);
        }

    }

    public void getPurchase(HttpServletRequest req, HttpServletResponse res) throws JSONException, IOException {
        boolean flag = false ;
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
        String msg ="";
        String pid = req.getParameter("pid");
        Product p = new ProductDB().getProductById(pid).getProductList().get(0);
        int point = p.getPoint();
        userInformation ui = new userInformation();
        userInfo ac = ui.getUserInfoByEmail(user).getUserinfoList().get(0);
        if (Integer.valueOf(ac.getPointAmount()) > point) {
            int newAmount = Integer.valueOf(ac.getPointAmount()) - point;
            OrderDB ord = new OrderDB();
            int nextID = ord.getMaxOID() + 1;

            ord.createEpisodeOrder(user, pid, nextID);
            System.out.println(newAmount);
            flag =true;
            ui.updatePointAmount(user, newAmount);
                        
        }


        
    
        
    
        
    }

    public void getSearchBook(HttpServletRequest req, HttpServletResponse res) throws JSONException, IOException {
        boolean errorNoKeyMatch = false;
        JSONArray jr = new JSONArray();
        String[] comicType = null;
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
        String keyword = req.getParameter("keyword");
        String payTime = req.getParameter("payTimePeriod");
        String start = req.getParameter("start");
        String end = req.getParameter("end");
        System.out.println("The value of start is " + start);
        System.out.println("The value of end is " + end);

        System.out.print("The value of payTime" + payTime);
        if (!req.getParameter("comicType").equals("")) {
            comicType = req.getParameter("comicType").split(",");
        }

        String basicQuery = " Select Distinct(product.comic_Id) "
                + " FROM product ,orderRequest ,ComicWorks "
                + " where product.product_id =orderRequest.product_id "
                + " and  ComicWorks.comic_Id = product.comic_Id      "
                + " and orderRequest.eAddress= '" + user + "' "
                + " and bid is null "
                + " and  orderRequest.status = 'Complete' "
                + " and point !=0     ";

        if (!keyword.equals("")) {

            basicQuery += identify_InputField(keyword);
        }

        if (!payTime.equals("others") && !payTime.equals("")) {
            basicQuery += " and orderRequest.updateTime>= NOW() - INTERVAL " + payTime;
        } else {
            if (!start.equals("")) { /// to the current date
                basicQuery += "  and `updateTime` >= '" + start + "'  " + " and `updateTime` <=  CURRENT_DATE ";
            } else if (!end.equals("")) {//before this date
                basicQuery += " and orderRequest.updateTime  <='" + end + "' + INTERVAL 1 DAY ";
            } else if (!start.equals("") && !end.equals("")) {
                basicQuery += " and `updateTime` >= '" + start + "' and `updateTime` <= '" + end + "'";
            }

        }

        basicQuery += " ORDER by `updateTime` ";

        ArrayList<String> idList = screenBeforeComicType(basicQuery);
        ArrayList<String> outcome = (comicType != null) ? sortComicType(idList, comicType) : idList;
        jr = SelectedComic(outcome);

        sendJSon(res, jr);

    }

    public ArrayList<String> sortComicType(ArrayList<String> idList, String[] comicType) {
        ArrayList<String> MyList = new ArrayList<String>();
        for (int w = 0; w < idList.size(); w++) {
            ArrayList<String> sa = new ArrayList<String>();
            for (int s = 0; s < comicType.length; s++) {
                String query = " SELECT * FROM `ComicType` WHERE comic_Id='" + idList.get(w) + "' and tid ='" + comicType[s] + "' ";
                if (canBeFindType(query)) {
                    sa.add("true");
                }
            }
            if (comicType.length == Collections.frequency(sa, "true")) {
                MyList.add(idList.get(w));
            }

        }
        return MyList;
    }

    public boolean canBeFindType(String q) {
        Connection con = null;
        Statement preState = null;
        ResultSet rs = null;
        try {
            con = new dbOperation().getConnection();
            preState = con.createStatement();
            rs = preState.executeQuery(q);
            if (rs.next()) {
                return true;
            }

            con.close();
            rs.close();
        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }

        return false;

    }

    public String identify_InputField(String keyword) {
        String query = "";
        for (ComicWorks cm : new ComicWorksDB().getComicInfo().getComicList()) {
            if (cm.getName().equals(keyword)) {
                query += " And ComicWorks.name ='" + cm.getName() + "'  ";
            } else if (cm.getPenName().equals(keyword)) {
                query += " And ComicWorks.penName ='" + cm.getPenName() + "' ";
            }

        }
        if (query.equals("")) {
            query += " And ComicWorks.penName ='" + keyword + "' ";
        }

        return query;

    }

    public ArrayList<String> screenBeforeComicType(String screen) {
        Connection con = null;
        ResultSet rs = null;
        Statement preState = null;
        ArrayList<String> sa = null;

        try {
            con = new dbOperation().getConnection();
            String query = screen;

            preState = con.createStatement();
            rs = preState.executeQuery(screen);
            sa = new ArrayList<String>();
            while (rs.next()) {
                sa.add(rs.getString(1));

            }
            rs.close();
            con.close();
            preState.close();

        } catch (SQLException s) {
            s.printStackTrace();

        }
        return sa;

    }

    public void getPurchasedChapter(HttpServletRequest req, HttpServletResponse res) throws JSONException, IOException {
        String comicId = req.getParameter("cid");
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
        String queryString = basicQuery(user) + " and  product.comic_Id='" + comicId + "' ";
        System.out.println(queryString);
        ArrayList<Product> pl = new ProductDB().getPurchasedEpisode(queryString).getProductList();
        JSONArray jr = new JSONArray();
        for (Product i : pl) {
            JSONObject jb = new JSONObject();

            int epNum = i.getEp();
            ComicWorks comic = new ComicWorksDB().getComicbyId(comicId);
            episodes ep = new episode().getDetailsEpisodesById_Ep(comicId, epNum);
            Timestamp purChaseDate = new OrderDB().getOrder(user, i.getProduct_id()).getUpdateTime();
            jb.put("image", new imageTranslator().genImage(ep.getCover()));
            jb.put("name", comic.getName());
            jb.put("title", ep.getTitle());
            jb.put("ep", epNum);
            jb.put("date", dateFormat(purChaseDate));
            jr.put(jb);
        }

        sendJSon(res, jr);

    }

    public String dateFormat(Timestamp t) {
        SimpleDateFormat sa = new SimpleDateFormat("dd.MM.yyyy");
        Date d = new Date(t.getTime());
        return sa.format(d);

    }

    public JSONArray SelectedComic(ArrayList<String> pl) throws IOException, JSONException {
        JSONArray jr = new JSONArray();
        for (String i : pl) {
            JSONObject jb = new JSONObject();
            String cm = i;
            ComicWorks comic = new ComicWorksDB().getComicbyId(cm);
            jb.put("image", new imageTranslator().genImage(comic.getCoverPage()));
            jb.put("name", comic.getName());
            jb.put("auhtor", comic.getPenName());
            jb.put("cid", i);
            jb.put("list", getTypeString(new ComicTypeDB().getTypeListById(cm)));
            jr.put(jb);
        }

        return jr;

    }

    public void getPurchasedProduct(HttpServletRequest req, HttpServletResponse res) throws JSONException, IOException {
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

        ArrayList<String> pl = new OrderDB().getPurchasedEpisode(user);
        JSONArray jr = SelectedComic(pl);

        sendJSon(res, jr);

    }

    public JSONArray getTypeString(ArrayList<String> tp) {
        JSONArray jr = new JSONArray();
        for (int s = 0; s < tp.size(); s++) {
            jr.put(tp.get(s));
        }
        return jr;

    }

    public String basicQuery(String user) {
        String query = "Select product.* "
                + " FROM product ,orderRequest "
                + " where product.product_id =orderRequest.product_id "
                + " and eAddress= '" + user + "'"
                + " and bid is null "
                + " and  status = 'Complete'"
                + " and point !=0";
        return query;
    }

    public void sendJSon(HttpServletResponse res, JSONArray jr) throws IOException {
        res.setContentType("text/plain");
        res.setCharacterEncoding("UTF-8");
        res.getWriter().write(jr.toString());
    }

}
