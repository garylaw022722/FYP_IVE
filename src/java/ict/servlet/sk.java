/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.EmailConfig;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author law
 */
@WebServlet(name = "sk", urlPatterns = {"/sk"})
public class sk extends HttpServlet {

   public void doPost(HttpServletRequest req , HttpServletResponse res) throws IOException, ServletException{
       
         new EmailConfig().sendEmail("garylaw696969@gmail.com",
                "garylawka696969@gmail.com", "馬すめたんろうs", "<h1>馬すめたんろうss</h1>", "");
         
   
   
   
   }

}
