/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import ict.db.Conectar;
import ict.bean.ImagenVO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author user
 */
public class ImagenDAO {

    public ArrayList<ImagenVO> Listar_ImagenVO() {
        ArrayList<ImagenVO> list = new ArrayList<ImagenVO>();
        Conectar conec = new Conectar();
        String sql = "SELECT bundleset.bid as bid,Name,coverPage,Descript,type,version,product_id FROM bundleset,product WHERE bundleset.bid = product.bid";
        ResultSet rs = null;
        PreparedStatement ps = null;
        try {
            ps = conec.getConnection().prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                ImagenVO vo = new ImagenVO();
                vo.setBid(rs.getInt(1));
                vo.setName(rs.getString(2));
                vo.setCoverPage2(rs.getBytes(3));
                vo.setDescript(rs.getString(4));
                vo.setType(rs.getString(5));
                vo.setVersion(rs.getString(6));
                vo.setProductID(rs.getString("product_id"));
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


    /*Metodo agregar*/
    public void Agregar_ImagenVO(ImagenVO vo) {
        Conectar conec = new Conectar();
        String sql = "INSERT INTO bundleset (bid, Name, coverPage) VALUES(?, ?, ?);";
        PreparedStatement ps = null;
        try {
            ps = conec.getConnection().prepareStatement(sql);
            ps.setInt(1, vo.getBid());
            ps.setString(2, vo.getName());
            ps.setBlob(3, vo.getCoverPage());
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
    public void Modificar_ImagenVO(ImagenVO vo) {
        Conectar conec = new Conectar();
        String sql = "UPDATE bundleset SET Name = ?, coverPage = ? WHERE bid = ?;";
        PreparedStatement ps = null;
        try {
            ps = conec.getConnection().prepareStatement(sql);
            ps.setString(1, vo.getName());
            ps.setBlob(2, vo.getCoverPage());
            ps.setInt(3, vo.getBid());
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
    public void Modificar_ImagenVO2(ImagenVO vo) {
        Conectar conec = new Conectar();
        String sql = "UPDATE bundleset SET Name = ? WHERE bid = ?;";
        PreparedStatement ps = null;
        try {
            ps = conec.getConnection().prepareStatement(sql);
            ps.setString(1, vo.getName());
            ps.setInt(2, vo.getBid());
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

    /*Metodo Eliminar*/
    public void Eliminar_ImagenVO(int id) {
        Conectar conec = new Conectar();
        String sql = "DELETE FROM bundleset WHERE bid = ?;";
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
    public ImagenVO getImagenVOById(int imgId) {
        ImagenVO vo = new ImagenVO();
        Conectar db = new Conectar();
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        String query = "SELECT bid,Name,coverPage FROM bundleset WHERE bid = ?;";
        try {
            preparedStatement = db.getConnection().prepareStatement(query);
            preparedStatement.setInt(1, imgId);
            rs = preparedStatement.executeQuery();
            while (rs.next()) {
                vo.setBid(rs.getInt(1));
                vo.setName(rs.getString(2));
                vo.setCoverPage2(rs.getBytes(3));
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
        return vo;
    }

    public ArrayList<ImagenVO> Listar_IdVO(String id) {
        ArrayList<ImagenVO> list = new ArrayList<ImagenVO>();
        Conectar conec = new Conectar();
        String sql = "SELECT bid,Name,coverPage,Descript,type,version FROM bundleset WHERE Name IN (?);";
        ResultSet rs = null;
        PreparedStatement ps = null;
        ImagenVO vo = new ImagenVO();
        try {
            ps = conec.getConnection().prepareStatement(sql);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                vo.setBid(rs.getInt(1));
                vo.setName(rs.getString(2));
                vo.setCoverPage2(rs.getBytes(3));
                vo.setDescript(rs.getString(4));
                vo.setType(rs.getString(5));
                vo.setVersion(rs.getString(6));
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
    public ArrayList<ImagenVO> Listar_CBookVO(String name) {
        ArrayList<ImagenVO> list = new ArrayList<ImagenVO>();
        Conectar conec = new Conectar();
        String sql = "SELECT bid,Name,coverPage,Descript,type,version FROM bundleset WHERE NAME LIKE ?;";
        ResultSet rs = null;
        PreparedStatement ps = null;
        ImagenVO vo = new ImagenVO();
        try {
            ps = conec.getConnection().prepareStatement(sql);
            ps.setString(1,name);
            rs = ps.executeQuery();
            while (rs.next()) {
                vo.setBid(rs.getInt(1));
                vo.setName(rs.getString(2));
                vo.setCoverPage2(rs.getBytes(3));
                vo.setDescript(rs.getString(4));
                vo.setType(rs.getString(5));
                vo.setVersion(rs.getString(6));
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

    public ArrayList<ImagenVO> Listar_BookVO(String name) {
        ArrayList<ImagenVO> list = new ArrayList<ImagenVO>();
        Conectar conec = new Conectar();
        String sql = "SELECT bid,Name,coverPage,Descript,type,version FROM bundleset WHERE NAME LIKE ?;";
        ResultSet rs = null;
        PreparedStatement ps = null;
        ImagenVO vo = new ImagenVO();
        try {
            ps = conec.getConnection().prepareStatement(sql);
            ps.setString(1, "%" + name + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                vo.setBid(rs.getInt(1));
                vo.setName(rs.getString(2));
                vo.setCoverPage2(rs.getBytes(3));
                vo.setDescript(rs.getString(4));
                vo.setType(rs.getString(5));
                vo.setVersion(rs.getString(6));
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

    public ArrayList<ImagenVO> Listar_CookieVO(ArrayList<String> name) {
        ArrayList<ImagenVO> list = new ArrayList<ImagenVO>();
        Conectar conec = new Conectar();
        String sql = "SELECT bid,Name,coverPage,Descript,type,version FROM bundleset WHERE Name IN";
        StringBuilder parameterBuilder = new StringBuilder();
        parameterBuilder.append(" (");
        for (int i = 0; i < name.size(); i++) {
            parameterBuilder.append("?");
            if (name.size() > i + 1) {
                parameterBuilder.append(",");
            }
        }
        parameterBuilder.append(")");

        ResultSet rs = null;
        PreparedStatement ps = null;
        ImagenVO vo = new ImagenVO();
        try {
            ps = conec.getConnection().prepareStatement(sql + parameterBuilder);
            for (int i = 1; i < name.size() + 1; i++) {
                ps.setString(i, (String) name.get(i - 1));
            }
            rs = ps.executeQuery();
            while (rs.next()) {
                vo.setBid(rs.getInt(1));
                vo.setName(rs.getString(2));
                vo.setCoverPage2(rs.getBytes(3));
                vo.setDescript(rs.getString(4));
                vo.setType(rs.getString(5));
                vo.setVersion(rs.getString(6));
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

    public ImagenVO getImagenVOByName(String name) {
        ImagenVO vo = new ImagenVO();
        Conectar db = new Conectar();
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        String query = "SELECT bid,Name,coverPage FROM bundleset WHERE Name LIKE %?&;";
        try {
            preparedStatement = db.getConnection().prepareStatement(query);
            preparedStatement.setString(1, name);
            rs = preparedStatement.executeQuery();
            while (rs.next()) {
                vo.setBid(rs.getInt(1));
                vo.setName(rs.getString(2));
                vo.setCoverPage2(rs.getBytes(3));
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
        return vo;
    }

}
