/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.bean;

import java.io.Serializable;
import java.util.ArrayList;

/**
 *
 * @author User
 */
public class CommentBean implements Serializable{
    private int orderID;
    private int ep;
    private String coverPage;
    private String name;
    private int price;
    private String productID;
    private ArrayList<CommentBean> acb;

    public CommentBean() {
        this.acb = new ArrayList<CommentBean>();
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getEp() {
        return ep;
    }

    public void setEp(int ep) {
        this.ep = ep;
    }

    public String getCoverPage() {
        return coverPage;
    }

    public void setCoverPage(String coverPage) {
        this.coverPage = coverPage;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public ArrayList<CommentBean> getAcb() {
        return acb;
    }

    public void setAcb(ArrayList<CommentBean> acb) {
        this.acb = acb;
    }
    
    
}
