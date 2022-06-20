<%-- 
    Document   : orderStatus
    Created on : 2021/1/28, 下午 10:03:23
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="ict.bean.Account" %>
<%@page import="ict.bean.OrderDetailBean" %>
<%@page import="java.text.DecimalFormat" %>
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
            * {
                box-sizing: border-box;
            }
            input[type=text]{
                padding: 10px;
                font-size: 17px;
                border: 1px solid grey;
                float: left;
                width: 300px;
                background: #f1f1f1;
            }
            button{
                float: left;
                width: 80px;
                padding: 12px;
                background: #2196F3;
                color: white;
                font-size: 17px;
                border: 1px solid grey;
                border-left: none;
                cursor: pointer;
            }
            button:hover {
                background: #0b7dda;
            }

            input[type="date"] {
                background:#fff url(https://cdn1.iconfinder.com/data/icons/cc_mono_icon_set/blacks/16x16/calendar_2.png)  97% 50% no-repeat ;
            }
            input[type="date"]::-webkit-inner-spin-button {
                display: none;
            }
            input[type="date"]::-webkit-calendar-picker-indicator {
                opacity: 0;
            }
            input[type="date"]{
                border: 1px solid #c4c4c4;
                border-radius: 5px;
                background-color: #fff;
                padding: 3px 5px;
                box-shadow: inset 0 3px 6px rgba(0,0,0,0.1);
                width: 190px;
            }
            label {
                display: block;
            }
            #datebutton{
                border-radius: 12px;
                border: none;
                background-color:  #c2c374;
                padding: 8px;
            }
            #datebutton:hover{
                opacity: 0.8;
                border: 2px solid black;
                box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 17px 50px 0 rgba(0,0,0,0.19);
            }
        </style>
        <%
            OrderDetailBean Eodb = (OrderDetailBean) request.getAttribute("eob");
            OrderDetailBean Rodb = (OrderDetailBean) request.getAttribute("rob");
        %>


        <%
            Account member = (Account) request.getSession().getAttribute("member");
            if (member == null) {%>
        <jsp:forward page="Login2.jsp"/>
        <% }
        %>
    </head>
    <body>
        <jsp:include page="sideBar/MsideBar.jsp" />
        <div class="container-fluid">
            <div class="db-breadcrumb">
                <h4 class="breadcrumb-title" >Home Page</h4>
                <ul class="db-breadcrumb-list">
                    <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                    <li>Order List</li>
                </ul>
            </div>
            <form action="reviewOrder" method="get" style="max-width:600px">
                <input type="hidden" name="action" value="Search">
                <input type="text" name="searchKey" placeholder="Search by orderID" required>
                <button type="submit"><i class="fa fa-search"></i></button>
            </form><br><br><br>

            <form action="" method="get">
                <label for="date1">Date Search</label>
                <input type="hidden" name="action" value="date">
                <input type="date" name="date1" id="date1"> <input type="date" name="date2">
                <input type="submit" value="Search Date" id="datebutton">
            </form>
            <h1>Order List  <h3><span style="color:  red;">* R = Realistic | E = Electron</span></h3></h1>

            <table id='mytable' class='table table-bordred table-striped'>

                <%
                    double totalPoint = 0.0;
                    double totalPrice = 0.0;
                    DecimalFormat df = new DecimalFormat("####0.00");
                    out.println("<tr>");
                    out.println("<th>OrderID</th>");
                    out.println("<th>Total Price</th>");
                    out.println("<th>Points</th>");
                    out.println("<th>SendTime</th>");
                    out.println("<th>UpdateTime</th>");
                    out.println("<th>Status</th>");
                    out.println("<th></th>");
                    out.println("</tr>");

                    for (OrderDetailBean eob : Eodb.getOList()) {
                        if (member.geteAddress() != null) {
                            if (eob.getPoint() > 0) {
                                out.println("<tr>");
                                out.println("<td><a href='orderDetail?orderID=" + eob.getOrderID() + "'>E " + eob.getOrderID() + "</a></td>");
                                out.println("<td>0</td>");
                                if (eob.getDiscount() > 0.0) {
                                    totalPoint = eob.getPoint() * eob.getDiscount();
                                    out.println("<td>" + df.format(totalPoint) + "</td>");
                                } else {
                                    out.println("<td>" + eob.getPoint() + "</td>");
                                }
                                out.println("<td>" + eob.getDate() + "</td>");
                                out.println("<td>" + eob.getDate() + "</td>");
                                out.println("<td>" + eob.getStatus() + "</td>");
                                out.println("</tr>");
                            }
                        }
                    }

                    for (OrderDetailBean rob : Rodb.getOList()) {
                        if (member.geteAddress() != null) {
                            out.println("<tr>");
                            out.println("<td><a href='orderDetail?orderID=" + rob.getOrderID() + "'>R " + rob.getOrderID() + "</a></td>");
                            if (rob.getDiscount() > 0.0) {
                                totalPrice = rob.getPrice()*rob.getQuantity()*rob.getDiscount();
                                out.println("<td>" + df.format(totalPrice) + "</td>");
                            } else {
                                out.println("<td>" + rob.getPrice() * rob.getQuantity() + "</td>");
                            }
                            out.println("<td>0</td>");
                            out.println("<td>" + rob.getDate() + "</td>");
                            out.println("<td>" + rob.getDate() + "</td>");
                            out.println("<td>" + rob.getStatus() + "</td>");
                            if (rob.getStatus().equals("Complete")) {
                                out.print("<td><a href='additionalcommand?orderID=" + rob.getOrderID() + "&email=" + member.geteAddress() + "&productID=" + rob.getProductID() + "'>Additional comments</a></td>");
                            }
                            out.println("</tr>");
                        }
                    }
                %>
            </table>
        </div>

    </body>
</html>
