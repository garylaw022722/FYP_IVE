/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.bean;

public class UserBean {
    private int contactNum,idenNo;
    private String Address,fistName,lastName,subEmail,penName,bankAcount;
    public UserBean(){};
    public void setContactNum(int contactNum){
        this.contactNum = contactNum;
    }
    public int getContactNum(){
        return contactNum;
    }
    public void setIdenNo(int idenNo){
        this.idenNo = idenNo;
    }
    public int getIdenNo(){
        return idenNo;
    }
    public void setBankAcount(String bankAcount){
        this.bankAcount = bankAcount;
    }
    public String getBankAcount(){
        return bankAcount;
    }
    public void setAddress(String Address){
        this.Address = Address;
    }
    public String getAddress(){
        return Address;
    }
    public void setFistName(String fistName){
        this.fistName = fistName;
    }
    public String getFistName(){
        return fistName;
    }
    public void setLastName(String lastName){
        this.lastName = lastName;
    }
    public String getLastName(){
        return lastName;
    }
    public void setSubEmail(String subEmail){
        this.subEmail = subEmail;
    }
    public String getSubEmail(){
        return subEmail;
    }
    public void setPenName(String penName){
        this.penName = penName;
    }
    public String getPenName(){
        return penName;
    }
}
