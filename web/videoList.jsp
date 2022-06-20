<%-- 
    Document   : videoList
    Created on : 2021/3/11, 下午 05:52:37
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="videoCss/bootstrap.min.css">
        <link rel="stylesheet" href="css/videoList.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <title>JSP Page</title>
        <script>
            $(document).ready(function(){

                    $.ajax({
                        type:"get",
                        datatype: "json",
                        url:"videoDetail",
                        success: function(data){
                            var json = JSON.parse(data);
                            alert(json.videoDetail.length);
                            for(var i=0;i<json.videoDetail.length;i++){
                                $(".item-list").append("<div class='col-lg-4 col-md-6 col-sm-12 catalog-item'>" +
                                        "<div class='position-relative thumbnail-container'>" +
                                        "<video class='img-fluid tm-catalog-item-img'>" +
                                        "<source src='"+json.videoDetail[i].url+"' type='video/mp4'>" +
                                        "</video>" +
                                        "<a href='viewVideo.jsp?id="+json.videoDetail[i].videoID+"' class='position-absolute img-overlay'>" +
                                        "<i class='overlay-icon'></i>" +
                                        "</a>" +
                                        "</div>" +
                                        "<div class='p-4 tm-bg-gray catalog-item-description'>" +
                                        "<h3 class='text-primary mb-3 tm-catalog-item-title'>"+json.videoDetail[i].title+"</h3>" +
                                        "<p>"+json.videoDetail[i].description+"</p>" +
                                        "<p style='text-align: right;'>"+json.videoDetail[i].uploadTime+"</p>" +
                                        "</div>" +
                                        "</div>" +
                                        "</div>");
                            }
                            
                            
                        }
                });
            });
        </script>
    </head>
    <body>
        <jsp:include page="parts/memberNav2.jsp"/>
        <div class="tm-page-wrap mx-auto">
            <div class="container-fluid">
                <div id="content" class="mx-auto content-container">
                    <div class="row">
                        <div class="col-12">
                            <h2 class="title mb-4">Author Video Catalog</h2>
                            <div class="categories mb-5" style="border: 2px solid while;box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 17px 50px 0 rgba(0,0,0,0.19);">
                                <h3 class="tm-text-primary tm-categories-text" style="color: grey;margin-right: 16px;">Categories:</h3>
                                <ul class="nav category-list">
                                    <li class="nav-item category-item" style="color: grey;"><a href="#" class="nav-link">All</a></li>
                                    <li class="nav-item category-item" style="color: grey;"><a href="#" class="nav-link">Sort</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="row item-list">


                    </div>



                </div>
            </div>

        </div>
    </body>
</html>
