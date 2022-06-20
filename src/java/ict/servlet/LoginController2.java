/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.Account;
import ict.db.AccountDB;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author User
 */
@WebServlet(name = "LoginController2", urlPatterns = {"/login2"})
public class LoginController2 extends HttpServlet {

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
        String action = request.getParameter("action");
        Account ac = new Account();
        String previous = (String) request.getSession().getAttribute("referer");
        String targetURL;
        String type = "";
        String userState = "";
        AccountDB adb = new AccountDB();
        ac.seteAddress(request.getParameter("username"));
        ac.setPassword(request.getParameter("password"));
        boolean isValid, isFreeze,isUser;
        if (action.equals("login")) {
            isValid = adb.isValidUser(ac);
            isFreeze = adb.isFreeze(ac);
            type = adb.getUserTypeByEmail(request.getParameter("username"));
            HttpSession session = request.getSession(true);
            if (isFreeze == false && isValid == true) {
                targetURL = "FreezeMessage.jsp";
                RequestDispatcher rd;
                rd = getServletContext().getRequestDispatcher("/" + targetURL);
                rd.forward(request, response);
            } else {
                if (isValid == true && type.equals("Member")) {
                    adb.UpdateStatus(ac);
                    userState = adb.getUserStatus(ac);
                    session.setAttribute("userstate", userState);
                    session.setAttribute("member", ac);
                    targetURL = "Main.jsp";
                } else if (isValid == true && type.equals("Admin")) {
                    adb.UpdateStatus(ac);
                    userState = adb.getUserStatus(ac);
                    session.setAttribute("userstate", userState);
                    session.setAttribute("admin", ac);
                    targetURL = "Main.jsp";
                } else if (isValid == true && type.equals("Author")) {
                    adb.UpdateStatus(ac);
                    userState = adb.getUserStatus(ac);
                    session.setAttribute("userstate", userState);
                    session.setAttribute("editor", ac);
                    targetURL = "Main.jsp";
                } else if (isValid == true && type.equals("Staff")) {
                    adb.UpdateStatus(ac);
                    userState = adb.getUserStatus(ac);
                    session.setAttribute("userstate", userState);
                    session.setAttribute("staff", ac);
                    targetURL = "Main.jsp";
                } else {
                    targetURL = "LoginError.jsp";
                }
                if (previous != null) {
                    response.sendRedirect(previous);
                } else {
                    RequestDispatcher rd;
                    rd = getServletContext().getRequestDispatcher("/" + targetURL);
                    rd.forward(request, response);
                }
            }

        } else if (action.equals("logout")) {
            Account member = (Account) request.getSession().getAttribute("member");
            Account admin = (Account) request.getSession().getAttribute("admin");
            Account editor = (Account) request.getSession().getAttribute("editor");
            Account staff = (Account) request.getSession().getAttribute("staff");
            String userlogout = "";
            if (member != null) {
                userlogout = member.geteAddress();
            } else if (admin != null) {
                userlogout = admin.geteAddress();
            } else if (editor != null) {
                userlogout = editor.geteAddress();
            } else if (staff != null) {
                userlogout = staff.geteAddress();
            }
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.removeAttribute("member");
                session.removeAttribute("admin");
                session.removeAttribute("editor");
                session.removeAttribute("staff");
                session.removeAttribute("userstate");
                if (member != null || admin != null || editor != null | staff != null) {
                    ac.seteAddress(userlogout);
                    adb.LogoutStatus(ac);
                }
            }
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/Main.jsp");
            rd.forward(request, response);
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
