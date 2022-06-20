/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.ComicWorks;
import ict.bean.ContributeBean;
import ict.bean.contractBean;
import ict.db.AccountDB;
import ict.db.ComicWorksDB;
import ict.db.ContributeDB;
import ict.db.contract;
import ict.db.userInformation;
import ict.imageTranslator;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
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
@WebServlet(name = "contractControleler", urlPatterns = {"/contractControleler"})
@MultipartConfig
public class contractControleler extends HttpServlet {

    public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {

        try {
            uploadNewContract(req, res);
        } catch (FileUploadException ex) {
            Logger.getLogger(contractControleler.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(contractControleler.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void uploadNewContract(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException, FileUploadException, ParseException {
        List<FileItem> list = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(req);
        JSONArray jr = new JSONArray();

        String firstname = list.get(0).getString();

        String lastname = list.get(1).getString();

        String gender = list.get(2).getString();

        String hkid = list.get(3).getString();
        String bank = list.get(4).getString();

        String tel = list.get(5).getString();
//        String   = list.get(6).getString();

        String address = list.get(6).getString();

        String comicName = list.get(7).getString();
        String penName = list.get(8).getString();

        String serDay = list.get(9).getString();

        String paymentMethod = list.get(10).getString();

        String price = list.get(11).getString().substring(1);

        String period = list.get(12).getString();

        String periodUnit = list.get(13).getString();

        InputStream file = list.get(14).getInputStream();
        String fileName = list.get(15).getString();

        String conId = list.get(17).getString();
        String dob = list.get(18).getString();
        String nextComic = new ComicWorksDB().getNextNo(" SELECT `comic_Id` FROM `ComicWorks` ");
        ContributeBean cb = new ContributeDB().getContributionById(Integer.valueOf(conId));
        //create new Comic 
        String desc = cb.getDescription();
        String email = cb.geteAddress();
        String nextPenId = new ComicWorksDB().getNextNo(" SELECT  `penId` FROM `ComicWorks` ");

        System.out.print(nextComic);
        System.out.print(comicName);
        System.out.print(desc);
        System.out.print(email);
        System.out.print(serDay.length());
        System.out.print(penName);
        System.out.print(nextPenId);
        System.out.print(paymentMethod);
//          return;

        Date z = new SimpleDateFormat("yyyy-mm-dd").parse(dob);
        java.sql.Date dobp = new java.sql.Date(z.getTime());

        new ComicWorksDB().innsertComic(nextComic, comicName, desc, email, serDay, null, "Serialize", null, penName, nextPenId);
        contract db = new contract();
        int nextContract = db.getNextId();
        db.newContract(nextContract, nextComic, email, Integer.valueOf(price), paymentMethod, period, periodUnit, file, fileName, Integer.valueOf(conId));
        new AccountDB().updateUserRole(email, "Author");
        new userInformation().updateUserPortfolio_Contract(firstname, lastname, address, tel, gender, hkid, dobp, bank, email);

        sendJSon(res, jr);

    }

    public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
                
            
                 
                ContractController(req, res);

        } catch (JSONException ex) {
            Logger.getLogger(contractControleler.class.getName()).log(Level.SEVERE, null, ex);
        } 

    }

    public void ContractController(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException, JSONException {
        String operation = req.getParameter("operation");
        if (operation.equals("first8Seri")) {
            getFirst8Seri(res, 8);
        } else if (operation.equals("getNextId")) {
            getNextId(res);
        }

    }

  

    public void getNextId(HttpServletResponse res) throws IOException, JSONException {
        JSONArray jr = new JSONArray();
        JSONObject jb = new JSONObject();
        System.out.print(new contract().getNextId());
        jr.put(jb.put("id", new contract().getNextId()));

        sendJSon(res, jr);
    }

    public void getFirst8Seri(HttpServletResponse res, int max) throws IOException, JSONException {
        ArrayList<contractBean> sa = new contract().getContractWithSorting().getContract();
        JSONArray jr = new JSONArray();
        if (max==0)
                max = sa.size();
        
        for (int s = 0; s < sa.size(); s++) {
            if (s < max) {
                JSONObject jb = new JSONObject();
                String cid = "" + sa.get(s).getCid();
                ComicWorks cm = new ComicWorksDB().getComicbyId(cid);
                jb.put("cname", cm.getName());
                jb.put("id", cid);
                jb.put("penName", cm.getPenName());
                jb.put("sch", cm.getSchedule());
                jb.put("cover", new imageTranslator().genImage(cm.getCoverPage()));
                jr.put(jb);
            }

        }

        sendJSon(res, jr);

    }

    public void sendJSon(HttpServletResponse res, JSONArray jr) throws IOException {
        res.setContentType("text/plain");
        res.setCharacterEncoding("UTF-8");
        res.getWriter().write(jr.toString());
    }

}
