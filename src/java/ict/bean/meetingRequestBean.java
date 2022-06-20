/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.bean;

import java.io.InputStream;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;

/**
 *
 * @author law
 */
public class meetingRequestBean {
    private int reqNo ;
    private String status ;
    private String approver ;
    private Timestamp sendDate ;
    private String eAddress ;
    private String title  ;
    private String comment ;
    private InputStream  pdf ;
    private Timestamp meetingDate ;    
    private ArrayList<meetingRequestBean> list ;
    private String phoneCallTime ;
    private Time  callBackTime;

    public String getPhoneCallTime() {
        return phoneCallTime;
    }

    public void setPhoneCallTime(String phoneCallTime) {
        this.phoneCallTime = phoneCallTime;
    }

    public Time getCallBackTime() {
        return callBackTime;
    }

    public void setCallBackTime(Time callBackTime) {
        this.callBackTime = callBackTime;
    }

    public int getReqNo() {
        return reqNo;
    }

    public void setReqNo(int reqNo) {
        this.reqNo = reqNo;
    }

    public String getStatus() {
        return  status;
    }

    public void setStatus(String status) {
            this.status  = status ;
    }

    public String getApprover() {
        return approver;
    }

    public void setApprover(String approver) {
        this.approver = approver;
    }

    public Timestamp getSendDate() {
        return sendDate;
    }

    public void setSendDate(Timestamp sendDate) {
        this.sendDate = sendDate;
    }

    public String geteAddress() {
        return eAddress;
    }

    public void seteAddress(String eAddtess) {
        this.eAddress = eAddtess;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public InputStream getPdf() {
        return pdf;
    }

    public void setPdf(InputStream pdf) {
        this.pdf = pdf;
    }

    public Timestamp getMeetingDate() {
        return meetingDate;
    }

    public void setMeetingDate(Timestamp meetingDate) {
        this.meetingDate = meetingDate;
    }
    

    public ArrayList<meetingRequestBean> getList() {
        return list;
    }

    public void addList(meetingRequestBean bean) {
        list.add(bean);
    }

    public void setList(ArrayList<meetingRequestBean> list) {
        this.list = list;
    }
    
    public meetingRequestBean(){
    
    list  = new ArrayList<meetingRequestBean >();
    }
}
