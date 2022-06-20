<%-- 
    Document   : s2
    Created on : 17-Mar-2021, 13:44:27
    Author     : law
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
           <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
           <script>
               $(document).ready(function(){
                   
                   $("#sk").click(function(){
                      $.ajax({
                          type:'post',
                          url :'sk'
                        
                          
                      }) 
                       
                      
                   })
                   
                   
                   
               })
               
               
           </script>
    </head>
    <body>
        <button id="sk">Button</button>
    </body>
</html>
