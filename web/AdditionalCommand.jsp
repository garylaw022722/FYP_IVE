<%-- 
    Document   : AdditionalCommand
    Created on : 2021/1/28, 下午 11:22:39
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="ict.bean.CommentBean" %>
<%@ page import="ict.bean.Account" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="barCss/css/bootstrap.min.css" rel="stylesheet">
        <link href="barCss/css/simple-sidebar.css" rel="stylesheet">
        <link href="barCss/css/dashboard.css" rel="stylesheet">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <style type="text/css">
            body {
                background-image: url("https://s3-us-west-2.amazonaws.com/s.cdpn.io/239518/birds1.svg"), url("https://s3-us-west-2.amazonaws.com/s.cdpn.io/239518/birds2.svg"), url("https://s3-us-west-2.amazonaws.com/s.cdpn.io/239518/clouds.svg"), linear-gradient(to bottom, rgba(255, 255, 255, 0), 40%, rgba(255, 255, 255, 1) 60%), url("https://s3-us-west-2.amazonaws.com/s.cdpn.io/239518/BG2.svg");
                background-size: 20%, 20%, 100%, 100%, 50px;
                background-repeat: no-repeat, no-repeat, no-repeat, repeat-x, repeat;
                background-position: 5% 40%, 95% 60%, center bottom;
            }
            ul {
                list-style-type: none;
                padding: 0;
                -moz-user-select: none;
                -webkit-user-select: none;
            }
            ul > li.star {
                display: inline-block;
            }
            ul > li.star > i.fa {
                font-size: 2.5em;
                color: #ccc;
            }
            ul > li.star.hover > i.fa {
                color: green;
            }
            ul > li.star.selected > i.fa {
                color: #FFCC36;
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
    </head>
    <body>
        <jsp:include page="sideBar/MsideBar.jsp" />
        <div class="container-fluid">
            <div class="db-breadcrumb">
                <h4 class="breadcrumb-title" >Home Page</h4>
                <ul class="db-breadcrumb-list">
                    <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                    <li>Order List</li>
                    <li>Comment</li>
                </ul>
            </div>
            <div class="container">
                <div style="padding: 110px;">
                    <h1>Comment Now</h1>

                    <%
                        Account member = (Account) request.getSession().getAttribute("member");
                        CommentBean orderdetail = (CommentBean) request.getAttribute("commentDetail");
                        String productID = "";
                        int orderID = 0;
                        for (CommentBean cb : orderdetail.getAcb()) {
                            productID = cb.getProductID();
                            orderID = cb.getOrderID();
                        }
                    %>
                    <hr>
                    <form action="newRComment" method="post">
                        <h2>Rating: </h2>
                        <ul id='stars'>
                            <li class='star' title='Poor' data-value='1'>
                                <i class='fa fa-star fa-fw'></i>
                            </li>
                            <li class='star' title='Fair' data-value='2'>
                                <i class='fa fa-star fa-fw'></i>
                            </li>
                            <li class='star' title='Good' data-value='3'>
                                <i class='fa fa-star fa-fw'></i>
                            </li>
                            <li class='star' title='Excellent' data-value='4'>
                                <i class='fa fa-star fa-fw'></i>
                            </li>
                            <li class='star' title='WOW!!!' data-value='5'>
                                <i class='fa fa-star fa-fw'></i>
                            </li>
                        </ul>
                        <input type="hidden" name="productID" value="<%=productID%>" id="productID">
                        <input type="hidden" name="email" value="<%if (member != null) {%><%=member.geteAddress()%><%}%>" id="email">
                        <input type="hidden" value="" id="ratingstar" name="ratingstar">
                        <input type="hidden" value="<%=orderID%>" name="orderID">
                        <textarea class="form-control" id="comment" name="comment" rows="7" required></textarea><br>
                        <input type="submit" value="Comment" id="submitcomment">
                    </form>
                </div>
            </div>
    </body>
</html>
<script>
    //function rating star
    $('#stars li').on('mouseover', function () {
        var onStar = parseInt($(this).data('value'), 10);


        $(this).parent().children('li.star').each(function (e) {
            if (e < onStar) {
                $(this).addClass('hover');
            } else {
                $(this).removeClass('hover');
            }
        });

    }).on('mouseout', function () {
        $(this).parent().children('li.star').each(function (e) {
            $(this).removeClass('hover');
        });
    });



    $('#stars li').on('click', function () {
        var onStar = parseInt($(this).data('value'), 10);
        var stars = $(this).parent().children('li.star');

        for (i = 0; i < stars.length; i++) {
            $(stars[i]).removeClass('selected');
        }

        for (i = 0; i < onStar; i++) {
            $(stars[i]).addClass('selected');
        }


        var ratingValue = parseInt($('#stars li.selected').last().data('value'), 10);
        var ratingstar = document.getElementById("ratingstar");
        ratingstar.value = ratingValue;
        var msg = "";
        msg = "Thanks! You rated this " + ratingValue + " stars.";
    });
</script>
