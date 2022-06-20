/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import ict.bean.ComicTypeBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author law
 */
public class ComicTypeDB {

    public Connection getConnection() throws SQLException {

        return new dbOperation().getConnection();
    }

    public ComicTypeBean getComicType() {
        Connection con = null;
        Statement state = null;
        ResultSet rs = null;
        ComicTypeBean item = null;

        try {
            con = getConnection();
            String query = "Select * from ComicList";
            state = con.createStatement();
            rs = state.executeQuery(query);
            item = new ComicTypeBean();
            while (rs.next()) {
                ComicTypeBean container = new ComicTypeBean();
                container.setTid(rs.getString(1));
                container.setComicType(rs.getString(2));
                container.setCover(rs.getBinaryStream(3));

                item.addHash(rs.getString(1), container);
                item.addList(container);
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

    public ComicTypeBean getAllComicTypeById(String id) {
        Connection con = null;
        PreparedStatement preState = null;
        ResultSet rs = null;
        ComicTypeBean item = null;

        try {
            con = getConnection();
            String query = " Select Descript ,comic_id From ComicType ct  ,  ComicList  cl  "
                    + " where  ct.tid = cl.tid and comic_id= ? ";

            preState = con.prepareStatement(query);
            preState.setString(1, id);
            rs = preState.executeQuery();
            item = new ComicTypeBean();
            while (rs.next()) {
                ComicTypeBean container = new ComicTypeBean();
                container.setTid(rs.getString(2));
                container.setComicType(rs.getString(1));
                item.addList(container);
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

    public ComicTypeBean getAllComicInfoById(String id) {
        Connection con = null;
        PreparedStatement preState = null;
        ResultSet rs = null;
        ComicTypeBean item = null;

        try {
            con = getConnection();
            String query = " Select Descript ,ct.tid From ComicType ct  ,  ComicList  cl  "
                    + " where  ct.tid = cl.tid and comic_id= ? ";

            preState = con.prepareStatement(query);
            preState.setString(1, id);
            rs = preState.executeQuery();
            item = new ComicTypeBean();
            while (rs.next()) {
                ComicTypeBean container = new ComicTypeBean();
                container.setTid(rs.getString(2));
                container.setComicType(rs.getString(1));
                item.addList(container);
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

    public ArrayList<String> getTypeListById(String id) {
        Connection con = null;
        PreparedStatement preState = null;
        ResultSet rs = null;
        ComicTypeBean item = null;
        ArrayList<String> tl = null;
        try {
            con = getConnection();
            String query = " Select Descript From ComicType ct ,ComicList  cl  "
                    + " where  ct.tid = cl.tid and comic_id= ? ";
            preState = con.prepareStatement(query);
            preState.setString(1, id);
            rs = preState.executeQuery();
            tl = new ArrayList<String>();
            while (rs.next()) {
                tl.add(rs.getString(1));

            }

            con.close();
            rs.close();
        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }

        return tl;

    }

    public static void main(String[] args) {

        ArrayList<String> sa = new ComicTypeDB().getTypeListById("1");
        for (int s = 0; s < sa.size(); s++) {
            System.out.print(sa.get(s));

        }

    }

}
