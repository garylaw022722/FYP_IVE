/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import ict.bean.ContentBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author law
 */
public class contentDB {

    dbOperation db;

    public contentDB() {
        this.db = new dbOperation();
    }

    public Connection getConnection() throws SQLException {

        return db.getConnection();

    }
    
    public ContentBean getAllContent(){
    Connection  con = null;
    ResultSet rs  = null;
    ContentBean ct  =  null;
    Statement   state = null;
    try{
        con  = getConnection();
        String query =" SELECT * FROM `content`  ";
        state = con.createStatement();
        rs= state.executeQuery(query);
        ct=  handleRowData(rs);
        rs.close();
        con.close();
        state.close();
           
    }catch(SQLException ex){
                   
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        
        
        }
    
    
    return ct;
    
    
    }
    
    
    public void innsertNewContent(String  bid ,String comic_id , int ep){
          PreparedStatement  preState = null;
          Connection  con  =null;
          try{
              con = getConnection(); 
              String query = " INSERT INTO `content`(`bid`, `comic_Id`, `ep`) VALUES (?,?,?) ";
              preState = con.prepareStatement(query);
              preState.setString(1, bid);
              preState.setString(2, comic_id);
              preState.setInt(3,ep);
              preState.executeUpdate();
              preState.close();
              con.close();

          }catch(SQLException ex){
                   
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        
        
        }
    
    }
 public ContentBean getContentById(String bid){
    Connection  con = null;
    ResultSet rs  = null;
    ContentBean ct  =  null;
    PreparedStatement   state = null;
    try{
        con  = getConnection();
        String query =" SELECT * FROM `content` where  bid= ?  ";
        state = con.prepareStatement(query);
        state.setString(1, bid);
        rs= state.executeQuery();
        ct=  handleRowData(rs);
        rs.close();
        con.close();
        state.close();
           
    }catch(SQLException ex){
                   
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        
        
        }
    
    
    return ct;
    
    
    }  

    public ContentBean handleRowData(ResultSet rs) throws SQLException {
        ContentBean ct = new ContentBean();
        while (rs.next()) {
            ContentBean item = new ContentBean();
            item.setBid(rs.getString(1));
            item.setComic_id(rs.getString(2));
            item.setEp(rs.getInt(3));
            ct.addItem(item);

        }
        rs.close();
        return ct;
    }

}
