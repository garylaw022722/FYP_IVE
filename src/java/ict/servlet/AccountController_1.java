/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.Account;
import ict.bean.UserBean;
import ict.db.AccountDb_1;
import ict.db.BookDb;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author tytap
 */
@WebServlet(name = "AccountController", urlPatterns = {"/Account"})
public class AccountController_1 extends HttpServlet {
    private AccountDb_1 adb;
    public void init() {
        String dbUser = this.getServletContext().getInitParameter("dbUser");
        String dbPassword = this.getServletContext().getInitParameter("dbPassword");
        String dbUrl = this.getServletContext().getInitParameter("dbUrl");
        
        adb = new AccountDb_1(dbUrl, dbUser, dbPassword);
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
  
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        if (action.equals("updata")) {
            Account member = (Account) request.getSession().getAttribute("member");
                String username = member.geteAddress();
            String fistName = request.getParameter("fistName");
            String lastName = request.getParameter("lastName");
            String address = request.getParameter("address");
            String contactNum = request.getParameter("contactNum");
            String subEmail = request.getParameter("subEmail");
            String idenNo = request.getParameter("idenNo");
            String bankAcount =request.getParameter("bankAccount");
            String eAddress = username;
            String password = request.getParameter("password");
            boolean a = adb.EditUserInfo(fistName,lastName,address,contactNum,subEmail,idenNo,bankAcount,eAddress);
            if(password!=null)
            adb.EditPassword(password,eAddress);
            //boolean a = adb.EditUserInfo2(penName,eAddress);
            if(a){
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/index.jsp");
            rd.forward(request, response);
            }else{RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/Main.jsp");
            rd.forward(request, response);}
        }
        else if(action.equals("form")){
            Account member = (Account) request.getSession().getAttribute("member");
            String username = member.geteAddress();
            UserBean u = adb.getUserInfo(username);
            request.setAttribute("userInfo", u);
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/EditAccount.jsp");
            rd.forward(request, response);
        }
        else {
            PrintWriter out = response.getWriter();
            out.println("No such action!!!");
        }
    }
    }