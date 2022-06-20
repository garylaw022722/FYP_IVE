/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import ict.bean.ContributeBean;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.sql.Timestamp;

/**
 *
 * @author law
 */
public class ContributeDB {

    dbOperation db;

    public ContributeDB() {
        db = new dbOperation();

    }

    public Connection getConnection() throws SQLException {
        return db.getConnection();
    }

    public ContributeBean getAll_Contribution() {

        Connection con = null;
        ResultSet rs = null;
        Statement state = null;
        ContributeBean mrBean = null;
        try {
            con = getConnection();
            String query = " SELECT * FROM  Contribution ";
            state = con.createStatement();
            rs = state.executeQuery(query);
            mrBean = dataField(rs);
            rs.close();
            state.close();
            con.close();

        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }
        return mrBean;

    }

    public ContributeBean getAll_Contribution(String query) {

        Connection con = null;
        ResultSet rs = null;
        Statement state = null;
        ContributeBean mrBean = null;
        try {
            con = getConnection();
            state = con.createStatement();
            rs = state.executeQuery(query);
            mrBean = dataField(rs);
            rs.close();
            state.close();
            con.close();

        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }
        return mrBean;

    }

    public ContributeBean dataField(ResultSet rs) throws SQLException {
        ContributeBean container = new ContributeBean();
        while (rs.next()) {
            ContributeBean sources = new ContributeBean();
            sources.setConId(rs.getInt(1));
            sources.setTitle(rs.getString(2));
            sources.seteAddress(rs.getString(3));
            sources.setTime(rs.getTime(4));
            sources.setDescription(rs.getString(5));
            sources.setPdf(rs.getBinaryStream(6));
            sources.setFileName(rs.getString(7));
            sources.setComment(rs.getString(8));
            sources.setSubTime(rs.getTimestamp(9));
            sources.setComic_Id(rs.getString(10));
            sources.setCallLast(rs.getTime(11));

            container.addList(sources);
        }

        return container;
    }

    public ContributeBean getContributionById(int id) {
        Connection con = null;
        ResultSet rs = null;
        Statement state = null;
        ContributeBean sources = null;
        try {
            con = getConnection();
            sources = new ContributeBean();
            state = con.createStatement();
            String query = "Select * from Contribution where conId ='" + id + "'";
            rs = state.executeQuery(query);
            while (rs.next()) {
                sources.setConId(rs.getInt(1));
                sources.setTitle(rs.getString(2));
                sources.seteAddress(rs.getString(3));
                sources.setTime(rs.getTime(4));
                sources.setDescription(rs.getString(5));
                sources.setPdf(rs.getBinaryStream(6));
                sources.setFileName(rs.getString(7));
                sources.setComment(rs.getString(8));
                sources.setSubTime(rs.getTimestamp(9));
                sources.setComic_Id(rs.getString(10));
                sources.setCallLast(rs.getTime(11));

            }

            rs.close();
            state.close();
            con.close();

        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }
        return sources;

    }

    public void innsertComment(String comment, int conId) {
        Connection con = null;

        PreparedStatement preState = null;
        try {
            con = getConnection();
            String query = " UPDATE `Contribution` SET `comment`=? WHERE conId =? ";
            preState = con.prepareStatement(query);
            preState.setString(1, comment);
            preState.setInt(2, conId);
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

    public void SubmitContribution( String title, String eAddress, Time callT, String desc, InputStream cm,
            String fileName, String comment, String comicId, Time callF) {
        Connection con = null;

        PreparedStatement preState = null;
        try {
            con = getConnection();
            String query = " INSERT INTO `Contribution`(`title`, `eAddress`, `callBackAvailable`, `Description`, `pdf`, `fileName`,"
                    + " `comment`, `submissionDate`, `comic_Id`, `callBackAvailableLast`)"
                    + " VALUES (?,?,?,?,?,?,?,?,?,?) ";
            preState = con.prepareStatement(query);

            preState.setString(1, title);
            preState.setString(2, eAddress);
            preState.setTime(3, callT);
            preState.setString(4, desc);
            preState.setBinaryStream(5, cm);
            preState.setString(6, fileName);
            preState.setString(7, comment);
            preState.setTimestamp(8, new Timestamp(System.currentTimeMillis()));
            preState.setString(9, comicId);
            preState.setTime(10, callF);
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
        new ContributeDB().innsertComment("sssssss", 2);
//        System.out.print(new ContributeDB()() );
    }

}
