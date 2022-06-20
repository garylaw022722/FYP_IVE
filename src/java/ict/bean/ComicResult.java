/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.bean;

import java.io.InputStream;
import java.util.ArrayList;

/**
 *
 * @author law
 */
public class ComicResult {
    private String cName;
    private String  comicDesc;
    private InputStream   coverPage ;
    private String penName ;
    private String penid;
    private String comicId ;
    private String schedule;
    private String authorAddress;
    private String   typeDescript ;
    private  ArrayList<ComicResult> result;
    
    public ComicResult(){    
        result  = new  ArrayList<ComicResult>();
    }

    public void addResult(ComicResult rs) {
        this.result.add(rs);
    }

    public String getcName() {
        return cName;
    }

    public void setcName(String cName) {
        this.cName = cName;
    }

    public String getComicDesc() {
        return comicDesc;
    }

    public void setComicDesc(String comicDesc) {
        this.comicDesc = comicDesc;
    }

    public InputStream getCoverPage() {
        return coverPage;
    }

    public void setCoverPage(InputStream coverPage) {
        this.coverPage = coverPage;
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

    public String getComicId() {
        return comicId;
    }

    public void setComicId(String comicId) {
        this.comicId = comicId;
    }

    public String getSchedule() {
        return schedule;
    }

    public void setSchedule(String schedule) {
        this.schedule = schedule;
    }

    public String getAuthorAddress() {
        return authorAddress;
    }

    public void setAuthorAddress(String authorAddress) {
        this.authorAddress = authorAddress;
    }

    public String getTypeDescript() {
        return typeDescript;
    }

    public void setTypeDescript(String typeDescript) {
        this.typeDescript = typeDescript;
    }

    public ArrayList<ComicResult> getResult() {
        return result;
    }

    public void setResult(ArrayList<ComicResult> result) {
        this.result = result;
    }

 
    
    
    
    
    
    
    
    
}
