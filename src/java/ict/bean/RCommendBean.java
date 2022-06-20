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
public class RCommendBean implements Serializable{
     private String eAddress;
    private String comment;
    private int commentID;
    private String productID;
    private String name;
    private String currentDate;
    private int ratingstar;
    private int orderID;
    private ArrayList<RCommendBean> acomment;

    public RCommendBean() {
        this.acomment = new ArrayList<RCommendBean>();
    }

    public String geteAddress() {
        return eAddress;
    }

    public void seteAddress(String eAddress) {
        this.eAddress = eAddress;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getCommentID() {
        return commentID;
    }

    public void setCommentID(int commentID) {
        this.commentID = commentID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCurrentDate() {
        return currentDate;
    }

    public void setCurrentDate(String currentDate) {
        this.currentDate = currentDate;
    }

    public ArrayList<RCommendBean> getAcomment() {
        return acomment;
    }

    public void setAcomment(ArrayList<RCommendBean> acomment) {
        this.acomment = acomment;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public int getRatingstar() {
        return ratingstar;
    }

    public void setRatingstar(int ratingstar) {
        this.ratingstar = ratingstar;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }
    
}
