/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.Account;
import ict.bean.Point;
import ict.bean.userInfo;
import ict.db.BuyPointRecord;
import ict.db.PointList;
import ict.db.userInformation;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
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
@WebServlet(name = "buyPointController", urlPatterns = {"/buyPointController"})
public class buyPointController extends HttpServlet {

    public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {

        try {
            buyPointController(req, res);
        } catch (JSONException ex) {
            Logger.getLogger(buyPointController.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void buyPointController(HttpServletRequest req, HttpServletResponse res) throws JSONException, IOException {
        String operation = req.getParameter("operation");
        if (operation.equals("init")) {
            getPointList(res,req);
        } else if (operation.equals("showList")) {
            showSalesList(req, res);
        } else if (operation.equals("buyPoint")) {
            buyPoint(req, res);
        } else if (operation.equals("removeItem")) {
            removePointItem(req, res);
        } else if (operation.equals("createItem")) {
            createPointItem(req, res);
        } else if (operation.equals("removeAll")) {
            removeALLPointItem(req, res);
        } else if (operation.equals("updateItem")) {
            updateItem(req, res);
        } else if (operation.equals("search")) {
            searchItem(req, res);
        }

    }

    public void searchItem(HttpServletRequest req, HttpServletResponse res) throws JSONException, IOException {
        String pid = req.getParameter("data");
        JSONArray jr = new JSONArray();

        Point p = new PointList().getPointInfoById(pid);
        getPointListResponse(jr, p);
        sendJSon(res, jr);

    }

    public void updateItem(HttpServletRequest req, HttpServletResponse res) throws JSONException, IOException {
        String data = req.getParameter("data");
        String[] item = data.split("-");
        int price = toInt(item[2]);
        int point = toInt(item[0]);
        int extra = toInt(item[1]);
        int pid = toInt(item[3]);
        new PointList().UpdateItem(pid, price, point, extra);

    }

    public void showSalesList(HttpServletRequest req, HttpServletResponse res) throws JSONException, IOException {
        JSONArray jr = new JSONArray();
        Point p = new PointList().getPointSellingList_id();
        getPointListResponse(jr, p);
        sendJSon(res, jr);

    }

    public void removePointItem(HttpServletRequest req, HttpServletResponse res) throws JSONException, IOException {
        int pid = Integer.valueOf(req.getParameter("pointId"));
        new PointList().removePointItem(pid);

    }

    public void removeALLPointItem(HttpServletRequest req, HttpServletResponse res) throws JSONException, IOException {
        String pidList = req.getParameter("removeList");
        String[] list = pidList.split(",");
        for (String i : list) {
            new PointList().removePointItem(toInt(i));
        }
        res.sendRedirect("pointListManagement.jsp");

    }

    public void createPointItem(HttpServletRequest req, HttpServletResponse res) throws JSONException, IOException {
        String str = req.getParameter("str");
        JSONArray jr = new JSONArray(str);
        for (int s = 0; s < jr.length(); s++) {
            JSONObject item = (JSONObject) jr.getJSONObject(s);
            PointList pl = new PointList();
            int pid = pl.getNextPointIndex();
            int point = toInt(item.get("point").toString());
            int extra = toInt(item.get("extra").toString());
            System.out.println("The extra is " + extra);
            int price = toInt(item.get("price").toString());
            pl.addPointItem(pid, price, point, extra);

        }
        res.sendRedirect("pointListManagement.jsp");

    }

    public int toInt(String item) {
        return Integer.valueOf(item);
    }

    public void buyPoint(HttpServletRequest req, HttpServletResponse res) throws IOException {
        System.out.println(req.getParameter("pid"));

        Account member = (Account) req.getSession().getAttribute("member");
        Account admin = (Account) req.getSession().getAttribute("admin");
        Account editor = (Account) req.getSession().getAttribute("editor");
        Account staff = (Account) req.getSession().getAttribute("staff");
        String type = "";
        if (member != null) {
            type = member.geteAddress();
        } else if (admin != null) {
            type = admin.geteAddress();
        } else if (editor != null) {
            type = editor.geteAddress();
        } else if (staff != null) {
            type = staff.geteAddress();
        }
        Point pointListItem = new PointList().getPointInfoById(req.getParameter("pid")).getPointList().get(0);
        userInformation user = new userInformation();
        userInfo ui = user.getUserInfoByEmail(type).getUserinfoList().get(0);
        int pointRemain = ui.getPointAmount();
        String itemId = "" + pointListItem.getPid();
        int pointRequest = pointListItem.getPointReturn();
        int productPrice = pointListItem.getPrice();
        int extraPoint = pointListItem.getExtraPoint();
        int newPoint = pointRemain + pointRequest + extraPoint;
        String eAddress = ui.geteAddress();
        BuyPointRecord pt = new BuyPointRecord();
        pt.buyPoint(itemId, eAddress, productPrice, pointRequest);
        new userInformation().updatePointAmount(type, newPoint);

        JSONArray jr = new JSONArray();
        String response = "" + user.getUserInfoByEmail(type).getUserinfoList().get(0).getPointAmount();
        jr.put(response);
        sendJSon(res, jr);

    }

    public void sendJSon(HttpServletResponse res, JSONArray jr) throws IOException {
        res.setContentType("text/plain");
        res.setCharacterEncoding("UTF-8");
        res.getWriter().write(jr.toString());
    }

    public void getPointList(HttpServletResponse res, HttpServletRequest req) throws JSONException, IOException {
        JSONArray jr = new JSONArray();
        JSONObject pt = new JSONObject();

        Account member = (Account) req.getSession().getAttribute("member");
        Account admin = (Account) req.getSession().getAttribute("admin");
        Account editor = (Account) req.getSession().getAttribute("editor");
        Account staff = (Account) req.getSession().getAttribute("staff");
        if (member != null) {
            pt.put("remainingPoint", "" + getUserPoint(req));
        } else if (admin != null) {
            pt.put("remainingPoint", "" + getUserPoint(req));
        } else if (editor != null) {
            pt.put("remainingPoint", "" + getUserPoint(req));
        } else if (staff != null) {
            pt.put("remainingPoint", "" + getUserPoint(req));
        } else {
            pt.put("remainingPoint", "" + "0");
        }
        jr.put(pt);

        Point p = new PointList().getPointSellingList();
        getPointListResponse(jr, p);
        sendJSon(res, jr);

    }

    public JSONArray getPointListResponse(JSONArray jr, Point s) throws JSONException {

        for (Point item : s.getPointList()) {
            JSONObject jb = new JSONObject();
            jb.put("pid", "" + item.getPid());
            jb.put("point", item.getPointReturn());
            jb.put("price", item.getPrice());
            jb.put("extraPoint", item.getExtraPoint());
            jr.put(jb);
        }

        return jr;

    }

    public int getUserPoint(HttpServletRequest req) {
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
        userInformation ui = new userInformation();
        return ui.getUserInfoByEmail(user)
                .getUserinfoList().get(0).getPointAmount();
    }

}
