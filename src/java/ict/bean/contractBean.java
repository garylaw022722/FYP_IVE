/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.bean;

import ict.DateGenerator;
import java.io.InputStream;
import java.sql.Timestamp;
import java.util.ArrayList;

/**
 *
 * @author law
 */
public class contractBean {

    private int cid;
    private String comicid;
    private String eAddress;
    private Timestamp signDate;
    private int price;
    private String unitPay;
    private int period;
    private String unitDate;
    private InputStream  pdf;
    private String fileName;
    private int contriId;

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public int getContriId() {
        return contriId;
    }

    public void setContriId(int contriId) {
        this.contriId = contriId;
    }
   private ArrayList<contractBean> contract;

    public InputStream getPdf() {
        return pdf;
    }

    public void setPdf(InputStream pdf) {
        this.pdf = pdf;
    }



    public String getUnitPay() {
        return unitPay;
    }

    public void setUnitPay(String unitPay) {
        this.unitPay = unitPay;
    }

    public String getUnitDate() {
        return unitDate;
    }

    public void setUnitDate(String unitDate) {
        this.unitDate = unitDate;
    }

    public contractBean() {
        this.contract = new ArrayList<contractBean>();
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public String getComicid() {
        return comicid;
    }

    public void setComicid(String comicid) {
        this.comicid = comicid;
    }

    public String geteAddress() {
        return eAddress;
    }

    public void seteAddress(String eAddress) {
        this.eAddress = eAddress;
    }

    public Timestamp getSignDate() {
        return signDate;
    }

    public void setSignDate(Timestamp signDate) {
        this.signDate = signDate;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getPeriod() {
        return period;
    }

    public void setPeriod(int period) {
        this.period = period;
    }

    public ArrayList<contractBean> getContract() {
        return contract;
    }

    public void setContract(ArrayList<contractBean> contract) {
        this.contract = contract;
    }

    public void addContract(contractBean ct) {
        contract.add(ct);
    }

    public int getSignYear(Timestamp time) {
        DateGenerator gd = new DateGenerator();
        return gd.getYear(time) + 1900;
    }

}
