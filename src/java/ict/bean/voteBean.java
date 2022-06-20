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
public class voteBean implements Serializable {

    private String comicName;
    private int voteTotal;
    private String eAddress;
    private String comicID;
    private String eachvote;
    private String coverPage;
    private String email;
    private byte[] image;
    private String base64Image;
    private ArrayList<voteBean> vb;

    public voteBean() {
        this.vb = new ArrayList<voteBean>();
    }

    private byte[] getImage(){
        return this.image;
    }
    public String getComicName() {
        return comicName;
    }

    public void setComicName(String comicName) {
        this.comicName = comicName;
    }

    public int getVoteTotal() {
        return voteTotal;
    }

    public void setVoteTotal(int voteTotal) {
        this.voteTotal = voteTotal;
    }

    public String geteAddress() {
        return eAddress;
    }

    public void seteAddress(String eAddress) {
        this.eAddress = eAddress;
    }

    public String getComicID() {
        return comicID;
    }

    public void setComicID(String comicID) {
        this.comicID = comicID;
    }

    public String getEachvote() {
        return eachvote;
    }

    public void setEachvote(String eachvote) {
        this.eachvote = eachvote;
    }

    public ArrayList<voteBean> getVb() {
        return vb;
    }

    public void setVb(ArrayList<voteBean> vb) {
        this.vb = vb;
    }

    public String getCoverPage() {
        return coverPage;
    }

    public void setCoverPage(String coverPage) {
        this.coverPage = coverPage;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getBase64Image() {
        return base64Image;
    }

    public void setBase64Image(String base64Image) {
        this.base64Image = base64Image;
    }

}
