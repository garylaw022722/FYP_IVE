/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import ict.bean.BundleSetBean;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;

/**
 *
 * @author law
 */
public class BundleSetDB {

    dbOperation db;

    public BundleSetDB() {
        db = new dbOperation();       
    }

    public Connection getConnection() throws SQLException {

        return db.getConnection();

    }
    
    public  BundleSetBean getAllBundle(){
        Connection con = null;
        ResultSet rs =null;
        Statement  state = null;
        BundleSetBean output  = null;
        try{
        con = getConnection();
        String query =  " SELECT * FROM `BundleSet`  ";
        state = con.createStatement();
        rs = state.executeQuery(query);
        output =  handleRowData(rs);
        rs.close();
        con.close();
        state.close();
        
        }catch(SQLException ex){
        
            
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        
        
        }
            
    
    return  output;
        
    }
    
    public void insertNewBundleBook(String bid , String name, String Description, String type, String version, InputStream coverPage ,byte[] PdfStream){
         Connection con = null;
        PreparedStatement  preState = null;
        try{
            con = getConnection();
            String query = " INSERT INTO `BundleSet` VALUES (?,?,?,?,?,?,?,?) ";            
            preState =  con.prepareStatement(query);
            preState.setString(1, bid);
            preState.setString(2, name);
            preState.setString(3, Description);
            preState.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
            preState.setString(5, type);
            preState.setString(6,version);
            preState.setBinaryStream(7, coverPage);
            preState.setBytes(8, PdfStream);
            preState.executeUpdate();
            con.close();
            preState.close();
        }catch(SQLException ex){
        
            
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        
        
        }

    }
    
    public BundleSetBean  getBundleById(String bid){
        ResultSet rs =null;
        Connection con = null;
        PreparedStatement  preState = null;
        BundleSetBean  bs = null;
        try{
            con = getConnection();
            String query = " SELECT * FROM `BundleSet` WHERE `bid` = ? ";
            preState =con.prepareStatement(query);
            preState.setString(1, bid);
            rs = preState.executeQuery();
            bs = handleRowData(rs);
            rs.close();
            con.close();
            preState.close();
        
        
        
        }catch(SQLException ex){
                    
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        
        
        }
        
        return   bs;
    
    
    
    }
    
    
    public int  getMaxBid(){
         ResultSet rs =null;
        Connection con = null;
        Statement  State = null;
        BundleSetBean  bs = null;
         int max = 0;
        try{
            con = getConnection();
            String query = " SELECT bid FROM `BundleSet` ";
            State = con.createStatement();
            rs = State.executeQuery(query);
            while(rs.next()){
                if(Integer.valueOf(rs.getString(1))>max)
                    max =  Integer.valueOf(rs.getString(1));

            }
            

            rs.close();
 
        
        
        
        }catch(SQLException ex){
                    
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        
        
        }
        return max;
       
    
    }
             
    public BundleSetBean handleRowData(ResultSet rs) throws SQLException {
        BundleSetBean container = new BundleSetBean();
        while (rs.next()) {
            BundleSetBean item = new BundleSetBean();
            item.setBid(rs.getString(1));
            item.setName(rs.getString(2));
            item.setDescription(rs.getString(3));
            item.setCreateDate(rs.getTimestamp(4));
            item.setType(rs.getString(5));
            item.setVersion(rs.getString(6));
            item.setCoverPage(rs.getBinaryStream(7));
            item.setPdf(rs.getBinaryStream(8));
            container.addItem(item);
        }
        rs.close();

        return container;

    }
    
    
  

    
    public static void main(String [] args ){
           int max = new BundleSetDB().getMaxBid();
          System.out.println(max);
    
    }
}
