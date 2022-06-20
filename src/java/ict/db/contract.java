/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import ict.bean.contractBean;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

/**
 *
 * @author law
 */
public class contract {
    dbOperation  db =null;
    
    public contract(){
        db = new dbOperation();
    }
    
    public Connection getConnection() throws SQLException{
    
    return  db.getConnection();
    
    }
    
    
    public  contractBean  getContract(){
        Connection  con =null;
        Statement  State  =null;
        ResultSet  rs  =null;
        contractBean  item  =null;
        try{
            con  =getConnection();
            String query  = "Select * from contract";
            State =con.createStatement();
            rs = State.executeQuery(query);
            item    = getFieldSet(rs );
           
            rs.close();
            con.close();
        
        }catch(SQLException ex){
        
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
                       
        }
        return item;
    
    }
    
    
    public ArrayList<String> getContractYear(){
        Connection  con =null;
        Statement  State  =null;
        ResultSet  rs  =null;
        contractBean  item  =null;
         ArrayList<String> YearList =null ;
        
        
        try{
            con  =getConnection();
            String query  = "SELECT  DISTINCT(Year(`signDate`)) as Year FROM `contract`";
            State =con.createStatement();
            rs = State.executeQuery(query);
            YearList   =new ArrayList<String>();
          
          while(rs.next()){
              YearList.add(rs.getString(1));

          }
           
            rs.close();
            con.close();
        
        }catch(SQLException ex){
        
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
                       
        }
        return  YearList;
    
    }
    
    
     public  contractBean  getAuthorEmail(){
        Connection  con =null;
        Statement  State  =null;
        ResultSet  rs  =null;
        contractBean  item  =null;
        try{
            con  =getConnection();
            String query  = "SELECT DISTINCT(`eAddress`) FROM `contract` ";
            State =con.createStatement();
            rs = State.executeQuery(query);
            item    =new  contractBean();
          while(rs.next()){
              contractBean  container = new contractBean();
              container.seteAddress(rs.getString(1));
              item.addContract(container);

          }
           
            rs.close();
            con.close();
        
        }catch(SQLException ex){
        
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
                       
        }
        return item;
    
    }
    
     public contractBean getContractByComicId(String cid){
            Connection  con =null;
        PreparedStatement  State  =null;
        ResultSet  rs  =null;
        contractBean  item  =null;
        try{
            con  =getConnection();
            String query  = "Select * from contract where  comic_Id = ?";
            State =con.prepareStatement(query);
            State.setString(1, cid);
            rs = State.executeQuery();
            item    = getFieldSet(  rs );
         
            rs.close();
            con.close();
        
        }catch(SQLException ex){
        
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
                       
        }
        return item;
     
     }
     
     
     public contractBean  getContractWithSorting(){
          Connection  con =null;
        PreparedStatement  preState  =null;
        ResultSet  rs  =null;
        contractBean  item  =null;
        try{
            con  =getConnection();
            String query  = "SELECT * FROM `contract` ORDER by `signDate` DESC";
            preState =con.prepareStatement(query);
            rs=  preState.executeQuery();
            item = getFieldSet(rs);
            con.close();
            preState.close();
        }catch(SQLException ex){
        
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
                       
        }
     
     
          return item;
     }
     
     
     
     public  contractBean   getFieldSet( ResultSet  rs ) throws SQLException{
         contractBean  item = new contractBean();
         while(rs.next()){
              contractBean  container = new contractBean();
              container.setCid(rs.getInt(1));
              container.setComicid(rs.getString(2));
              container.seteAddress(rs.getString(3));
              container.setSignDate(rs.getTimestamp(4));
              container.setPrice(rs.getInt(5));
              container.setUnitPay(rs.getString(6));
              container.setPeriod(rs.getInt(7));
              container.setUnitDate(rs.getString(8));
              container.setPdf(rs.getBinaryStream(9));
              container.setFileName(rs.getString(10));
              container.setContriId(rs.getInt(11));
              item.addContract(container);

          }               
        return item ;         
     }
     
     
     public  boolean  hasContriId(int contrid){
     
     
       
         
         boolean   b = false;
           Connection  con =null;
        PreparedStatement  preState  =null;
        ResultSet  rs  =null;
        contractBean  item  =null;
        try{
            con  =getConnection();
           String query ="SELECT * FROM `contract` WHERE `contriId` =?";
            preState =con.prepareStatement(query);
            preState.setInt(1, contrid);
            rs=  preState.executeQuery();
           if(rs.next())
                b = true;
            con.close();
            preState.close();
        }catch(SQLException ex){
        
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
                       
        }
     
     
     
        return b;
     
     }
     
     public int getNextId() {

        Connection con = null;
        Statement State = null;
        ResultSet rs = null;
        int max = 0;
        try {
            con = getConnection();
            String query = "SELECT MAX(conId) FROM `contract` ";
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
    
     
     public void  newContract(int conId, String comicId,String eAddress,int price , String unitPay ,
             String period ,String unitDate ,InputStream pdf ,String fileName,int contriId){
          Connection con = null;
        PreparedStatement State = null;
  
        try {
            con = getConnection();
            String query = " INSERT INTO `contract` VALUES (?,?,?,?,?,?,?,?,?,?,?) ";
            State = con.prepareStatement(query);
            State.setInt(1,conId);
            State.setString(2,comicId);
            State.setString(3, eAddress);
            State.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
            State.setInt(5, price);
            State.setString(6, unitPay);
            State.setString(7, period);
            State.setString(8, unitDate);
            State.setBinaryStream(9, pdf);
           State.setString(10,fileName);
           State.setInt(11,contriId);
            State.executeUpdate();
                    

           
      
            con.close();

        } catch (SQLException ex) {

            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }

        }

     }

    
}
