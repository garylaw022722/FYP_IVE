/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import ict.bean.OrderBean;

import ict.bean.episodes;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

public class OrderDB {

    dbOperation db = null;

    public OrderDB() {
        db = new dbOperation();

    }

    public Connection getConnection() throws SQLException {

        return db.getConnection();

    }

    public episodes getEpisodeOrder(String status, String eAddress, String comic_id, int ep) {
        Connection con = null;
        ResultSet rs = null;
        episodes comicEpisode = null;
        PreparedStatement preState = null;
        try {
            comicEpisode = new episodes();
            con = getConnection();
            String query = " select comic_Id ,ep "
                    + " from product , orderRequest  re "
                    + " where product.product_id = re.product_id "
                    + " And  status =? "
                    + " And  eAddress = ? "
                    + " And `comic_Id`= ? "
                    + " And  `ep` = ? ";

            preState = con.prepareStatement(query);
            preState.setString(1, status);
            preState.setString(2, eAddress);
            preState.setString(3, comic_id);
            preState.setInt(4, ep);
            rs = preState.executeQuery();
            while (rs.next()) {
                comicEpisode.setCid(rs.getString(1));
                comicEpisode.setEp(rs.getInt(2));

            }
            rs.close();
            con.close();
            preState.close();

        } catch (SQLException s) {

        }
        return comicEpisode;
    }

    public int getProdctSalesAmountById(String productId) {
        Connection con = null;
        ResultSet rs = null;
        int amount = 0;
        PreparedStatement preState = null;

        try {
            con = getConnection();
            String query = " SELECT COUNT(`comic_Id`) FROM `product` , orderRequest "
                    + " WHERE product.product_id = orderRequest.product_id "
                    + " and comic_Id = ? "
                    + " and orderRequest.status ='Complete' "
                    + " and product.`product_id` LIKE 'e%' ";
            preState = con.prepareStatement(query);
            preState.setString(1, productId);
            rs = preState.executeQuery();
            if (rs.next()) {
                amount = rs.getInt(1);
            }
            rs.close();
            con.close();
            preState.close();

        } catch (SQLException s) {
            s.printStackTrace();

        }

        return amount;

    }

    public OrderBean getOrder(String email, String pid) {
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement preState = null;
        OrderBean item = null;

        try {
            con = getConnection();

            String query = " SELECT * FROM `orderRequest` WHERE "
                    + " `eAddress` =? and `product_id` =? ";

            preState = con.prepareStatement(query);
            preState.setString(1, email);
            preState.setString(2, pid);
            rs = preState.executeQuery();
            item = new OrderBean();
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
            rs.close();
            con.close();
            preState.close();

        } catch (SQLException s) {
            s.printStackTrace();

        }
        return item;
    }

    public OrderBean getField(ResultSet rs) throws SQLException {
        OrderBean container = new OrderBean();
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
            container.addOrderList(item);

        }

        return container;
    }

    public ArrayList<String> getPurchasedEpisode(String user) {
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement preState = null;
        ArrayList<String> sa = null;

        try {
            con = getConnection();
            String query = "Select Distinct(comic_Id)"
                    + " FROM product ,orderRequest "
                    + " where product.product_id =orderRequest.product_id "
                    + " and eAddress= ?"
                    + " and bid is null "
                    + " and  status = 'Complete'"
                    + " and point !=0"
                    + " ORDER by `updateTime` ";

            preState = con.prepareStatement(query);
            preState.setString(1, user);

            rs = preState.executeQuery();
            sa = new ArrayList<String>();
            while (rs.next()) {
                sa.add(rs.getString(1));

            }
            rs.close();
            con.close();
            preState.close();

        } catch (SQLException s) {
            s.printStackTrace();

        }
        return sa;
    }

    public void createEpisodeOrder(String eAddress, String pid, int oid) {
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement preState = null;

        try {
            con = getConnection();

            String query = "INSERT INTO `orderRequest`(`eAddress`, `product_id`, `ord_id`, `sendDate`,`status`, `updateTime` ,approver ) VALUES (?,?,?,?,?,?,?)";
            preState = con.prepareStatement(query);
            preState.setString(1, eAddress);
            preState.setString(2, pid);
            preState.setInt(3, oid);
            preState.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
            preState.setString(5, "Complete");
            preState.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
            preState.setString(7, "System");
            preState.executeUpdate();
        } catch (SQLException s) {
            s.printStackTrace();

        }

    }

    public int getMaxOID() {
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement preState = null;
        int max = 0;

        try {
            con = getConnection();
            String query = "SELECT MAX(`ord_id`) FROM `orderRequest` ";
            preState = con.prepareStatement(query);
            rs = preState.executeQuery();
            if (rs.next()) {
                max = rs.getInt(1);
            }
            con.close();
            rs.close();
        } catch (SQLException s) {
            s.printStackTrace();

        }

        return max;

    }

    public static void main(String[] args) {

        System.out.print(new OrderDB().getPurchasedEpisode("law190444956@gmail.com").get(0));

    }

    public ArrayList<String> getAllProduct_by_id(String email) {  ///sales 
        Connection con = null;
        ResultSet rs = null;
        ArrayList<String> str = null;
        PreparedStatement preState = null;
        try {
            str = new ArrayList<String>();
            con = getConnection();
            String query = "SELECT `product_id` FROM `orderRequest` WHERE eAddress=? ";
            preState = con.prepareStatement(query);
            preState.setString(1, email);
            rs = preState.executeQuery();
            while (rs.next()) {
                str.add(rs.getString(1));
            }

        } catch (SQLException s) {
            s.printStackTrace();

        }

        return str;

    }

    public int getMaxOrderID() {
        Connection cnnct = null;
        ResultSet rs = null;
        int maxId = 0;
        PreparedStatement preState = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String query = "SELECT MAX(ord_id) FROM `orderrequest`";
            preState = cnnct.prepareStatement(query);
            rs = preState.executeQuery();
            if (rs.next()) {
                maxId = rs.getInt(1);
            }
            maxId++;

            preState.close();
            cnnct.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }
        return maxId;

    }

    public boolean UserAddBook(ArrayList pid, ArrayList QTY, String eAddress, int ord_id, String ord_Discount) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            for (int i = 0; i < pid.size(); i++) {
                String preQueryStatement2 = "INSERT INTO `orderrequest`(`eAddress`, `product_id`, `ord_id`, `ordDiscount`, `status`, `approver`, `amount`, `store_id`) VALUES(?,?,?,?,?,?,?,?)";
                pStmnt = cnnct.prepareStatement(preQueryStatement2);
                pStmnt.setString(1, eAddress);
                pStmnt.setObject(2, pid.get(i));
                pStmnt.setInt(3, ord_id);
                pStmnt.setString(4, ord_Discount);
                pStmnt.setString(5, "Complete");
                pStmnt.setString(6, "1");
                pStmnt.setObject(7, QTY.get(i));
                pStmnt.setString(8, "1");
                int rowCount = pStmnt.executeUpdate();
                if (rowCount >= 1) {
                    isSuccess = true;
                }
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }
        return isSuccess;

    }

}
