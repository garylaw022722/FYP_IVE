/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.CreateBundle;
import ict.db.ProductDB;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;
import javax.servlet.RequestDispatcher;
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
 * @author User
 */
@WebServlet(name = "CreateRBundle", urlPatterns = {"/createRBundle"})
public class CreateRBundle extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            String dburl = "jdbc:mysql://localhost:3306/fyp";
            String dbUser = "root";
            String dbPassword = "";
            String imgName = "";
            String action = request.getParameter("action");
            CreateBundle cbb = new CreateBundle();
            JSONObject json = new JSONObject();
            JSONArray array = new JSONArray();
            try {
                if (action.equals("all")) {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection(dburl, dbUser, dbPassword);
                    String s2 = "SELECT product_id,bundleset.bid as bid,coverPage,Name,type,price,Stock,Public,startDate FROM bundleset,product where bundleset.bid = product.bid AND product_id LIKE 'r%'";
                    PreparedStatement pstmt2 = con.prepareStatement(s2);
                    ResultSet rs = pstmt2.executeQuery();
                    while (rs.next()) {
                        CreateBundle cb = new CreateBundle();
                        cb.setProduct_id(rs.getString("product_id"));
                        cb.setBid(rs.getString("bid"));
                        Blob blob = rs.getBlob("coverPage");
                        InputStream inputStream = blob.getBinaryStream();
                        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                        byte[] buffer = new byte[4096];
                        int bytesRead = -1;

                        while ((bytesRead = inputStream.read(buffer)) != -1) {
                            outputStream.write(buffer, 0, bytesRead);
                        }

                        byte[] imageBytes = outputStream.toByteArray();
                        String base64Image = Base64.getEncoder().encodeToString(imageBytes);

                        inputStream.close();
                        outputStream.close();
                        imgName = base64Image;
                        cb.setName(rs.getString("Name"));
                        cb.setType(rs.getString("type"));
                        cb.setPrice(rs.getInt("price"));
                        cb.setStock(rs.getInt("Stock"));
                        cb.setPublic(rs.getString("Public"));
                        cb.setStartDate(rs.getString("startDate"));
                        cb.setBase64Image(imgName);
                        cbb.addList(cb);

                    }
                    request.setAttribute("cb", cbb);
                    RequestDispatcher rd;
                    rd = getServletContext().getRequestDispatcher("/createRBundleSet.jsp");
                    rd.forward(request, response);
                    con.close();
                } else if (action.equals("search")) {
                    String bid = request.getParameter("bid");
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection(dburl, dbUser, dbPassword);
                    String s2 = "SELECT * FROM bundleset WHERE bid = '" + bid + "'";
                    PreparedStatement pstmt2 = con.prepareStatement(s2);
                    ResultSet rs = pstmt2.executeQuery();
                    while (rs.next()) {
                        JSONObject getDetail = new JSONObject();
                        Blob blob = rs.getBlob("coverPage");
                        InputStream inputStream = blob.getBinaryStream();
                        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                        byte[] buffer = new byte[4096];
                        int bytesRead = -1;

                        while ((bytesRead = inputStream.read(buffer)) != -1) {
                            outputStream.write(buffer, 0, bytesRead);
                        }

                        byte[] imageBytes = outputStream.toByteArray();
                        String base64Image = Base64.getEncoder().encodeToString(imageBytes);

                        inputStream.close();
                        outputStream.close();
                        imgName = base64Image;
                        getDetail.put("Name", rs.getString("Name"));
                        getDetail.put("bid", rs.getString("bid"));
                        getDetail.put("CoverPage", imgName);
                        array.put(getDetail);

                    }
                    json.put("BundleDetail", array);
                    out.write(json.toString());

                } else if (action.equals("insertProduct")) {
                    String bid = request.getParameter("hiddenbid");
                    String productID = "r";
                    int Insertprice = Integer.parseInt(request.getParameter("Insertprice"));
                    int InsertStock = Integer.parseInt(request.getParameter("InsertStock"));
                    String Insertpublic = request.getParameter("Insertpublic");
                    DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                    Date date = new Date();
                    ProductDB pdb = new ProductDB();
                    int max = 0;
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection(dburl, dbUser, dbPassword);
                    String s = "SELECT  `product_id` FROM `product` WHERE `product_id` like ?";
                    PreparedStatement pstmt2 = con.prepareStatement(s);
                    pstmt2.setString(1, "r%");
                    ResultSet rs = pstmt2.executeQuery();
                    while (rs.next()) {
                        String number = rs.getString(1).substring(1);
                        if (Integer.valueOf(number) > max) {
                            max = Integer.valueOf(number);
                        }
                    }
                    productID = productID + (max + 1);
                    String s2 = "INSERT INTO product VALUES ('" + productID + "',null,null,'" + bid + "','" + Insertprice + "',0,'" + InsertStock + "','" + dateFormat.format(date) + "',null,null,'" + Insertpublic + "','')";
                    pstmt2 = con.prepareStatement(s2);
                    pstmt2.executeUpdate();
                    con.close();
                    out.println("<script>alert('Create Sucessful!');location.href = 'createRBundle?action=all';</script>");
                } else if (action.equals("UpdateProduct")) {
                    String UpdateproductID = request.getParameter("UpdateproductID");
                    int Updateprice = Integer.parseInt(request.getParameter("Updateprice"));
                    int UpdateStock = Integer.parseInt(request.getParameter("UpdateStock"));
                    String Updatepublic = request.getParameter("Updatepublic");
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection(dburl, dbUser, dbPassword);
                    String s = "UPDATE product SET price=?,Stock=?,Public=? WHERE product_id=?";
                    PreparedStatement pstmt2 = con.prepareStatement(s);
                    pstmt2.setInt(1, Updateprice);
                    pstmt2.setInt(2, UpdateStock);
                    pstmt2.setString(3, Updatepublic);
                    pstmt2.setString(4, UpdateproductID);
                    pstmt2.executeUpdate();
                    con.close();
                    out.println("<script>alert('Update Sucessful!');location.href = 'createRBundle?action=all';</script>");
                } else if (action.equals("Delete")) {
                    String productID = request.getParameter("productID");
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection(dburl, dbUser, dbPassword);
                    String s = "DELETE FROM product where product_id=?";
                    PreparedStatement pstmt2 = con.prepareStatement(s);
                    pstmt2.setString(1, productID);
                    pstmt2.executeUpdate();
                    con.close();
                    out.println("<script>alert('Delete Sucessful!');location.href = 'createRBundle?action=all';</script>");
                } else if (action.equals("searchKey")) {
                    String productID = request.getParameter("key");
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection(dburl, dbUser, dbPassword);
                    String s2 = "SELECT product_id,bundleset.bid as bid,coverPage,Name,type,price,Stock,Public,startDate FROM bundleset,product where bundleset.bid = product.bid AND product_id LIKE 'r%' AND product_id = '" + productID + "'";
                    PreparedStatement pstmt2 = con.prepareStatement(s2);
                    ResultSet rs = pstmt2.executeQuery();
                    while (rs.next()) {
                        CreateBundle cb = new CreateBundle();
                        cb.setProduct_id(rs.getString("product_id"));
                        cb.setBid(rs.getString("bid"));
                        Blob blob = rs.getBlob("coverPage");
                        InputStream inputStream = blob.getBinaryStream();
                        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                        byte[] buffer = new byte[4096];
                        int bytesRead = -1;

                        while ((bytesRead = inputStream.read(buffer)) != -1) {
                            outputStream.write(buffer, 0, bytesRead);
                        }

                        byte[] imageBytes = outputStream.toByteArray();
                        String base64Image = Base64.getEncoder().encodeToString(imageBytes);

                        inputStream.close();
                        outputStream.close();
                        imgName = base64Image;
                        cb.setName(rs.getString("Name"));
                        cb.setType(rs.getString("type"));
                        cb.setPrice(rs.getInt("price"));
                        cb.setStock(rs.getInt("Stock"));
                        cb.setPublic(rs.getString("Public"));
                        cb.setStartDate(rs.getString("startDate"));
                        cb.setBase64Image(imgName);
                        cbb.addList(cb);

                    }
                    request.setAttribute("cb", cbb);
                    RequestDispatcher rd;
                    rd = getServletContext().getRequestDispatcher("/createRBundleSet.jsp");
                    rd.forward(request, response);
                    con.close();
                }
            } catch (ClassNotFoundException ex) {
                ex.printStackTrace();
            } catch (SQLException ex) {
                while (ex != null) {
                    ex.printStackTrace();
                    ex = ex.getNextException();
                }

            } catch (JSONException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
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
