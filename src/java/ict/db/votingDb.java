/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import ict.bean.ComicBean;
import ict.bean.votingBean;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Base64;

/**
 *
 * @author user
 */
public class votingDb {
    private String url = "";
    private String username = "";
    private String password = "";
    public votingDb(String url, String username, String password) {
        this.url = url;
        this.username = username;
        this.password = password;
    }
    public Connection getConnection() throws SQLException, IOException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        }
        return DriverManager.getConnection(url, username, password);
    }
    public boolean addVoting(String event_id, String comic_Id, String eAddress, String yearRange, String repsonse) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement2 = "INSERT INTO voting VALUES(?,?,?,?,?)";
            pStmnt = cnnct.prepareStatement(preQueryStatement2);
            pStmnt.setString(1, event_id);
            pStmnt.setString(2, comic_Id);
            pStmnt.setString(3, eAddress);
            pStmnt.setString(4, yearRange);
            pStmnt.setString(5, repsonse);
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
    public ArrayList<ComicBean> getComicList() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<ComicBean> ebs = new ArrayList<ComicBean>();

        try {
            cnnct = getConnection();
            String preQueryStatement = "select comic_Id,Name,Descript,coverPage from comicworks";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = null;
            rs = pStmnt.executeQuery();

            while (rs.next()) {
                ComicBean e = new ComicBean();
                e.setComic_Id(rs.getInt(1));
                e.setName(rs.getString(2));
                e.setDescript(rs.getString(3));
                Blob blob = rs.getBlob(4);
                    InputStream inputStream = blob.getBinaryStream();
                    ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                    byte[] buffer = new byte[4096];
                    int bytesRead = -1;

                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }

                    byte[] imageBytes = outputStream.toByteArray();
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                    e.setCoverPage(base64Image);
                ebs.add(e);
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
    public ComicBean getComicById(String comic_Id) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ComicBean e = new ComicBean();

        try {
            cnnct = getConnection();
            String preQueryStatement = "select comic_Id,Name,Descript,coverPage from comicworks where comic_Id = " + comic_Id;
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = null;
            rs = pStmnt.executeQuery();

            while (rs.next()) {
                e.setComic_Id(rs.getInt(1));
                e.setName(rs.getString(2));
                e.setDescript(rs.getString(3));
                Blob blob = rs.getBlob(4);
                    InputStream inputStream = blob.getBinaryStream();
                    ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                    byte[] buffer = new byte[4096];
                    int bytesRead = -1;

                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }

                    byte[] imageBytes = outputStream.toByteArray();
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                    e.setCoverPage(base64Image);
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
        return e;
    }
    public String getEventId() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        String eventId = "";

        try {
            cnnct = getConnection();
            String preQueryStatement = "select event_id from votingevent where Now() BETWEEN startDate and endDate";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = null;
            rs = pStmnt.executeQuery();

            while (rs.next()) {
                eventId = (rs.getString(1));
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
        return eventId;
    }
    public ArrayList getEventBook(String event_Id) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList al = new ArrayList();
        String eventId;
        try {
            cnnct = getConnection();
            String preQueryStatement = "select comic_id from competitor where event_Id = " + event_Id;
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = null;
            rs = pStmnt.executeQuery();

            while (rs.next()) {
                eventId = (rs.getString(1));
                al.add(eventId);
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
        return al;
    }
    public boolean addEntries(String comic_id ,String event_Id) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<ComicBean> ebs = new ArrayList<ComicBean>();
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "INSERT INTO competitor VALUES(?,?)";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, event_Id);
            pStmnt.setString(2, comic_id);
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
    public String CheckNotVoted(String eAddress) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        String Check = "";

        try {
            cnnct = getConnection();
            String preQueryStatement = "select comic_id from voting where eAddress = "+ eAddress;
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = null;
            rs = pStmnt.executeQuery();

            while (rs.next()) {
                Check = (rs.getString(1));
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
        return Check;
    }
    public String getQuestion(String event_id) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<votingBean> ebs = new ArrayList<votingBean>();
        String question = "can not find the question";
        try {
            cnnct = getConnection();
            String preQueryStatement = "select question from votingevent where event_id = "+ event_id;
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = null;
            rs = pStmnt.executeQuery();
            
            while (rs.next()) {
                question = (rs.getString(1));
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
        return question;
    }
    public ArrayList<votingBean> getVotingResults(String event_id) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<votingBean> ebs = new ArrayList<votingBean>();

        try {
            cnnct = getConnection();
            String preQueryStatement = "select * from voting where event_id = "+ event_id;
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = null;
            rs = pStmnt.executeQuery();

            while (rs.next()) {
                votingBean v = new votingBean();
                v.setEvent_id(rs.getInt(1));
                v.setComic_Id(rs.getInt(2));
                v.setEAddress(rs.getString(3));
                v.setYearRange(rs.getString(4));
                v.setRepsonse(rs.getString(5));
                ebs.add(v);
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
    public boolean addVotingEvent(String descript,String question,String startDate, String EAddress, String endDate) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            
            cnnct = getConnection();
            String preQueryStatement2 = "INSERT INTO votingevent VALUES(?,?,?,?,?,?)";
            pStmnt = cnnct.prepareStatement(preQueryStatement2);
            pStmnt.setInt(1, 0);
            pStmnt.setString(2, descript);
            pStmnt.setString(3, question);
            pStmnt.setString(4, startDate);
            pStmnt.setString(5, EAddress);
            pStmnt.setString(6, endDate);
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
    public String getMaxEventId() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        String MAX ="";
        try {
            
            cnnct = getConnection();
            String preQueryStatement2 = "SELECT MAX(event_id) FROM votingevent";
            pStmnt = cnnct.prepareStatement(preQueryStatement2);
            ResultSet rs = null;
            rs = pStmnt.executeQuery();
            
            while (rs.next()) {
                MAX = (rs.getString(1));
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
        return MAX;
    }
}
