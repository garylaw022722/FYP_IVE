/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import ict.bean.userInfo;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 *
 * @author law
 */
public class userInformation {

    private dbOperation db;

    public userInformation() {

        db = new dbOperation();

    }

    public Connection getConnection() throws SQLException {

        return db.getConnection();
    }

    public userInfo getUserBackground() {
        Connection con = null;
        Statement state = null;
        ResultSet rs = null;
        userInfo container = null;
        try {
            con = getConnection();
            container = new userInfo();
            String query = "Select * from  userInfo";
            state = con.createStatement();
            rs = state.executeQuery(query);
            while (rs.next()) {
                userInfo item = new userInfo();
                item.seteAddress(rs.getString(1));
                item.setFirstName(rs.getString(2));
                item.setLastName(rs.getString(3));
                item.setAddress(rs.getString(4));
                item.setContactNum(rs.getString(5));
                item.setSubEmail(rs.getString(6));
                item.setIdenNo(rs.getString(7));
                item.setBankAccount(rs.getString(8));
                item.setDob(rs.getDate(9));

                item.setPointAmount(rs.getInt(10));
                item.setGender(rs.getString(11));
                container.addList(item);
                container.addHash(item.geteAddress(), item);

            }

        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }
        return container;
    }

    public userInfo getUserInfoByEmail(String email) {
        Connection con = null;
        PreparedStatement state = null;
        ResultSet rs = null;
        userInfo container = null;
        try {
            con = getConnection();
            container = new userInfo();
            String query = "Select * from  userInfo where eAddress = ?";
            state = con.prepareStatement(query);
            state.setString(1, email);
            rs = state.executeQuery();
            while (rs.next()) {
                userInfo item = new userInfo();
                item.seteAddress(rs.getString(1));
                item.setFirstName(rs.getString(2));
                item.setLastName(rs.getString(3));
                item.setAddress(rs.getString(4));
                item.setContactNum(rs.getString(5));
                item.setSubEmail(rs.getString(6));
                item.setIdenNo(rs.getString(7));
                item.setBankAccount(rs.getString(8));
                item.setDob(rs.getDate(9));
                item.setPointAmount(rs.getInt(10));
                item.setGender(rs.getString(11));
                container.addList(item);

            }

        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }
        return container;
    }

    public void updatePointAmount(String email, int amount) {
        Connection con = null;
        PreparedStatement state = null;
        try {
            con = getConnection();
            String query = "UPDATE `userInfo` SET `pointAmount`=? WHERE  `eAddress`=?";
            state = con.prepareStatement(query);
            state.setInt(1, amount);
            state.setString(2, email);
            state.executeUpdate();
            con.close();

        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }

    }

    public String getLoginStatus(String uid) {
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String state = "";
        try {
            con = getConnection();
            String query = " SELECT `state` FROM `userInfo` WHERE  userId =? ";
            pre = con.prepareStatement(query);
            pre.setString(1, uid);
            rs = pre.executeQuery();
            while (rs.next()) {
                state = rs.getString(1);
            }
            con.close();
            pre.close();

        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }
        return state;
    }

    public void createAccount(String emailAddress, String firstName, String lastName,
            String Address, String contactNum, String subEmail, String idenNo, String bankAc, Date dob,
            int pointAmount, String gender) throws ParseException {
        Connection con = null;
        PreparedStatement preState = null;
        try {
            con = getConnection();
            String query = "INSERT INTO `userInfo` values(?,?,?,?,?,?,?,?,?,?,?)";
            preState = con.prepareStatement(query);
            preState.setString(1, emailAddress);
            preState.setString(2, firstName);
            preState.setString(3, lastName);
            preState.setString(4, Address);
            preState.setString(5, contactNum);
            preState.setString(6, subEmail);
            preState.setString(7, idenNo);
            preState.setString(8, bankAc);
            preState.setDate(9, dob);
            preState.setInt(10, pointAmount);
            preState.setString(11, gender);

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
    
    

    public void updateUserPortfolio(String firstName, String lastName,String Address ,String phone,String gender,String email) {

        Connection con = null;
        PreparedStatement preState = null;
        try {
            con = getConnection();
            String query = " UPDATE `userInfo` SET `FirstName`=?, `LastName`=?, `Address`=? ,`contactNum`=? ,gender = ? WHERE `eAddress`=? ";
            
            preState  = con.prepareStatement(query);
            preState.setString(1,firstName);
            preState.setString(2,lastName);
            preState.setString(3,Address);
            preState.setString(4, phone);
            preState.setString(5, gender);
//            preState.setString("Address", query);
            preState.setString(6,email);

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
    
    
    public void updateUserPortfolio_Contract(String firstName, String lastName,
            String Address ,String phone,String gender,String idenNo,Date DOB,String BankAccount,String email) {

        Connection con = null;
        PreparedStatement preState = null;
        try {
            con = getConnection();
            String query = " UPDATE `userInfo` SET `FirstName`=?, `LastName`=?, `Address`=? ,`contactNum`=? "+
                    " ,gender = ?  , idenNo =? , DOB=? ,BankAccount =?  WHERE `eAddress`=? ";
            
            preState  = con.prepareStatement(query);
            preState.setString(1,firstName);
            preState.setString(2,lastName);
            preState.setString(3,Address);
            preState.setString(4, phone);
            preState.setString(5, gender);
            preState.setString(6, idenNo);
            preState.setDate(7, DOB);
            preState.setString(8, BankAccount);
//            preState.setString("Address", query);
            preState.setString(9,email);

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

}
