/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author law
 */
public class dbOperation {

    private String username;
    private String url;
    private String password;

    public dbOperation() {
        this.url = "jdbc:mysql://localhost/FYP";
        this.username = "root";
        this.password = "";
        
    }
    
      public Connection getConnection() throws SQLException {
       
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        }
        return DriverManager.getConnection(url, username, password);
    }

}
