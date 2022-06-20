/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import com.mysql.cj.protocol.Resultset;
import ict.bean.ComicWorks;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;

/**
 *
 * @author law
 */
public class ComicWorksDB {

    dbOperation db = null;

    public ComicWorksDB() {
        db = new dbOperation();
    }

    public Connection getConnection() throws SQLException {
        return db.getConnection();
    }

    public ComicWorks getComicInfo() {
        Connection con = null;
        Statement state = null;
        ResultSet rs = null;
        ComicWorks item = null;

        try {
            con = getConnection();
            String query = "Select * from ComicWorks";
            state = con.createStatement();
            rs = state.executeQuery(query);
            item = new ComicWorks();
            while (rs.next()) {
                ComicWorks container = new ComicWorks();
                container.setCid(rs.getString(1));
                container.setName(rs.getString(2));
                container.setDescription(rs.getString(3));
                container.seteAddress(rs.getString(4));
                container.setSchedule(rs.getString(5));
                container.setCoverPage(rs.getBinaryStream(6));
                container.setStatus(rs.getString(7));
                container.setResponsor(rs.getString(8));
                container.setPenName(rs.getString(9));
                container.setPenid(rs.getString(10));
                item.addComicList(container);
                item.addComic(container.getCid(), container);
            }

            con.close();
            rs.close();
        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }
        return item;
    }

    public ComicWorks getDistinctAuthor() {
        Connection con = null;
        Statement state = null;
        ResultSet rs = null;
        ComicWorks item = null;

        try {
            con = getConnection();
            String query = "SELECT DISTINCT(`penName`) FROM `ComicWorks`";
            state = con.createStatement();
            rs = state.executeQuery(query);
            item = new ComicWorks();
            while (rs.next()) {
                ComicWorks container = new ComicWorks();
                container.setPenName(rs.getString(1));
                item.addComicList(container);
            }

            con.close();
            rs.close();
        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }
        return item;
    }

    public ComicWorks getSearching(String query) {
        Connection con = null;
        Statement state = null;
        ResultSet rs = null;
        ComicWorks item = null;
        try {
            con = getConnection();
            state = con.createStatement();
            rs = state.executeQuery(query);
            item = new ComicWorks();
            while (rs.next()) {
                ComicWorks container = new ComicWorks();
                container.setName(rs.getString(1));
                container.setDescription(rs.getString(2));
                container.setCoverPage(rs.getBinaryStream(3));
                container.setPenName(rs.getString(4));
                container.setPenid(rs.getString(5));
                container.setCid(rs.getString(6));
                container.setSchedule(rs.getString(7));
                container.seteAddress(rs.getString(8));
                item.addComicList(container);
            }
            con.close();
            rs.close();

        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }
        return item;
    }

    public ComicWorks getComicByYear(String year) {
        Connection con = null;
        PreparedStatement state = null;
        ResultSet rs = null;
        ComicWorks item = null;
        try {
            con = getConnection();
            String query = "Select distinct(penName) From ComicWorks cw , contract ct "
                    + " where cw.comic_Id = ct.comic_Id And  Year(`signDate`) =? ";
            state = con.prepareStatement(query);
            state.setString(1, year);
            rs = state.executeQuery();
            item = new ComicWorks();
            while (rs.next()) {
                ComicWorks list = new ComicWorks();
                list.setPenName(rs.getString(1));
                item.addComicList(list);
            }
            rs.close();
            con.close();;

        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }

        return item;

    }

    public ComicWorks getComicNameByPenName(String penName) {
        Connection con = null;
        PreparedStatement state = null;
        ResultSet rs = null;
        ComicWorks item = null;
        try {
            con = getConnection();
            String query = " Select  * from ComicWorks Where   penName = ? ";
            state = con.prepareStatement(query);
            state.setString(1, penName);
            rs = state.executeQuery();
            item = new ComicWorks();
            while (rs.next()) {
                ComicWorks container = new ComicWorks();
                container.setCid(rs.getString(1));
                container.setName(rs.getString(2));
                container.setDescription(rs.getString(3));
                container.seteAddress(rs.getString(4));
                container.setSchedule(rs.getString(5));
                container.setCoverPage(rs.getBinaryStream(6));
                container.setStatus(rs.getString(7));
                container.setResponsor(rs.getString(8));
                container.setPenName(rs.getString(9));
                container.setPenid(rs.getString(10));
                item.addComicList(container);
            }
            rs.close();
            con.close();;

        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }

        return item;
    }

    public ComicWorks getComicbyId(String id) {

        Connection con = null;
        PreparedStatement preState = null;
        ComicWorks cm = null;
        ResultSet rs = null;
        try {

            cm = new ComicWorks();
            con = getConnection();
            String query = " SELECT * FROM `ComicWorks` WHERE `comic_Id` = ?";
            preState = con.prepareStatement(query);
            preState.setString(1, id);
            rs = preState.executeQuery();
            if (rs.next()) {
                cm.setCid(rs.getString(1));
                cm.setName(rs.getString(2));
                cm.setDescription(rs.getString(3));
                cm.seteAddress(rs.getString(4));
                cm.setSchedule(rs.getString(5));
                cm.setCoverPage(rs.getBinaryStream(6));
                cm.setStatus(rs.getString(7));
                cm.setResponsor(rs.getString(8));
                cm.setPenName(rs.getString(9));
                cm.setPenid(rs.getString(10));
            }

            con.close();
            rs.close();
            preState.close();
        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }
        return cm;

    }

    public String getNextNo(String queryString) {

        Connection con = null;
        PreparedStatement preState = null;
        ComicWorks cm = null;
        ResultSet rs = null;
        ArrayList<String> item = null;
        String max = "";
        String prev = "";
        int count = 0;

        try {
            item = new ArrayList<String>();
            con = getConnection();
            String query = queryString;
            preState = con.prepareStatement(query);
            rs = preState.executeQuery();
            while (rs.next()) {

                if (count == 0) {
                    max = rs.getString(1);
                } else {
                    if (Integer.valueOf(rs.getString(1)) > Integer.valueOf(max)) {
                        max = rs.getString(1);
                    }

                }

                count++;

            }

            con.close();
            rs.close();
            preState.close();
        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }

        return "" + (Integer.valueOf(max) + 1);

    }

    public void innsertComic(String comicId, String Name, String Description,
            String email, String schedule, InputStream cover, String status, String responsor, String penName, String penId) {

        Connection con = null;
        PreparedStatement preState = null;
        ComicWorks cm = null;
        ResultSet rs = null;
        try {
            cm = new ComicWorks();
            con = getConnection();
            String query = "INSERT INTO `ComicWorks` VALUES (?,?,?,?,?,?,?,?,?,?)";
            preState = con.prepareStatement(query);
            preState.setString(1, comicId);
            preState.setString(2, Name);
            preState.setString(3, Description);
            preState.setString(4, email);
            preState.setString(5, schedule);
            preState.setBinaryStream(6, cover);
            preState.setString(7, status);
            preState.setString(8, responsor);
            preState.setString(9, penName);
            preState.setString(10, penId);

            preState.executeUpdate();

            con.close();

            preState.close();
        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }

    }

    public void removeComicFile(String comic_Id) {
        Connection con = null;
        PreparedStatement preState = null;
        ComicWorks cm = null;
        try {
            cm = new ComicWorks();
            con = getConnection();
            String query = "UPDATE `ComicWorks` SET `coverPage`=null WHERE `comic_Id` = ?";
            preState = con.prepareStatement(query);
            preState.setString(1, comic_Id);
            preState.executeUpdate();
            con.close();
            preState.close();
           
        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }

    }

    public static void main(String[] args) {

//      String  id = new ComicWorksDB().getNextNo(" SELECT `comic_Id` FROM `ComicWorks` ");
//      System.out.print(id.length());
        new ComicWorksDB().innsertComic("30", "sassa", "saassa", "garylaw696969@gmail.com", "Thursday", null, "Serialize", null, "29292", "500");

    }

}
