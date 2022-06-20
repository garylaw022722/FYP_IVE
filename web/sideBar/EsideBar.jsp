<%-- 
    Document   : EsideBar
    Created on : 2021/1/28, 下午 06:54:12
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>JSP Page</title>
        <link href="../barCss/css/bootstrap.min.css" rel="stylesheet">
        <link href="../barCss/css/simple-sidebar.css" rel="stylesheet">
        <link href="../barCss/css/dashboard.css" rel="stylesheet">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body>
        <div class="d-flex" id="wrapper">
            <!-- Sidebar -->
            <i class="fas fa-house-user"></i>
            <div class="bg-light border-right" id="sidebar-wrapper">
                <div class="sidebar-heading"><img src="img/logo.svg" height="200" width="186"></div>
                <div class="list-group list-group-flush">
                    <a href="Editor.jsp" class="list-group-item list-group-item-action bg-light"><i class="fa fa-home" style="font-size: 25px;"></i> EditorPage</a>
                    <!-- dropdown  -->
                    <a href="Student.jsp" class="list-group-item list-group-item-action bg-light"><i class="fa fa-upload" style="font-size: 25px;"></i> Upload file</a>
                    <a href="showVote.jsp" class="list-group-item list-group-item-action bg-light"><i class="fa fa-check-circle" style="font-size: 25px;"></i> Review Vote</a>
                    <a href="meetingRequest.jsp" class="list-group-item list-group-item-action bg-light"><i class="fa fa-calendar-minus-o" aria-hidden="true" style="font-size: 25px;"></i> Meeting Request</a>
                    <a href="login2?action=logout" class="list-group-item list-group-item-action bg-light"><i class="fa fa-sign-out" aria-hidden="true" style="font-size: 25px;"></i> Logout</a>
                    <a href="Main.jsp" class="list-group-item list-group-item-action bg-light"><i class="fa fa-home" style="font-size: 25px;"></i> MainPage</a>
                </div>

            </div>
            <!-- /#sidebar-wrapper -->
    </body>
</html>
