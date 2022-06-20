/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.test;

import ict.bean.ComicWorks;
import ict.bean.episodes;
import ict.db.ComicWorksDB;
import ict.db.episode;
import ict.db.userInformation;
import java.io.File;
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
class str {
    
    
    public static void main(String []args) throws FileNotFoundException, IOException{
       
//       for(ContributeBean vb :new ContributeDB().getAll_Contribution().getList())
//           System.out.println(new  DateGenerator().formatDate(vb.getSubTime(), "yyyy-MM-dd "));
            

//        for(contractBean cb : new contract().getContractWithSorting().getContract()){
//            System.out.println(cb.getSignDate());
//        
//        }
//    

//         for(ComicWorks  mc : new ComicWorksDB().getComicInfo().getComicList()){
//             System.out.println(mc.getName());
//             InputStream  in = mc.getCoverPage();             
//             byte[] sa = new byte[in.available()];
//             in.read(sa);                        
//             String path ="/Users/law/Desktop/path/"+mc.getName()+".jpg";
//             OutputStream  out =  new FileOutputStream(new File(path));
//             out.write(sa);            
//                      new ComicWorksDB().removeComicFile(mc.getCid());
//         }
//         
               

//                ArrayList<episodes> ep = new episode().getAllEpisode().getEpisodeByArr();
//                for(episodes sa  :  ep){
                   new episode().removeFileBycomicId_ep("13", 100);
                      new episode().removeFileBycomicId_ep("13", 101);
                         new episode().removeFileBycomicId_ep("14", 1093);
    
//                }

    }
}
