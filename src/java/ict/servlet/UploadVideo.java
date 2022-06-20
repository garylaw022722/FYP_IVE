/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.Account;
import ict.bean.VideoBean;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;
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
@WebServlet(name = "UploadVideo", urlPatterns = {"/uploadVideo"})
public class UploadVideo extends HttpServlet {

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
        String saveDirectory = "D:\\ITP4913M\\newVersion\\mix\\FYP_WEB\\new\\ff\\FYP_WEB(v2)\\FYP_WEB\\demoV3\\web\\upload";
        
        Account staff = (Account)request.getSession().getAttribute("staff");
        String user;
        if(staff != null){
            user = staff.geteAddress();
        }else{
            out.println("<script>alert('Login First!');location.href = 'Login2.jsp';</script>");
            user = "";
        }
        
        // Check that we have a file upload request
        VideoBean vb = new VideoBean();
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        try {
            // Parse the request
            List<FileItem> items = upload.parseRequest(request);

            // Process the uploaded items
            Iterator iter = items.iterator();
            while (iter.hasNext()) {
                FileItem item = (FileItem) iter.next();

                if (!item.isFormField()) {
                    // Process a file upload
                    //processUploadedFile(item);
                    String fieldName = item.getFieldName();
                    String fileName = item.getName();
                    String contentType = item.getContentType();
                    long sizeInBytes = item.getSize();
                    String title = "";
                    String descript = "";
                    String url = "upload/" + item.getName();
                    DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                    Date date = new Date();
                    vb.setVideoName(fileName);
                    for (FileItem i : items) {
                        if ("title".equals(i.getFieldName())) {
                            title = i.getString("utf-8");
                        } else if ("descript".equals(i.getFieldName())) {
                            descript = i.getString("utf-8");
                        }
                    }
                    out.println(url + "<br>");
                    out.println("title=" + title + "<br>");
                    out.println("Descript=" + descript + "<br>");
                    out.println("Date=" + dateFormat.format(date) + "<br>");
                    out.println("fieldName=" + fieldName + "<br>");
                    out.println("fileName=" + fileName + "<br>");
                    out.println("contentType=" + contentType + "<br>");
                    out.println("sizeInBytes=" + sizeInBytes + "<br>");
                    if (fileName != null && !"".equals(fileName)) {
                        fileName = FilenameUtils.getName(fileName);
                        File uploadedFile = new File(saveDirectory, fileName);
                        item.write(uploadedFile);
                    }

                    try {
                        String deleteBeforeImg = "";
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection(dburl, dbUser, dbPassword);
                        PreparedStatement pstmt = null;
                        String s = "INSERT INTO video VALUES (0,'"+user+"','" + title + "','" + descript + "','" + url + "','" + dateFormat.format(date) + "')";
                        pstmt = con.prepareStatement(s);
                        pstmt.executeUpdate();
                        con.close();
                        out.println("<script>alert('Upload Sucessful!');location.href = 'videoUpload.jsp';</script>");
                    } catch (ClassNotFoundException ex) {
                        ex.printStackTrace();
                    } catch (SQLException ex) {
                        while (ex != null) {
                            ex.printStackTrace();
                            ex = ex.getNextException();
                        }

                    }

                } else {
                }
            }
        } catch (FileUploadException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
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
