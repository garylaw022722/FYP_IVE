/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.CommentBean;
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
@WebServlet(name = "AdditionalCommand", urlPatterns = {"/additionalcommand"})
public class AdditionalCommand extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        String orderID = request.getParameter("orderID");
        int orderIDi = Integer.parseInt(orderID);
        String useremail = request.getParameter("email");
        String productID = request.getParameter("productID");
        String dburl = "jdbc:mysql://localhost:3306/fyp";
        String dbUser = "root";
        String dbPassword = "";
        try (PrintWriter out = response.getWriter()) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(dburl, dbUser, dbPassword);
                PreparedStatement pstmt = null;
                String s = "SELECT ord_id,(price*amount) as total,orderrequest.product_id as productID FROM product,orderrequest WHERE product.product_id = orderrequest.product_id AND orderrequest.eAddress = '" + useremail + "' AND ord_id = " + orderIDi + " AND orderrequest.product_id = '" + productID + "'";
                pstmt = con.prepareStatement(s);
                ResultSet rs = pstmt.executeQuery();
                ArrayList<CommentBean> comment = new ArrayList<CommentBean>();
                CommentBean cmb = new CommentBean();
                while (rs.next()) {
                    CommentBean cb = new CommentBean();
                    cb.setOrderID(rs.getInt("ord_id"));
                    cb.setPrice(rs.getInt("total"));
                    cb.setProductID(rs.getString("productID"));
                    comment.add(cb);
                    cmb.setAcb(comment);
                }
                request.setAttribute("commentDetail", cmb);
                RequestDispatcher rd;
                rd = getServletContext().getRequestDispatcher("/AdditionalCommand.jsp");
                rd.forward(request, response);
                con.close();
            } catch (ClassNotFoundException ex) {
                ex.printStackTrace();
            } catch (SQLException ex) {
                while (ex != null) {
                    ex.printStackTrace();
                    ex = ex.getNextException();
                }

            }
        }

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
