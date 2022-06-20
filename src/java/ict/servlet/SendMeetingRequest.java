/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.Account;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author User
 */
@WebServlet(name = "SendMeetingRequest", urlPatterns = {"/sendmeetingrequest"})
@MultipartConfig(maxFileSize = 16177216)
public class SendMeetingRequest extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIRECTORY = "upload";

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
        try (PrintWriter out = response.getWriter()) {
            String dburl = "jdbc:mysql://localhost:3306/fyp";
            String dbUser = "root";
            String dbPassword = "";
            String date = request.getParameter("date");
            String time = request.getParameter("time");
            String callphone = request.getParameter("callphone");
            String title = request.getParameter("title");
            String comment = request.getParameter("comment");
            date = date + " " + time + ":00";
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            Date d = sdf.parse(date);
            Date currentDate = new Date();
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            String username = "";
            Account editor = (Account) request.getSession().getAttribute("editor");
            if(editor != null){
            username = editor.geteAddress();
            }else{
                out.println(("<script>alert('You are not author!');location.href = 'Login2.jsp';</script>"));
            }

            try {
                Part part = request.getPart("file");
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(dburl, dbUser, dbPassword);
                String s = "INSERT INTO meetingrequest VALUES (?,?,?,?,?,?,?,?,?,?)";
                InputStream is = part.getInputStream();
                PreparedStatement pstmt2 = con.prepareStatement(s);
                pstmt2.setInt(1, 0);
                pstmt2.setString(2, username);
                pstmt2.setString(3, dateFormat.format(currentDate));
                pstmt2.setString(4, dateFormat.format(d));
                pstmt2.setString(5, "");
                pstmt2.setString(6, "");
                pstmt2.setBlob(7, is);
                pstmt2.setString(8, title);
                pstmt2.setString(9, comment);
                pstmt2.setString(10, callphone);
                pstmt2.executeUpdate();
                con.close();
                out.print(dateFormat.format(d) + "<br>" + callphone + "<br>" + part);
                out.println("<script>alert('Send meetingRequest sucessful!');location.href = 'meetingRequest.jsp';</script>");
            } catch (ClassNotFoundException ex) {
                ex.printStackTrace();
            } catch (SQLException ex) {
                while (ex != null) {
                    ex.printStackTrace();
                    ex = ex.getNextException();
                }

            }
        } catch (ParseException ex) {
            Logger.getLogger(SendMeetingRequest.class.getName()).log(Level.SEVERE, null, ex);
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
