/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author user
 */
public class msql {
    
    public int auto_increm(String sql){
        int id = 1;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Conectar db = new Conectar();
        try{    
                ps = db.getConnection().prepareStatement(sql);
                rs = ps.executeQuery();
                while(rs.next()){
                    id = rs.getInt(1)+1;
                }
        }catch(Exception ex){
            System.out.println("idmaximo"+ex.getMessage());
            id = 1;
        }
        finally{
            try{
                ps.close();
                rs.close();
                db.desconectar();
            }catch(Exception ex){}
        }
        return id;
    }
    
    public static void main(String []args){
        msql s = new msql();
        int a = s.auto_increm("SELECT MAX(reqNo) FROM meetingrequest;");
        System.out.println(a);
    }
    
}
