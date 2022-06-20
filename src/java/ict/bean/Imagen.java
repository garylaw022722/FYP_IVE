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
public class Imagen {
    String comcid;
    String Name;
    String penName;
    InputStream coverPage;
    private byte[] coverPage2;
    
    public Imagen(String comcid, String name, String penName, byte[] coverPage) {
        this.comcid = comcid;
        this.Name = name;
        this.penName = penName;
        this.coverPage2 = coverPage;
    }
    public Imagen() {
    }

    public String getComcid() {
        return comcid;
    }

    public void setComcid(String comcid) {
        this.comcid = comcid;
    }

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    public String getPenName() {
        return penName;
    }

    public void setPenName(String penName) {
        this.penName = penName;
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

}
