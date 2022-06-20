/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import ict.bean.PointRecord;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author law
 */
public class BuyPointRecord {

    dbOperation db;

    public BuyPointRecord() {
        db = new dbOperation();
    }

    public Connection getConnection() throws SQLException {

        return db.getConnection();
    }

    public  PointRecord getAllRecord() {
        Connection con = null;
        ResultSet rs = null;
        Statement st = null;
       PointRecord container = null;

        try {
            con = db.getConnection();
            st = con.createStatement();
            String query = "Select * from Point";
            rs = st.executeQuery(query);
            container = new PointRecord();
            while (rs.next()) {
            PointRecord item = new  PointRecord();
                item.setPid(rs.getInt(1));
                item.seteAddress(rs.getString(2));
                item.setPurchasesDate(rs.getTimestamp(3));
                item.setPrice(rs.getInt(4)); 
                item.setPoint(rs.getInt(5));
                container.addPointRecord(item);
            }
        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }
        return container;
    }
    
    
     public  PointRecord getPointRecordByEmail(String email) {
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement st = null;
       PointRecord container = null;

        try {
            con = db.getConnection();
           String query ="SELECT * FROM `Point` WHERE `eAddress`=? and useDate is null";
            st = con.prepareStatement(query);
            st.setString(1, email);
            rs = st.executeQuery();
            container = new PointRecord();
            while (rs.next()) {
            PointRecord item = new  PointRecord();
                item.setPid(rs.getInt(1));
                item.seteAddress(rs.getString(2));
                item.setPurchasesDate(rs.getTimestamp(3));
                item.setPrice(rs.getInt(4));
                item.setPoint(rs.getInt(5));
                container.addPointRecord(item);
            }
        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }
        return container;
    }
     
     
      public  void  buyPoint(String pid ,String eAddress , int Price , int Point) {
        Connection con = null;
        PreparedStatement st = null;
  

        try {
            con = db.getConnection();
           String query ="INSERT INTO `Point`(`pid`, `eAddress`, `price`, `point`) VALUES (?,?,?,?)";
            st = con.prepareStatement(query);
            st.setString(1, pid);
            st.setString(2, eAddress);
            st.setInt(3, Price);
            st.setInt(4,Point);
              st.executeUpdate();
              con.close();
              st.close();
        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }
      
    }
    
    
    

}
