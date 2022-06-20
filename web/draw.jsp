<%-- 
    Document   : draw
    Created on : 03-May-2021, 19:32:20
    Author     : 85266
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>   
        <title>JSP Page</title>
    </head>
    <style>
        #glassLayOut ,#msgLayOut{
            background: rgba(0, 0, 0, 0.05);
            width: 100%;
            height: 100%;
            position: fixed;
            z-index: 999;
        }
        #msgLayOut{
            background: none;
        }


        #DrawGif{
            margin: auto;
            width: 50%;
        }

        #msgBox {
            width:  35%;
            position: fixed;
            z-index :1200;
            height: 200px;
            top:180px;
            box-shadow: 1px 2px 10px rgba(0,0,0,0.2);
            left:30%;
            background:  white;

        }

        #titleS{
            text-align: center;
            margin-top: 30px;
            font-size: 14px;
            color:#aeb1b5;
            /*            border:1px solid #90939b;*/
        }

        #mainCon{
            text-align: center;
            margin-top: 30px;
            font-size: 16px;
            color:  #3b506b;

        }
        #AA{
            display:inline-block;
            width: 40%;
            background:  #3f4a56;
            margin: auto;
            padding: 4px 0px;
            color: white;
            margin-top: 40px;
        }
        #closePayment{
            display:inline-block;
            width: 30%;
            background:  #3f4a56;
            margin: auto;
            padding: 4px 0px;
            color: white;
            margin-top: 40px;

        }
    </style>
            <%Object num2 = request.getAttribute("random"); %>
    <script>
        var num = '<%=num2%>';
        var str ="";
        $(document).ready(function () {
            $("#msgLayOut").hide();
            if(num == 1){
                document.getElementById("gif").src = "images/redd.gif";
                document.getElementById("end").src = "images/endR.jpg";
                str = "You gat the 80% off coupon";
            }else if(num == 2){
                document.getElementById("gif").src = "images/yelloww.gif";
                document.getElementById("end").src = "images/endY.jpg";
                str = "You gat the 90% off coupon";
            }else if(num == 0){
                document.getElementById("gif").src = "images/whitee.gif";
                document.getElementById("end").src = "images/endW.jpg";
                str = "oh you gat nothing";
            }
            $("#AA").click(function () {
                $("#layout1").css({visibility: "visible"})
                $("#jpg").hide();
                $("#gif").show();
                setTimeout(function () {
                    $("#gif").hide();
                    $("#end").show();
                    $("#msgLayOut").show();
                    $("#msgBox").html("<div id='titleS'>Result<div><div id='mainCon'>" + str + "<div><a href='Main.jsp' id='btnCheckout'><div id='closePayment'>OK<div></a>");
                }, 3000);
            })
        });
    </script>
    <body>
        <div id="DrawGif">
            <image src="images/start.jpg" data-gifsee="images/redd.gif"  id="jpg"/>
            <image src="images/redd.gif" id="gif" hidden/>
            <image src="images/endR.jpg" id="end" hidden/>
            <button id="AA">Draw</button>
        </div>

        <div>
            <div id="msgLayOut">
                <div id="msgBox"></div>
            </div>  
        </div>
    </body>
</html>
