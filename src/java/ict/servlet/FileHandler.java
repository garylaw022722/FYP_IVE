/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author law
 */
@WebServlet(name = "FileHandler", urlPatterns = {"/FileHandler"})
@MultipartConfig

public class FileHandler extends HttpServlet {

    public void doGet(HttpServletRequest req , HttpServletResponse res)
    throws ServletException, IOException
    {
        String itemList = "";
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        try {
            for (FileItem fi : upload.parseRequest(req)) {
                if(fi.isFormField()){
    
                   itemList = "it's  form field";
                  
                } else {
                    itemList = "it's  not  form field";
                }
            }
        } catch(FileUploadException e){
           
        }

                   
            JSONArray  jr = new  JSONArray();
            jr.put(itemList);
            sendJSon( res, jr);
       
   
    }
     public void createPDF(HttpServletRequest req,HttpServletResponse res ) throws JSONException, IOException{
//      String  imageCode  = req.getParameter("Code");
//       ArrayList<String>   imageList  =  getImageCode(imageCode);
       JSONArray  jr  =new  JSONArray();
       jr.put("sassa");
       sendJSon(res,jr);
          
  }
  public void  fileController(HttpServletRequest req , HttpServletResponse res) throws JSONException, IOException{
      String operation  =req.getParameter("operation");
      if(operation.equals("createPdf")){
            createPDF(req,res);
      
      
      }
      
    
  }
  public ArrayList<String>  getImageCode(String code) throws JSONException{
       JSONObject  container  = new JSONObject(code);
       ArrayList<String>  codeList  =  new    ArrayList<String>();
         JSONArray   list =   container.getJSONArray("decodeImage");
          for(int s=0  ;s< list.length() ; s++)               
                          codeList.add(list.get(s).toString());
               
       
    return  codeList ;
  }
  
    public  void  sendJSon(HttpServletResponse res , JSONArray jr) throws IOException{
        res.setContentType("text/plain");  
        res.setCharacterEncoding("UTF-8"); 
        res.getWriter().write(jr.toString());     
   }
    
    
    
}
