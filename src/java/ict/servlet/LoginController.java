 /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

//import static com.sun.corba.se.spi.presentation.rmi.StubAdapter.request;
import ict.bean.Account;
import ict.db.AccountDB;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import static org.bouncycastle.crypto.tls.NameType.isValid;


/**
 *
 * @author User
 */
@WebServlet(name = "LoginController", urlPatterns = {"/login"})

public class LoginController extends HttpServlet {

 

    public  void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
            LoginController(req,res);
        
        
        
    }
    
    
    public  void LoginController(HttpServletRequest req, HttpServletResponse res){
       String operation = req.getParameter("action");
        if (operation.equals("login"))    
                loginAccount(req,res);
//        else if (operation.equals("logout"))
//                logoutAccount(req,res);
    
    
    
    
    }
    
    
    public void loginAccount(HttpServletRequest req, HttpServletResponse res){
        String  email =  req.getParameter("email");
        String password = req.getParameter("password");
         String realPassword ="";
        AccountDB   ac =  new  AccountDB();
         if(ac.getAccountByEmail(email)!=null){
              realPassword =  ac.getUserPasswordByEmail(email);
              if(realPassword.equals(password))
                       Direction(email,true);
              else
                       Direction("",false);
         }else{                          
                 Direction("",false);             
         }                 
    
         
         
        RequestDispatcher  s = req.getRequestDispatcher("");
    
    
    
    }
    
    
 
    
      public  void   Direction(String email , boolean  valid){
         String targetURL ="";
         Account  ac = new AccountDB().getTypeUser(email).getAcList().get(0);
         String role  = ac.getUserType();
          if(!valid){
             targetURL = "LoginError.jsp";
             return ;
         }
                 
//         if (role.equals("Member")) {
//            HttpSession session = request.getSession(true);
//            session.setAttribute("member", login);
//            targetURL = "Main.jsp";
//        } else if (role.equals("Admin")) {
//            HttpSession session = request.getSession(true);
//            session.setAttribute("admin", login);
//            targetURL = "Main.jsp";
//        } else if (role.equals("Editor") && isValid == true) {
//            HttpSession session = request.getSession(true);
//            session.setAttribute("editor", login);
//            targetURL = "Main.jsp";
//        } else if (role.equals("Staff") && isValid == true) {
//            HttpSession session = request.getSession(true);
//            session.setAttribute("staff", login);
//            targetURL = "Main.jsp";
//        } else {
//          
//        }
          
      
      
      
      
      
      
      
      
      
      
      }
      
      public void  createSession(String role){
//       HttpSession session = request.getSession(true);
//       session.setAttribute(role, login);
      
      
      
      
      }
    private void doAuthenticate(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
       
        String previous = (String) request.getSession().getAttribute("referer");

        String role = "";
        boolean isValid = false;
   
        
        
        
        
        
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private boolean isAuthenticated(HttpServletRequest request) {
        boolean result = false;
        HttpSession session = request.getSession();
        if (session.getAttribute("member") != null) {
            result = true;
        } else if (session.getAttribute("admin") != null) {
            result = true;
        } else if (session.getAttribute("editor") != null) {
            result = true;
        } else if (session.getAttribute("staff") != null) {
            result = true;
        }
        return result;
    }

    private void doLogin(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String targetURL = "Login.jsp";
        RequestDispatcher rd;
        rd = getServletContext().getRequestDispatcher("/" + targetURL);
        rd.forward(request, response);
    }

    private void doLogout(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute("member");
            session.removeAttribute("admin");
            session.removeAttribute("editor");
            session.removeAttribute("staff");
        }
        doLogin(request, response);
    }

}
