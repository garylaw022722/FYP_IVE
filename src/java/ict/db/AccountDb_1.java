/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import ict.bean.ComicBean;
import ict.bean.UserBean;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author tytap
 */
public class AccountDb_1 {

    private String url = "";
    private String username = "";
    private String password = "";

    public AccountDb_1(String url, String username, String password) {
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

    public Boolean EditUserInfo(String fistName, String lastName, String Address, String contactNum, String subEmail, String idenNo, String bankAcount, String eAddress) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "update userinfo set FirstName=?,LastName=?,Address=?,contactNum=?,subEmail=?,idenNo=?,BankAcount=? WHERE eAddress=?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, fistName);
            pStmnt.setString(2, lastName);
            pStmnt.setString(3, Address);
            pStmnt.setString(4, contactNum);
            pStmnt.setString(5, subEmail);
            pStmnt.setString(6, idenNo);
            pStmnt.setString(7, bankAcount);
            pStmnt.setString(8, eAddress);
            int rs = pStmnt.executeUpdate();
            if (rs >= 1) {
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
    public Boolean EditPassword( String password, String eAddress) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "update account set password=? WHERE eAddress=?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, password);
            pStmnt.setString(2, eAddress);
            int rs = pStmnt.executeUpdate();
            if (rs >= 1) {
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

    public UserBean getUserInfo(String eAddress) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        UserBean u = new UserBean();
        try {
            cnnct = getConnection();
            String preQueryStatement = "select FirstName,LastName,Address,contactNum,subEmail,idenNo,BankAcount from userinfo where eAddress = '"+eAddress+"'";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = null;
            rs = pStmnt.executeQuery();

            while (rs.next()) {
                u.setFistName(rs.getString(1));
                u.setLastName(rs.getString(2));
                u.setAddress(rs.getString(3));
                u.setContactNum(rs.getInt(4));
                u.setSubEmail(rs.getString(5));
                u.setIdenNo(rs.getInt(6));
                u.setBankAcount(rs.getString(7));
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
        return u;
    }
}
