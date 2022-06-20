/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.Account;
import ict.bean.OrderDetailBean;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
@WebServlet(name = "OrderDetail", urlPatterns = {"/orderDetail"})
public class OrderDetail extends HttpServlet {

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
        String dburl = "jdbc:mysql://localhost:3306/fyp";
        String dbUser = "root";
        String dbPassword = "";
        String orderID = request.getParameter("orderID");
        int orderIDI = Integer.parseInt(orderID);
        Account member = (Account) request.getSession().getAttribute("member");
        OrderDetailBean Rodb = new OrderDetailBean();
        OrderDetailBean Eodb = new OrderDetailBean();
        try {
            if (member != null) {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(dburl, dbUser, dbPassword);
                String s = "SELECT ord_id,ordDiscount,price,orderrequest.status as status,sendDate,updateTime,orderrequest.eAddress as eAddress,point,amount,orderrequest.product_id as product_id,comicworks.Name AS Name,title,product.ep as ep FROM orderrequest,product,comicworks,episode WHERE comicworks.comic_Id = product.comic_Id AND product.product_id = orderrequest.product_id AND comicworks.comic_Id = episode.comic_Id AND product.ep = episode.ep AND ord_id = '" + orderIDI + "' AND orderrequest.eAddress = '" + member.geteAddress() + "'";
                PreparedStatement pstmt2 = con.prepareStatement(s);
                ResultSet rs = pstmt2.executeQuery();
                while (rs.next()) {
                    OrderDetailBean odb = new OrderDetailBean();
                    odb.setDiscount(rs.getDouble("ordDiscount"));
                    odb.setDate(rs.getString("sendDate"));
                    odb.setOrderID(rs.getInt("ord_id"));
                    odb.setPoint(rs.getInt("point"));
                    odb.setStatus(rs.getString("status"));
                    odb.setComicName(rs.getString("Name"));
                    odb.setEp(rs.getInt("ep"));
                    odb.setEpTitle(rs.getString("title"));
                    Eodb.addList(odb);
                }

                String s2 = "SELECT ord_id,ordDiscount,price,orderrequest.status as status,sendDate,updateTime,orderrequest.eAddress as eAddress,point,amount,orderrequest.product_id as product_id,bundleset.Name as Name FROM orderrequest,product,bundleset WHERE product.product_id = orderrequest.product_id AND bundleset.bid = product.bid AND ord_id = '"+orderIDI+"'  AND orderrequest.eAddress = '" + member.geteAddress() + "' AND price > 0";
                pstmt2 = con.prepareStatement(s2);
                rs = pstmt2.executeQuery();
                while (rs.next()) {
                    OrderDetailBean odb = new OrderDetailBean();
                    odb.setDiscount(rs.getDouble("ordDiscount"));
                    odb.setDate(rs.getString("sendDate"));
                    odb.setOrderID(rs.getInt("ord_id"));
                    odb.setPrice(rs.getInt("price"));
                    odb.setStatus(rs.getString("status"));
                    odb.setQuantity(rs.getInt("amount"));
                    odb.setBundleName(rs.getString("Name"));
                    Rodb.addList(odb);
                }
                request.setAttribute("EorderDetail", Eodb);
                request.setAttribute("RorderDetail", Rodb);
                RequestDispatcher rd;
                rd = getServletContext().getRequestDispatcher("/OrderDetail.jsp");
                rd.forward(request, response);
                con.close();
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
