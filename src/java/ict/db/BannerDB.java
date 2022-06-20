/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import ict.bean.BannerBean;
import ict.imageTranslator;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author law
 */
public class BannerDB {

    dbOperation db = null;

    public BannerDB() {
        db = new dbOperation();
    }

    public Connection getConnection() throws SQLException {
        return db.getConnection();
    }

    public BannerBean getAllBanner() throws IOException {
        Connection con = null;
        ResultSet rs = null;
        BannerBean  container =null;
         Statement  preState =null;
        try{
            container  = new BannerBean(); 
            imageTranslator it   =new   imageTranslator ();
            con = getConnection();            
            String query ="Select * from banner";
            preState = con.createStatement();
            rs =preState.executeQuery(query);            
            while(rs.next()){
                BannerBean js = new BannerBean();
                js.setBannerID(rs.getInt(1));
                js.setBase64Image(it.genImage(rs.getBinaryStream(2))); 
                container.addBb(js);
            }
            con.close();
            preState.close();
            rs.close();
           
        }catch(SQLException ex){
             while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
    
        }
    
        return container ;
    
    
    }

}
