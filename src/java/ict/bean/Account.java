/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.bean;

import java.util.ArrayList;

/**
 *
 * @author law
 */
public class Account {
    
    private String eAddress;
    private String password;
    private String userType;
    private String loginState;
    private String  RegCode ;
    private String  isUsed ;

    public String  getRegCode() {
        return RegCode;
    }

    public void setRegCode(String RegCode) {
        this.RegCode = RegCode;
        
    }

    public String getIsUsed() {
        return isUsed;
    }

    public void setIsUsed(String isUsed) {
        this.isUsed = isUsed;
    }

    public String getLoginState() {
        return loginState;
    }

    public void setLoginState(String loginState) {
        this.loginState = loginState;
    }

    public ArrayList<Account> getAcList() {
        return acList;
    }

    public void setAcList(ArrayList<Account> acList) {
        this.acList = acList;
    }
    private String  freeze;
    ArrayList<Account> acList ; 

    
    public Account(){
    
        acList  = new ArrayList<Account>();
    }
    
    
    public void addAccount(Account ac){
        acList.add(ac);
    }
    public String geteAddress() {
        return eAddress;
    }

    public void seteAddress(String eAddress) {
        this.eAddress = eAddress;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

 
    public String getFreeze() {
        return freeze;
    }

    public void setFreeze(String freeze) {
        this.freeze = freeze;
    }
    
    
    
}
