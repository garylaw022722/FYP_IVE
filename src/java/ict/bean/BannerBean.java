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
public class BannerBean implements Serializable {

    private String img;
    private int bannerID;
    private byte[] image;
    private String base64Image;
    private ArrayList<BannerBean> bb;

    public BannerBean() {
        this.bb = new ArrayList<BannerBean>();
    }

    private byte[] getImage(){
        return this.image;
    }
    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public int getBannerID() {
        return bannerID;
    }

    public void setBannerID(int bannerID) {
        this.bannerID = bannerID;
    }

    public String getBase64Image() {
        return base64Image;
    }

    public void setBase64Image(String base64Image) {
        this.base64Image = base64Image;
    }

    public ArrayList<BannerBean> getBb() {
        return bb;
    }

    public void setBb(ArrayList<BannerBean> bb) {
        this.bb = bb;
    }

      public void addBb(BannerBean banner) {
        this.bb.add(banner);
    }
    


}
