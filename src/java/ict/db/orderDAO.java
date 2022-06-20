package ict.db;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import ict.db.Conectar;
import ict.bean.OrderBean;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class orderDAO {

    /*Metodo listar*/
    public ArrayList<OrderBean> Listar_ImagenVO() {
        ArrayList<OrderBean> list = new ArrayList<OrderBean>();
        Conectar conec = new Conectar();
        String sql = "SELECT * FROM orderrequest;";
        ResultSet rs = null;
        PreparedStatement ps = null;
        try {
            ps = conec.getConnection().prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                OrderBean item = new OrderBean();
                item.seteAddress(rs.getString(1));
                item.setPid(rs.getString(2));
                item.setOrdId(rs.getInt(3));
                item.setSendDate(rs.getTimestamp(4));
                item.setOrdDiscount(rs.getDouble(5));
                item.setStatus(rs.getString(6));
                item.setUpdateTime(rs.getTimestamp(7));
                item.setApprover(rs.getString(8));
                item.setAmount(rs.getInt(9));
                item.setStoreId(rs.getInt(10));
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
    public void Agregar_ImagenVO(OrderBean ob) {
        Conectar conec = new Conectar();
        String sql = "INSERT INTO `orderrequest`(`eAddress`, `product_id`, `ord_id`, `ordDiscount`, `status`, `approver`, `amount`, `store_id`) VALUES(?,?,?,?,?,?,?,?);";
        PreparedStatement ps = null;
        try {

            ps = conec.getConnection().prepareStatement(sql);
            ps.setString(1, ob.geteAddress());
            ps.setString(2, ob.getPid());
            ps.setInt(3, ob.getOrdId());
            ps.setDouble(4, ob.getOrdDiscount());
            ps.setString(5, "Complete");
            ps.setString(6, "1");
            ps.setInt(7, ob.getAmount());
            ps.setString(8, "1");
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
    public void Modificar_ImagenVO(OrderBean ob) {
        Conectar conec = new Conectar();
        String sql = "UPDATE orderrequest SET eAddress=?, product_id=?, ordDiscount=?, status=?, approver=?, amount=?, store_id=? WHERE ord_id = ?;";
        PreparedStatement ps = null;
        try {
            ps = conec.getConnection().prepareStatement(sql);
            ps.setString(1, ob.geteAddress());
            ps.setString(2, ob.getPid());
            ps.setDouble(3, ob.getOrdDiscount());
            ps.setString(4, "Complete");
            ps.setString(5, "1");
            ps.setInt(6, ob.getAmount());
            ps.setString(7, "1");
            ps.setInt(8, ob.getOrdId());
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
        String sql = "DELETE FROM orderrequest WHERE ord_id = ?;";
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
    public OrderBean getImagenVOById(int ordId) {
        OrderBean item = new OrderBean();
        Conectar db = new Conectar();
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        String query = "SELECT * FROM orderrequest WHERE ord_id = ?;";
        try {
            preparedStatement = db.getConnection().prepareStatement(query);
            preparedStatement.setInt(1, ordId);
            rs = preparedStatement.executeQuery();
            while (rs.next()) {
                item.seteAddress(rs.getString(1));
                item.setPid(rs.getString(2));
                item.setOrdId(rs.getInt(3));
                item.setSendDate(rs.getTimestamp(4));
                item.setOrdDiscount(rs.getDouble(5));
                item.setStatus(rs.getString(6));
                item.setUpdateTime(rs.getTimestamp(7));
                item.setApprover(rs.getString(8));
                item.setAmount(rs.getInt(9));
                item.setStoreId(rs.getInt(10));
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
