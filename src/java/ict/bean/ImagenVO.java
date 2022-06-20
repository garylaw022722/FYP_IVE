/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.bean;

import java.io.InputStream;
/**
 *
 * @author user
 */
public class ImagenVO {

    int bid;
    String Name;
    String Descript;
    String type;
    String version;
    InputStream coverPage;
    private byte[] coverPage2;
    private String productID;

    public ImagenVO(int id, String name, String descript, String type, String version, byte[] coverPage) {
        this.bid = id;
        this.Name = name;
        this.Descript = descript;
        this.type = type;
        this.version = version;
        this.coverPage2 = coverPage;
    }

    public ImagenVO() {
    }

    public int getBid() {
        return bid;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public void setBid(int bid) {
        this.bid = bid;
    }

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    public InputStream getCoverPage() {
        return coverPage;
    }

    public void setCoverPage(InputStream coverPage) {
        this.coverPage = coverPage;
    }

    public byte[] getCoverPage2() {
        return coverPage2;
    }

    public void setCoverPage2(byte[] coverPage2) {
        this.coverPage2 = coverPage2;
    }

    public String getDescript() {
        return Descript;
    }

    public void setDescript(String Descript) {
        this.Descript = Descript;
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

}
