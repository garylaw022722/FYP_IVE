/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import ict.bean.ComicBean;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;

/**
 *
 * @author user
 */
public class BookDb {

    private String url = "";
    private String username = "";
    private String password = "";
   dbOperation sa  = null;
    public BookDb() {       
        sa = new dbOperation();
    }

    public Connection getConnection() throws SQLException, IOException {
        return sa.getConnection();
    }

    public ArrayList getBookCaseList(ArrayList Al) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList ebs = new ArrayList();

        try {
            cnnct = getConnection();
            for (int i = 0; i < Al.size(); i++) {
                String preQueryStatement = "SELECT comic_Id,Name,coverPage FROM comicworks WHERE comic_Id = " + Al.get(i);
                pStmnt = cnnct.prepareStatement(preQueryStatement);
                ResultSet rs = null;
                rs = pStmnt.executeQuery();

                while (rs.next()) {
                    ComicBean c = new ComicBean();
                    c.setComic_Id(rs.getInt(1));
                    c.setName(rs.getString(2));
                    
                    Blob blob = rs.getBlob(3);
                    InputStream inputStream = blob.getBinaryStream();
                    ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                    byte[] buffer = new byte[4096];
                    int bytesRead = -1;

                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }

                    byte[] imageBytes = outputStream.toByteArray();
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                    c.setCoverPage(base64Image);
                    
                    ebs.add(c);
                }
            }
            cnnct.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return ebs;
    }
    public ArrayList getUserBookCaseList(String EAdress) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList ebs = new ArrayList();
        
        try {
            cnnct = getConnection();
                String preQueryStatement = "SELECT comic_id FROM collection WHERE eAddress = '" + EAdress+"'";
                pStmnt = cnnct.prepareStatement(preQueryStatement);
                ResultSet rs = null;
                rs = pStmnt.executeQuery();
                
                while (rs.next()) {
                    ebs.add(rs.getInt(1));
                }
            cnnct.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return ebs;
    }
    public ComicBean getEleBookCaseList(int comic_Id) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ComicBean c = new ComicBean();
        try {
            cnnct = getConnection();
                String preQueryStatement = "SELECT comic_Id,Name,coverPage FROM comicworks WHERE comic_Id = " + comic_Id;
                pStmnt = cnnct.prepareStatement(preQueryStatement);
                ResultSet rs = null;
                rs = pStmnt.executeQuery();

                while (rs.next()) {
                    
                    c.setComic_Id(rs.getInt(1));
                    c.setName(rs.getString(2));
                    
                    Blob blob = rs.getBlob(3);
                    InputStream inputStream = blob.getBinaryStream();
                    ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                    byte[] buffer = new byte[4096];
                    int bytesRead = -1;

                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }

                    byte[] imageBytes = outputStream.toByteArray();
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                    c.setCoverPage(base64Image);
            }
            cnnct.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return c;
    }
    
    public ComicBean getRealtricBookCaseList(int bid) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList ebs = new ArrayList();
        ComicBean c = new ComicBean();
        try {
            cnnct = getConnection();
                String preQueryStatement = "SELECT bid,Name FROM bundleset WHERE bid = " + bid;
                pStmnt = cnnct.prepareStatement(preQueryStatement);
                ResultSet rs = null;
                rs = pStmnt.executeQuery();

                while (rs.next()) {
                    c.setBid(rs.getInt(1));
                    c.setName(rs.getString(2));
                    ebs.add(c);
            }
            cnnct.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return c;
    }
    public ArrayList getBookPrice(ArrayList comic_Id , ArrayList con_Id) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList ebs = new ArrayList();

        try {
            cnnct = getConnection();
            for (int i = 0; i < comic_Id.size(); i++) {
                String preQueryStatement = "SELECT conId,price FROM contract WHERE comic_Id = " + comic_Id.get(i) +" AND conId = "+con_Id.get(i);
                pStmnt = cnnct.prepareStatement(preQueryStatement);
                ResultSet rs = null;
                rs = pStmnt.executeQuery();

                while (rs.next()) {
                    ComicBean c = new ComicBean();
                    c.setChapter(rs.getInt(1));
                    c.setPrice(rs.getInt(2));
                    ebs.add(c);
                }
            }
            cnnct.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return ebs;
    }
    public ArrayList getProductInfo(ArrayList product_id) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList ebs = new ArrayList();

        try {
            cnnct = getConnection();
            for (int i = 0; i < product_id.size(); i++) {
                String preQueryStatement = "SELECT product_id,comic_Id,bid,price,point FROM product WHERE product_id = '" + product_id.get(i)+"'";
                pStmnt = cnnct.prepareStatement(preQueryStatement);
                ResultSet rs = null;
                rs = pStmnt.executeQuery();

                while (rs.next()) {
                    ComicBean c = new ComicBean();
                    c.setProduct_Id(rs.getString(1));
                    c.setComic_Id(rs.getInt(2));
                    c.setBid(rs.getInt(3));
                    c.setPrice(rs.getInt(4));
                    c.setPoint(rs.getInt(5));
                    ebs.add(c);
                }
            }
            cnnct.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return ebs;
    }
    public boolean UserAddBook(String EAddress, String comic_Id) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement2 = "INSERT INTO collection (`eAddress`, `comic_id`) VALUES(?,?)";
            pStmnt = cnnct.prepareStatement(preQueryStatement2);
            pStmnt.setString(1, EAddress);
            pStmnt.setString(2, comic_Id);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;

    }
    public boolean UserRemoveBook(String EAddress, String comic_Id) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement2 = "DELETE FROM `collection` WHERE `collection`.`eAddress` = ? AND `collection`.`comic_id` = ?";
            pStmnt = cnnct.prepareStatement(preQueryStatement2);
            pStmnt.setString(1, EAddress);
            pStmnt.setString(2, comic_Id);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }
    
    
      public ArrayList<String> getUserBookCase(String EAdress) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<String> ebs = new ArrayList();
        
        try {
            cnnct = getConnection();
                String preQueryStatement = "SELECT comic_id FROM collection WHERE eAddress = '" + EAdress+"'";
                pStmnt = cnnct.prepareStatement(preQueryStatement);
                ResultSet rs = null;
                rs = pStmnt.executeQuery();
                
                while (rs.next()) {
                    ebs.add(rs.getString(1));
                }
            cnnct.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return ebs;
    }
      
      public String getProudctIDByCid(String comic_Id , String ep) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        String comicId = "";
        try {
            cnnct = getConnection();
                String preQueryStatement = "SELECT `product_id` FROM `product` WHERE `comic_Id` = '"+comic_Id+"' AND `ep`= '"+ep+"'";
                pStmnt = cnnct.prepareStatement(preQueryStatement);
                ResultSet rs = null;
                rs = pStmnt.executeQuery();

                while (rs.next()) {
                    comicId = (rs.getString(1));
            }
            cnnct.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return comicId;
    }
}
