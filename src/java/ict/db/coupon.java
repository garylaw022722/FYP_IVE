/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author 85266
 */
public class coupon {

    dbOperation db;

    public coupon() {
        db = new dbOperation();
    }

    public Connection getConnection() throws SQLException {

        return db.getConnection();
    }
    public boolean UserAddCoupon(String cpid,String EAddress) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement2 = "INSERT INTO `coupond`(`cpid`, `eAddress`) VALUES (?,?)";
            pStmnt = cnnct.prepareStatement(preQueryStatement2);
            pStmnt.setString(1, cpid);
            pStmnt.setString(2, EAddress);
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
        }
        return isSuccess;

    }
     public ArrayList getUserCoupon(String eAddress) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList c = new ArrayList();
        
        try {
            cnnct = getConnection();
                String preQueryStatement = "SELECT `cpid` FROM `coupond` WHERE eAddress = '"+eAddress+"'";
                pStmnt = cnnct.prepareStatement(preQueryStatement);
                ResultSet rs = null;
                rs = pStmnt.executeQuery();
                
                while (rs.next()) {
                    
                    c.add(rs.getString(1));
                }
            cnnct.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }
        return c;
    }
     public boolean UsingCoupon(String cpid,String EAddress) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement2 = "DELETE FROM `coupond` WHERE `cpid` = ? AND `eAddress` = ?";
            pStmnt = cnnct.prepareStatement(preQueryStatement2);
            pStmnt.setString(1, cpid);
            pStmnt.setString(2, EAddress);
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
        }
        return isSuccess;

    }
}

