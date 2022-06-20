package ict.db;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import ict.db.Conectar;
import ict.bean.meetingRequestBean;
import java.io.InputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MeetingDAO {

    /*Metodo listar*/
    public ArrayList<meetingRequestBean> Listar_ImagenVO() {
        ArrayList<meetingRequestBean> list = new ArrayList<meetingRequestBean>();
        Conectar conec = new Conectar();
        String sql = "SELECT `reqNo`, `eAddress`, `sendDate`, `meetingDate`, `approver`, `Status`,`title`, `comment`, `phoneCallTime` FROM meetingrequest;";
        ResultSet rs = null;
        PreparedStatement ps = null;
        try {
            ps = conec.getConnection().prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                meetingRequestBean item = new meetingRequestBean();
                item.setReqNo(rs.getInt(1));
                item.seteAddress(rs.getString(2));
                item.setSendDate(rs.getTimestamp(3));
                item.setMeetingDate(rs.getTimestamp(4));
                item.setApprover(rs.getString(5));
                item.setStatus(rs.getString(6));
                item.setTitle(rs.getString(7));
                item.setComment(rs.getString(8));
                item.setCallBackTime(rs.getTime(9));
                list.add(item);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            try {
                ps.close();
                rs.close();
                conec.desconectar();
            } catch (Exception ex) {
            }
        }
        return list;
    }


    /*Metodo agregar*/
    public void Agregar_ImagenVO(meetingRequestBean mb) {
        Conectar conec = new Conectar();
        String sql = "INSERT INTO `meetingrequest`(`reqNo`, `eAddress`, `approver`, `Status`, `title`, `comment`, `phoneCallTime`) VALUES(?,?,?,?,?,?,?);";
        PreparedStatement ps = null;
        try {

            ps = conec.getConnection().prepareStatement(sql);
            ps.setInt(1, mb.getReqNo());
            ps.setString(2, mb.geteAddress());
            ps.setString(3, mb.getApprover());
            ps.setString(4, mb.getStatus());
            ps.setString(5, mb.getTitle());
            ps.setString(6, mb.getComment());
            ps.setString(7, mb.getPhoneCallTime());
            ps.executeUpdate();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            try {
                ps.close();
                conec.desconectar();
            } catch (Exception ex) {
            }
        }
    }


    /*Metodo Modificar*/
    public void Modificar_ImagenVO(meetingRequestBean mb) {
        Conectar conec = new Conectar();
        String sql = "UPDATE meetingrequest SET eAddress =?, approver=?, Status=?, title=?, comment=?, phoneCallTime=? WHERE reqNo = ?;";
        PreparedStatement ps = null;
        try {
            ps = conec.getConnection().prepareStatement(sql);
            ps.setString(1, mb.geteAddress());
            ps.setString(2, mb.getApprover());
            ps.setString(3, mb.getStatus());
            ps.setString(4, mb.getTitle());
            ps.setString(5, mb.getComment());
            ps.setString(6, mb.getPhoneCallTime());
            ps.setInt(7, mb.getReqNo());
            ps.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            try {
                ps.close();
                conec.desconectar();
            } catch (Exception ex) {
            }
        }
    }

    public void Eliminar_ImagenVO(int id) {
        Conectar conec = new Conectar();
        String sql = "DELETE FROM meetingrequest WHERE reqNo = ?;";
        PreparedStatement ps = null;
        try {
            ps = conec.getConnection().prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            try {
                ps.close();
                conec.desconectar();
            } catch (Exception ex) {
            }
        }
    }

    /*Metodo Consulta id*/
    public meetingRequestBean getImagenVOById(int ordId) {
        meetingRequestBean item = new meetingRequestBean();
        Conectar db = new Conectar();
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        String query = "SELECT `reqNo`, `eAddress`, `sendDate`, `meetingDate`, `approver`, `Status`,`title`, `comment`, `phoneCallTime` FROM meetingrequest WHERE reqNo = ?;";
        try {
            preparedStatement = db.getConnection().prepareStatement(query);
            preparedStatement.setInt(1, ordId);
            rs = preparedStatement.executeQuery();
            while (rs.next()) {
                item.setReqNo(rs.getInt(1));
                item.seteAddress(rs.getString(2));
                item.setSendDate(rs.getTimestamp(3));
                item.setMeetingDate(rs.getTimestamp(4));
                item.setApprover(rs.getString(5));
                item.setStatus(rs.getString(6));
                item.setTitle(rs.getString(7));
                item.setComment(rs.getString(8));
                item.setCallBackTime(rs.getTime(9));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            try {
                rs.close();
                preparedStatement.close();
                db.desconectar();
            } catch (Exception ex) {
            }
        }
        return item;
    }

}
