/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import ict.bean.CustomBookBean;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import static org.bouncycastle.crypto.modes.kgcm.KGCMUtil_128.x;

/**
 *
 * @author law
 */
public class CustomBook {

    dbOperation db;

    public CustomBook() {
        db = new dbOperation();
    }

    public Connection getConnection() throws SQLException {

        return db.getConnection();
    }

    public CustomBookBean getCustomBookByEmail(String email) {
        Connection con = null;
        String maxNum = "";
        ResultSet rs = null;
        PreparedStatement preState = null;
        CustomBookBean container = null;

        try {
            con = getConnection();
            String query = " SELECT * FROM `CustomBook` WHERE `eAddress` =? ";
            preState = con.prepareStatement(query);
            preState.setString(1, email);
            rs = preState.executeQuery();
            container = new CustomBookBean();
            while (rs.next()) {
                CustomBookBean item = new CustomBookBean();
                item.seteAddress(rs.getString(1));
                item.setCustom_id(rs.getInt(2));
                item.setCustomBookDate(rs.getTimestamp(3));
                item.setCustomBook(rs.getBinaryStream(4));
                item.setCustomBookName(rs.getString(5));
                item.setCovertPage(rs.getBinaryStream(6));
                container.addCustomBookList(item);
            }
            con.close();
            preState.close();
            rs.close();

        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }
        return container;
    }

    public CustomBookBean getCustomBookById(int id) {
        Connection con = null;
        String maxNum = "";
        ResultSet rs = null;
        PreparedStatement preState = null;
        CustomBookBean item = null;

        try {
            con = getConnection();
            String query = " SELECT * FROM `CustomBook` WHERE `custom_id`= ?";
            preState = con.prepareStatement(query);
            preState.setInt(1, id);
            rs = preState.executeQuery();
            item = new CustomBookBean();
            if (rs.next()) {

                item.seteAddress(rs.getString(1));
                item.setCustom_id(rs.getInt(2));
                item.setCustomBookDate(rs.getTimestamp(3));
                item.setCustomBook(rs.getBinaryStream(4));
                item.setCustomBookName(rs.getString(5));
                item.setCovertPage(rs.getBinaryStream(6));

            }
            con.close();
            preState.close();
            rs.close();

        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }
        return item;
    }

    public void insertNewBook(String eAddress, InputStream pdf, String name, InputStream coverPage, int cusid) {
        Connection con = null;
        PreparedStatement preState = null;
        try {
            con = getConnection();
            String query = "INSERT INTO `CustomBook`(`eAddress`, customBook, `customBookName`, `coverPage`,`custom_id`) VALUES (?,?,?,?,?)";
            preState = con.prepareStatement(query);
            preState.setString(1, eAddress);
            preState.setBinaryStream(2, pdf);
            preState.setString(3, name);
            preState.setBinaryStream(4, coverPage);
            preState.setInt(5, cusid);
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

    public CustomBookBean getMaxId(String email) {
        Connection con = null;
        String maxNum = "";
        ResultSet rs = null;
        PreparedStatement preState = null;
        CustomBookBean container = null;
        try {
            con = getConnection();
            String query = " SELECT * FROM `CustomBook` WHERE `eAddress` =? ";
            preState = con.prepareStatement(query);
            preState.setString(1, email);
            rs = preState.executeQuery();
            container = new CustomBookBean();
            while (rs.next()) {

                container.setCustom_id(rs.getInt(2));

            }
            con.close();
            preState.close();
            rs.close();

        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }
        return container;
    }
}
