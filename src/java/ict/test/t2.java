/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.test;

import ict.bean.episodes;
import ict.bean.meetingRequestBean;
import ict.db.BundleSetDB;
import ict.db.episode;
import ict.db.meetingRequestDB;
import ict.pdf_Generator;
import ict.servlet.meetingRequest;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;

/**
 *
 * @author law
 */
public class t2 {

    public static void main(String[] args) throws FileNotFoundException, IOException {

//               new Pdf_Generator
//        new contentDB().innsertNewContent("1", "1", 5);
        ArrayList<InputStream> sl = new ArrayList<InputStream>();
        ArrayList<meetingRequestBean> sa = new meetingRequestDB().getAllRequst().getList();
        for (int s = 0; s < 2; s++){
                sl.add(sa.get(s).getPdf());
        } 
        byte[] ins = new pdf_Generator().combineResources(sl);         
//        new BundleSetDB().insertNewBundleBook("20", "My first bundle", "treette 20", "Electric","Magazine", null, ins);
//        InputStream  js =  new BundleSetDB().getBundleById("20").getList().get(0).getPdf();
         OutputStream  out = new FileOutputStream("/Users/law/Desktop/m2/pkTang.pdf");
         out.write(ins);
         
        
        

//            System.out.println("comic_id :"+sa.getComic_id()+" ep :" + sa.getEp());
    }
}
