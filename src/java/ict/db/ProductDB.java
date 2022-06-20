/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import ict.bean.Product;
import ict.bean.episodes;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Base64;

/**
 *
 * @author law
 */
public class ProductDB {

    dbOperation db;

    public ProductDB() {
        db = new dbOperation();
    }

    public Connection getConnection() throws SQLException {
        return db.getConnection();

    }

    public Product getNewReleaseProduct() {
        Product container = null;
        ResultSet rs = null;
        Connection con = null;
        Statement state = null;
        try {
            con = getConnection();

            String query = " SELECT   product.*  FROM `product` ,contract "
                    + " WHERE  product.comic_Id = contract.comic_Id "
                    + " And `Public` = 'T'  and product.`comic_Id`is not null "
                    + " And YEAR(`signDate`) =YEAR(CURRENT_TIMESTAMP) "
                    + " Order by `startDate`  DESC ";

            state = con.createStatement();
            rs = state.executeQuery(query);
            container = new Product();
            while (rs.next()) {
                Product item = new Product();
                item.setProduct_id(rs.getString(1));
                item.setComic_id(rs.getString(2));
                item.setEp(rs.getInt(3));
                item.setBid(rs.getString(4));
                item.setPrice(rs.getInt(5));
                item.setPoint(rs.getInt(6));
                item.setStock(rs.getInt(7));
                item.setsDate(rs.getTimestamp(8));
                item.seteDate(rs.getTimestamp(9));
                item.setDiscount(rs.getInt(10));
                item.setPublic(rs.getString(11));
                item.setEventId(rs.getString(12));
                container.addProductList(item);

            }
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }

        return container;
    }

    public episodes getProductEpisode(String comic_id, String state) {
        episodes container = null;
        ResultSet rs = null;
        Connection con = null;
        PreparedStatement preState = null;
        try {
            con = getConnection();
            container = new episodes();
            String query = " SELECT epi.* "
                    + " FROM `product`  pi ,episode epi "
                    + " WHERE  pi.`comic_Id`  =epi.comic_Id "
                    + " And   pi.ep = epi.ep "
                    + " And  pi.comic_Id = ?"
                    + " And pi.Public  = ?";

            preState = con.prepareStatement(query);
            preState.setString(1, comic_id);
            preState.setString(2, state);
            rs = preState.executeQuery();
            while (rs.next()) {
                episodes chapter = new episodes();
                chapter.setCid(rs.getString(1));
                chapter.setEp(rs.getInt(2));
                chapter.setTitle(rs.getString(3));
                chapter.setDesc(rs.getString(4));
                chapter.setCover(rs.getBinaryStream(5));
                chapter.setUpdate(rs.getTimestamp(6));
                chapter.setView(rs.getInt(7));
                chapter.setPdf(rs.getBinaryStream(8));
                chapter.setIspublic(rs.getString(9));
                container.addEpisodeByArr(chapter);
            }
            con.close();
            preState.close();
            rs.close();

        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }

        return container;

    }

    public ArrayList<String> sortComicBySignDate() {
        ResultSet rs = null;
        Connection con = null;
        Statement State = null;
        ArrayList<String> p = null;
        try {
            con = getConnection();
            p = new ArrayList<String>();;
            String query = " SELECT DISTINCT(product.comic_Id) From product,contract WHERE product.`comic_Id` = contract.comic_Id "
                    + "And Public ='T' AND `product_id` LIKE 'e%' And YEAR(`signDate`) =YEAR(CURRENT_TIMESTAMP)  and product.`comic_Id`is not null ORDER by contract.signDate DESC ";
            State = con.createStatement();
            rs = State.executeQuery(query);
            while (rs.next()) {
                p.add(rs.getString(1));
            }
            rs.close();
            con.close();

        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }

        return p;

    }

    public int getMaxReleasEpisode(String comic_id, String state) {
        int MaxEpisode = 0;
        episodes container = null;
        ResultSet rs = null;
        Connection con = null;
        PreparedStatement preState = null;
        try {
            con = getConnection();
            String query = " SELECT  MAX(pi.ep) "
                    + " FROM `product`  pi ,episode epi  "
                    + " WHERE  pi.`comic_Id`  =epi.comic_Id  "
                    + " And   pi.ep = epi.ep  "
                    + " And pi.`Public` = ? "
                    + " GROUP by pi.comic_Id "
                    + " HAVING pi.comic_Id = ? ";

            preState = con.prepareStatement(query);
            preState.setString(1, state);
            preState.setString(2, comic_id);
            rs = preState.executeQuery();
            if (rs.next()) {
                MaxEpisode = rs.getInt(1);
            }

            con.close();
            preState.close();
            rs.close();

        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }

        return MaxEpisode;
    }

    public ArrayList<String> getAllProductComic(String status) {

        ResultSet rs = null;
        Connection con = null;
        PreparedStatement State = null;
        ArrayList<String> p = null;

        try {
            con = getConnection();
            String query = "SELECT DISTINCT(`comic_Id`)  FROM `product` WHERE `Public` =? AND `product_id` LIKE 'e%'   and `comic_Id`is not null  ";
            State = con.prepareStatement(query);
            State.setString(1, status);
            rs = State.executeQuery();
            p = new ArrayList<String>();

            while (rs.next()) {
                p.add(rs.getString(1));

            }
            rs.close();
            con.close();

        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }

        return p;

    }

    public ArrayList<String> getProductByComicDescription(String desc) {

        ArrayList<String> ts = null;
        ResultSet rs = null;
        Connection con = null;
        PreparedStatement State = null;
        try {
            con = getConnection();

            String query = " SELECT  DISTINCT(ComicType.comic_Id)"
                    + " FROM `product` , ComicType ,ComicList "
                    + " WHERE comicType.comic_Id   = product.comic_Id "
                    + " and ComicType.tid = ComicList.tid "
                    + " And `Public` ='T' AND `product_id` LIKE 'e%'  "
                    + " And  ComicList.Descript = ? ";
            State = con.prepareStatement(query);
            State.setString(1, desc);
            rs = State.executeQuery();
            ts = new ArrayList<String>();
            while (rs.next()) {
                ts.add(rs.getString(1));
            }

        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }
        return ts;
    }

    public Product getField(ResultSet rs) throws SQLException {
        Product container = new Product();
        while (rs.next()) {
            Product item = new Product();
            item.setProduct_id(rs.getString(1));
            item.setComic_id(rs.getString(2));
            item.setEp(rs.getInt(3));
            item.setBid(rs.getString(4));
            item.setPrice(rs.getInt(5));
            item.setPoint(rs.getInt(6));
            item.setStock(rs.getInt(7));
            item.setsDate(rs.getTimestamp(8));
            item.seteDate(rs.getTimestamp(9));
            item.setDiscount(rs.getInt(10));
            item.setPublic(rs.getString(11));
            item.setEventId(rs.getString(12));
            container.addProductList(item);

        }
        return container;

    }

    public ArrayList<String> getProductUpdateSchedule(String schedule) {

        ArrayList<String> ts = null;
        ResultSet rs = null;
        Connection con = null;
        PreparedStatement state = null;
        try {
            con = getConnection();
            String query = " SELECT DISTINCT(product.comic_Id)"
                    + " from product ,ComicWorks "
                    + " where product.comic_Id = ComicWorks.comic_Id "
                    + " and ComicWorks.Schedule =  ? ";
            state = con.prepareStatement(query);
            state.setString(1, schedule);
            rs = state.executeQuery();
            ts = new ArrayList<String>();
            while (rs.next()) {
                ts.add(rs.getString(1));
            }
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }

        return ts;

    }

    public Product getPurchasedEpisode(String queryString) {

        Product ts = null;
        ResultSet rs = null;
        Connection con = null;
        Statement State = null;

        try {
            con = getConnection();

            String query = queryString;
            State = con.createStatement();

            rs = State.executeQuery(query);
            ts = getField(rs);
            con.close();
            rs.close();
            State.close();

        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }

        return ts;

    }

    public void innsetProduct() {

        Product ts = null;
        ResultSet rs = null;
        Connection con = null;
        PreparedStatement State = null;
        try {
            con = getConnection();

            String query = "INSERT INTO `product`VALUES (?,?,?,?, ?,?,?,?, ?,?,?)";

            State = con.prepareStatement(query);

            rs = State.executeQuery();
            ts = getField(rs);
            con.close();
            rs.close();
            State.close();

        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }

    }

    public String getNextIndex(String type) {
        Product ts = null;
        ResultSet rs = null;
        Connection con = null;
        PreparedStatement State = null;
        int max = 0;
        try {
            con = getConnection();

            String query = "SELECT  `product_id` FROM `product` WHERE `product_id` like ?";
            State = con.prepareStatement(query);
            State.setString(1, type + "%");
            rs = State.executeQuery();

            while (rs.next()) {
                String number = rs.getString(1).substring(1);
                if (Integer.valueOf(number) > max) {
                    max = Integer.valueOf(number);
                }

            }

            con.close();
            rs.close();
            State.close();

        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }

        return type + (max + 1);
    }

    public String getEvent_Id() throws SQLException {
        Connection con = null;
        Statement State = null;
        ResultSet rs = null;
        int max = 0;
        try {
            con = getConnection();
            String query = "SELECT `event_Id` FROM `product` ";

            State = con.createStatement();
            rs = State.executeQuery(query);
            while (rs.next()) {
                if (rs.getString(1) == null) {
                    continue;
                }
                if (Integer.valueOf(rs.getString(1)) > max) {
                    max = Integer.valueOf(rs.getString(1));
                }

            }
            con.close();
            State.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }

        return "" + (max + 1);

    }

    public void insertElectricBundle(String pid, String bid, int Point, Timestamp start, String Public) throws SQLException {

        Connection con = null;
        PreparedStatement State = null;
        try {
            con = getConnection();
            String query = " INSERT INTO `product`(`product_id` ,`bid`, `point`, `startDate`, `Public`) VALUES (?,?,?,?,?) ";

            State = con.prepareStatement(query);
            State.setString(1, pid);
            State.setString(2, bid);
            State.setInt(3, Point);

            State.setTimestamp(4, start);

            State.setString(5, Public);
            State.executeUpdate();
            con.close();
            State.close();

        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }

    }

    public void insertEpisodeProduct(String pid, String cid, int ep, int Point, Timestamp end, String Public, String eid) throws SQLException {

        Connection con = null;
        PreparedStatement State = null;
        try {
            con = getConnection();
            String query = "INSERT INTO `product`(`product_id`, `comic_Id`, `ep`,  `point`,`startDate`, `endDate`,`Public`, `event_Id`) VALUES (?,?,?,?,?,?,?,?)";

            State = con.prepareStatement(query);
            State.setString(1, pid);
            State.setString(2, cid);
            State.setInt(3, ep);
            State.setInt(4, Point);
            State.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
            State.setTimestamp(6, end);
            State.setString(7, Public);

            State.setString(8, eid);

            State.executeUpdate();
            con.close();
            State.close();

        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }

    }

    public void createEvent(String eid, Timestamp end, String pid, String Public) {
        Connection con = null;
        PreparedStatement State = null;
        try {
            con = getConnection();
            String query = " CREATE EVENT `" + eid + "` ON SCHEDULE AT ? ON COMPLETION NOT PRESERVE ENABLE DO Update product set Public =? WHERE product_id = ? ";

            State = con.prepareStatement(query);

            State.setTimestamp(1, end);
            State.setString(2, Public);
            State.setString(3, pid);

            State.executeUpdate();
            con.close();
            State.close();

        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }

    }

    public Product showAllBundleProduct() {
        Connection con = null;
        Statement State = null;
        ResultSet rs = null;
        Product p = null;
        try {
            con = getConnection();

            String query = " SELECT * from product where product_id like'r%' ";
            State = con.createStatement();
            rs = State.executeQuery(query);
            p = new Product();

            p = getField(rs);

        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }

        return p;

    }

    public Product getNewUpdateEpisode(String comicId) {
        Connection con = null;
        PreparedStatement State = null;
        ResultSet rs = null;
        Product item = null;
        try {
            con = getConnection();

            String query = " SELECT * FROM `product` WHERE comic_Id = ?  and `Public` ='T' ORDER by `startDate` DESC ";
            State = con.prepareStatement(query);
            State.setString(1, comicId);
            rs = State.executeQuery();
            item = new Product();
            if (rs.next()) {

                item.setProduct_id(rs.getString(1));
                item.setComic_id(rs.getString(2));
                item.setEp(rs.getInt(3));
                item.setBid(rs.getString(4));
                item.setPrice(rs.getInt(5));
                item.setPoint(rs.getInt(6));
                item.setStock(rs.getInt(7));
                item.setsDate(rs.getTimestamp(8));
                item.seteDate(rs.getTimestamp(9));
                item.setDiscount(rs.getInt(10));
                item.setPublic(rs.getString(11));
                item.setEventId(rs.getString(12));

            }

        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }

        return item;

    }

    public Product getProductById(String id) {
        Connection con = null;
        PreparedStatement State = null;
        ResultSet rs = null;
        Product item = null;
        try {
            con = getConnection();

            String query = " SELECT * from product where product_id = ? ";
            State = con.prepareStatement(query);
            State.setString(1, id);
            rs = State.executeQuery();
            item = getField(rs);
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }

        return item;

    }

    public Product getAllEpisodeProduct(String comicId, String Sort) {

        Connection con = null;
        PreparedStatement State = null;
        ResultSet rs = null;
        Product item = null;
        try {
            con = getConnection();
            String query = " SELECT * FROM `product` WHERE comic_Id = ?  and `Public` ='T' ORDER by `startDate` " + Sort;
            State = con.prepareStatement(query);
            State.setString(1, comicId);
            rs = State.executeQuery();
            item = getField(rs);

        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }

        return item;

    }

    public static void main(String[] args) {
        for (Product pd : new ProductDB().getAllEpisodeProduct("1", "DESC").getProductList()) {
            System.out.println(pd.getPoint());
        }
    }

    public Product getAll_E_Bundle() {
        Connection con = null;
        Statement State = null;
        ResultSet rs = null;
        Product item = null;

        try {
            con = getConnection();
            item = new Product();
            String query = " Select  product.* "
                    + " from product ,BundleSet "
                    + " WHERE product.bid = BundleSet.bid and Public ='T' "
                    + " and `version`='Electric' ORDER by `startDate` DESC ";
            State = con.createStatement();
            rs = State.executeQuery(query);
            item = getField(rs);

        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }

        return item;

    }

    public Product getProductWithBid(String bid) {
        Connection con = null;
        PreparedStatement State = null;
        ResultSet rs = null;
        Product item = null;

        try {
            con = getConnection();
            item = new Product();

            String query = " Select  product.* "
                    + " from product ,BundleSet "
                    + " WHERE product.bid = BundleSet.bid and Public ='T' and product.bid= ? "
                    + " and `version`='Electric' ORDER by `startDate` DESC ";
             State = con.prepareStatement(query);
               State.setString(1, bid); 
               
            rs = State.executeQuery();
            if(rs.next()){
                  item.setProduct_id(rs.getString(1));
                item.setComic_id(rs.getString(2));
                item.setEp(rs.getInt(3));
                item.setBid(rs.getString(4));
                item.setPrice(rs.getInt(5));
                item.setPoint(rs.getInt(6));
                item.setStock(rs.getInt(7));
                item.setsDate(rs.getTimestamp(8));
                item.seteDate(rs.getTimestamp(9));
                item.setDiscount(rs.getInt(10));
                item.setPublic(rs.getString(11));
                item.setEventId(rs.getString(12));
                        
            
            }
   
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }
        return item;

    }

    public  ArrayList  getAllEBook() throws IOException{
            Connection con = null;
                Statement State = null;
                ResultSet rs = null;
                 Product  p= null;
                 ArrayList<Product> alp = new ArrayList();
                 ArrayList<Product> alp2 = new ArrayList();
        try {
            con = getConnection();
    
    
        String query =" SELECT `product_id`, `comic_Id`, `ep`, `point`, `Public` from product where product_id like'e%' ";
        State = con.createStatement();
        rs =  State.executeQuery(query);
        
        while (rs.next()) {
            p = new  Product ();
            p.setProduct_id(rs.getString(1));
            p.setComic_id(rs.getString(2));
            p.setEp(rs.getInt(3));
            p.setPoint(rs.getInt(4));
            p.setPublic(rs.getString(5));
            alp.add(p);
        }
        for(int i = 0 ; i < alp.size() ; i++){
            p = alp.get(i);
            query ="SELECT `Name`,`coverPage` FROM `comicworks`WHERE comic_Id = '"+p.getComic_id()+"'";
            State = con.createStatement();
            rs =  State.executeQuery(query);
            while (rs.next()) {
                p.setName(rs.getString(1));
                Blob blob = rs.getBlob(2);
                    InputStream inputStream = blob.getBinaryStream();
                    ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                    byte[] buffer = new byte[4096];
                    int bytesRead = -1;

                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }

                    byte[] imageBytes = outputStream.toByteArray();
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                    p.setCoverPage(base64Image);
            }
                alp2.add(p);
            }
        
        
          } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        }
    
        return alp2;
    
    }
    public boolean updateProductByPid(String product_id, int point,String Public) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement2 = "UPDATE `product` SET `point`=?,`Public`=? WHERE `product_id` = ?";
            pStmnt = cnnct.prepareStatement(preQueryStatement2);
            pStmnt.setInt(1, point);
            pStmnt.setString(2, Public);
            pStmnt.setString(3, product_id);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
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
