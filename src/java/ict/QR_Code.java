/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict;

/**
 *
 * @author law
 */
import java.io.File;
import java.util.HashMap;
import java.util.Map;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter; 
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
public class QR_Code {
    
    
    public void  create(){
        
//            String qrCodeData = "http://192.168.31.144:8080/ITP4511_Assignment_Group_7%20(1)%202";
            String qrCodeData ="http://192.168.31.144/FYP/template.php";
            
            
             try {
            String filePath = "/Users/law/Desktop/jarFile/qr.png";
            String charset = "UTF-8"; // or "ISO-8859-1"
            Map < EncodeHintType, ErrorCorrectionLevel > hintMap = new HashMap < EncodeHintType, ErrorCorrectionLevel > ();
            hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);
            BitMatrix matrix = new MultiFormatWriter().encode(
                new String(qrCodeData.getBytes(charset), charset),
                BarcodeFormat.QR_CODE, 500, 600, hintMap);
                MatrixToImageWriter.writeToPath(matrix, filePath.substring(filePath
                .lastIndexOf('.') + 1), new File(filePath));
            System.out.println("QR Code image created successfully!");
        } catch (Exception e) {
            System.err.println(e);
        }
           
        
        
    }
    
        public static void main(String []args){
        QR_Code qr = new QR_Code ();
        qr.create();
        
        
        }
    
    
    
    
    }
    

