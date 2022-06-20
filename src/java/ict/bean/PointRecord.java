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
public class PointRecord {
    private int pid ;
    private String eAddress ;
    private Timestamp  purchasesDate;
    private int price ;
    private int point ;

    public int getPoint() {
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }
    private Timestamp  useDate ;
    private ArrayList<PointRecord> br ;
    
    public  PointRecord(){
            br  = new ArrayList<PointRecord>();
    }
    
    
    public void addPointRecord(PointRecord  record ){
        br.add(record);
    }

    public ArrayList<PointRecord> getBr() {
        return br;
    }

    public void setBr(ArrayList<PointRecord> br) {
        this.br = br;
    }
    
    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public String geteAddress() {
        return eAddress;
    }

    public void seteAddress(String eAddress) {
        this.eAddress = eAddress;
    }

    public Timestamp getPurchasesDate() {
        return purchasesDate;
    }

    public void setPurchasesDate(Timestamp purchasesDate) {
        this.purchasesDate = purchasesDate;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public Timestamp getUseDate() {
        return useDate;
    }

    public void setUseDate(Timestamp useDate) {
        this.useDate = useDate;
    }
    
}
