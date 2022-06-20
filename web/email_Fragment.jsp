<%-- 
    Document   : email_Fragment
    Created on : 15-Mar-2021, 20:24:30
    Author     : law
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://smtpjs.com/v3/smtp.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="js/ActivationEmail.js"></script>


        <title>JSP Page</title>
    </head>
    <body>
        <script>

            $(document).ready(function () {
               
                var js = sessionStorage.getItem("activation");
                var item = JSON.parse(js);
                var regCode = item[0];
                var receiver = item[1];
                alert(receiver);
                var title = "Account Activation 2021 "
                $("#regCodeLink").attr("href", regCode)
                var html = $("#content").html()
                send(receiver, title, html);
//                
                       
            })




            function send(receiver, sub, body) {
                Email.send({
                    Host: "smtp.gmail.com",
                    Username: "law190444956@gmail.com",
                    Password: "oarlvkgypmrchwiv",
                    To: receiver,
                    From: "law190444956@gmail.com",
                    Subject: sub,
                    Body: body
                })
            }


        </script>
        <div style="visibility: hidden">
            <div id="content">
                <h3>Thank your for Registration</h3>            
                <a id="regCodeLink"> Click  here to  activate your account </a>            
            </div>
        </div>
        
    </body>
</html>
