/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import ict.bean.Point;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author law
 */
public class PointList {

    dbOperation db;

    public PointList() {
        db = new dbOperation();

    }

    public Connection getConnection() throws SQLException {
        return db.getConnection();
    }

    public Point getPointSellingList() {
        Connection con = null;
        ResultSet rs = null;
        Statement st = null;
        Point container = null;

        try {
            con = db.getConnection();
            st = con.createStatement();
            String query = "Select * from PointList order by pointReturn";
            rs = st.executeQuery(query);
            container = new Point();
            while (rs.next()) {
                Point item = new Point();
                item.setPid(rs.getInt(1));
                item.setPrice(rs.getInt(2));
                item.setPointReturn(rs.getInt(3));
                item.setExtraPoint(rs.getInt(4));
                container.addPointList(item);
            }
        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }
        return container;
    }
     public Point getPointSellingList_id() {
        Connection con = null;
        ResultSet rs = null;
        Statement st = null;
        Point container = null;

        try {
            con = db.getConnection();
            st = con.createStatement();
            String query = "Select * from PointList order by pid";
            rs = st.executeQuery(query);
            container = new Point();
            while (rs.next()) {
                Point item = new Point();
                item.setPid(rs.getInt(1));
                item.setPrice(rs.getInt(2));
                item.setPointReturn(rs.getInt(3));
                item.setExtraPoint(rs.getInt(4));
                container.addPointList(item);
            }
        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }
        return container;
    }

    public Point getPointInfoById(String pid) {
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement st = null;
        Point container = null;

        try {
            con = db.getConnection();
            String query = "Select * from PointList  where  pid=?";
            st = con.prepareStatement(query);
            st.setString(1, pid);
            rs = st.executeQuery();
            container = new Point();
            while (rs.next()) {
                Point item = new Point();
                item.setPid(rs.getInt(1));
                item.setPrice(rs.getInt(2));
                item.setPointReturn(rs.getInt(3));
                item.setExtraPoint(rs.getInt(4));
                container.addPointList(item);
            }
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }
        return container;

    }
    
    
    
    public void UpdateItem(int pid , int price ,int pointReturn , int extraPoint){
            Connection con = null;
        ResultSet rs = null;
        PreparedStatement st = null;

        try {
            con = getConnection();         
            String query  =" UPDATE `PointList` SET `price`=?,`pointReturn`=?,`extraPoint`=? WHERE `pid` =? ";                                 
            st = con.prepareStatement(query);
            st.setInt(4, pid);
            st.setInt(1, price);
            st.setInt(2, pointReturn);
            st.setInt(3, extraPoint);
            st.executeUpdate();

            con.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }

    
    
    
    
    }
    
    
    

    public void removePointItem(int pid) {

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement st = null;

        try {
            con = db.getConnection();
            String query = "DELETE FROM `PointList`  where  pid=?";
            st = con.prepareStatement(query);
            st.setInt(1, pid);
            st.executeUpdate();

            con.close();;
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }

    }

    public int getNextPointIndex() {
        int max = 0;
        Connection con = null;
        ResultSet rs = null;
        Statement state = null;

        try {
            con = db.getConnection();
            String query = "SELECT MAX(pid) FROM `PointList` ";
            state = con.createStatement();
            rs = state.executeQuery(query);
            if (rs.next()) {
                max = rs.getInt(1) + 1;
            }
            con.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }

        return max;
    }

    public void addPointItem(int pid , int price ,int pointReturn ,int extraPoint) {

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement st = null;

        try {
            con = getConnection();
            String query = "INSERT INTO `PointList`VALUES (?,?,?,?)";
            st = con.prepareStatement(query);
            st.setInt(1, pid);
            st.setInt(2, price);
            st.setInt(3, pointReturn);
            st.setInt(4, extraPoint);
            st.executeUpdate();

            con.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }

    }

    public static void main(String[] args) {

        PointList pl = new PointList();
        pl.addPointItem(10, 20, 20, 20);

    }

}
