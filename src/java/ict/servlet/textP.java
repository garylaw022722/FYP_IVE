/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author law
 */
package ict.servlet;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;


@MultipartConfig
@WebServlet(name = "textP", urlPatterns = {"/textP"})
public class textP extends HttpServlet {

    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
//       
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
  
       String str ="";
        upload(req);
        res.setContentType("text/plain");
        res.setCharacterEncoding("UTF-8");
        
        res.getWriter().write(str);  
        
       

    }

    public void upload(HttpServletRequest req)throws ServletException {
        List<FileItem> items = null;
       String fieldName = "", fileName = "";
        try {
            items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(req);

            for (FileItem item : items) {
                if (!item.isFormField()) {
                    fieldName = item.getFieldName();
                    fileName = FilenameUtils.getName(item.getName());          
                    InputStream in = item.getInputStream();
                    OutputStream out = new FileOutputStream("/Users/law/Desktop/ComicWorks/admin/" + fileName);
                    byte[] br = new byte[in.available()];
                    in.read(br);
                    out.write(br);
                    in.close();
                    out.close();
                } else {
                    fileName = req.getParameter("action");
                }

            }
        } catch (Exception es) {
            es.printStackTrace();
        }

    }
    
    public void json(){
    //            try{
//             JSONObject json = new JSONObject();
//             json.put("isB",getState());
//             PrintWriter out = response.getWriter();
//             response.setContentType("application/json");
//             response.setCharacterEncoding("UTF-8");
//             out.print(json);
//            
//            out.flush();
//        
//            }catch(Exception ex){}
    
    
    
    }

}
