/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import static java.lang.System.in;
import static java.lang.System.out;
import java.util.Base64;

/**
 *
 * @author law
 */
public class imageTranslator {
       
    public String  genImage(InputStream  input ) throws IOException{
         InputStream inputStream  = input ;        
         String header ="data:image/jpg;base64,";
          byte[] br = new byte[input.available()];
          input.read(br);
          in.close();                                             
          String base64Image = Base64.getEncoder().encodeToString(br);   
        return header+base64Image ;                
    }
    
      public String  genImageWithByte(byte[] item) throws IOException{
         
         String header ="data:image/jpg;base64,";
                                            
          String base64Image = Base64.getEncoder().encodeToString(item);   
        return header+base64Image ;                
    }
    
}
