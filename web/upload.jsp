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
            #outer{
                visibility: hidden;
                position:  absolute;
                width: 100%;
                z-index:  99;
                background: rgba(0,0,0,0.6);
                height: 110vh;
                top:0;
            }
            #progressBox{
                margin-top:109px;
                margin-left: 20%; 
                    
            }
            #text{
                margin-top: -680px;
            }
        </style>
    </head>
    <body>   

        <%@include file="CDN.jsp" %>
        <script >
            $(document).ready(function () {
                var start = "";
                $("#msgBox").hide();
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
                      if((e.loaded / e.total)*100 ==100 ){
                          $("#msg").text("The file is handling......")
                          
                      }


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
                    $("#outer").css({visibility: "visible"})
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

        <div id="loader">


            <div id="hd"> 
                <h3 id="UploadTitle">Comic uplodad</h3>
            </div>
            <div class="uploadBox" style="border:1px solid gainsboro;margin-top: 10px">
                <i class="fa fa-cloud-upload" 
                   style="font-size:120px ;color:  #66ced2; 
                   position: absolute; top:250px; left: 45%"></i>
                <div id="msgUpload" style="margin-top:280px;margin-left:39%">Drag your file here(Single file only)</div>
            </div>








        </div>
        <!--            <form id="upload" method="post" enctype="multipart/form-data" >
                                          <label for="#comic" style="
                                           padding: 10px;
                                           background: aquamarine;
                                           margin-bottom: 120px;
                                           ">Submit</label>
                        <input type ="hidden" name="action"  value="upload">
                        <input type="file" name="comic" value="" id="comic"  multiple >
        
                    </form>-->

        <!--<button id="sub">Submit</button>-->

        <!--<button id="su">St</button>-->

        <!--</div>-->

        <div id="outer">
            <div id="progressBox" style="border:none;border-radius: 2px;height: 450px;">
                <div
                    id="progressbar"
                    class="ldBar label-center"
                    data-preset="circle"          
                    data-stroke="data:ldbar/res,gradient(1,1,#c9d5f3,#69fae8)"
                    data-stroke-width="1.5"
                    style="width:100%;height:100%;"
                    ></div>
                <h4 id="progHeading">In Progress</h4><!--
<!---->        <div id="text">
                <h4 id="remaining" >Time Required</h4>
                <h4 id="time" style="margin-top:10px;">assasasa</h4>
                <h4 id="FileSize">File Size <br><span id="fs"></span></h4>
                <h4 id="msg">Uploading.....</h4>
                <div>
            </div>
                    
            <div>

                </body>

                </html>
