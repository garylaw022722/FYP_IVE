/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.Account;
import ict.bean.BookCaseBean;
import ict.bean.ComicBean;
import ict.bean.ComicWorks;
import ict.db.BookDb;
import ict.db.ComicWorksDB;
import ict.imageTranslator;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author user
 */
@WebServlet(name = "BookcaseController", urlPatterns = {"/Bookcase"})
public class BookcaseController extends HttpServlet {

    private BookDb bdb;

    public void init() {
        String dbUser = this.getServletContext().getInitParameter("dbUser");
        String dbPassword = this.getServletContext().getInitParameter("dbPassword");
        String dbUrl = this.getServletContext().getInitParameter("dbUrl");

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (JSONException ex) {
            Logger.getLogger(BookcaseController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (JSONException ex) {
            Logger.getLogger(BookcaseController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, JSONException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        HttpSession session = request.getSession(true);
        BookCaseBean bcb = new BookCaseBean();
        if (action.equals("add")) {
            //String bookID = request.getParameter("bookID");
            String bookID = "2";
            Account member = (Account) request.getSession().getAttribute("member");
            String username = member.geteAddress();
            bdb.UserAddBook(username, bookID);
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/index.jsp");
            rd.forward(request, response);
        } else if (action.equals("remove")) {
            //String bookID = request.getParameter("bookID");
            String bookID = "2";
            Account member = (Account) request.getSession().getAttribute("member");
            String username = member.geteAddress();
            bdb.UserRemoveBook(username, bookID);
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/Login2.jsp");
            rd.forward(request, response);
        } else if (action.equals("getList")) {
            Account member = (Account) request.getSession().getAttribute("member");
            String username = member.geteAddress();
            ArrayList<ComicBean> ComicBookList = bdb.getBookCaseList(bdb.getUserBookCaseList(username));
            request.setAttribute("ComicBookList", ComicBookList);
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/bookcase.jsp");
            rd.forward(request, response);
        } else if (action.equals("showCollection")) {
            showCollection(request, response);

        } else {
            PrintWriter out = response.getWriter();
            out.println("No such action!!!");
        }

    }

    public void showCollection(HttpServletRequest req, HttpServletResponse res) throws JSONException, IOException {
        JSONArray  jr = new JSONArray();
        Account member = (Account) req.getSession().getAttribute("member");
        Account admin = (Account) req.getSession().getAttribute("admin");
        Account editor = (Account) req.getSession().getAttribute("editor");
        Account staff = (Account) req.getSession().getAttribute("staff");
        String user = "";
        if (member != null) {
            user = member.geteAddress();
        } else if (admin != null) {
            user = admin.geteAddress();
        } else if (editor != null) {
            user = editor.geteAddress();
        } else if (staff != null) {
            user = staff.geteAddress();
        }
        ArrayList<String> cList = new BookDb().getUserBookCase(user);
        for (String i : cList) {           
            ComicWorks cm = new ComicWorksDB().getComicbyId(i);
            JSONObject jb=  new JSONObject();
            jb.put("cid", cm.getCid());
            jb.put("img", new imageTranslator().genImage(cm.getCoverPage()));
            jb.put("name", cm.getName());
            
            
            jr.put(jb);
            
            
        }
        
        
        sendJSon(res,jr);
        
        
    }
      public void sendJSon(HttpServletResponse res, JSONArray jr) throws IOException {
        res.setContentType("text/plain");
        res.setCharacterEncoding("UTF-8");
        res.getWriter().write(jr.toString());
    }

}
