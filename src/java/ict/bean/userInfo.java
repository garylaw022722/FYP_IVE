/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.bean;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

/**
 *
 * @author law
 */
public class userInfo {

    private boolean vaild;
    private String eAddress;
    private String FirstName;
    private String LastName;
    private String Address;
    private String contactNum;
    private String subEmail;
    private String idenNo;
    private String BankAccount;
    private Date dob;
    private String gender;

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }
    private String penName;
    private int penid;
    private int pointAmount;

    public int getPointAmount() {
        return pointAmount;
    }

    public void setPointAmount(int pointAmount) {
        this.pointAmount = pointAmount;
    }
    private ArrayList<userInfo> userinfoList;
   private  HashMap<String,userInfo>  userinfoHash ;
   
   public userInfo() {
        this.userinfoList = new  ArrayList<userInfo>();
        this.userinfoHash = new HashMap<String,userInfo>();
    }

    public void addList(userInfo item ){
        
            userinfoList.add(item);
    }  
    
    public void addHash(String  eAddress , userInfo item ){
        
            userinfoHash.put(eAddress, item);
    }  

    
    
    public ArrayList<userInfo> getUserinfoList() {
        return userinfoList;
    }

    public void setUserinfoList(ArrayList<userInfo> userinfoList) {
        this.userinfoList = userinfoList;
    }

    public HashMap<String, userInfo> getUserinfoHash() {
        return userinfoHash;
    }

    public void setUserinfoHash(HashMap<String, userInfo> userinfoHash) {
        this.userinfoHash = userinfoHash;
    }

    public String geteAddress() {
        return eAddress;
    }

    public void seteAddress(String eAddress) {
        this.eAddress = eAddress;
    }

    public String getFirstName() {
        return FirstName;
    }

    public void setFirstName(String FirstName) {
        this.FirstName = FirstName;
    }

    public String getLastName() {
        return LastName;
    }

    public void setLastName(String LastName) {
        this.LastName = LastName;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }

    public String getContactNum() {
        return contactNum;
    }

    public void setContactNum(String contactNum) {
        this.contactNum = contactNum;
    }

    public String getSubEmail() {
        return subEmail;
    }

    public void setSubEmail(String subEmail) {
        this.subEmail = subEmail;
    }

    public String getIdenNo() {
        return idenNo;
    }

    public void setIdenNo(String idenNo) {
        this.idenNo = idenNo;
    }

    public String getBankAccount() {
        return BankAccount;
    }

    public void setBankAccount(String BankAccount) {
        this.BankAccount = BankAccount;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getPenName() {
        return penName;
    }

    public void setPenName(String penName) {
        this.penName = penName;
    }

    public int getPenid() {
        return penid;
    }

    public void setPenid(int penid) {
        this.penid = penid;
    }

    

    public boolean getVaild() {
        return vaild;
    }

    public void setVaild(boolean vaild) {
        this.vaild = vaild;
    }

}
