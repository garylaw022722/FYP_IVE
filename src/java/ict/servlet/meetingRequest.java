/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.meetingRequestBean;
import ict.db.meetingRequestDB;
import ict.imageTranslator;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author law
 */
@WebServlet(name = "meetingRequest", urlPatterns = {"/meetingRequest"})
public class meetingRequest extends HttpServlet {
    public void  doPost(HttpServletRequest  req, HttpServletResponse res) throws ServletException, IOException{
    
    
       
    }
    

    public void  doGet(HttpServletRequest  req, HttpServletResponse res) throws ServletException, IOException{
        try {
            RequestController(req,res);
        } catch (JSONException ex) {
            Logger.getLogger(meetingRequest.class.getName()).log(Level.SEVERE, null, ex);
        }
    
    
    
    }
    public void RequestController(HttpServletRequest  req, HttpServletResponse res) throws ServletException, IOException, JSONException{
        String operation   =req.getParameter("operation");
        if(operation.equals("getAllRequest"))
              getAllRequest(req,res)       ;
    }
    
    public void getAllRequest(HttpServletRequest  req, HttpServletResponse res) throws ServletException, IOException, JSONException{
        JSONArray jr = new  JSONArray();
        String fileType = ".pdf";
            for (meetingRequestBean item : new meetingRequestDB().getAllRequst().getList()) {
                 JSONObject jb = new JSONObject();
                 jb.put("title", item.getTitle().toString()+fileType);
                 jb.put("pdf", new imageTranslator().genImage(item.getPdf()));
                 jr.put(jb);
            }
    
    
    sendJSon(jr,res);
    
    }

    public void  sendJSon(JSONArray jr ,HttpServletResponse res)throws ServletException, IOException{   
        res.setContentType("text/plain");  
        res.setCharacterEncoding("UTF-8"); 
        res.getWriter().write(jr.toString());
   }


}
     
