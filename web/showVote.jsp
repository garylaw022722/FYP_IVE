<%-- 
    Document   : showVote
    Created on : 2021/1/28, 下午 07:20:02
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="ict.bean.Account"%>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="barCss/css/simple-sidebar.css" rel="stylesheet">
        <link href="barCss/css/dashboard.css" rel="stylesheet">
        <link rel="stylesheet" href="barCss/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/EditorController.css">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    </head>
    <script>
        $(document).ready(function () {
            $.post("ShowVoteEvent", function (data) {
                if (data.length > 0) {
                    $("#mytable").html(data);
                }
            });
        });
    </script>

    <%Account editor = (Account) request.getSession().getAttribute("editor");%>

    <%if (editor == null) {%>
    <script>window.location.href = "Login2.jsp";</script>
    <%}%>
    <body>
        <div id="topNav"></div>
        <div id="left">
            <%@include file="parts/editorLeftBar.jsp" %>
        </div>
        <div id="reight">
            <div id="contentInsert">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title" >Home Page</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                        <li>Review Vote</li>
                    </ul>
                </div>
                <h1> Vote List</h1>
                <table id='mytable' class='table table-bordred table-striped'>

                </table>
            </div>
        </div>
    </body>
</html>
