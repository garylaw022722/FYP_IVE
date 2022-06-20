/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.bean;

/**
 *
 * @author user
 */
public class ComicBean {
    private int comic_Id,price,chapter,point,bid;
    private String name,descript,eAddress,schedule,coverPage,status,responsor,product_Id;
    private String Base64Image;
    public ComicBean(){};
    public ComicBean(int comic_Id,String name,String descript,String eAddress,String schedule,String coverPage,String status,String responsor){
        this.comic_Id = comic_Id;
        this.name = name;
        this.descript = descript;
        this.eAddress = eAddress;
        this.schedule = schedule;
        this.coverPage = coverPage;
        this.status = status;
        this.responsor = responsor;
    }
    public void setComic_Id(int comic_Id){
        this.comic_Id = comic_Id;
    }
    public int getComic_Id(){
        return comic_Id;
    }
    public void setName(String name){
        this.name = name;
    }
    public String getName(){
        return name;
    }
    public void setDescript(String descript){
        this.descript = descript;
    }
    public String getDescript(){
        return descript;
    }
    public void setEAddress(String eAddress){
        this.eAddress = eAddress;
    }
    public String getEAddress(){
        return eAddress;
    }
    public void setSchedule(String schedule){
        this.schedule = schedule;
    }
    public String getSchedule(){
        return schedule;
    }
    public void setCoverPage(String coverPage){
        this.coverPage = coverPage;
    }
    public String getCoverPage(){
        return coverPage;
    }
    public void setStatus(String status){
        this.status = status;
    }
    public String getStatus(){
        return status;
    }
    public void setResponsor(String responsor){
        this.responsor = responsor;
    }
    public String getResponsor(){
        return responsor;
    }
    public void setPrice(int price){
        this.price = price;
    }
    public int getPrice(){
        return price;
    }
    public void setChapter(int chapter){
        this.chapter = chapter;
    }
    public int getChapter(){
        return chapter;
    }
    public void setProduct_Id(String product_Id){
        this.product_Id = product_Id;
    }
    public String getProduct_Id(){
        return product_Id;
    }
    public void setPoint(int point){
        this.point = point;
    }
    public int getPoint(){
        return point;
    }
    public void setBid(int bid){
        this.bid = bid;
    }
    public int getBid(){
        return bid;
    }
}
