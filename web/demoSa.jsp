<%-- 
    Document   : demoSa
    Created on : Feb 3, 2021, 3:56:16 PM
    Author     : law
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <body>
        <script>

            const empty = {};
            empty.pageSelected = [];
            empty.pageSelected.push("1-101-5")
            empty.pageSelected.push("1-292-3")
            empty.pageSelected.push("2-21-2")          

            var json = JSON.stringify(empty);
            alert(json)


            $(document).ready(function () {
                
               $.ajax({
                   url:"CustomBookController",
                   type:"get",
                   data:{
                       operation:"CreateCustomBook",
                       sources:json
                   },
                   success:function(res){
                       
                       
                       
                   }                                      
               })
               





            })

        </script>



    </body>
</html>
