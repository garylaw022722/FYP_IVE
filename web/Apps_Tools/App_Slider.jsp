<%-- 
    Document   : Apps_Front
    Created on : 02-Apr-2021, 11:25:48
    Author     : law
--%>

<%@page import="ict.db.BannerDB"%>
<%@page import="ict.bean.BannerBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>

</head>
<style>

    .lSSlideOuter .lSPager.lSpg  {
            position: absolute;
        width: 100%;
            top:360px;
      

    }
    .lSSlideOuter .lSPager.lSpg li {
            margin: 10px;
            font-size: 14px;

    }
    
    
    
    #Banner{
        margin: 0px 0px 20px;
        display: block;
        width: 100%;
        margin-left: 20px;
        height: 400px;
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


    /*body{margin: 0; padding: 0 ;top: 0;}*/
</style>
<script>
    $(document).ready(function() {
        $("#lightSlider").lightSlider({
            autoWidth:true,
            item:4,
            speed: 1500, //ms'
            pause:3000,
            slideMargin: 10,
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

    <body>
        <ul id="lightSlider" class="cs-hidden">
            <%if (bb != null) {
                    for (BannerBean bbb : bb.getBb()) {
                    out.println("<li class='item1'><a id='Banner' href=''><img src='"+bbb.getBase64Image()+"'></a></li>");
                   }
                        }%>
        </ul>
    </body>
</html>