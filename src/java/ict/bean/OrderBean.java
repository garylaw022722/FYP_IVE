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
public class OrderBean {
    String eAddress;
    String pid ;
    int ordId;
    Timestamp sendDate;
    double ordDiscount;
    String status;
    Timestamp updateTime;
    String approver;
    int amount;
    int  storeId;
   ArrayList<OrderBean> orderList ;
   public OrderBean(){
   
   orderList  = new    ArrayList<OrderBean>();
   }

    public String geteAddress() {
        return eAddress;
    }

    public void seteAddress(String eAddress) {
        this.eAddress = eAddress;
    }
    
    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public int getOrdId() {
        return ordId;
    }

    public void setOrdId(int ordId) {
        this.ordId = ordId;
    }

    public Timestamp getSendDate() {
        return sendDate;
    }

    public void setSendDate(Timestamp sendDate) {
        this.sendDate = sendDate;
    }

    public double getOrdDiscount() {
        return ordDiscount;
    }

    public void setOrdDiscount(double ordDiscount) {
        this.ordDiscount = ordDiscount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Timestamp updateTime) {
        this.updateTime = updateTime;
    }

    public String getApprover() {
        return approver;
    }

    public void setApprover(String approver) {
        this.approver = approver;
    }

    public int  getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public int getStoreId() {
        return storeId;
    }

    public void setStoreId(int storeId) {
        this.storeId = storeId;
    }

    public ArrayList<OrderBean> getOrderList() {
        return orderList;
    }

    public void setOrderList(ArrayList<OrderBean> orderList) {
        this.orderList = orderList;
    }
    
       public void addOrderList(OrderBean orderList) {
        this.orderList.add(orderList);
    }
    
    
    
}
