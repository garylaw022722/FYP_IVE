/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.bean;

import java.io.InputStream;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;

/**
 *
 * @author law
 */
public class episodes {

    private String cid;
    private int ep;
    private String title;
    private String desc;
    private String cp;
    private Timestamp update;
    private InputStream pdf;
    private String  ispublic ;

    public InputStream getPdf() {
        return pdf;
    }

    public String getIspublic() {
        return ispublic;
    }

    public void setIspublic(String ispublic) {
        this.ispublic = ispublic;
    }

    public void setPdf(InputStream pdf) {
        this.pdf = pdf;
    }
    private int view;

    private InputStream cover;

    private ArrayList<episodes> episodeByArr;
    private HashMap<String, episodes> sa;

    public episodes() {
        this.episodeByArr =  new ArrayList<episodes>();
        this.sa = new HashMap<String, episodes>();
    }

    public InputStream getCover() {
        return cover;
    }

    public void setCover(InputStream cover) {
        this.cover = cover;
    }

    public ArrayList<episodes> getEpisodeByArr() {
        return episodeByArr;
    }

    public void setEpisodeByArr(ArrayList<episodes> episodeByArr) {
        this.episodeByArr = episodeByArr;
    }

    public HashMap<String, episodes> getSa() {
        return this.sa;
    }

    public void setSa(HashMap<String, episodes> sa) {
        this.sa = sa;
    }

    public void addSa(episodes ep) {
        sa.put(ep.getCid(), ep);
    }

    public void addEpisodeByArr(episodes ep) {
        this.episodeByArr.add(ep);
    }

    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = cid;
    }

    public int getEp() {
        return ep;
    }

    public void setEp(int ep) {
        this.ep = ep;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getCp() {
        return cp;
    }

    public void setCp(String cp) {
        this.cp = cp;
    }

    public Timestamp getUpdate() {
        return update;
    }

    public void setUpdate(Timestamp update) {
        this.update = update;
    }



    public int getView() {
        return view;
    }

    public void setView(int view) {
        this.view = view;
    }

}
