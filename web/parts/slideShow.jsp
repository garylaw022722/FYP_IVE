<!DOCTYPE html>
<%@ page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %>
<%@page import="ict.bean.BannerBean" %>
<%@page import="ict.db.BannerDB" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Title</title>
        <!--<script src="js/lightslider.js"></script>-->
        <!--<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">-->
        <!--<link rel="stylesheet" href="css/lightslider.css">-->
        <!--<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>-->
    </head>
    <style>
        #Banner{

        margin: 14px 0px 30px;
        display: block;
        width: 100%;
        margin-left: 20px;
        height: 250px;
     }

    #Banner:hover{
        opacity: 0.8;
    }
    img{
        width: 100%;
        height: 100%;
        /*border-radius: 10px;*/

    }
    #Banner img{
        border-radius: 15px;


    }
    .item1 {
        margin-top: 8px;
        width:540px;
    }
    .item2 { width:430px; }
    .item3 { width:440px; }
    .item4 { width:390px; }
    .item5 { width:420px; }

    #lightSlider{

        background-color: #31374c;
        background-color: #455070;
        background: linear-gradient(to right, #31374c , #455070, #72819d);
        /*background-color: #e5156f;*/

    }
        
    </style>
  <body>      
   <script>
    $(document).ready(function() {
        $("#lightSlider").lightSlider({
            autoWidth:true,
            item:1,
            speed: 1500, //ms'
            pause:3000,
            // slideMargin: 10,
            controls:false,
            auto:true,
            loop:true,
            pauseOnHover:true,
            onSliderLoad: function() {
                $('#autoWidth').removeClass('cS-hidden');
            }

        });
    });



</script>

       
   
         <%
              BannerBean  bb = new BannerDB().getAllBanner();
        %>

        <ul id="lightSlider" class="cs-hidden">
            <%if (bb != null) {
                    for (BannerBean bbb : bb.getBb()) {
                    out.println("<li class='item1'><a id='Banner' href=''><img src='"+bbb.getBase64Image()+"'></a></li>");
                   }
                        }%>
        </ul>
    </body>

</html>