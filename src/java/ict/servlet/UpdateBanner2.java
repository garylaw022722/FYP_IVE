/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.BannerBean;
import ict.bean.Account;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
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
import java.util.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

/**
 *
 * @author User
 */
@WebServlet(name = "UpdateBanner2", urlPatterns = {"/updatebanner2"})
@MultipartConfig(maxFileSize = 16177216)
public class UpdateBanner2 extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        String dburl = "jdbc:mysql://localhost:3306/fyp";
        String dbUser = "root";
        String dbPassword = "";
        String saveDirectory = "C:\\Users\\User\\Documents\\NetBeansProjects\\WebApplication3\\web\\upload";
        Account admin = (Account) request.getSession().getAttribute("admin");
        String username = admin.geteAddress();
        // Check that we have a file upload request
        BannerBean bb = new BannerBean();
        int bookId = Integer.parseInt(request.getParameter("bannerID"));
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        
        try {
            Part part = request.getPart("file");
            out.println(part);
            String deleteBeforeImg = "";
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(dburl, dbUser, dbPassword);
            PreparedStatement pstmt = null;
            String s = "UPDATE banner,account SET img=?,banner.eAddress=? WHERE banner.eAddress = account.eAddress AND banner_Id=?";
            InputStream is = part.getInputStream();
            pstmt = con.prepareStatement(s);
            pstmt.setBlob(1, is);
            pstmt.setString(2, username);
            pstmt.setInt(3, bookId);
            pstmt.executeUpdate();
            con.close();
            out.println("<script>alert('Upload Sucessful!');location.href = 'AdminControl.jsp';</script>");

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
