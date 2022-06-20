<%-- 
    Document   : index
    Created on : Dec 15, 2020, 1:27:34 AM
    Author     : law
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/index.css">
        <link rel="stylesheet" href="css/loading-bar.css">
        <style type="text/css">
            .ldBar {
                position: relative;
                color:  #66ced2;
                font-size: 60px;
            }
        </style>
    </head>
    <body>   

        <%@include file="CDN.jsp" %>

        <h1 id="title">Hello World!</h1>
        <a href="createState" style="">state</a>
        <script src="js/preview.js">




        </script>
        <div style="margin-top: 150px;margin-bottom: 150px">
            <form>
                <h2></h2>
                <select name="item" id="la"  >
                    <option value="Angle">angle</option>
                    <option value="banana">nana</option>
                    <option value="sgle">gle</option>
                </select>
            </form>
        </div>
        <div>

            <form id="upload" method="post" enctype="multipart/form-data" >
                <!--                  <label for="#comic" style="
                                   padding: 10px;
                                   background: aquamarine;
                                   margin-bottom: 120px;
                                   ">Submit</label>-->
                <input type ="hidden" name="action"  value="upload">
                <input type="file" name="comic" value="" id="comic"  multiple >

            </form>

            <button id="sub">Submit</button>

            <button id="su">St</button>

        </div>


        <div id="progressBox" style="  ">
            <div
                id="progressbar"
                class="ldBar label-center"
                data-preset="circle"          
                data-stroke="data:ldbar/res,gradient(1,1,#c9d5f3,#69fae8)"
                data-stroke-width="1.5"
                style="width:100%;height:100%;"
                ></div>
            <h4 id="progHeading">In Progress</h4>

            <h4 id="remaining">Time Required</h4>
            <h4 id="time">assasasa</h4>
            <h4 id="FileSize">File Size <br><span id="fs"></span></h4>
            <h4 id="msg">The file is handling......</h4>

        </div>

        <div class="uploadBox"></div>
            
        
        <div id="imgPrev"><img id="im"></div>
    </body>
</html>
