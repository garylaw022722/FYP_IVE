<%-- 
    Document   : index
    Created on : Dec 15, 2020, 1:27:34 AM
    Author     : law
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*,java.util.*,ict.pdf_Generator"%>
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
        <script >
            $(document).ready(function () {
                var start = "";
//                sa = function () {
//                    $.getJSON("createState", function (data) {
//                        $("h1").text(data.isB);
//                    })
//                }
//                window.setInterval(sa, 0.000001);
//              
                $('.uploadBox').on("dragover", function () {
                    $(this).addClass('fileDrag');
                    return false;
                })
                $('.uploadBox').on('dragleave', function () {
                    $(this).removeClass('fileDrag');
                    return false;
                })


                function setProgressInfo(start, end, e) {
                    var hr = 0;
                    var duration = (end - start) / 1000;
                    var bps = e.loaded / duration;
                    var mbps = e.total / Math.pow(1000, 1);
                    var time = (e.total - e.loaded) / bps;
                    var sec = time % 60;
                    var min = time / 60;
                    if (min > 59) {
                        hr = time / 60;
                        min = min % 60;
                    }

                    var timeStr = hr + " hr : " + Math.floor(min) + " min : " + Math.floor(sec) + " second  ";

                    $('#time').html(timeStr);
                    $('#fs').html(Math.round(mbps * 10) / 10 + " Kb");



                }

                $('.uploadBox').on('drop', function (e) {
                    e.preventDefault();
//        $(this).removeClass('fileDrag');
//        $('#progressBox').css({"visibility": "visible"});
//    $('#sub').click(function () {
                    start = new Date().getTime();
//        var formData = new FormData($('#upload')[0]);
                    var formData = new FormData();
                    var s = e.originalEvent.dataTransfer.files;
                    for (let i = 0; i < s.length; i++) {
                        formData.append("comic", s[i]);

                    }
                     formData.append('operation', 'law');

                    var progBar = new ldBar("#progressbar");
                    $.ajax({
                        url: "createState",
                        data: formData,
                        type: 'post',
                        processData: false,
                        contentType: false,
                        async: true,
                        xhr: function () {

                            var xhr = $.ajaxSettings.xhr();
                            xhr.upload.onprogress = function (e) {
                                var v = e.loaded / e.total;
                                console.log(v * 1000);
                                progBar.set(v * 100);//                   
                                setProgressInfo(start, new Date().getTime(), e);
//                             
                            }
                            return xhr;
                        },
                        success: function (res) {
//                            $('h1').text(res);
          
                                window.location.href = 'comic2.jsp';
           


                        }
                    })



                });
                $('#la').change(function () {
                    var option = $(this).val();
                    $.get('texting', {
                        optionItem: option
                    }, function (res) {
                        $('h2').css({color: 'red'});
                        $('h2').text(res);

                    });
                });

                $('#comic').change(function () {

                    $('h2').text("");
                });

                $('#su').click(() => {

                    document.querySelector("#progress").style.width = "123px";
                });
            });



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

        <div id="fd" style="width: 19%;height:330px;"><img  id="pre" src="Comic/shi_0.jpg" style="width: 100%;height: 100%"></div>
    </body>

</html>
