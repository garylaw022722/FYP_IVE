/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.Account;
import ict.bean.ComicBean;
import ict.db.ProductDB;
import ict.db.votingDb;
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
 * @author user
 */
@WebServlet(name = "VotingController", urlPatterns = {"/Voting"})
public class VotingController extends HttpServlet {

    private votingDb vdb;
    private ProductDB pdb;
    public void init() {
        String dbUser = this.getServletContext().getInitParameter("dbUser");
        String dbPassword = this.getServletContext().getInitParameter("dbPassword");
        String dbUrl = this.getServletContext().getInitParameter("dbUrl");

        vdb = new votingDb(dbUrl, dbUser, dbPassword);
        pdb = new ProductDB();
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
        String action = request.getParameter("action");
        if (action.equals("add")) {
            String event_id = request.getParameter("event_id");
            String comic_Id = request.getParameter("comic_Id");
            Account member = (Account) request.getSession().getAttribute("member");
                String username = member.geteAddress();
            String eAddress = username;
            String yearRange = request.getParameter("yearRange");
            String repsonse = request.getParameter("repsonse");
            boolean a = vdb.addVoting(event_id, comic_Id, eAddress, yearRange, repsonse);
            if (a) {
                RequestDispatcher rd;
                rd = getServletContext().getRequestDispatcher("/Member.jsp");
                rd.forward(request, response);
            } else {
                RequestDispatcher rd;
                rd = getServletContext().getRequestDispatcher("/Share.jsp");
                rd.forward(request, response);
            }
        } else if (action.equals("Form")) {
            HttpSession session = request.getSession(true);
            String checkVotingEventIsRuning = vdb.getEventId();
            Account member = (Account) request.getSession().getAttribute("member");
                String username = member.geteAddress();
            String eAddress = username;
            String NotVoted = vdb.CheckNotVoted(eAddress);
            ArrayList<ComicBean> comicList = new ArrayList();
            if (checkVotingEventIsRuning != "" && NotVoted !=eAddress) {
                String question = vdb.getQuestion(checkVotingEventIsRuning);
                ArrayList<String> cl = vdb.getEventBook(checkVotingEventIsRuning);
                for(int i = 0 ; i <cl.size() ; i++){
                    ComicBean cb = new ComicBean();
                    cb = vdb.getComicById(cl.get(i));
                    comicList.add(cb);
                }
                
                request.setAttribute("event_Id", checkVotingEventIsRuning);
                request.setAttribute("comicList", comicList);
                request.setAttribute("question", question);
                RequestDispatcher rd;
                rd = getServletContext().getRequestDispatcher("/votingUI.jsp");
                rd.forward(request, response);
            } else {
                RequestDispatcher rd;
                rd = getServletContext().getRequestDispatcher("/Member.jsp");
                rd.forward(request, response);
            }
        }else if (action.equals("Product")) {
                ArrayList al = pdb.getAllEBook();                
                request.setAttribute("Product", al);
                RequestDispatcher rd;
                rd = getServletContext().getRequestDispatcher("/UpdateProduct.jsp");
                rd.forward(request, response);
        }else if (action.equals("ProductUpdate")) {
                String productId = request.getParameter("productId");
                int Point = Integer.parseInt(request.getParameter("Point"));
                String Public = request.getParameter("Public");
                pdb.updateProductByPid(productId,Point,Public);               
                ArrayList al = pdb.getAllEBook();                
                request.setAttribute("Product", al);
                RequestDispatcher rd;
                rd = getServletContext().getRequestDispatcher("/UpdateProduct.jsp");
                rd.forward(request, response);
        }
        else if (action.equals("CreateForm")) {
            HttpSession session = request.getSession(true);
            ArrayList<ComicBean> comicList = vdb.getComicList();
            request.setAttribute("comicList", comicList);
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/CreateVoteForm.jsp");
            rd.forward(request, response);
        } else if (action.equals("Create")) {
            String[] checks = {};
            Account admin = (Account) request.getSession().getAttribute("admin");
                String username = admin.geteAddress();
            String eAddress = username;
            checks = request.getParameterValues("checks");
            String descript = request.getParameter("descript");
            String question = request.getParameter("question");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            boolean b = vdb.addVotingEvent(descript, question, startDate, eAddress, endDate);
            if (b) {
                String event_Id = vdb.getMaxEventId();
                for(int i=0 ; i < checks.length ; i++){
                    vdb.addEntries(checks[i], event_Id);
                }
                RequestDispatcher rd;
                rd = getServletContext().getRequestDispatcher("/Main.jsp");
                rd.forward(request, response);
            } else {
                RequestDispatcher rd;
                rd = getServletContext().getRequestDispatcher("/Share.jsp");
                rd.forward(request, response);
            }
        } else {
            PrintWriter out = response.getWriter();
            out.println("No such action!!!");
        }
    }
}
