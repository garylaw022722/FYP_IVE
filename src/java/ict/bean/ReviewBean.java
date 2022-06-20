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
public class ReviewBean implements Serializable {

    private String name;
    private String coverPage;
    private int view;
    private String type;
    private String comicDesc;
    private String author;
    private int ep;
    private int eachView;
    private String uploadDate;
    private byte[] image;
    private String base64Image;
    private String comicID;
    private ArrayList<ReviewBean> rb;

    public ReviewBean() {
        this.rb = new ArrayList<ReviewBean>();
    }

    private byte[] getImage(){
        return this.image;
    }
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCoverPage() {
        return coverPage;
    }

    public void setCoverPage(String coverPage) {
        this.coverPage = coverPage;
    }

    public int getView() {
        return view;
    }

    public void setView(int view) {
        this.view = view;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getComicDesc() {
        return comicDesc;
    }

    public void setComicDesc(String comicDesc) {
        this.comicDesc = comicDesc;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public int getEp() {
        return ep;
    }

    public void setEp(int ep) {
        this.ep = ep;
    }

    public int getEachView() {
        return eachView;
    }

    public void setEachView(int eachView) {
        this.eachView = eachView;
    }

    public String getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(String uploadDate) {
        this.uploadDate = uploadDate;
    }

    public String getBase64Image() {
        return base64Image;
    }

    public void setBase64Image(String base64Image) {
        this.base64Image = base64Image;
    }

    public String getComicID() {
        return comicID;
    }

    public void setComicID(String comicID) {
        this.comicID = comicID;
    }

}
