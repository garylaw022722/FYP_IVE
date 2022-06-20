/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.ComicWorks;
import ict.db.userInformation;
import java.io.IOException;
import java.util.ArrayList;
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
@WebServlet(name = "Searching", urlPatterns = {"/Searching"})
public class Searching extends HttpServlet {

    public void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
            
        try {
            SearchingController(req,res);
        } catch (JSONException ex) {
            Logger.getLogger(Searching.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
    }
    
    
    
    public void SearchingController(HttpServletRequest req,HttpServletResponse res) throws JSONException, ServletException, IOException{
    
      String type =req.getParameter("type");
      String stage  =req.getParameter("Stage");
      if(type.equals("bookConfig")){          
            if(stage.equals("getComicName")){
             JSONArray result = getMatchYear(req);
             jsonResponse(result ,res);
            }
      }
    
         
    }
        
    
    
    public   JSONArray getComicByAuthor(HttpServletRequest req ){
        userInformation  ui  =  new  userInformation ();
         
        JSONArray   jr  =new JSONArray();
    
    
       return  jr ;
    }
    
   public  JSONArray getMatchYear(HttpServletRequest req ) throws JSONException{
       String yearChoice  = req.getParameter("years");
          ComicWorks  cm   =  new ComicWorks();
         ArrayList<ComicWorks>mList   = cm.getComicByYear(yearChoice);

        JSONArray   jr  =new JSONArray();
        for (ComicWorks  item : mList){
            JSONObject  jb  =new   JSONObject();
            jb.put("comicName", item.getName());
            jr.put(jb);;
        }
          
        
        return jr ;
   }
      
   public void  jsonResponse(JSONArray jr ,HttpServletResponse res)throws ServletException, IOException{   
        res.setContentType("text/plain");  
        res.setCharacterEncoding("UTF-8"); 
        res.getWriter().write(jr.toString());
   }
}
