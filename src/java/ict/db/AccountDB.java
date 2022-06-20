/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import ict.bean.Account;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author law
 */
public class AccountDB {

    dbOperation db;

    public AccountDB() {
        db = new dbOperation();
    }

    public Connection getConnection() throws SQLException {

        return db.getConnection();
    }

    public String getUserTypeByEmail(String email) {
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement preState = null;
        String type = "";
        try {
            con = getConnection();
            String query = "SELECT  `type` FROM `Account` WHERE `eAddress`=?";
            preState = con.prepareStatement(query);
            preState.setString(1, email);
            rs = preState.executeQuery();
            if (rs.next()) {
                type = rs.getString(1);
            }
            con.close();
        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }

        return type;

    }

    public String getUserPasswordByEmail(String email) {
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement preState = null;
        String password = "";
        try {
            con = getConnection();
            String query = "SELECT  `password` FROM `Account` WHERE `eAddress`=?";
            preState = con.prepareStatement(query);
            preState.setString(1, email);
            rs = preState.executeQuery();
            if (rs.next()) {
                password = rs.getString(1);
            }
            con.close();
        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }

        return password;

    }

    public Account getAccountByEmail(String email) {
        Account ac = null;
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement preState = null;
        String password = "";

        try {
            con = getConnection();
            String query = "SELECT  * FROM `Account` WHERE `eAddress`=?";
            preState = con.prepareStatement(query);
            preState.setString(1, email);
            rs = preState.executeQuery();
            ac = new Account();
            while (rs.next()) {
                Account list = new Account();
                list.seteAddress(rs.getString(1));
                list.setPassword(rs.getString(2));
                list.setUserType(rs.getString(3));
                list.setLoginState(rs.getString(4));
                list.setFreeze(rs.getString(5));
                list.setRegCode(rs.getString(6));
                list.setIsUsed(rs.getString(7));
                ac.addAccount(list);

            }

            con.close();
        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }
        return ac;
    }

    public void Freezing(String email, String status) {

        Connection con = null;
        PreparedStatement preState = null;
        try {
            con = getConnection();
            String query = "UPDATE `Account` SET `freeze`= ? WHERE `eAddress`=?";
            preState = con.prepareStatement(query);
            preState.setString(2, email);
            preState.setString(1, status);
            preState.executeUpdate();
            con.close();
        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }

    }

    public Account getTypeUser(String user) {
        Account ac = null;
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement preState = null;
        String password = "";

        try {
            con = getConnection();
            String query = " SELECT * FROM `Account` WHERE `type`=? ";
            preState = con.prepareStatement(query);
            preState.setString(1, user);
            rs = preState.executeQuery();
            ac = new Account();
            while (rs.next()) {
                Account list = new Account();
                list.seteAddress(rs.getString(1));
                list.setPassword(rs.getString(2));
                list.setUserType(rs.getString(3));
                list.setLoginState(rs.getString(4));
                list.setFreeze(rs.getString(5));
                list.setRegCode(rs.getString(6));
                list.setIsUsed(rs.getString(7));
                ac.addAccount(list);

            }

            con.close();
        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }
        return ac;
    }

    public Account getUserByFreeze(String state) {
        Account ac = null;
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement preState = null;
        String password = "";

        try {
            con = getConnection();
            String query = " SELECT * FROM `Account` WHERE `freeze`=? ";
            preState = con.prepareStatement(query);
            preState.setString(1, state);
            rs = preState.executeQuery();
            ac = new Account();
            while (rs.next()) {
                Account list = new Account();
                list.seteAddress(rs.getString(1));
                list.setPassword(rs.getString(2));
                list.setUserType(rs.getString(3));
                list.setLoginState(rs.getString(4));
                list.setFreeze(rs.getString(5));
                list.setRegCode(rs.getString(6));
                list.setIsUsed(rs.getString(7));
                ac.addAccount(list);

            }

            con.close();
        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }
        return ac;
    }

    public void ActivateAccount(String email, String password, String userType, String loginState, String freeze, String RegCode, String usedCode) {

        Connection con = null;

        PreparedStatement preState = null;

        try {
            con = getConnection();
            String query = " INSERT INTO `Account` VALUES (?,?,?,?,?,?,?) ";
            preState = con.prepareStatement(query);
            preState.setString(1, email);
            preState.setString(2, password);
            preState.setString(3, userType);
            preState.setString(4, loginState);
            preState.setString(5, freeze);
            preState.setString(6, RegCode);
            preState.setString(7, usedCode);
            preState.executeUpdate();

            con.close();
        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }

    }

    public boolean isValidUser(Account ac) {
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement preState = null;
        boolean isValid = false;
        try {
            con = getConnection();
            String preQueryStatement = "SELECT * FROM account WHERE eAddress=? and password=?";
            preState = con.prepareStatement(preQueryStatement);
            preState.setString(1, ac.geteAddress());
            preState.setString(2, ac.getPassword());
            rs = preState.executeQuery();
            if (rs.next()) {
                isValid = true;
            }
            con.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }
        return isValid;
    }
    public String getUserStatus(Account ac) {
        ResultSet rs = null;
        Connection con = null;
        PreparedStatement preState = null;
        String status = "";
        try {
            con = getConnection();
            String preQueryStatement = "SELECT * FROM account WHERE eAddress=?";
            preState = con.prepareStatement(preQueryStatement);
            preState.setString(1, ac.geteAddress());
            rs = preState.executeQuery();
            if (rs.next()) {
                status = rs.getString("LoginState");
            }
            con.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }
        return status;
    }

    public void UpdateStatus(Account ac) {

        Connection con = null;
        PreparedStatement preState = null;
        try {
            con = getConnection();
            String query = "UPDATE account SET LoginState = ? WHERE eAddress = ?";
            preState = con.prepareStatement(query);
            preState.setString(1, "yes");
            preState.setString(2, ac.geteAddress());
            preState.executeUpdate();
            con.close();
        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }

    }

    public void LogoutStatus(Account ac) {

        Connection con = null;
        PreparedStatement preState = null;
        try {
            con = getConnection();
            String query = "UPDATE account SET LoginState = ? WHERE eAddress = ?";
            preState = con.prepareStatement(query);
            preState.setString(1, "no");
            preState.setString(2, ac.geteAddress());
            preState.executeUpdate();
            con.close();
        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }

    }
    public boolean isFreeze(Account ac){
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement preState = null;
        boolean isFreeze = false;
        try {
            con = getConnection();
            String preQueryStatement = "SELECT * FROM account WHERE eAddress=? and freeze=?";
            preState = con.prepareStatement(preQueryStatement);
            preState.setString(1, ac.geteAddress());
            preState.setString(2, "F");
            rs = preState.executeQuery();
            if (rs.next()) {
                isFreeze = true;
            }
            con.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }
        return isFreeze;
    }

    public boolean isUser(Account ac) {
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement preState = null;
        boolean isValid = false;
        try {
            con = getConnection();
            String preQueryStatement = "SELECT * FROM account WHERE eAddress=?";
            preState = con.prepareStatement(preQueryStatement);
            preState.setString(1, ac.geteAddress());
            rs = preState.executeQuery();
            if (rs.next()) {
                isValid = true;
            }
            con.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }
        return isValid;
    }
    public boolean isDuplication(String regcode) {
        boolean flag = false;
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement preState = null;

        try {
            con = getConnection();
            String preQueryStatement = " SELECT * FROM account WHERE RegCode  = ? ";

            preState = con.prepareStatement(preQueryStatement);
            preState.setString(1, regcode);
            rs = preState.executeQuery();
            if (rs.next()) {
                flag = true;
            }
            con.close();
            rs.close();;
            preState.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }
        return flag;

    }

    public void activateAccount(String regCode, String freeze, String status) {
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement preState = null;

        try {
            con = getConnection();
            String preQueryStatement = " Update account  set   isUseRegcode =? ,freeze =?  where  RegCode  = ?   ";
            preState = con.prepareStatement(preQueryStatement);
            preState.setString(1, status);
            preState.setString(2, freeze);
            preState.setString(3, regCode);
            preState.executeUpdate();
            preState.close();
            con.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }

    }

    public boolean isActivate(String code) {
        boolean flag = false;
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement preState = null;

        try {
            con = getConnection();
            String preQueryStatement = " Select * from account where isUseRegcode  is not Null  and   RegCode  = ?   ";
            preState = con.prepareStatement(preQueryStatement);
            preState.setString(1, code);
            rs = preState.executeQuery();
            if (rs.next()) {
                flag = true;
            }

            rs.close();
            preState.close();
            con.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }
        return flag;
    }

    public void updateUserRole(String email, String role) {
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement preState = null;

        try {
            con = getConnection();
            String preQueryStatement = "                 UPDATE `Account` SET  `type`=? where eAddress=?   ";
            preState = con.prepareStatement(preQueryStatement);
            preState.setString(1, role);
            preState.setString(2, email);
            preState.executeUpdate();
          

            preState.close();
            con.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }
       

    }

}
