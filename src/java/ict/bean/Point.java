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
public class Point {
    private int pid ;
    private int price ;
    private int  pointReturn ;
    private ArrayList<Point> pointList;    
    private int extraPoint;

    public int getExtraPoint() {
        return extraPoint;
    }

    public void setExtraPoint(int extraPoint) {
        this.extraPoint = extraPoint;
    }
    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getPointReturn() {
        return pointReturn;
    }

    public void setPointReturn(int pointReturn) {
        this.pointReturn = pointReturn;
       
    }
    
    
    public void  addPointList(Point pt){
        pointList.add(pt);    
    }

    public ArrayList<Point> getPointList() {
        return pointList;
    }

    public void setPointList(ArrayList<Point> pointList) {
        this.pointList = pointList;
    }
    public Point(){
     pointList  = new  ArrayList<Point>();
    
    }
    
}
