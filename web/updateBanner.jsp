<%-- 
    Document   : updateBanner
    Created on : 2021/1/28, 下午 05:07:10
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/AdminSidebar.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    </head>
    <style type="text/css">
        #drop_zone {
            max-width: 470px;
            height: 250px;
            padding: 25px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            font-family: 'Quicksand',sans-serif;
            font-size: 500;
            font-size: 20px;
            cursor: pointer;
            color: #cccccc;
            border: 4px dashed red;
            border-radius: 10px;
            margin-top: 15px;
        }

        .drop-input{

        }
        #submitcomment {
            border-radius: 10px;
            background-color: #20c997;
            border: none;
            color: #FFFFFF;
            text-align: center;
            font-size: 28px;
            padding: 20px;
            width: 200px;
            transition: all 0.5s;
            cursor: pointer;
            margin: 5px;
        }
        #submitcomment:hover{
            opacity: 0.6;
        }
    </style>
    <script>
        $(document).ready(function () {
            var pageLoad = "";
            $('#AccountOpt').click(function () {
                pageLoad = "AccountManage.jsp";
                controller(pageLoad);
            })
            $('#Appointment').click(function () {
                pageLoad = "t1.jsp";
                controller(pageLoad);
            })
            $('#Posted').click(function () {
                pageLoad = "upload.jsp";
                controller(pageLoad);
            })


            $("#buildCon").click(function () {
                pageLoad = "upload.jsp";
                controller(pageLoad);
            })

            $("#userInfo").click(function () {
                pageLoad = "upload.jsp";
                controller(pageLoad);
            })
            $("#bannerUpload").click(function () {
                pageLoad = "bannerList.jsp";
                controller(pageLoad);
            })


        })
        function  controller(page) {
            $('#pageSetUP').load(page);
        }

        function dropHandler(ev) {
            alert('File dropped');
            ev.preventDefault();
            if (ev.dataTransfer.items) {
                for (var i = 0; i < ev.dataTransfer.items.length; i++) {
                    if (ev.dataTransfer.items[i].kind === 'file') {
                        var file = ev.dataTransfer.items[i].getAsFile();
                        console.log(file.name);
                        document.getElementById('output').src = URL.createObjectURL(file);
                        document.getElementById('prompt').innerHTML = file.name;

                    }
                }
            } else {
                for (var i = 0; i < ev.dataTransfer.files.length; i++) {
                    console.log(ev.dataTransfer.files[i].name);
                }
            }
        }

        function dragOverHandler(ev) {
            console.log('File(s) in drop zone');

            ev.preventDefault();
        }

        var loadFile = function (event) {
            var image = document.getElementById('output');
            image.src = URL.createObjectURL(event.target.files[0]);
        };

    </script>

    <%
        String silder = (String) request.getAttribute("silder");
        String imgName = (String) request.getAttribute("imgName");
        String selectbanner = "";
        if (silder.equals("1")) {
            selectbanner = "First";
        } else if (silder.equals("2")) {
            selectbanner = "Second";
        } else if (silder.equals("3")) {
            selectbanner = "Third";
        } else if (silder.equals("4")) {
            selectbanner = "Four";
        } else if (silder.equals("5")) {
            selectbanner = "Five";
        } else if (silder.equals("6")) {
            selectbanner = "Six";
        } else if (silder.equals("7")) {
            selectbanner = "Seven";
        } else if (silder.equals("8")) {
            selectbanner = "Eight";
        }
    %>
    <body>
        <jsp:include page="parts/AdminSidebar.jsp"/>
        <div class="container">
            <div class="row">
                <h1 style="margin-left:20px;">Update Detail</h1>
                <div style="padding:10px;">
                    <form action="updatebanner2" method="post" enctype="multipart/form-data" >
                        <input type="hidden" name="bannerID" value="<%=silder%>">
                        <%=selectbanner%>Banner <input type="text" name="bannerID" value="<%=silder%>" disabled ><br>
                        <div id="drop_zone" ondrop="dropHandler(event);" ondragover="dragOverHandler(event);">
                            <input type="file" name="file" id="file" style="display: none;" onchange="loadFile(event)" accept="image/*" required>
                            <span class="drop-zone__prompt" id="prompt"><label for="file" id="uploadText"> Drop here or click to upload </label></span>
                        </div>
                        <div style="margin-top: 25px;"><p ><img id="output" width="200" height="200"  style="float: left;"/></p> <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Before <image src="data:image/jpg;base64,<%=imgName%>" width="200" height="200"></div></div>
                        <input type="submit" value="Upload" id="submitcomment" style="margin-top: 25px;">
                    </form>

                </div>
            </div>  
        </div>
    </body>
</html>
<script>
    var loadFile = function (event) {
        var image = document.getElementById('output');
        image.src = URL.createObjectURL(event.target.files[0]);
        document.getElementById("uploadText").innerHTML = event.target.files[0].name + " upload completed";
    };
</script>
