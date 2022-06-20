/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.bean;

import java.io.InputStream;
import java.sql.Timestamp;
import java.util.ArrayList;

/**
 *
 * @author law
 */
public class CustomBookBean {
    private int custom_id ;
    private String eAddress;
    private Timestamp  customBookDate ;
    private InputStream  customBook;
    private String customBookName;
    private InputStream  covertPage;
    private ArrayList<CustomBookBean>  customBookList ;
    
    
    public CustomBookBean(){
    this.customBookList  =  new  ArrayList<CustomBookBean> ();
    }
     public void addCustomBookList(CustomBookBean cus) {
       customBookList.add(cus);
    }


    public ArrayList<CustomBookBean> getCustomBookList() {
        return customBookList;
    }

    public void setCustomBookList(ArrayList<CustomBookBean> customBookList) {
        this.customBookList = customBookList;
    }
    
    

    public int getCustom_id() {
        return custom_id;
    }

    public void setCustom_id(int custom_id) {
        this.custom_id = custom_id;
    }

    public String geteAddress() {
        return eAddress;
    }

    public void seteAddress(String eAddress) {
        this.eAddress = eAddress;
    }

    public Timestamp getCustomBookDate() {
        return customBookDate;
    }

    public void setCustomBookDate(Timestamp customBookDate) {
        this.customBookDate = customBookDate;
    }

    public InputStream getCustomBook() {
        return customBook;
    }

    public void setCustomBook(InputStream customBook) {
        this.customBook = customBook;
    }

    public String getCustomBookName() {
        return customBookName;
    }

    public void setCustomBookName(String customBookName) {
        this.customBookName = customBookName;
    }

    public InputStream getCovertPage() {
        return covertPage;
    }

    public void setCovertPage(InputStream covrtPage) {
        this.covertPage = covrtPage;
    }
    
    
    
}
