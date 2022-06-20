<%-- 
    Document   : Member
    Created on : 2021/1/30, 下午 09:22:48
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %>
<%@page import="ict.bean.Account" %>
<%@page import="ict.bean.userInfo" %>
<%@page import="ict.bean.UserOrderBean" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="barCss/css/bootstrap.min.css" rel="stylesheet">
        <link href="barCss/css/simple-sidebar.css" rel="stylesheet">
        <link href="barCss/css/dashboard.css" rel="stylesheet">
        <link href="mdi-font/css/material-design-iconic-font.min.css" rel="stylesheet" media="all">
        <link href="css/theme.css" rel="stylesheet">
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
            .img_circle {
                border-radius: 50%;
            }

            .setting2 {
                display: flex;
                padding: 20px;
            }


        </style>

        <!--Get user info -->
        <%
            String dburl = "jdbc:mysql://localhost:3306/fyp";
            String dbUser = "root";
            String dbPassword = "";
            Account member = (Account) request.getSession().getAttribute("member");
            int totalorder = 0;
            
            userInfo userinfo = new userInfo();
            try {
                if (member != null) {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection(dburl, dbUser, dbPassword);
                    PreparedStatement pstmt = null;
                    //get user Detail
                    String s = "select * from userinfo where eAddress = '" + member.geteAddress() + "'";
                    pstmt = con.prepareStatement(s);
                    ResultSet rs = pstmt.executeQuery();
                    while (rs.next()) {
                        userinfo.setFirstName(rs.getString("FirstName"));
                        userinfo.setLastName(rs.getString("LastName"));
                        userinfo.setPointAmount(rs.getInt("pointAmount"));
                        userinfo.setContactNum(rs.getString("contactNum"));
                    }
                    
                    //get totalOrder
                    String s2 = "select ord_id from orderrequest where eAddress = '"+member.geteAddress()+"' GROUP BY ord_id";
                    pstmt = con.prepareStatement(s2);
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        totalorder++;
                    }
                    con.close();
                }
            } catch (ClassNotFoundException ex) {
                ex.printStackTrace();
            } catch (SQLException ex) {
                while (ex != null) {
                    ex.printStackTrace();
                    ex = ex.getNextException();
                }
                
            }
        %>
        <!--End Get user info-->

        <!--IF Not Member-->
        <%if (member == null) {%>
        <jsp:forward page="Login2.jsp"/>
        <%}%>



    </head>
    <body>
        <%@include  file="sideBar/MsideBar.jsp" %>
        <div class="container-fluid">
            <div class="db-breadcrumb">
                <h4 class="breadcrumb-title" >Home Page</h4>
                <ul class="db-breadcrumb-list">
                    <li><a href="Member.jsp"><i class="fa fa-home"></i>Home</a></li>
                </ul>
            </div>

            <div class="row">
                <div class="col-sm-6 col-lg-3">
                    <div class="overview-item overview-item--c1">
                        <div class="overview__inner">
                            <div class="overview-box clearfix">
                                <div class="icon">
                                    <i class="zmdi zmdi-account-o"></i>
                                </div>
                                <div class="text">
                                    <h2><%out.println(userinfo.getFirstName() + " " + userinfo.getLastName());%></h2>
                                    <span style="color: greenyellow;">online</span>
                                </div>
                            </div>
                            <div class="overview-chart">

                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-lg-3">
                    <div class="overview-item overview-item--c2">
                        <div class="overview__inner">
                            <div class="overview-box clearfix">
                                <div class="icon">
                                    <i class="zmdi zmdi-shopping-cart"></i>
                                </div>
                                <div class="text">
                                    <h2><%=totalorder%></h2>
                                    <span>Total Order</span>
                                </div>
                            </div>
                            <div class="overview-chart">

                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-sm-6 col-lg-3">
                    <div class="overview-item overview-item--c4">
                        <div class="overview__inner">
                            <div class="overview-box clearfix">
                                <div class="icon">
                                    <i class="zmdi zmdi-money"></i>
                                </div>
                                <div class="text">
                                    <h2><%=userinfo.getPointAmount()%></h2>
                                    <span>Points</span>
                                </div>
                            </div>
                            <div class="overview-chart">

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <h2 style="border-bottom: 2px solid #EEEEEE;"><i class="fa fa-user" aria-hidden="true"></i> Personal Detail</h2>
            <div class="row">
                <span class="setting2"><div style="margin-left: 30px;margin-top: 15px;"><img src="images/face.jpg" style="width: 240px; height: 240px;" class="img_circle"></div>
                    <ul class="list-group" style="margin-left:20px;margin-top: 15px;">
                        <li class="list-group-item"><span style='font-size:30px;'>&#9993;</span> Email authentication : <%if (member != null) {
                                out.println(member.geteAddress());
                            }%></li>
                        <li class="list-group-item"><span style='font-size:30px;'>&#9998;</span> User Name : <%out.println(userinfo.getFirstName() + " " + userinfo.getLastName());%></li>
                        <li class="list-group-item"><span style='font-size:30px;'>&#9990;</span> PhoneNumber : <%=userinfo.getContactNum()%></li>
                    </ul>
                </span>
            </div>


            <div class="row">
                <div class="col-lg-9">
                    <h2 class="title-1 m-b-25">Recently purchased</h2>
                    <div class="table-responsive table--no-card m-b-40">
                        <table class="table table-borderless table-striped table-earning">
                            <thead>
                                <tr>
                                    <th>date</th>
                                    <th>order ID</th>
                                    <th class="text-right">Totalpoints</th>
                                    <th class="text-right">Totalprice</th>
                                    <th class="text-right">status</th>
                                </tr>
                            </thead>
                            <!--get Recently Purchased -->
                            <tbody>
                                <%
                                    if (member != null) {
                                        try {
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection con = DriverManager.getConnection(dburl, dbUser, dbPassword);
                                            PreparedStatement pstmt = null;
                                            String s = "SELECT ord_id,Sum(price*amount) as price,orderrequest.status as status,sendDate,updateTime,orderrequest.eAddress as eAddress,SUM(point) as point,orderrequest.product_id as product_id FROM orderrequest,product WHERE   product.product_id = orderrequest.product_id AND orderrequest.eAddress = '" + member.geteAddress() + "' GROUP BY ord_id ORDER BY ord_id DESC";
                                            pstmt = con.prepareStatement(s);
                                            ResultSet rs = pstmt.executeQuery();
                                            while (rs.next()) {
                                                out.println("<tr>");
                                                out.println("<td>" + rs.getString("sendDate") + "</<td>");
                                                out.println("<td><a href='orderDetail?orderID=" + rs.getInt("ord_id") + "'>" + rs.getInt("ord_id") + "</a></<td>");
                                                out.println("<td class='text-right'>" + rs.getInt("point") + "</<td>");
                                                out.println("<td class='text-right'>" + rs.getInt("price") + "</<td>");
                                                out.println("<td class='text-right'>" + rs.getString("status") + "</<td>");
                                                out.println("</tr>");
                                                totalorder++;
                                            }
                                            con.close();
                                        } catch (ClassNotFoundException ex) {
                                            ex.printStackTrace();
                                        } catch (SQLException ex) {
                                            while (ex != null) {
                                                ex.printStackTrace();
                                                ex = ex.getNextException();
                                            }
                                            
                                        }
                                    }
                                %>
                            </tbody>
                            <!--End get Recently Purchased-->
                        </table>

                    </div>
                </div>

            </div>
        </div>
    </body>
</html>
