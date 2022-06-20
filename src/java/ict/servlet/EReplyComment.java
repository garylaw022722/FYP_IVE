/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.ECommendBean;
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
@WebServlet(name = "EReplyComment", urlPatterns = {"/reply"})
public class EReplyComment extends HttpServlet {

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
        String dburl = "jdbc:mysql://localhost:3306/fyp";
        String dbUser = "root";
        String dbPassword = "";
        String comicName = request.getParameter("comicName");
        String comicID = request.getParameter("comicID");
        String comment = request.getParameter("comment");
        String eAddress = request.getParameter("eAddress");
        int commentID = Integer.parseInt(request.getParameter("commentID"));
        java.util.Date date = new java.util.Date();
        ArrayList<ECommendBean> ecb = new ArrayList<ECommendBean>();
        ArrayList<ECommendBean> Secb = (ArrayList<ECommendBean>) request.getSession().getAttribute("replyComment");
        HttpSession session = request.getSession(true);
        ECommendBean eb = new ECommendBean();
        if (comment.equals("cls") || comment.equals("fuck")) {
            out.println("<script>");
            out.println("alert('Dont enter offensive speech');location.href = 'ReadBookController?operation=SelectComic&comicId=" + comicID + "';");
            out.println("</script>");
        } else {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(dburl, dbUser, dbPassword);
                String s2 = "SELECT FirstName,LastName FROM userinfo WHERE eAddress = '" + eAddress + "'";
                PreparedStatement pstmt2 = con.prepareStatement(s2);
                ResultSet rs = pstmt2.executeQuery();
                rs.next();
                if (session.getAttribute("replyComment") != null) {
                    eb.setComment(comment);
                    eb.setComicName(comicName);
                    eb.seteAddress(eAddress);
                    eb.setName(rs.getString("FirstName") + " " + rs.getString("LastName"));
                    eb.setCurrentDate(date.toString());
                    eb.setCommentID(commentID);
                    ecb.add(eb);
                    Secb.add(eb);
                    out.println("<script>");
                    out.println("location.href = 'ReadBookController?operation=SelectComic&comicId=" + comicID + "';");
                    out.println("</script>");
                } else {
                    eb.setComment(comment);
                    eb.setComicName(comicName);
                    eb.seteAddress(eAddress);
                    eb.setCommentID(commentID);
                    eb.setName(rs.getString("FirstName") + " " + rs.getString("LastName"));
                    eb.setCurrentDate(date.toString());
                    ecb.add(eb);
                    session.setAttribute("replyComment", ecb);
                    out.println("<script>");
                    out.println("location.href = 'ReadBookController?operation=SelectComic&comicId=" + comicID + "';");
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
