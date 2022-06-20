/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

/**
 *
 * @author law
 */
public class EmailConfig {

    public void sendEmail(String sender, String receiver, String subject, String html, String text) {
        String host = "smtp.gmail.com";
        String username = "garylaw696969@gmail.com";
        String password = "Nino2657";
        String port = "587";
        Properties prop = new Properties();
        prop.put("mail.smtp.auth", true);
        prop.put("mail.smtp.starttls.enable","true");
        prop.put("mail.smtp.host", host);
        prop.put("mail.smtp.port", port);
        prop.put("mail.smtp.ssl.trust", host);

        Session session = Session.getInstance(prop, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            MimeMessage msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(sender));
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(receiver));
            msg.setSubject(subject);
            msg.setContent(html, "text/html");
            Transport.send(msg);

        } catch (MessagingException sa) {
            sa.printStackTrace();
        }

    }
    public void sendEmailV2(String sender, String receiver, String subject, String html, String text) {
        String host = "smtp.gmail.com";
        String username = "garylaw696969@gmail.com";
        String password = "Nino2657";
        String port = "587";
        Properties prop = System.getProperties();     
        prop.put("mail.smtp.host", "localhost");
//        prop.put("mail.smtp.ssl.trust", host);

      Session session = Session.getDefaultInstance(prop);

        try {
            MimeMessage msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(sender));
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(receiver));
            msg.setSubject(subject);
            msg.setContent(html, "text/html");
            Transport.send(msg);

        } catch (MessagingException sa) {
            sa.printStackTrace();
        }

    }
//
    public static void main(String[] args) {

        new EmailConfig().sendEmail("garylaw696969@gmail.com",
                "garylawka696969@gmail.com", "馬すめたんろうs", "<h1>馬すめたんろうss</h1>", "");
//    
    }

}
