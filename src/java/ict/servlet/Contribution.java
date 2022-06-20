/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.DateGenerator;
import ict.bean.Account;
import ict.bean.ComicWorks;
import ict.bean.ContributeBean;
import ict.bean.meetingRequestBean;
import ict.bean.userInfo;
import ict.db.ComicWorksDB;
import ict.db.ContributeDB;
import ict.db.contract;
import ict.db.dbOperation;
import ict.db.meetingRequestDB;
import ict.db.userInformation;
import ict.imageTranslator;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
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
import sun.rmi.server.Dispatcher;

/**
 *
 * @author law
 */
@WebServlet(name = "Contribution", urlPatterns = {"/Contribution"})
@MultipartConfig
public class Contribution extends HttpServlet {

    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            PostController(req, res);
        } catch (JSONException ex) {
            Logger.getLogger(Contribution.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Contribution.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(Contribution.class.getName()).log(Level.SEVERE, null, ex);
        } catch (FileUploadException ex) {
            Logger.getLogger(Contribution.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            RequestController(req, res);
        } catch (JSONException ex) {
            Logger.getLogger(meetingRequest.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Contribution.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(Contribution.class.getName()).log(Level.SEVERE, null, ex);
        } catch (FileUploadException ex) {
            Logger.getLogger(Contribution.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void PostController(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, JSONException, SQLException, ParseException, FileUploadException {
        List<FileItem> list = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(req);
        JSONArray jr = new JSONArray();
        String operation = list.get(0).getString();
        if (operation.equals("submitContribution")) {
            jr = getFormData(req, res, list);
        }

        sendJSon(jr, res);

    }

    public void RequestController(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, JSONException, SQLException, ParseException, FileUploadException {
        String operation = req.getParameter("operation");
        JSONArray jr = null;
        if (operation.equals("getAllContribution")) {
            jr = getAllContribute(req, res, " Select * from Contribution");
        } else if (operation.equals("searchContribute")) {
            jr = searchContribute(req, res);
        } else if (operation.equals("showContact")) {
            jr = showContributorContact(req, res);
        } else if (operation.equals("showContributeDetails")) {
            jr = showContributionDetails(req, res);
        } else if (operation.equals("getComment")) {
            jr = showComment(req, res);
        } else if (operation.equals("comment")) {
            jr = comment(req, res);
        } else if (operation.equals("getContributionSender")) {
            jr = getContributionSender(req, res);

        }
        sendJSon(jr, res);
    }

    public JSONArray getContributionSender(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, JSONException {
        //get submited  contirbution sender details ;
        JSONArray jr = new JSONArray();
        String keyword = req.getParameter("keyword");
        System.out.print("it'scallled ");
        JSONObject jb = new JSONObject();
        ContributeDB db = new ContributeDB();

        for (ContributeBean sa : db.getAll_Contribution().getList()) {
            if (String.valueOf(sa.getConId()).equals(keyword) || sa.getTitle().equals(keyword)) {

                if (!new contract().hasContriId(sa.getConId())) {
                    String eAddress = sa.geteAddress();
                    jb = getSenderInfo(eAddress);
                    jb.put("conId", sa.getConId());
                    jb.put("title", sa.getTitle());
                    jr.put(jb);

                } else if (new contract().hasContriId(sa.getConId()) == true) {
                    jb.put("msg", "Your Searching  Contribution  has been signed ");
                    jr.put(jb);

                }
            }

        }

        return jr;
    }

    public JSONObject getSenderInfo(String eAddress) throws JSONException {
        JSONObject jb = new JSONObject();
        userInfo user = new userInformation().getUserInfoByEmail(eAddress).getUserinfoList().get(0);
        jb.put("FirstName", user.getFirstName());
        jb.put("email", user.geteAddress());
        jb.put("LastName", user.getLastName());
        jb.put("Address", user.getAddress());
        jb.put("tel", user.getContactNum());
        jb.put("idenNo", user.getIdenNo());
        jb.put("BankAccount", user.getBankAccount());
        jb.put("DOB", user.getDob());
        jb.put("gender", user.getGender());

        return jb;

    }

    public JSONArray getFormData(HttpServletRequest req, HttpServletResponse res, List<FileItem> list) throws ServletException, IOException, JSONException, FileUploadException, ParseException {
        JSONArray jr = new JSONArray();

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
        String firstName = list.get(1).getString();
        String lastName = list.get(2).getString();
        String phone = list.get(3).getString();
        String gender = list.get(4).getString();
        String callF = list.get(5).getString();
        String callT = list.get(6).getString();
        String floor = list.get(7).getString();
        String dest = list.get(8).getString();
        String building = list.get(9).getString();

        String comicName = list.get(10).getString();
        String fileName = list.get(11).getString();

        InputStream comic = list.get(12).getInputStream();
        String description = list.get(13).getString();

        String address = building + "," + floor + "," + dest;

        Time from = parseTime(callF);
        Time to = parseTime(callT);

        new userInformation().updateUserPortfolio(lastName, firstName, address, phone, gender, user);
        //update userInfo

        new ContributeDB().SubmitContribution(comicName, user, from, description, comic, fileName, null, null, to);

//       System.out.print(filN);
        jr.put(fileName);

        return jr;
    }

    public Time parseTime(String td) throws ParseException {

        SimpleDateFormat sf = new SimpleDateFormat("HH:mm");
        java.util.Date sa = (java.util.Date) sf.parse(td);
        java.sql.Time ps1 = new java.sql.Time(sa.getTime());
        return ps1;

    }

    public JSONArray comment(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, JSONException {
        String conId = req.getParameter("conId");
        String comment = req.getParameter("com");
        new ContributeDB().innsertComment(comment, Integer.valueOf(conId));

        return new JSONArray();
    }

    public JSONArray showContributionDetails(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, JSONException {
        JSONObject jb = new JSONObject();
        JSONArray jr = new JSONArray();
        String conId = req.getParameter("conId");
        ContributeBean user = new ContributeDB().getContributionById(Integer.valueOf(conId));
        String desc = user.getDescription();

        jb.put("desc", desc);

        jr.put(jb);
        return jr;

    }

    public JSONArray showComment(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, JSONException {
        JSONObject jb = new JSONObject();
        JSONArray jr = new JSONArray();
        String conId = req.getParameter("conId");
        ContributeBean user = new ContributeDB().getContributionById(Integer.valueOf(conId));
        String comment = user.getComment();

        jb.put("comment", comment);

        jr.put(jb);

        return jr;

    }

    public JSONArray showContributorContact(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, JSONException, ParseException {
        JSONObject jb = new JSONObject();
        JSONArray jr = new JSONArray();
        String conId = req.getParameter("conId");

        ContributeBean user = new ContributeDB().getContributionById(Integer.valueOf(conId));
        String eAddress = user.geteAddress();
        System.out.print(eAddress);
        String call_FirstPeriod = new DateGenerator().formatTime(user.getTime(), "hh.mm aa");
        String call_LastPeriod = new DateGenerator().formatTime(user.getCallLast(), "hh.mm aa");
        userInfo ui = new userInformation().getUserInfoByEmail(eAddress).getUserinfoList().get(0);
        System.out.print(ui.getGender());
        String gender = (ui.getGender().equals("Male")) ? "Mr." : "Miss.";
        String name = gender + " " + ui.getFirstName();
        String contactNum = ui.getContactNum();
        String period = "From " + call_FirstPeriod + " to " + call_LastPeriod;
        jb.put("name", name);
        jb.put("period", period);
        jb.put("contactNo", contactNum);
        jr.put(jb);

//         jb.put(, value)
        return jr;
    }

    public JSONArray searchContribute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, JSONException, SQLException {
        String sender = req.getParameter("Sender");
        JSONArray jr = new JSONArray();
        String date = req.getParameter("Date");
        String text = req.getParameter("textContent");
        System.out.print(sender);
        if (sender.equals("All") || sender.equals("")) {
            String query = SearchingQuery(req,sender, date, text);
            if (!query.equals("")) {
                jr = getAllContribute(req, res, query);
            }

        } else {
            Connection con = new dbOperation().getConnection();

            String query = SearchingQuery(req,sender, date, text);
            if (query.equals("")) {
                return jr;
            }
            Statement state = con.createStatement();
            ResultSet rs = state.executeQuery(query);
            while (rs.next()) {
                String penName, cName;
                int conid = rs.getInt("conId");
                Timestamp subTime = rs.getTimestamp("submissionDate");
                String eAddress = rs.getString("eAddress");
                String title = rs.getString("title");
                String fileName = rs.getString("fileName");
                InputStream pdf = rs.getBinaryStream("pdf");

                if (sender.equals("Member")) {

                    cName = "N/A";
                    penName = "N/A";

                } else {
                    cName = rs.getString("Name");
                    penName = rs.getString("penName");

                }
                JSONObject jb = AddField(conid, subTime,
                        eAddress, penName, cName, title,
                        fileName, pdf);
                jr.put(jb);
//            
            }
            con.close();
            state.close();
            rs.close();

        }
        return jr;

    }

    public String SearchingQuery(HttpServletRequest req,String sender, String date, String text) throws JSONException, IOException {
        String comicName = "", penName = "";
        String query = "";
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
        boolean textNotFinded = false;

        if (sender.equals("Author")) {
            query = " SELECT ct.* ,Name ,penName FROM `Contribution` ct,ComicWorks cw WHERE  ct.`comic_Id` = cw.`comic_Id` And responsor = '" + user + "'";
        } else if (sender.equals("Member")) {
            query = " SELECT ct.* FROM `Contribution` ct  where comic_Id is null";
        } else if (sender.equals("All") || sender.equals("")) {
            query = "SELECT ct.* FROM `Contribution` ct  ,Account ac  Where ac.eAddress  = ct.eAddress   ";
        }

        if (!text.equals("")) {
            String sk = FindTextField(text);
            if (!sk.equals("")) {
                query += sk;
            } else {
                textNotFinded = true;
            }
        }

        if (!date.equals("")) {
            query += "And  Date(`submissionDate` ) ='" + date + "' ";
        }

        if (textNotFinded) {
            query = "";
        }

        return query;

    }

    public String FindTextField(String text) {
        String fieldString = "";
        System.out.print(text);
        for (ContributeBean item : new ContributeDB().getAll_Contribution().getList()) {
            if (text.equals("" + item.getConId())) {
                fieldString = " And conId ='" + item.getConId() + "' ";
            } else if (text.equals(item.geteAddress())) {
                fieldString = " And ct.eAddress ='" + item.geteAddress() + "' ";
            } else {
                ComicWorks cm = new ComicWorksDB().getComicbyId(item.getComic_Id());
                if (text.equals(cm.getPenName())) {
                    fieldString = "And penName ='" + cm.getPenName() + "' ";
                } else if (text.equals(cm.getName())) {
                    fieldString = "And Name ='" + cm.getName() + "' ";
                }

            }

        }

        return fieldString;
    }

    public JSONArray getAllContribute(HttpServletRequest req, HttpServletResponse res, String query) throws ServletException, IOException, JSONException {
        JSONArray jr = new JSONArray();
        String cName = "", penName = "";
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
        System.out.print(query);
        ArrayList<ContributeBean> list = new ContributeDB().getAll_Contribution(query).getList();
        if (list == null) {
            return jr;
        }

        for (ContributeBean item : list) {

            String id = item.getComic_Id();
            if (item.getComic_Id() != null) {
                ComicWorks cm = new ComicWorksDB().getComicbyId(id);

                if (cm.getResponsor() == null || !cm.getResponsor().equals(user)) {
                    continue;
                }
                penName = cm.getPenName();
                cName = cm.getName();

            } else {
                penName = "N/A";
                cName = "N/A";
            }
            JSONObject jb = AddField(item.getConId(), item.getSubTime(),
                    item.geteAddress(), penName, cName, item.getTitle(),
                    item.getFileName(), item.getPdf());
            jr.put(jb);
        }
        return jr;

    }

    public JSONObject AddField(int conid, Timestamp subTime, String eAddress, String penName,
            String cName, String title, String fileName, InputStream pdf) throws JSONException, IOException {
        JSONObject jb = new JSONObject();
        jb.put("conId", conid);
        jb.put("subDate", subTime);
        jb.put("eAddress", eAddress);
        jb.put("penName", penName);
        jb.put("comicName", cName);
        jb.put("title", title);
        jb.put("fileName", fileName);
        jb.put("file", new imageTranslator().genImage(pdf));
        return jb;

    }

    public void sendJSon(JSONArray jr, HttpServletResponse res) throws ServletException, IOException {
        res.setContentType("text/plain");
        res.setCharacterEncoding("UTF-8");
        res.getWriter().write(jr.toString());
    }

}
