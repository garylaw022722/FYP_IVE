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
public class BundleSetBean {
    private String bid;
    private String name;
    private String Description;
    private String type ;
    private String version;
    private InputStream  coverPage;
    private InputStream pdf;
    private ArrayList<BundleSetBean>  list;
    private Timestamp  createDate ;

    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }

    public BundleSetBean(){
     list =  new  ArrayList<BundleSetBean>();
    }
    public String getBid() {
        return bid;
    }

    public void setBid(String bid) {
        this.bid = bid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public InputStream getCoverPage() {
        return coverPage;
    }

    public void setCoverPage(InputStream coverPage) {
        this.coverPage = coverPage;
    }

    public InputStream getPdf() {
        return pdf;
    }

    public void setPdf(InputStream pdf) {
        this.pdf = pdf;
    }

    public ArrayList<BundleSetBean> getList() {
        return list;
    }

    public void setList(ArrayList<BundleSetBean> list) {
        this.list = list;
    }
        
     public void addItem(BundleSetBean item) {
        this.list.add(item);
    }
    
}
