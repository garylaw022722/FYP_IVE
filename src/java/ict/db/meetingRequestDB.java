/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import com.mysql.cj.protocol.Resultset;
import ict.bean.meetingRequestBean;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author law
 */
public class meetingRequestDB {

    dbOperation db;

    public meetingRequestDB() {
        db = new dbOperation();

    }

    public Connection getConnection() throws SQLException {
        return db.getConnection();
    }

    public meetingRequestBean getAllRequst() {

        Connection con = null;
        ResultSet rs = null;
        Statement state = null;
        meetingRequestBean mrBean = null;
        try {
            con = getConnection();         
            String query = " SELECT * FROM `meetingRequest` ";
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

    public meetingRequestBean dataField(ResultSet rs) throws SQLException {
        meetingRequestBean container = new meetingRequestBean();
        while (rs.next()) {
            meetingRequestBean sources  = new meetingRequestBean();
            sources.setReqNo(rs.getInt(1));
            sources.seteAddress(rs.getString(2));
            sources.setSendDate(rs.getTimestamp(3));
            sources.setMeetingDate(rs.getTimestamp(4));
            sources.setApprover(rs.getString(5));
            sources.setStatus(rs.getString(6));
            sources.setPdf(rs.getBinaryStream(7));
            sources.setTitle(rs.getString(8));
            sources.setComment(rs.getString(9));
            sources.setCallBackTime(rs.getTime(10));
            container.addList(sources);
        }
        
      return container ;
    }
}
