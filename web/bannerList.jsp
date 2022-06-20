<%-- 
    Document   : newjsp
    Created on : 2021/1/28, 下午 04:59:36
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/lightslider.css" type="text/css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    </head>
    <body>
        <div class="container">
            <div class="row">
            <form action="updatebanner" method="get">
                <div class="col-auto my-1" style="margin-left: 250px;">
                    <h1 class="mr-sm-2" for="silder" style="margin-top: 240px;">MainPageBanner</h1>
                <select name="silder" id="silder" class="custom-select mr-sm-2">
                    <option value="1">First</option>
                    <option value="2">Second</option>
                    <option value="3" selected>Third</option>
                    <option value="4">Four</option>
                    <option value="5">Five</option>
                    <option value="6">Six</option>
                    <option value="7">Seven</option>
                    <option value="8">Eight</option>
                </select>
                </div><br>
                <input type="submit" value="Submit" id="select" class="btn btn-primary" style="margin-left: 265px;">
            </form>
                </div>
        </div><br>
    </body>
</html>
