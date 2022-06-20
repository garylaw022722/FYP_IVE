package ict.servlet;

import ict.bean.CustomBookBean;
import ict.bean.episodes;
import ict.db.CustomBook;
import ict.db.episode;
import ict.imageTranslator;
import ict.pdf_Generator;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map.Entry;
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
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author law
 */
@MultipartConfig
@WebServlet(name = "createState", urlPatterns = {"/createState"})
public class createState extends HttpServlet {

    ArrayList<String> list = null;
    String w = "";
    InputStream file = null;

//    String list="";
    public void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String operation = (String) req.getAttribute("operation");
        if (operation.equals("initComic")) {
            initComicEpisodeFromDB(req, res);
        }
    }

    public void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            uploadController(req, res);
        } catch (NullPointerException ex) {
            upload(req, res);
        } catch (JSONException ex) {
            Logger.getLogger(createState.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void uploadController(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, JSONException {

        if (req.getAttribute("operation").equals("uploadCustomBook")) {
            uploadCustomBook(req, res);
        }

    }

    public void getTag(HttpServletRequest req, HttpServletResponse res) throws IOException {
        HttpSession ss = req.getSession();
        JSONArray jr = (JSONArray) ss.getAttribute("tag");
        sendJSon(res, jr);

    }

    public void sendJSon(HttpServletResponse res, JSONArray jr) throws IOException {
        res.setContentType("text/plain");
        res.setCharacterEncoding("UTF-8");
        res.getWriter().write(jr.toString());
    }

    public void upload(HttpServletRequest req, HttpServletResponse res) throws ServletException {
        List<FileItem> items = null;
        ArrayList<byte[]> sa = new ArrayList<byte[]>();
        String fieldName = "", fileName = "";
        String path = "";
        String dir = "";
        try {
            items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(req);

            for (FileItem item : items) {
                if (!item.isFormField()) {
                    fieldName = item.getFieldName();
                    fileName = FilenameUtils.getName(item.getName());
                    System.out.print(fieldName);
                    if (fieldName.equals("coverPage")) {///upload episode                           
                        file = item.getInputStream();
//                        new episode().uploadCoverPage(in);
//                        in.close();
                        continue;
                    }

                    System.out.println(fileName);
                    InputStream in = item.getInputStream();

//                   path ="/Users/law/Desktop/ComicWorks/admin/" + fileName;
                    dir = "/Users/law/Desktop/ComicWorks/admin/";

//                    OutputStream out = new FileOutputStream(path);
                    byte[] br = new byte[in.available()];
                    in.read(br);

//                    out.write(br);
                    in.close();
//                    out.close();
//                    sa.add(br);
                    System.out.print(fieldName);

                    HttpSession ss = req.getSession();
//                     ArrayList<String> list =new pdf_Generator().seperate(br);
//                        list =   new pdf_Generator().seperator(dir,fileName);
//                   JSONArray  json = sendJSon(new pdf_Generator().seperate(br));
//                      ss.setAttribute("tag",list );
                    ss.setAttribute("base64String", new pdf_Generator().seperate(br, fileName));
//                        ss.setAttribute("base64String", new pdf_Generator().seperate(dir, "sassa", br));
//                        int []  pageNo  = {0,30};
//                            ss.setAttribute("base64String", new pdf_Generator().getImagePageById(pageNo,br));

//                    episode ep = new episode();
//                    File  s =new File(path);
//                    ep.addPdf_Path(path);
                } else {
                    String field = item.getFieldName();
                    if (field.equals("MJ")) {
                        previewComic(req, res);
                    } else if (field.equals("create")) {
                        UploadEpisode(item.getString(), res, req);
                    }
//                         HandlUploadForm(req,res);

                }

            }
        } catch (Exception es) {
            es.printStackTrace();
        }
//            new pdf_Generator().create(sa, dir);
    }

    public void previewComic(HttpServletRequest req, HttpServletResponse res) throws IOException, JSONException {
        LinkedHashMap<String, byte[]> itemlist = (LinkedHashMap<String, byte[]>) req.getSession().getAttribute("base64String");
        HashMap<String, String> sa = new HashMap<String, String>();
        String key = "", value = "";
        JSONArray jr = new JSONArray();
        imageTranslator it = new imageTranslator();
// 
        for (Entry<String, byte[]> item : itemlist.entrySet()) {
            JSONObject jb = new JSONObject();
            key = item.getKey();
            value = it.genImageWithByte(item.getValue());
            jb.put("pageCode", key);
            jb.put("sources", value);
            sa.put(key, value);
            jr.put(jb);
        }
        backUpForSources(sa, req);
        sendJSon(res, jr);
    }

    public void backUpForSources(HashMap<String, String> page, HttpServletRequest req) {
        HttpSession ss = req.getSession();
        ss.setAttribute("base64Bean", page);
    }

    

    public void uploadCustomBook(HttpServletRequest req, HttpServletResponse res) throws IOException, JSONException, ServletException {
        JSONArray jr = new JSONArray();
        jr.put("it is ok!!!");
        ArrayList<byte[]> pageCodeSet = (ArrayList<byte[]>) req.getAttribute("customSources");
        ArrayList<String> pageCodeString = base64Encoder(pageCodeSet);
        InputStream item = new pdf_Generator().create(pageCodeSet, "/Users/law/Desktop/m2");
        String Des = req.getAttribute("Des").toString();
        String eAddress = req.getAttribute("eAddress").toString();
        String fileName = req.getAttribute("fileName").toString();
        InputStream coverPage = (InputStream) req.getAttribute("coverPage");
        CustomBookBean  cb   =new CustomBook().getMaxId(eAddress);
         int custom_id =(cb!=null)?cb.getCustom_id()+1:1;                         
        new CustomBook().insertNewBook(eAddress, item, fileName, coverPage, custom_id);
        String key = eAddress + "-custom-" + custom_id;
        createComicSession(pageCodeString, pageCodeSet, key, req);
        sendJSon(res, jr);

    }

    public void initComicEpisodeFromDB(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {//double file 

        episodes reqEp = (episodes) req.getAttribute("selectedEpisode");
        String Des = req.getAttribute("Des").toString();
        String result = req.getAttribute("result").toString();// response operation 
        InputStream in = reqEp.getPdf();
        byte[] so = new byte[in.available()];
        in.read(so);
        in.close();

        String key = reqEp.getCid() + "-" + reqEp.getEp();
        ArrayList<byte[]> pageCodeSet = new pdf_Generator().seperate(so);
        ArrayList<String> pageCodeString = base64Encoder(pageCodeSet);
        createComicSession(pageCodeString, pageCodeSet, key, req);
        req.setAttribute("result", result);
        req.getRequestDispatcher(Des).forward(req, res);
    }

    public ArrayList<String> base64Encoder(ArrayList<byte[]> ute) throws IOException {
        imageTranslator it = new imageTranslator();
        ArrayList<String> container = new ArrayList<String>();
        for (byte[] item : ute) {
            container.add(it.genImageWithByte(item));
        }

        return container;

    }

    public void UploadEpisode(String pageCode, HttpServletResponse res, HttpServletRequest req) throws IOException, JSONException {
        String dir = "/Users/law/Desktop/m2/";
        episode ep = new episode();
        HashMap<String, Object> data = getEpisodeFormData(pageCode);
        ArrayList<byte[]> pageCodeSet = getSourcesPage((ArrayList<String>) data.get("pageMain"), req);
        ArrayList<String> pageCodeString = getSourceString((ArrayList<String>) data.get("pageMain"), req);
        InputStream input = new pdf_Generator().create(pageCodeSet, dir);
        String comicId = data.get("comicId").toString();
        int epi = Integer.valueOf(data.get("epNo").toString());
        String key = comicId + "-" + epi;       
        String title =  "Session "+epi+" :"+data.get("title").toString();
        String desc = data.get("Desc").toString();
        ep.uploadEpisode(comicId, epi, title, desc, file, 0, input, "P");
        createComicSession(pageCodeString, pageCodeSet, key, req);

//        createPDF(pageCode,res,req);
    }

    public void createComicSession(ArrayList<String> backup, ArrayList<byte[]> sources, String key, HttpServletRequest req) {
        HttpSession s = req.getSession();
        System.out.println(key + "-Sources");
        s.setAttribute(key + "-Copy", backup);
        s.setAttribute(key + "-Sources", sources);

    }

    public HashMap<String, Object> getEpisodeFormData(String pageCode) throws JSONException {
        HashMap<String, Object> item = new HashMap<String, Object>();
        ArrayList<String> pageMain = new ArrayList<String>();
        ArrayList<String> pageCopy = new ArrayList<String>();
        JSONObject sa = new JSONObject(pageCode);
        item.put("comicId", sa.getString("comicId"));
        item.put("title", sa.getString("title"));
        item.put("epNo", sa.getString("epNo"));
        item.put("Desc", sa.getString("Des"));
        JSONArray sources = sa.getJSONArray("sources");
        JSONArray list = sa.getJSONArray("page");

        for (int s = 0; s < sources.length(); s++) {
            pageMain.add(list.get(s).toString());
            pageCopy.add(sources.get(s).toString());
        }
        item.put("pageMain", pageMain);
        item.put("pageBackup", pageCopy);

        return item;
    }

    public ArrayList<String> getSourceString(ArrayList<String> pagecode, HttpServletRequest req) {
        HashMap<String, String> itemlist = (HashMap<String, String>) req.getSession().getAttribute("base64Bean");
        ArrayList<String> imgString = new ArrayList<String>();
        for (String sa : pagecode) {
            imgString.add(itemlist.get(sa));

        }
        return imgString;

    }

    public ArrayList<byte[]> getSourcesPage(ArrayList<String> pagecode, HttpServletRequest req) {
        LinkedHashMap<String, byte[]> itemlist = (LinkedHashMap<String, byte[]>) req.getSession().getAttribute("base64String");
        ArrayList<byte[]> imgByte = new ArrayList<byte[]>();
        for (String sa : pagecode) {
            imgByte.add(itemlist.get(sa));

        }

        return imgByte;
    }

    public ArrayList<byte[]> getSourcesPage(String pageCode, HttpServletResponse res, HttpServletRequest req) throws IOException, JSONException {
        JSONObject sa = new JSONObject(pageCode);
        System.out.print(pageCode);
        LinkedHashMap<String, byte[]> itemlist = (LinkedHashMap<String, byte[]>) req.getSession().getAttribute("base64String");
        ArrayList<byte[]> imgByte = new ArrayList<byte[]>();
        JSONArray list = sa.getJSONArray("page");
        for (int s = 0; s < list.length(); s++) {
            imgByte.add(itemlist.get(list.get(s)));

        }

        return imgByte;

    }

}
