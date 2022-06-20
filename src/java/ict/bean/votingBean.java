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
public class votingBean {
    private int event_id,comic_Id;
    private String eAddress,yearRange,repsonse;
    public votingBean(){};
    public votingBean(int event_id,int comic_Id,String eAddress,String yearRange,String repsonse){
        this.event_id = event_id;
        this.comic_Id = comic_Id;
        this.eAddress = eAddress;
        this.yearRange = yearRange;
        this.repsonse = repsonse;
    }
    public void setEvent_id(int event_id){
        this.event_id = event_id;
    }
    public int getEvent_id(){
        return event_id;
    }
    public void setComic_Id(int comic_Id){
        this.comic_Id = comic_Id;
    }
    public int getComic_Id(){
        return comic_Id;
    }
    public void setEAddress(String eAddress){
        this.eAddress = eAddress;
    }
    public String getEAddress(){
        return eAddress;
    }
    public void setYearRange(String yearRange){
        this.yearRange = yearRange;
    }
    public String getYearRange(){
        return yearRange;
    }
    public void setRepsonse(String repsonse){
        this.repsonse = repsonse;
    }
    public String getRepsonse(){
        return repsonse;
    }
}
