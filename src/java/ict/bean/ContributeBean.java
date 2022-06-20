/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.bean;

import java.io.InputStream;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;

/**
 *
 * @author law
 */
public class ContributeBean {
    private int conId;
    private String title;
    private String eAddress;
    private Time  time;
    private String Description;
    private  InputStream  pdf;
    private String  fileName   ;
    private String Comment  ;
    private Timestamp  subTime ;
        private Time  callLast;

    public Time getCallLast() {
        return callLast;
    }

    public void setCallLast(Time callLast) {
        this.callLast = callLast;
    }
    private String comic_Id;

    public String getComic_Id() {
        return comic_Id;
    }

    public void setComic_Id(String comic_Id) {
        this.comic_Id = comic_Id;
    }

  
    private ArrayList<ContributeBean>  list  ;
    
    
    public ContributeBean(){
    list  =new ArrayList<ContributeBean> ();
    }

    public int getConId() {
        return conId;
    }

    public void setConId(int conId) {
        this.conId = conId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String geteAddress() {
        return eAddress;
    }

    public void seteAddress(String eAddress) {
        this.eAddress = eAddress;
    }

    public Time getTime() {
        return time;
    }

    public void setTime(Time time) {
        this.time = time;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    public InputStream getPdf() {
        return pdf;
    }

    public void setPdf(InputStream pdf) {
        this.pdf = pdf;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getComment() {
        return Comment;
    }

    public void setComment(String Comment) {
        this.Comment = Comment;
    }

    public Timestamp getSubTime() {
        return subTime;
    }

    public void setSubTime(Timestamp subTime) {
        this.subTime = subTime;
    }

    public ArrayList<ContributeBean> getList() {
        return list;
    }

    public void setList(ArrayList<ContributeBean> list) {
        this.list = list;
    }
    
     public void addList(ContributeBean listItem) {
        this.list.add(listItem);
    }
    
    
    
    
    
}
