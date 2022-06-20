<%-- 
    Document   : viewVideo
    Created on : 2021/3/11, 下午 05:14:19
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <title>JSP Page</title>
        <style type="text/css">

            .detail{
                margin-top: 20px;
            }
            .title, .uploadTime{
                font-size: 25px;
            }
            .desc{
                margin-top: 10px;
                font-size: 12px;
            }
            .loading{
                text-align: center;
                margin-top: 100px;
            }
        </style>
        <%
            String s = request.getParameter("id");
        %>
        <script>
            $(document).ready(function () {
                $.ajax({
                    type: "get",
                    datatype: "json",
                    url: "videoController",
                    data: {id: <%=s%>},
                    success: function (data) {
                        var json = JSON.parse(data);
                        $(".loading").html("<i class='fa fa-spinner fa-pulse fa-6x fa-fw'></i>");
                        setTimeout(function () {
                            $(".loading").hide();
                            $(".row").html("<h1>Video Detail</h1>" + "<video width='1000' height='600' controls=''>" +
                                    "<source src='" + json.videoDetail[0].url + "' type='video/mp4'>" +
                                    "</video>");
                            $(".detail").html("<span class='title'>" + json.videoDetail[0].title + "  |</span><span class='uploadTime'> UploadTime: " + json.videoDetail[0].uploadTime + "</span>");
                            $(".desc").html("Description: " + json.videoDetail[0].description);
                        }, 3000);
                    }
                });
            });
        </script>
    </head>
    <body>
        <jsp:include page="parts/memberNav2.jsp"/>
        <div class="container" style="">
            <div class="row" style="margin-top: 120px;">

            </div> 
            <div class='loading'></div>
            <div class="detail"></div>
            <div class="desc"></div>
        </div>
    </body>
</html>
