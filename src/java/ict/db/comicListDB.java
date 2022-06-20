/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import ict.bean.contractBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author law
 */
public class comicListDB {

    dbOperation db;

    public comicListDB() {
        db = new dbOperation();
    }

    public Connection getConnection() throws SQLException {
        return db.getConnection();

    }

    public int getNextId() {

        Connection con = null;
        Statement State = null;
        ResultSet rs = null;
        int max = 0;
        try {
            con = getConnection();
            String query = "SELECT max(tid) FROM `ComicList`";
            State = con.createStatement();
            rs = State.executeQuery(query);

            if (rs.next()) {
                max = rs.getInt(1) + 1;
            }

            rs.close();
            con.close();

        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }
        return max;

    }

    public void addNewType(int tid, String name) {
        Connection con = null;
        PreparedStatement preState = null;
       
        try {
            con = db.getConnection();            
            String query = "INSERT INTO `ComicList` (`tid`, `Descript`) VALUES (?,?)";
            preState = con.prepareStatement(query);
            preState.setInt(1, tid);
            preState.setString(2, name);
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

//        System.out.println(new comicListDB().getNextId());
        new comicListDB().addNewType(21, "hehe") ;
    }

}
