/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.Account;
import ict.bean.BookCaseBean;
import ict.bean.ComicBean;
import ict.bean.ShoppingCartBean;
import ict.bean.userInfo;
import ict.db.BookDb;
import ict.db.OrderDB;
import ict.db.coupon;
import ict.db.userInformation;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Random;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author user
 */
@WebServlet(name = "ShoppingCartController", urlPatterns = {"/ShoppingCart"})
public class ShoppingCartController extends HttpServlet {

    private BookDb bdb;
    private userInformation UDB;
    private OrderDB ODB;
    private coupon cp;

    public void init() {
        String dbUser = this.getServletContext().getInitParameter("dbUser");
        String dbPassword = this.getServletContext().getInitParameter("dbPassword");
        String dbUrl = this.getServletContext().getInitParameter("dbUrl");

        cp = new coupon();
        bdb = new BookDb();
        UDB = new userInformation();
        ODB = new OrderDB();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        HttpSession session = request.getSession(true);
        ShoppingCartBean sc = new ShoppingCartBean();
        ShoppingCartBean hl = new ShoppingCartBean();
        if (action.equals("add")) {
            if (request.getSession().getAttribute("ShoppingCart") != null) {
                sc = (ShoppingCartBean) request.getSession().getAttribute("ShoppingCart");
            }
            String bookID = request.getParameter("bookID");
            String ep = request.getParameter("ep");
            String pid = bdb.getProudctIDByCid(bookID, ep);
            String productId = request.getParameter("productId");
            if(productId != null){
                sc.addTocart(productId);
            }else{
                sc.addTocart(pid);
            }
            session.setAttribute("ShoppingCart", sc);
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/Main.jsp");
            rd.forward(request, response);
        } else if (action.equals("remove")) {
            sc = (ShoppingCartBean) request.getSession().getAttribute("ShoppingCart");
            ArrayList<ComicBean> ShoppingCartList = new ArrayList<ComicBean>();
            String bookID = request.getParameter("bookID");
            sc.removeToCart(bookID);
            sc = (ShoppingCartBean) request.getSession().getAttribute("ShoppingCart");
//            hl.addTocart(bookID);
//            session.setAttribute("ShoppingCart", sc);
//            try{
//            session.setAttribute("hopeList", hl);
//            }catch(Exception e){}
            ArrayList<ComicBean> Price = bdb.getProductInfo(sc.getShoppingCartList());
            for (int i = 0; i < Price.size(); i++) {
                ComicBean c = Price.get(i);
                String orderType = c.getProduct_Id();
                String type = Character.toString(orderType.charAt(0));
                if (type.equals("r")) {
                    ComicBean x = bdb.getRealtricBookCaseList(1);
                    ShoppingCartList.add(x);
                } else if (type.equals("e")) {
                    ComicBean x = bdb.getEleBookCaseList(2);
                    ShoppingCartList.add(x);
                }
            }
            request.setAttribute("ShoppingCartList", ShoppingCartList);
            request.setAttribute("Price", Price);
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/shoppingCart2.jsp");
            rd.forward(request, response);
        } else if (action.equals("getList")) {
            sc = (ShoppingCartBean) request.getSession().getAttribute("ShoppingCart");
            ArrayList<ComicBean> ShoppingCartList = new ArrayList<ComicBean>();
            ArrayList cplist = new ArrayList();
            ArrayList al = new ArrayList();
            Account member = (Account) request.getSession().getAttribute("member");
            if (member != null) {
                String username = member.geteAddress();
                cplist = cp.getUserCoupon(username);
            }
            request.setAttribute("couponList", cplist);
            if (sc != null) {
                al = sc.getShoppingCartList();
            }
            ArrayList<ComicBean> Price = bdb.getProductInfo(al);
            for (int i = 0; i < Price.size(); i++) {
                ComicBean c = Price.get(i);
                String orderType = c.getProduct_Id();
                String type = Character.toString(orderType.charAt(0));
                if (type.equals("r")) {
                    ComicBean x = bdb.getRealtricBookCaseList(c.getBid());
                    ShoppingCartList.add(x);
                } else if (type.equals("e")) {
                    ComicBean x = bdb.getEleBookCaseList(c.getComic_Id());
                    ShoppingCartList.add(x);
                }
            }
            request.setAttribute("ShoppingCartList", ShoppingCartList);
            request.setAttribute("Price", Price);
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/shoppingCart2.jsp");
            rd.forward(request, response);
        } else if (action.equals("Checkout")) {
            sc = (ShoppingCartBean) request.getSession().getAttribute("ShoppingCart");
            ArrayList productId = new ArrayList();
            ArrayList qty = new ArrayList();
            if (sc != null) {
                productId = sc.getShoppingCartList();
                qty = sc.getQTYList();
            }
            Account member = (Account) request.getSession().getAttribute("member");
            String username = member.geteAddress();
            int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
            int totalPoint = Integer.parseInt(request.getParameter("totalPoint"));
            String Discount = request.getParameter("Discount");
            ArrayList<userInfo> uil = new ArrayList<userInfo>();
            userInfo ui = new userInfo();
            ui = UDB.getUserInfoByEmail(username);
            uil = ui.getUserinfoList();
            ui = uil.get(0);
            int UserPoint = 0;
            if (ui.getPointAmount() > totalPoint) {
                UserPoint = ui.getPointAmount();
                UserPoint -= totalPoint;
                UDB.updatePointAmount(username, UserPoint);
                int max = ODB.getMaxOrderID();
                ODB.UserAddBook(productId, qty, username, max, Discount);
                sc = new ShoppingCartBean();
                session.setAttribute("ShoppingCart", sc);
                if (Discount.equals(" 1")) {
                    Random rand = new Random();
                    int random = rand.nextInt(3);
                    if (random == 1) {
                        cp.UserAddCoupon("1", username);
                    } else if (random == 2) {
                        cp.UserAddCoupon("2", username);
                    }
                    request.setAttribute("random", random);
                    RequestDispatcher rd;
                    rd = getServletContext().getRequestDispatcher("/draw.jsp");
                    rd.forward(request, response);
                } else {
                    if (Discount.equals(" 0.8")) {
                        cp.UsingCoupon("1", username);
                    } else if (Discount.equals(" 0.9")) {
                        cp.UsingCoupon("2", username);
                    }
                    RequestDispatcher rd;
                    rd = getServletContext().getRequestDispatcher("/Main.jsp");
                    rd.forward(request, response);
                }

            } else {
                RequestDispatcher rd;
                rd = getServletContext().getRequestDispatcher("/pointList.jsp");
                rd.forward(request, response);
            }
            //sc = new ShoppingCartBean();
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/shoppingCart2.jsp");
            rd.forward(request, response);
        } else {
            PrintWriter out = response.getWriter();
            out.println("No such action!!!");
        }
    }
}
