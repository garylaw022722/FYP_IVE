/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.bean;

import java.sql.Timestamp;
import java.util.ArrayList;

/**
 *
 * @author law
 */
public class Product {
    private String product_id;
    private String comic_id;
    private int  ep;
    private String  bid;
    private int price;
    private int point ;
    private Timestamp sDate ;
    private Timestamp  eDate ;
    private double discount;
    private int Stock ;
    private String Public; 
    private String eventId;
    private String coverPage;
    private String base64Image;
    private String name;

    public String getEventId() {
        return eventId;
    }

    public void setEventId(String eventId) {
        this.eventId = eventId;
    }

    public String getPublic() {
        return Public;
    }

    public void setPublic(String Public) {
        this.Public = Public;
    }

    public int getStock() {
        return Stock;
    }

    public void setStock(int Stock) {
        this.Stock = Stock;
    }
    private ArrayList<Product> productList ;

     public Product(){
     
         this.productList  = new ArrayList<Product>();
     }
    public String getProduct_id() {
        return product_id;
    }

    public void setProduct_id(String product_id) {
        this.product_id = product_id;
    }

    public String getComic_id() {
        return comic_id;
    }

    public void setComic_id(String comic_id) {
        this.comic_id = comic_id;
    }

    public int getEp() {
        return ep;
    }

    public void setEp(int ep) {
        this.ep = ep;
    }

    public String getBid() {
        return bid;
    }

    public void setBid(String bid) {
        this.bid = bid;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getPoint() {
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }

    public Timestamp getsDate() {
        return sDate;
    }

    public void setsDate(Timestamp sDate) {
        this.sDate = sDate;
    }

    public Timestamp geteDate() {
        return eDate;
    }

    public void seteDate(Timestamp eDate) {
        this.eDate = eDate;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public ArrayList<Product> getProductList() {
        return productList;
    }

    public void setProductList(ArrayList<Product> productList) {
        this.productList = productList;
    }
    
    public void addProductList(Product product) {
        this.productList.add( product);
    }
    public void setCoverPage(String coverPage) {
        this.coverPage = coverPage;
    }
    public String getCoverPage() {
        return coverPage;
    }
    public void setName(String Name) {
        this.name = Name;
    }
    public String getName() {
        return name;
    }
    public void setBase64Image(String base64Image) {
        this.base64Image = base64Image;
    }
}
