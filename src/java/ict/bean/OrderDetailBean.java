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
public class OrderDetailBean implements Serializable {

    private int orderID;
    private int price;
    private int point;
    private int quantity;
    private int ep;
    private String status;
    private String Date;
    private String bundleName;
    private String epTitle;
    private String comicName;
    private String productID;
    private double discount;

    private ArrayList<OrderDetailBean> OList;

    public OrderDetailBean() {
        this.OList = new ArrayList<OrderDetailBean>();
    }

    public void addList(OrderDetailBean ob) {
        this.OList.add(ob);
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
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

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDate() {
        return Date;
    }

    public void setDate(String Date) {
        this.Date = Date;
    }

    public String getBundleName() {
        return bundleName;
    }

    public void setBundleName(String bundleName) {
        this.bundleName = bundleName;
    }

    public ArrayList<OrderDetailBean> getOList() {
        return OList;
    }

    public void setOList(ArrayList<OrderDetailBean> OList) {
        this.OList = OList;
    }

    public String getEpTitle() {
        return epTitle;
    }

    public void setEpTitle(String epTitle) {
        this.epTitle = epTitle;
    }

    public String getComicName() {
        return comicName;
    }

    public void setComicName(String comicName) {
        this.comicName = comicName;
    }

    public int getEp() {
        return ep;
    }

    public void setEp(int ep) {
        this.ep = ep;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

}
