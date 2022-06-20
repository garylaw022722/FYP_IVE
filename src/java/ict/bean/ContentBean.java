/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.bean;

import java.util.ArrayList;

/**
 *
 * @author law
 */
public class ContentBean {
    
    private String bid;
    private String comic_id ;
    private int ep;

    private ArrayList<ContentBean> list;
            
            
    public ContentBean(){
    
        list = new ArrayList<ContentBean>();
    }
    
    public String getBid() {
        return bid;
    }

    public void setBid(String bid) {
        this.bid = bid;
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

    public ArrayList<ContentBean> getList() {
        return list;
    }

    public void setList(ArrayList<ContentBean> list) {
        this.list = list;
    }
    
    
    public void addItem(ContentBean item) {
        this.list.add(item);
    }
}
