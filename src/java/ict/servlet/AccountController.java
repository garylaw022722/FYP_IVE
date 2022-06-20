/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.EmailConfig;
import ict.bean.Account;
import ict.bean.userInfo;
import ict.db.AccountDB;
import ict.db.userInformation;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
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
@WebServlet(name = "AccountController", urlPatterns = {"/AccountController"})
public class AccountController extends HttpServlet   {
    



    public void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        try {
            AccountController(req, res);
        } catch (JSONException ex) {
            Logger.getLogger(AccountController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(AccountController.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void AccountController(HttpServletRequest req, HttpServletResponse res) throws JSONException, IOException, ParseException, ServletException {
        String operation = req.getParameter("operation");

        if (operation.equals("init")) {
            initUserInfo(req, res);

        } else if (operation.equals("updateUser")) {
            UpdateUserAccount(req, res);

        } else if (operation.equals("freezing")) {
            freezeAccount(req, res);

        } else if (operation.equals("getTypeUser")) {
            userTypeController(req, res);

        } else if (operation.equals("getBackground")) {
            getUserBackground(req, res);
        } else if (operation.equals("createMemberAc")) {
            createMemberAc(req, res);
        } else if (operation.equals("createInternalAc")) {
            createInternalAc(req, res);
        }else if(operation.equals("activation")){
           activation(req,res);
        }

    }
    
    
    
    public void activation(HttpServletRequest req, HttpServletResponse res) throws IOException, ParseException, ServletException {
         String  regCode = req.getParameter("regCode");
        if(new AccountDB().isActivate(regCode)){
           res.sendError(HttpServletResponse.SC_NOT_FOUND);
        
        }else{
       
        new AccountDB().activateAccount(regCode,"F","T"); 
          res.sendRedirect("Main.jsp");
        }
    }

    public void createInternalAc(HttpServletRequest req, HttpServletResponse res) throws IOException, ParseException {
        String address = req.getParameter("address");
        String subEmail = req.getParameter("subEmail");
        String contactNum = req.getParameter("contactNum");
        String userType = req.getParameter("userType");
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String password = req.getParameter("password");
        String emailAddress = req.getParameter("emailAddress");
        String gender = req.getParameter("Gender");
        String id  =req.getParameter("id");
        String dob = req.getParameter("DOB");
    }

    public void createMemberAc(HttpServletRequest req, HttpServletResponse res) throws IOException, ParseException {

        String address = req.getParameter("address");
        String subEmail = req.getParameter("subEmail");
        String contactNum = req.getParameter("contactNum");
 
        if(address.equals(",,"))
            address =null;
        if (subEmail.equals("")) {
            subEmail = null;
        }
        if (contactNum.equals("")) {
            contactNum = null;
        }
        String operation = req.getParameter("operation");
        String userType = req.getParameter("userType");
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String password = req.getParameter("password");
        String emailAddress = req.getParameter("emailAddress");

        String gender = req.getParameter("Gender");
        String dob = req.getParameter("DOB");
        String  regCode =getRegCode();
        Date   z=  new SimpleDateFormat("yyyy-mm-dd").parse(dob);
        java.sql.Date  dobd = new java.sql.Date(z.getTime());
      
        new userInformation().
                createAccount(emailAddress, firstName, lastName, address,
                        contactNum, subEmail, null, null,  dobd, 0, gender);

        new AccountDB().ActivateAccount(emailAddress, password, userType, "online", "T" ,regCode,null);
//            new   EmailConfig().sendEmail("garylaw696969@gmail.com", "garylawka696969@gmail.com","Registration Account Activation","<h1>Hi this your enail</h1>","");
        JSONArray jr = new JSONArray();
        String codePath ="http://127.0.0.1:8080/"+ req.getContextPath()+ req.getServletPath() +"?operation=activation&regCode="+regCode;
        jr.put(codePath);
        jr.put(emailAddress);
        sendJSon(res, jr);

    }
    
   public String  getRegCode(){
    String regCode ="";
       while(true){             
           String  rd = ""+ new Random().nextInt(99999999);
           if(!new AccountDB().isDuplication(rd)){
               regCode = rd;
                 break;                 
           }
   }  
       return regCode;
   } 
   

    public void getUserBackground(HttpServletRequest req, HttpServletResponse res) throws JSONException, IOException {
        String email = req.getParameter("email");
        userInformation ui = new userInformation();
        userInfo info = ui.getUserInfoByEmail(email).getUserinfoList().get(0);
        JSONArray jr = getBackground(info);

        sendJSon(res, jr);

    }

    public JSONArray getBackground(userInfo info) throws JSONException {
        JSONArray jr = new JSONArray();
        JSONObject jb = new JSONObject();
        String address = info.getAddress();
        String bankAccount = info.getBankAccount();
        if (address == null) {
            address = "N/A,N/A,N/A";
        }

        if (bankAccount == null) {
            bankAccount = "N/A";
        }

        HashMap map = spitAddress(address);
        jb.put("Building", map.get("Building"));
        jb.put("floor", map.get("floor"));
        jb.put("Street", map.get("Street"));
        jb.put("email", info.geteAddress());
        jb.put("FirstName", info.getFirstName());
        jb.put("lastName", info.getLastName());
        jb.put("SubAddress", info.getSubEmail());
        jb.put("contactNum", info.getContactNum());
        jb.put("idenNo", info.getIdenNo());
        jb.put("BankAccount", bankAccount);
        jb.put("DOB", info.getDob());
        jb.put("gender", info.getGender());

        jr.put(jb);

        return jr;
    }

    public HashMap<String, String> spitAddress(String email) {
        HashMap<String, String> map = new HashMap<String, String>();
        String[] parts = email.split(",");
        map.put("Building", parts[0]);
        map.put("floor", parts[1]);
        map.put("Street", parts[2]);

        return map;

    }

    public void userTypeController(HttpServletRequest req, HttpServletResponse res) throws JSONException, IOException {
        String user = req.getParameter("userType");
        if (user.equals("No Condition")) {
            initUserInfo(req, res);
        } else if (user.equals("Disable")) {
            getAccountByFreeze(res, "T");
        } else if (user.equals("Enable")) {
            getAccountByFreeze(res, "F");
        } else {
            getTypeUserInfo(req, res);
        }
    }

    public void getAccountByFreeze(HttpServletResponse res, String freeze) throws JSONException, IOException {
        JSONArray jr = null;

        Account ac = new AccountDB().getUserByFreeze(freeze);
        if (ac != null) {
            jr = getUserInfoByAC(ac);
        }

        sendJSon(res, jr);

    }

    public void initUserInfo(HttpServletRequest req, HttpServletResponse res) throws JSONException, IOException {
        JSONArray jr = new JSONArray();
        String state = "", text = "";

        AccountDB ac = new AccountDB();
        for (userInfo ui : new userInformation().getUserBackground().getUserinfoList()) {
            String userType = ac.getUserTypeByEmail(ui.geteAddress());
            if (!userType.equals("Admin")) {
                JSONObject jb = new JSONObject();
                jb.put("UserType", userType);
                jb.put("email", ui.geteAddress());
                jb.put("password", ac.getUserPasswordByEmail(ui.geteAddress()));
                jb.put("firstName", ui.getFirstName());
                jb.put("lastName", ui.getLastName());
                jb.put("Gender", ui.getGender());
                state = ac.getAccountByEmail(ui.geteAddress()).getAcList().get(0).getFreeze();
                text = (state.equals("T")) ? "Disable" : "Enabling";
                jb.put("freeze", text);
                jr.put(jb);
            }
        }

        sendJSon(res, jr);

    }

    public void getTypeUserInfo(HttpServletRequest req, HttpServletResponse res) throws JSONException, IOException {
        String user = req.getParameter("userType").trim();
        JSONArray jr = null;

        Account ac = new AccountDB().getTypeUser(user);
        if (ac != null) {
            jr = getUserInfoByAC(ac);
        }

        sendJSon(res, jr);
    }

    public JSONArray getUserInfoByAC(Account ac) throws JSONException {
        JSONArray jr = new JSONArray();
        String state = "", text = "";
        for (Account item : ac.getAcList()) {
            JSONObject jb = new JSONObject();
            jb.put("UserType", item.getUserType());
            jb.put("email", item.geteAddress());
            jb.put("password", item.getPassword());
            userInfo ui = new userInformation().getUserInfoByEmail(item.geteAddress()).getUserinfoList().get(0);
            jb.put("firstName", ui.getFirstName());
            jb.put("lastName", ui.getLastName());
            jb.put("Gender", ui.getGender());
            state = item.getFreeze();
            text = (state.equals("T")) ? "Disable" : "Enabling";
            jb.put("freeze", text);
            jr.put(jb);
        }

        return jr;

    }

    public void freezeAccount(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String email = req.getParameter("email");
        AccountDB ac = new AccountDB();
        String freeze = ac.getAccountByEmail(email).getAcList().get(0).getFreeze();
        freeze = (freeze.equals("F")) ? "T" : "F";
        ac.Freezing(email, freeze);
        JSONArray jr = new JSONArray();
        jr.put(freeze);
        sendJSon(res, jr);

    }

    public void UpdateUserAccount(HttpServletRequest req, HttpServletResponse res) {

    }

    public void sendJSon(HttpServletResponse res, JSONArray jr) throws IOException {
        res.setContentType("text/plain");
        res.setCharacterEncoding("UTF-8");
        res.getWriter().write(jr.toString());
    }

   
}
