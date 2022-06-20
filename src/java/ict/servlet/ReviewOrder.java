/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.Account;
import ict.bean.OrderDetailBean;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
@WebServlet(name = "ReviewOrder", urlPatterns = {"/reviewOrder"})
public class ReviewOrder extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        Account member = (Account) request.getSession().getAttribute("member");
        String action = request.getParameter("action");
        String searchKey = request.getParameter("searchKey");
        String date1 = request.getParameter("date1");
        String date2 = request.getParameter("date2");
        String username = member.geteAddress();
        String eaddress = request.getParameter("username");
        String dburl = "jdbc:mysql://localhost:3306/fyp";
        String dbUser = "root";
        String dbPassword = "";
        int point = 0;
        
        OrderDetailBean Rodb = new OrderDetailBean();
        OrderDetailBean Eodb = new OrderDetailBean();
        try (PrintWriter out = response.getWriter()) {
            try {
                if (action.equals("all")) {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection(dburl, dbUser, dbPassword);
                    PreparedStatement pstmt = null;
                    String s2 = "SELECT ord_id,price,ordDiscount,orderrequest.status as status,sendDate,updateTime,orderrequest.eAddress as eAddress,SUM(point) AS point,amount,orderrequest.product_id as product_id,comicworks.Name AS Name,title,product.ep as ep FROM orderrequest,product,comicworks,episode WHERE comicworks.comic_Id = product.comic_Id AND product.product_id = orderrequest.product_id AND comicworks.comic_Id = episode.comic_Id AND product.ep = episode.ep AND orderrequest.eAddress = '" + member.geteAddress() + "' GROUP BY ord_id";
                    PreparedStatement pstmt2 = con.prepareStatement(s2);
                    ResultSet rs = pstmt2.executeQuery();
                    while (rs.next()) {
                        OrderDetailBean odb = new OrderDetailBean();
                        odb.setDiscount(rs.getDouble("ordDiscount"));
                        odb.setDate(rs.getString("sendDate"));
                        odb.setOrderID(rs.getInt("ord_id"));
                        odb.setPoint(rs.getInt("point"));
                        odb.setStatus(rs.getString("status"));
                        odb.setComicName(rs.getString("Name"));
                        Eodb.addList(odb);
                    }

                    String s3 = "SELECT ord_id,price,ordDiscount,amount,orderrequest.status as status,sendDate,updateTime,orderrequest.eAddress as eAddress,point,orderrequest.product_id as product_id,bundleset.Name as Name FROM orderrequest,product,bundleset WHERE product.product_id = orderrequest.product_id AND bundleset.bid = product.bid AND orderrequest.eAddress = '" + member.geteAddress() + "' AND price > 0";
                    pstmt2 = con.prepareStatement(s3);
                    rs = pstmt2.executeQuery();
                    while (rs.next()) {
                        OrderDetailBean odb = new OrderDetailBean();
                        odb.setDiscount(rs.getDouble("ordDiscount"));
                        odb.setDate(rs.getString("sendDate"));
                        odb.setOrderID(rs.getInt("ord_id"));
                        odb.setPrice(rs.getInt("price"));
                        odb.setStatus(rs.getString("status"));
                        odb.setQuantity(rs.getInt("amount"));
                        odb.setProductID(rs.getString("product_id"));
                        Rodb.addList(odb);
                    }

                    request.setAttribute("eob", Eodb);
                    request.setAttribute("rob", Rodb);
                    RequestDispatcher rd;
                    rd = getServletContext().getRequestDispatcher("/orderStatus.jsp");
                    rd.forward(request, response);
                    con.close();
                } else if (action.equals("Search")) {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection(dburl, dbUser, dbPassword);
                    PreparedStatement pstmt = null;
                    String s2 = "SELECT ord_id,price,ordDiscount,orderrequest.status as status,sendDate,updateTime,orderrequest.eAddress as eAddress,SUM(point) AS point,amount,orderrequest.product_id as product_id,comicworks.Name AS Name,title,product.ep as ep FROM orderrequest,product,comicworks,episode WHERE comicworks.comic_Id = product.comic_Id AND product.product_id = orderrequest.product_id AND comicworks.comic_Id = episode.comic_Id AND product.ep = episode.ep AND orderrequest.eAddress = '" + member.geteAddress() + "'  AND ord_id LIKE '" + searchKey + "%' GROUP BY ord_id";
                    PreparedStatement pstmt2 = con.prepareStatement(s2);
                    ResultSet rs = pstmt2.executeQuery();
                    while (rs.next()) {
                        OrderDetailBean odb = new OrderDetailBean();
                        odb.setDiscount(rs.getDouble("ordDiscount"));
                        odb.setDate(rs.getString("sendDate"));
                        odb.setOrderID(rs.getInt("ord_id"));
                        odb.setPoint(rs.getInt("point"));
                        odb.setStatus(rs.getString("status"));
                        odb.setComicName(rs.getString("Name"));
                        Eodb.addList(odb);
                    }

                    String s3 = "SELECT ord_id,price,ordDiscount,amount,orderrequest.status as status,sendDate,updateTime,orderrequest.eAddress as eAddress,point,orderrequest.product_id as product_id,bundleset.Name as Name FROM orderrequest,product,bundleset WHERE product.product_id = orderrequest.product_id AND bundleset.bid = product.bid AND orderrequest.eAddress = '" + member.geteAddress() + "' AND price > 0  AND ord_id LIKE '" + searchKey + "%'";
                    pstmt2 = con.prepareStatement(s3);
                    rs = pstmt2.executeQuery();
                    while (rs.next()) {
                        OrderDetailBean odb = new OrderDetailBean();
                        odb.setDiscount(rs.getDouble("ordDiscount"));
                        odb.setDate(rs.getString("sendDate"));
                        odb.setOrderID(rs.getInt("ord_id"));
                        odb.setPrice(rs.getInt("price"));
                        odb.setStatus(rs.getString("status"));
                        odb.setQuantity(rs.getInt("amount"));
                        odb.setProductID(rs.getString("product_id"));
                        Rodb.addList(odb);
                    }

                    request.setAttribute("eob", Eodb);
                    request.setAttribute("rob", Rodb);
                    RequestDispatcher rd;
                    rd = getServletContext().getRequestDispatcher("/orderStatus.jsp");
                    rd.forward(request, response);
                } else if (action.equals("date")) {
                    out.println(date1 + "<br>" + date2);
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection(dburl, dbUser, dbPassword);
                    PreparedStatement pstmt = null;
                    String s2 = "SELECT ord_id,price,ordDiscount,orderrequest.status as status,sendDate,updateTime,orderrequest.eAddress as eAddress,SUM(point) AS point,amount,orderrequest.product_id as product_id,comicworks.Name AS Name,title,product.ep as ep FROM orderrequest,product,comicworks,episode WHERE comicworks.comic_Id = product.comic_Id AND product.product_id = orderrequest.product_id AND comicworks.comic_Id = episode.comic_Id AND product.ep = episode.ep AND orderrequest.eAddress = '" + member.geteAddress() + "' AND sendDate BETWEEN '" + date1 + "' AND '" + date2 + "' GROUP BY ord_id";
                    PreparedStatement pstmt2 = con.prepareStatement(s2);
                    ResultSet rs = pstmt2.executeQuery();
                    while (rs.next()) {
                        OrderDetailBean odb = new OrderDetailBean();
                        odb.setDiscount(rs.getDouble("ordDiscount"));
                        odb.setDate(rs.getString("sendDate"));
                        odb.setOrderID(rs.getInt("ord_id"));
                        odb.setPoint(rs.getInt("point"));
                        odb.setStatus(rs.getString("status"));
                        odb.setComicName(rs.getString("Name"));
                        Eodb.addList(odb);
                    }

                    String s3 = "SELECT ord_id,price,ordDiscount,amount,orderrequest.status as status,sendDate,updateTime,orderrequest.eAddress as eAddress,point,orderrequest.product_id as product_id,bundleset.Name as Name FROM orderrequest,product,bundleset WHERE product.product_id = orderrequest.product_id AND bundleset.bid = product.bid AND orderrequest.eAddress = '" + member.geteAddress() + "' AND price > 0  AND sendDate BETWEEN '" + date1 + "' AND '" + date2 + "'";
                    pstmt2 = con.prepareStatement(s3);
                    rs = pstmt2.executeQuery();
                    while (rs.next()) {
                        OrderDetailBean odb = new OrderDetailBean();
                        odb.setDiscount(rs.getDouble("ordDiscount"));
                        odb.setDate(rs.getString("sendDate"));
                        odb.setOrderID(rs.getInt("ord_id"));
                        odb.setPrice(rs.getInt("price"));
                        odb.setStatus(rs.getString("status"));
                        odb.setQuantity(rs.getInt("amount"));
                        odb.setProductID(rs.getString("product_id"));
                        Rodb.addList(odb);
                    }

                    request.setAttribute("eob", Eodb);
                    request.setAttribute("rob", Rodb);
                    RequestDispatcher rd;
                    rd = getServletContext().getRequestDispatcher("/orderStatus.jsp");
                    rd.forward(request, response);
                }

            } catch (ClassNotFoundException ex) {
                ex.printStackTrace();
            } catch (SQLException ex) {
                while (ex != null) {
                    ex.printStackTrace();
                    ex = ex.getNextException();
                }

            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
