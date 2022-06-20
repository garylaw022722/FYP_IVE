/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.bean;

import java.util.ArrayList;

/**
 *
 * @author User
 */
public class CreateBundle {

    private String product_id;
    private String bid;
    private byte[] CoverPage;
    private String Name;
    private String type;
    private int price;
    private int Stock;
    private String Public;
    private String startDate;
    private ArrayList<CreateBundle> OList;
    private String base64Image;

    public CreateBundle() {
        this.OList = new ArrayList<CreateBundle>();
    }

    public void addList(CreateBundle ob) {
        this.OList.add(ob);
    }

    public String getBase64Image() {
        return base64Image;
    }

    public void setBase64Image(String base64Image) {
        this.base64Image = base64Image;
    }

    public ArrayList<CreateBundle> getOList() {
        return OList;
    }

    public void setOList(ArrayList<CreateBundle> OList) {
        this.OList = OList;
    }

    public String getProduct_id() {
        return product_id;
    }

    public void setProduct_id(String product_id) {
        this.product_id = product_id;
    }

    public String getBid() {
        return bid;
    }

    public void setBid(String bid) {
        this.bid = bid;
    }

    public byte[] getCoverPage() {
        return CoverPage;
    }

    public void setCoverPage(byte[] CoverPage) {
        this.CoverPage = CoverPage;
    }

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getStock() {
        return Stock;
    }

    public void setStock(int Stock) {
        this.Stock = Stock;
    }

    public String getPublic() {
        return Public;
    }

    public void setPublic(String Public) {
        this.Public = Public;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

}
