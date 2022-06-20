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
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import org.apache.commons.io.FilenameUtils;
import org.apache.pdfbox.io.MemoryUsageSetting;
import static org.apache.pdfbox.io.MemoryUsageSetting.setupTempFileOnly;
import org.apache.pdfbox.multipdf.PDFMergerUtility;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;
import org.apache.pdfbox.rendering.ImageType;
import org.apache.pdfbox.rendering.PDFRenderer;
import org.apache.pdfbox.tools.imageio.ImageIOUtil;

public class pdf_Generator {

    private static final String dir = "/Users/law/Desktop/ComicWorks/admin/";

    public static void main(String[] args) {
        pdf_Generator sa = new pdf_Generator();
//        sa.seperate("/Users/law/Desktop/ComicWorks/admin","001.pdf");
//          sa.seperate("sa.pdf");

//        File b = new File(dir);
//        File[] file = b.listFiles();
//        for (File e : file) {
//            System.out.println(e.getName());
//        }
//                sa.create(dir);
//    sa.deleteImg(dir);
    }

    public byte[] combineResources(ArrayList<InputStream> list) throws IOException {
        ByteArrayOutputStream output = new ByteArrayOutputStream();
        PDFMergerUtility newPdf = new PDFMergerUtility();
        for (InputStream pdf : list) {
            newPdf.addSource(pdf);
        }
        newPdf.setDestinationStream(output);
        newPdf.mergeDocuments(null);
        return output.toByteArray();
            
    }

    public ArrayList<byte[]> getDoublePageByIndex(InputStream input, String comicid, int first, int last) {
        String str = "", pageName = "";
        ArrayList<byte[]> as = new ArrayList<byte[]>();
        try (final PDDocument document = PDDocument.load(input)) {
            PDFRenderer pdfRenderer = new PDFRenderer(document);
            for (int page = first; page < last; page++) {
                BufferedImage bim = pdfRenderer.renderImageWithDPI(page, 300, ImageType.RGB);
                ByteArrayOutputStream bs = new ByteArrayOutputStream();
                ImageIOUtil.writeImage(bim, "JPEG", bs);
                pageName = comicid + "-" + page + ".jpg";

                as.add(bs.toByteArray());
                System.out.println(pageName);
            }
            document.close();

        } catch (IOException e) {
            System.err.println("Exception while trying to create pdf document - " + e);
        }

        return as;
    }

    public String getSinglePage(InputStream input) {//version 1

        String as = "";
        try (final PDDocument document = PDDocument.load(input, setupTempFileOnly())) {
            PDFRenderer pdfRenderer = new PDFRenderer(document);

            imageTranslator it = new imageTranslator();

            BufferedImage bim = pdfRenderer.renderImageWithDPI(0, 300, ImageType.RGB);
            ByteArrayOutputStream bs = new ByteArrayOutputStream();
            ImageIOUtil.writeImage(bim, "JPEG", bs);
            as = it.genImageWithByte(bs.toByteArray());

            document.close();
        } catch (IOException e) {
            System.err.println("Exception while trying to create pdf document - " + e);
        }
        return as;
    }

    public LinkedHashMap<String, byte[]> seperate(byte[] input, String fileName) {//version 1
        String pageName = "";
        imageTranslator it = new imageTranslator();
        LinkedHashMap<String, byte[]> as = new LinkedHashMap<String, byte[]>();
        try (final PDDocument document = PDDocument.load(input)) {
            PDFRenderer pdfRenderer = new PDFRenderer(document);

            for (int page = 0; page < document.getNumberOfPages(); page++) {
                BufferedImage bim = pdfRenderer.renderImageWithDPI(page, 300, ImageType.RGB);
                ByteArrayOutputStream bs = new ByteArrayOutputStream();
                ImageIOUtil.writeImage(bim, "JPEG", bs);
                pageName = fileName + "-" + page + ".jpg";

                as.put(pageName, bs.toByteArray());
                System.out.println(pageName);
            }
            document.close();
        } catch (IOException e) {
            System.err.println("Exception while trying to create pdf document - " + e);
        }
        return as;
    }

    public ArrayList<byte[]> seperate(byte[] input) {
        String pageName = "";
        ArrayList<byte[]> as = new ArrayList<byte[]>();
        try (final PDDocument document = PDDocument.load(input)) {
            PDFRenderer pdfRenderer = new PDFRenderer(document);

            for (int page = 0; page < document.getNumberOfPages(); page++) {
                BufferedImage bim = pdfRenderer.renderImageWithDPI(page, 300, ImageType.RGB);
                ByteArrayOutputStream bs = new ByteArrayOutputStream();
                pageName = "shi" + "-" + page + ".jpg";

                ImageIOUtil.writeImage(bim, "JPEG", bs);
                as.add(bs.toByteArray());
                System.out.println(pageName);
            }
            document.close();
        } catch (IOException e) {
            System.err.println("Exception while trying to create pdf document - " + e);
        }
        return as;
    }

    public ArrayList<String> seperate(String path, String fileName, byte[] input) {//version 3
//        dir + filePath
        String pageName = "";
        imageTranslator it = new imageTranslator();
        ArrayList<String> as = new ArrayList<String>();
        try (final PDDocument document = PDDocument.load(input)) {
            if (document == null) {
                System.out.print("inputStream is null ");
            }
            PDFRenderer pdfRenderer = new PDFRenderer(document);

            for (int page = 0; page < document.getNumberOfPages(); page++) {
                BufferedImage bim = pdfRenderer.renderImageWithDPI(page, 300, ImageType.RGB);
//                BufferedImage img = pdfRenderer.renderImage(page);
                ByteArrayOutputStream bs = new ByteArrayOutputStream();
                pageName = fileName + page + ".jpg";
                String des = path + pageName;
                ImageIOUtil.writeImage(bim, des, 300);
                as.add(des);
                System.out.println(des);

            }
            document.close();
        } catch (IOException e) {
            System.err.println("Exception while trying to create pdf document - " + e);
        }
        return as;
    }

    public InputStream create(ArrayList<byte[]> imgContent, String path) {
        InputStream inputStream = null;
        PDDocument doc = new PDDocument();
        try {
            for (byte[] item : imgContent) {
                PDPage page = new PDPage(PDRectangle.A4);
                PDImageXObject img = PDImageXObject.createFromByteArray(doc, item, null);
                PDPageContentStream con = new PDPageContentStream(doc, page);
                HashMap<String, Float> c = setImageLayout(page);
                con.drawImage(img, c.get("x"), c.get("y"), c.get("width"), c.get("height"));
                doc.addPage(page);
                con.close();
//                    System.out.println(s.getName());
//                }

            }
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
//            doc.save(path + "/" + "sa.pdf");
            doc.save(byteArrayOutputStream);
            doc.close();
            inputStream = new ByteArrayInputStream(byteArrayOutputStream.toByteArray());

//            deleteImg(path);
        } catch (IOException e) {
        }

        return inputStream;
    }

    public void deleteImg(String path) {
        File f = new File(path);
        File[] sa = f.listFiles();
        for (File k : sa) {
            if (!getFileType(k.getAbsolutePath()).equals("pdf")) {
                File exist = k.getAbsoluteFile();
                exist.delete();
            }

        }

    }

    public void insert(int start, String path) {

    }

    public String getFileType(String path) {
        return FilenameUtils.getExtension(path);
    }

    public HashMap<String, Float> setImageLayout(PDPage page) {
        float height = page.getMediaBox().getHeight();
        float width = page.getMediaBox().getWidth();
        float imgWidth = (float) (width * 0.9);
        float imgHeight = (float) (height * 0.9);
        float positionX = (float) (width * .05);
        float positionY = (float) (height * .05);
        HashMap<String, Float> value = new HashMap<String, Float>();
        value.put("x", positionX);
        value.put("y", positionY);
        value.put("width", imgWidth);
        value.put("height", imgHeight);
        return value;
    }

//    public void sortByNumber(File[] f) {
//      
//        int start  =1 ;
//    
//      
//
//        for(File  item : f){
//           if (!item.getName().equals(".DS_Store") && !getFileType(item.getAbsolutePath()).equals("pdf")) {
////               int  fNameIndex  = item.getName().lastIndexOf("_")+1;
////               int  LNameIndex  = item.getName().lastIndexOf(".");
////               String  str = item.getName().substring(fNameIndex,LNameIndex);
//               
//                
//            System.out.println(item.getName());
//           }
//        
//        }
//                
//    }
    public void sortByNumber(File[] item) {
        Arrays.sort(item, new Comparator<File>() {

            public int compare(File o1, File o2) {
                int n1 = extractNumber(o1.getName());
                int n2 = extractNumber(o2.getName());
                return n1 - n2;
            }

            private int extractNumber(String name) {
                int i = 0;
                try {
                    int fNameIndex = name.lastIndexOf("_") + 1;
                    int LNameIndex = name.lastIndexOf(".");
                    String str = name.substring(fNameIndex, LNameIndex);
                    i = Integer.parseInt(str);
                } catch (Exception e) {
                    i = 0; // if filename does not match the format
                    // then default to 0
                }
                return i;
            }
        });

    }

    public ArrayList<String> seperator(String filePath, String fname) throws IOException {
        ArrayList<String> str = new ArrayList<String>();
        String pageName = "";

        PDDocument document = PDDocument.load(new File(filePath + "/" + fname));
        PDFRenderer render = new PDFRenderer(document);
        for (int page = 0; page < document.getNumberOfPages(); page++) {
            BufferedImage bim = render.renderImage(page);
//                BufferedImage bim = render.renderImageWithDPI(page, 250, ImageType.RGB);
            pageName = "shw_" + page + ".jpg";
            String fileName = filePath + "/" + pageName;
            ImageIOUtil.writeImage(bim, fileName, 300);
            str.add(fileName);

            System.out.println(page);
        }
        document.close();

        return str;
    }

    public ArrayList<String> getImagePageById(int[] pageNo, byte[] input) {
        imageTranslator it = new imageTranslator();
        ArrayList<String> as = new ArrayList<String>();
        try (final PDDocument document = PDDocument.load(input)) {
            PDFRenderer pdfRenderer = new PDFRenderer(document);
            for (int page : pageNo) {
                BufferedImage bim = pdfRenderer.renderImageWithDPI(page, 300, ImageType.RGB);
                ByteArrayOutputStream bs = new ByteArrayOutputStream();
                ImageIOUtil.writeImage(bim, "JPEG", bs);
                as.add(it.genImageWithByte(bs.toByteArray()));
                System.out.println(page);
            }
            document.close();
        } catch (IOException e) {
            System.err.println("Exception while trying to create pdf document - " + e);
        }
        return as;

    }

}
