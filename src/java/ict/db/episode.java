/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import ict.bean.episodes;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

/**
 *
 * @author law
 */
public class episode {

    dbOperation db = null;

    public episode() {
        db = new dbOperation();
    }

    public Connection getConnection() throws SQLException {

        return db.getConnection();
    }

    public InputStream getEpisodes(String comic_id, int ep) {
        Connection con = null;
        PreparedStatement preState = null;
        ResultSet rs = null;

        try {
            con = getConnection();
            String query = "SELECT `pdfStream`  FROM `episode` WHERE `comic_Id`=? and `ep`=? ";
            preState = con.prepareStatement(query);
            preState.setString(1, comic_id);
            preState.setInt(2, ep);
            rs = preState.executeQuery();
            if (rs.next()) {
                return rs.getBinaryStream(1);
            }
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }

        return null;
    }

    public InputStream getEpisodesById_Ep(String comic_id, int ep) {
        Connection con = null;
        PreparedStatement preState = null;
        ResultSet rs = null;

        try {
            con = getConnection();
            String query = "SELECT `pdfStream`  FROM `episode` WHERE `comic_Id`=? and `ep`=? ";
            preState = con.prepareStatement(query);
            preState.setString(1, comic_id);
            preState.setInt(2, ep);
            rs = preState.executeQuery();
            if (rs.next()) {
                return rs.getBinaryStream(1);
            }
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }

        return null;
    }

    public episodes getDetailsEpisodesById_Ep(String comic_id, int ep) {
        Connection con = null;
        PreparedStatement preState = null;
        ResultSet rs = null;
        episodes chapter = null;

        try {
            chapter = new episodes();
            con = getConnection();
            String query = "SELECT *  FROM `episode` WHERE `comic_Id`=? and `ep`=? ";
            preState = con.prepareStatement(query);
            preState.setString(1, comic_id);
            preState.setInt(2, ep);
            rs = preState.executeQuery();
            if (rs.next()) {
                chapter.setCid(rs.getString(1));
                chapter.setEp(rs.getInt(2));
                chapter.setTitle(rs.getString(3));
                chapter.setDesc(rs.getString(4));
                chapter.setCover(rs.getBinaryStream(5));
                chapter.setUpdate(rs.getTimestamp(6));
                chapter.setView(rs.getInt(7));
                chapter.setPdf(rs.getBinaryStream(8));
                chapter.setIspublic(rs.getString(9));
            }
            con.close();
            rs.close();
            preState.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }

        return chapter;
    }

    public void uploadEpisode(String cid, int ep, String title, String Desc,
            InputStream cover, int view, InputStream pdf, String open) {
        Connection con = null;
        PreparedStatement preState = null;
        try {
            con = getConnection();
            String query = "INSERT INTO `episode` VALUES (?,?,?,?,?,?,?,?,?)";
            preState = con.prepareStatement(query);
            preState.setString(1, cid);
            preState.setInt(2, ep);
            preState.setString(3, title);
            preState.setString(4, Desc);
            preState.setBinaryStream(5, cover);
            preState.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
            preState.setInt(7, view);
            preState.setBinaryStream(8, pdf);
            preState.setString(9, open);
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

    public episodes getEpisodeByComicId(String cid) {
        Connection con = null;
        ResultSet rs = null;
        episodes comic = null;
        PreparedStatement preState = null;
        try {
            con = getConnection();
            comic = new episodes();
            String query = "SELECT * FROM `episode` WHERE  `comic_Id` =?";
            preState = con.prepareStatement(query);
            preState.setString(1, cid);
            rs = preState.executeQuery();
            while (rs.next()) {
                episodes ep = new episodes();
                ep.setCid(rs.getString(1));
                ep.setEp(rs.getInt(2));
                ep.setTitle(rs.getString(3));
                ep.setDesc(rs.getString(4));
                ep.setCover(rs.getBinaryStream(5));
                ep.setUpdate(rs.getTimestamp(6));
                ep.setView(rs.getInt(7));
                ep.setPdf(rs.getBinaryStream(8));
                ep.setIspublic(rs.getString(9));
                comic.addEpisodeByArr(ep);
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
        return comic;
    }

    public int getMaxEpisode(String cid) {
        Connection con = null;
        ResultSet rs = null;
        int maxEpisode = 0;
        PreparedStatement preState = null;
        try {
            con = getConnection();
            String query = " SELECT  Max(`ep`) FROM `episode` WHERE `comic_Id` = ? ";
            preState = con.prepareStatement(query);
            preState.setString(1, cid);
            rs = preState.executeQuery();
            if (rs.next()) {
                maxEpisode = rs.getInt(1);
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
        return maxEpisode;

    }

    public int removeFileBycomicId_ep(String comicId, int ep) {
        Connection con = null;
        ResultSet rs = null;
        int maxEpisode = 0;
        PreparedStatement preState = null;
        try {
            con = getConnection();
            String query = " UPDATE `episode` SET  `coverPage` =null ,`pdfStream` =null "
                    + "WHERE `comic_Id` =? and `ep`=? ";
            preState = con.prepareStatement(query);
            preState.setString(1, comicId);
            preState.setInt(2, ep);
            preState.executeUpdate();
        
            preState.close();
            con.close();

        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }
        return maxEpisode;

    }

    public episodes getAllEpisode() {
        Connection con = null;
        ResultSet rs = null;
        episodes item = null;
        PreparedStatement preState = null;
        try {
            item = new episodes();
            con = getConnection();
            String query = "SELECT * FROM `episode`";
            preState = con.prepareStatement(query);
            rs = preState.executeQuery();
            while (rs.next()) {
                episodes ep = new episodes();
                ep.setCid(rs.getString(1));
                ep.setEp(rs.getInt(2));
                ep.setTitle(rs.getString(3));
                ep.setDesc(rs.getString(4));
                ep.setCover(rs.getBinaryStream(5));
                ep.setUpdate(rs.getTimestamp(6));
                ep.setView(rs.getInt(7));
                ep.setPdf(rs.getBinaryStream(8));
                ep.setIspublic(rs.getString(9));
                item.addEpisodeByArr(ep);

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
            return item ;
    }
    
    
    
    public void UpdateEpisodeCover(String cid , int ep , InputStream  in){
        
            
        Connection con = null;
        PreparedStatement preState = null;
        try {
            con = getConnection();
            String query = "Update `episode` set coverPage =?  where  comic_Id = ? and  ep = ?";
            preState = con.prepareStatement(query);
            preState.setBinaryStream(1, in);
            preState.setString(2, cid);
            preState.setInt(3, ep);
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
