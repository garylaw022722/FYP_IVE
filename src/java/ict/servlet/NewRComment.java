/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.RCommendBean;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author User
 */
@WebServlet(name = "NewRComment", urlPatterns = {"/newRComment"})
public class NewRComment extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        int c =1;
        String dburl = "jdbc:mysql://localhost:3306/fyp";
        String dbUser = "root";
        String dbPassword = "";
        String productID = request.getParameter("productID");
        String comment = request.getParameter("comment");
        String eAddress = request.getParameter("email");
        String ratingstar = request.getParameter("ratingstar");
        String orderID = request.getParameter("orderID");
        java.util.Date date = new java.util.Date();
        ArrayList<RCommendBean> Secb = (ArrayList<RCommendBean>) request.getSession().getAttribute("Rcomment");
        ArrayList<RCommendBean> rcb = new ArrayList<RCommendBean>();
        
        HttpSession session = request.getSession(true);
        RCommendBean eb = new RCommendBean();
        try {
            int orderIDI = Integer.parseInt(orderID);
            int ratingstarI = Integer.parseInt(ratingstar);
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(dburl, dbUser, dbPassword);
            String s2 = "SELECT FirstName,LastName FROM userinfo WHERE eAddress = '" + eAddress + "'";
            PreparedStatement pstmt2 = con.prepareStatement(s2);
            ResultSet rs = pstmt2.executeQuery();
            rs.next();
            if (session.getAttribute("Rcomment") != null) {
                int commentID = (int) request.getSession().getAttribute("RcommentID");
                ++commentID;
                session.setAttribute("RcommentID", commentID);
                eb.setComment(comment);
                eb.setAcomment(Secb);
                eb.seteAddress(eAddress);
                eb.setRatingstar(ratingstarI);
                eb.setName(rs.getString("FirstName") + " " + rs.getString("LastName"));
                eb.setCurrentDate(date.toString());
                eb.setCommentID((int)session.getAttribute("RcommentID"));
                eb.setProductID(productID);
                eb.setOrderID(orderIDI);
                rcb.add(eb);
                Secb.add(eb);
                out.println("<script>");
                out.println("location.href = 'reviewOrder?action=all'");
                out.println("</script>");
            } else {
                eb.setComment(comment);
                eb.seteAddress(eAddress);
                eb.setAcomment(Secb);
                eb.setRatingstar(ratingstarI);
                eb.setCommentID(c);
                eb.setName(rs.getString("FirstName") + " " + rs.getString("LastName"));
                eb.setCurrentDate(date.toString());
                eb.setProductID(productID);
                eb.setOrderID(orderIDI);
                rcb.add(eb);
                session.setAttribute("RcommentID", c);
                session.setAttribute("Rcomment", rcb);
                out.println("<script>");
                out.println("location.href = 'reviewOrder?action=all'");
                out.println("</script>");
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
