/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.bean;

import ict.db.ComicWorksDB;
import ict.db.contract;
import ict.db.dbOperation;
import ict.imageTranslator;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;

/**
 *
 * @author law
 */
public class ComicWorks {

    private ArrayList<ComicWorks> comicList = null;
    private HashMap<String, ComicWorks> comic = null;
    dbOperation db  ;
    private String cid;
    private String name;
    private String description;
    private String eAddress;
    private String Schedule;
    private InputStream coverPage;
    private String status  ;
    private String responsor ;
    private String penName ;
    private String penid;
    private String typeDes;

    public String getTypeDes() {
        return typeDes;
    }

    public void setTypeDes(String typeDes) {
        this.typeDes = typeDes;
    }

    public String getPenName() {
        return penName;
    }

    public void setPenName(String penName) {
        this.penName = penName;
    }

    public String getPenid() {
        return penid;
    }

    public void setPenid(String penid) {
        this.penid = penid;
    }

    public ArrayList<ComicWorks> getComicList() {
        return comicList;
    }

    public void setComicList(ArrayList<ComicWorks> comicList) {
        this.comicList = comicList;
    }
    public void addComicList(ComicWorks cm){
    this.comicList.add(cm);
    
    
    }

    public HashMap<String, ComicWorks> getComic() {
        return comic;
    }

    public void setComic(HashMap<String, ComicWorks> comic) {
        this.comic = comic;
    }
    
    public void addComic(String cid ,ComicWorks cw){        
        this.comic.put(cid, cw);
    }

    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = cid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String geteAddress() {
        return eAddress;
    }

    public void seteAddress(String eAddress) {
        this.eAddress = eAddress;
    }

    public String getSchedule() {
        return Schedule;
    }

    public void setSchedule(String Schedule) {
        this.Schedule = Schedule;
    }

    public InputStream getCoverPage() {
        return coverPage;
    }

    public void setCoverPage(InputStream coverPage) {
        this.coverPage = coverPage;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getResponsor() {
        return responsor;
    }

    public void setResponsor(String responsor) {
        this.responsor = responsor;
    }

    public ComicWorks() {
        comicList = new ArrayList<ComicWorks>();
        comic = new HashMap<String, ComicWorks>();
        db  =new dbOperation();
    }

   public ArrayList<ComicWorks> getComicByYear(String yearChoice){
          ArrayList<ComicWorks>  comic  =   new ArrayList<ComicWorks>();
         contract ss  =new contract();  
            ArrayList<contractBean> contract =  ss.getContract().getContract();
        for(contractBean item  : contract){
            String year =""+item.getSignYear(item.getSignDate());
          
                if(year.equals(yearChoice)){
                    String comicId   = item.getComicid();      
                       comic.add(getComicById(comicId));
                    
                }
                                                  
        }

        return  comic ;
   }

    public  ComicWorks getComicById(String cid){
        ComicWorksDB  comicList  = new  ComicWorksDB();
        for(ComicWorks c : comicList.getComicInfo().getComicList())
                if(cid.equals(c.getCid()))
                    return  c;
    
     return null;
    
    }
       
      public String getBase64CoverPage(InputStream s) throws IOException{
                            
          return   new  imageTranslator().genImage(s);      
      }
    
}
