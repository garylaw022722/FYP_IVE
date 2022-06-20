/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
@WebServlet(name = "ShowVoteEvent", urlPatterns = {"/ShowVoteEvent"})
public class ShowVoteEvent extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(dburl, dbUser, dbPassword);
                PreparedStatement pstmt = null;
                String s = "SELECT * FROM votingevent";
                pstmt = con.prepareStatement(s);
                ResultSet rs = pstmt.executeQuery();
                out.println("<tr>");
                out.println("<th>Event_Id</th>");
                out.println("<th>Descript</th>");
                out.println("<th>Qestion</th>");
                out.println("<th>StartTime</th>");
                out.println("<th>EndTime</th>");
                out.println("<th></th>");
                out.println("</tr>");
                while (rs.next()) {
                    out.print("<tr>");
                    out.print("<td>" + rs.getInt("event_id") + "</td>");
                    out.print("<td>" + rs.getString("Descript") + "</td>");
                    out.print("<td>" + rs.getString("question") + "</td>");
                    out.print("<td>" + rs.getString("startDate") + "</td>");
                    out.print("<td>" + rs.getString("endDate") + "</td>");
                    out.print("<td><a href='voteResult.jsp?eventID="+rs.getInt("event_id")+"'>Click me</a></td>");
                    out.print("</tr>");
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
