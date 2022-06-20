/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.test;

//import ict.bean.Eps;
import ict.db.ComicWorksDB;
import ict.db.ContributeDB;
import ict.db.episode;
import ict.db.userInformation;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Date;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 *
 * @author law
 */
public class test {

    public static void main(String[] args) throws ParseException, IOException {                  
//        Pattern p = Pattern.compile("xn9"); /// user Input
//        Matcher m = p.matcher("on999");      // row data
//        boolean matchFound = m.find();
//        
//        String test  = m.toString();        
//        if (matchFound)
//            System.out.println("Match found");
//         else 
//            System.out.println("Match not found");
           
//        
//            new userInformation().updateUserPortfolio("KA", "Law", "1281281", "1229 3929","Male", "law190444956@gmail.com");
           InputStream  sa = new ContributeDB().getContributionById(10).getPdf();
           byte[] s = new byte [sa.available()];
            sa.read(s);
           OutputStream  ot = new FileOutputStream(new File("/Users/law/desktop/cksa.pdf"));
           ot.write(s);
           
           //new episode().removeFileBycomicId_ep(comicId, 0);

//                   removeComicFile(String comic_Id);
            
    }
}
