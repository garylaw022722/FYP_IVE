/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.bean;

import java.util.ArrayList;

/**
 *
 * @author user
 */
public class BookCaseBean {
    private String userid;
    private ArrayList bookCaseList = new ArrayList();
    public BookCaseBean(){
    }
    public void addBook(String bookID){
        bookCaseList.add(bookID);
    }
    public void removeBook(String bookID){
        bookCaseList.remove(bookID);
    }
    public ArrayList getBookCaseList(){
        return bookCaseList;
    }
}
