/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.DateGenerator;
import ict.bean.Account;
import ict.bean.CustomBookBean;
import ict.db.CustomBook;
import ict.imageTranslator;
import ict.pdf_Generator;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
@MultipartConfig
@WebServlet(name = "texting", urlPatterns = {"/texting"})
public class texting extends HttpServlet {

    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            getFormDataObj(req, res);

        } catch (FileUploadException ex) {
            Logger.getLogger(texting.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            Logger.getLogger(texting.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            CustomController(req, res);
        } catch (JSONException ex) {
            Logger.getLogger(texting.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void CustomController(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, JSONException {
        String operation = req.getParameter("operation");
        if (operation.equals("getCustomBook")) {
            getCustom(req, res);
        } else if (operation.equals("showBook")) {
            showBook(req, res);
        }else if(operation.equals("download"))
            downloadBook(req,res);

    }
    
    
    public void downloadBook(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException, JSONException {
        JSONArray jr = new JSONArray();
        String cusID = req.getParameter("cid");        
        CustomBookBean vm = new CustomBook().getCustomBookById(Integer.valueOf(cusID));
        InputStream in = vm.getCustomBook();
        JSONObject jb = new JSONObject();
          jb.put("sources", new imageTranslator().genImage(vm.getCustomBook()));
          jb.put("name", vm.getCustomBookName());
          jr.put(jb);
       sendJSon(res, jr);
    
    }

    public void showBook(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException, JSONException {
        String customId = req.getParameter("cid");
        JSONArray jr = new JSONArray();
        JSONObject jb = new JSONObject();
        JSONArray Final = new JSONArray();
        CustomBookBean vm = new CustomBook().getCustomBookById(Integer.valueOf(customId));
        InputStream in = vm.getCustomBook();
       

     
        byte[] br = new byte[in.available()];
        in.read(br);
        ArrayList<byte[]> i = new pdf_Generator().seperate(br);
        for (byte[] s : i) {
            jr.put(new imageTranslator().genImageWithByte(s));

        }
        
        jb.put("Status", "SessionFounded");
        jb.put("pageNo", "B-Cid");
        jb.put("page", jr);
        jb.put("cusId", vm.getCustom_id());
        Final.put(jb);


        req.getSession().setAttribute("pageSources", Final);
        req.setAttribute("result", "read");
        RequestDispatcher rd = req.getRequestDispatcher("readBookGallery.jsp");
        rd.forward(req, res);

    }

    public void getCustom(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, JSONException {
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
        JSONArray jr = new JSONArray();
        CustomBookBean cb = new CustomBook().getCustomBookByEmail(user);
        for (CustomBookBean i : cb.getCustomBookList()) {
            JSONObject jb = new JSONObject();
            jb.put("cid", i.getCustom_id());
            jb.put("date", new DateGenerator().formatDate(i.getCustomBookDate(), "dd.MM.YYYY"));
            jb.put("name", i.getCustomBookName());
            if (i.getCovertPage() == null) {
                continue;
            }
            jb.put("cover", new imageTranslator().genImage(i.getCovertPage()));

            jr.put(jb);

        }

        sendJSon(res, jr);

    }

    public void getFormDataObj(HttpServletRequest req, HttpServletResponse res) throws FileUploadException, IOException, JSONException, ServletException {

        List<FileItem> list = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(req);
        InputStream cover = list.get(0).getInputStream();
        String json = list.get(1).getString();
        String bn = list.get(2).getString();
        createCustomBook(req, res, json, bn, cover);

    }

    public void createCustomBook(HttpServletRequest req, HttpServletResponse res, String json, String bookName, InputStream cover) throws JSONException, IOException, ServletException {
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
        HashMap<String, ArrayList<String>> pageRequired = handleJSON(json); // handle JSON data pass
        HashMap<String, byte[]> ListOf_Comic = getSessionComic(req, pageRequired); //get Resources (byte)
        ArrayList<byte[]> finalProduct = Sorting(pageRequired.get("sequence"), ListOf_Comic);
        req.setAttribute("customSources", finalProduct);
        req.setAttribute("operation", "uploadCustomBook");
        req.setAttribute("Des", req.getServletPath());
        req.setAttribute("eAddress", user);
        req.setAttribute("fileName", bookName);
        System.out.println("the size is : " + finalProduct.size());
        req.setAttribute("coverPage", cover);
        RequestDispatcher dis = req.getRequestDispatcher("/createState");
        dis.forward(req, res);

    }

    public void testingKey(HashMap<String, byte[]> ssa, HashMap<String, ArrayList<String>> pageRequired) {
        // finded th json key is selected in container
        String json = "JSONStringKey  = ";
        String selected = " Selected  = ";
        for (Map.Entry comic : ssa.entrySet()) {//
//            if (!comic.getKey().equals("sequence")) {
            json += comic.getKey() + ",";

//            }
        }
        System.out.println(json);
    }

    public HashMap<String, byte[]> getSessionComic(HttpServletRequest req, HashMap<String, ArrayList< String>> comic) {
        HttpSession sa = req.getSession();
        HashMap<String, byte[]> pages = new HashMap<String, byte[]>();
        for (Map.Entry code : comic.entrySet()) {
            if (!code.getKey().equals("sequence")) {
                String comicKey = (String) code.getKey();///code
                String sessionKey = comicKey + "-" + "Sources";
                System.out.print(sessionKey);
                ArrayList<String> pageNo = (ArrayList<String>) code.getValue();// value 
                ArrayList<byte[]> selectedComic = (ArrayList<byte[]>) sa.getAttribute(sessionKey);
                for (String page : pageNo) {
                    byte[] pageSources = selectedComic.get(Integer.valueOf(page));
                    pages.put(comicKey + "-" + page, pageSources);
                    System.out.print(comicKey + "-" + page);
                }

            }

        }
        return pages;
    }

    public ArrayList<byte[]> Sorting(ArrayList<String> sequence, HashMap<String, byte[]> sources) {
        ArrayList<byte[]> selectedList = new ArrayList<byte[]>();
        for (String seqItem : sequence) {
            selectedList.add(sources.get(seqItem));
        }
        return selectedList;
    }

    public HashMap<String, ArrayList<String>> handleJSON(String str) throws JSONException {
        HashMap<String, ArrayList<String>> pageRequired = new HashMap<String, ArrayList<String>>();
        JSONObject jb = new JSONObject(str);
        JSONArray Seris = jb.getJSONArray("pageCode");
        for (int s = 0; s < Seris.length(); s++) {
            JSONObject comicSession = Seris.getJSONObject(s);
            String codeKey = comicSession.get("comicSession").toString();
            ArrayList<String> pageNumber = getPageNumber_And_Sequence(comicSession.getJSONArray("comicPage"));
            pageRequired.put(codeKey, pageNumber);
        }
        JSONArray sequence = jb.getJSONArray("sequence");
        pageRequired.put("sequence", getPageNumber_And_Sequence(sequence));

        return pageRequired;

    }

    public ArrayList<String> getPageNumber_And_Sequence(JSONArray page) throws JSONException {
        ArrayList<String> pageSelected = new ArrayList<String>();
        for (int sa = 0; sa < page.length(); sa++) {
            pageSelected.add(page.getString(sa));
        }

        return pageSelected;

    }

    public void sendJSon(HttpServletResponse res, JSONArray jr) throws IOException {
        res.setContentType("text/plain");
        res.setCharacterEncoding("UTF-8");
        res.getWriter().write(jr.toString());
    }

}
