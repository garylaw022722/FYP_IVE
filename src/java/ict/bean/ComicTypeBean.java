/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.bean;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;

/**
 *
 * @author law
 */
public class ComicTypeBean {
    private HashMap<String , ComicTypeBean> type ; 
    private  ArrayList<ComicTypeBean>  tlist ; 
    private String  tid ;
    private String   comicType;
    private InputStream cover;

    public InputStream getCover() {
        return cover;
    }

    public void setCover(InputStream cover) {
        this.cover = cover;
    }

    public String getTid() {
        return tid;
    }

    public void setTid(String tid) {
        this.tid = tid;
    }

    public String getComicType() {
        return comicType;
    }

    public void setComicType(String comicType) {
        this.comicType = comicType;
    }
    

    public HashMap<String, ComicTypeBean> getType() {
        return type;
    }
    public void addHash(String tid , ComicTypeBean  ct) {
           this.type.put(tid,ct);
    }
    
     public void addList(ComicTypeBean  ct) {
           this.tlist.add(ct);
    }


    public ComicTypeBean() {
        this.type =  new HashMap<String , ComicTypeBean>();
        this.tlist =  new  ArrayList<ComicTypeBean>();
    }
    public void setType(HashMap<String, ComicTypeBean> type) {
        this.type = type;
    }

    public ArrayList<ComicTypeBean> getTlist() {
        return tlist;
    }

    public void setTlist(ArrayList<ComicTypeBean> tlist) {
        this.tlist = tlist;
    }
    
}
