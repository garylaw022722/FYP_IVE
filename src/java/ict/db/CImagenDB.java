/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import ict.db.Conectar;
import ict.bean.Imagen;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
/**
 *
 * @author user
 */
public class CImagenDB {
     public ArrayList<Imagen> Listar_CBookVO(String name) {
        ArrayList<Imagen> list = new ArrayList<Imagen>();
        Conectar conec = new Conectar();
        String sql = "SELECT comic_Id ,Name,coverPage,penName FROM comicworks WHERE comic_Id LIKE ?;";
        ResultSet rs = null;
        PreparedStatement ps = null;
        Imagen vo = new Imagen();
        try {
            ps = conec.getConnection().prepareStatement(sql);
            ps.setString(1,name);
            rs = ps.executeQuery();
            while (rs.next()) {
                vo.setComcid(rs.getString(1));
                vo.setName(rs.getString(2));
                vo.setCoverPage2(rs.getBytes(3));
                vo.setPenName(rs.getString(4));
                list.add(vo);
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
}
