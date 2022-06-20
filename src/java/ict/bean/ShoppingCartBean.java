/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.bean;

import java.sql.Array;
import java.util.ArrayList;

/**
 *
 * @author user
 */
public class ShoppingCartBean {
    private ArrayList ShoppingCartList = new ArrayList();
    private ArrayList qtyList = new ArrayList();
    public ShoppingCartBean(){
    }
    public void addTocart(String product_Id,int qty){
        ShoppingCartList.add(product_Id);
        qtyList.add(qty);
    }
    public void addTocart(String product_Id){
        ShoppingCartList.add(product_Id);
        qtyList.add(1);
    }
    public void removeToCart(String product_Id){
        ShoppingCartList.remove(product_Id);  
    }
    public ArrayList getShoppingCartList(){
        return ShoppingCartList;
    }
    public ArrayList getQTYList(){
        return qtyList;
    }
}
