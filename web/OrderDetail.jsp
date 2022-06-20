<%-- 
    Document   : OrderDetail
    Created on : 2021/1/31, 下午 08:38:18
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            .totalDetail {
                float: right;
                margin-top: 10px;
            }

            .totalDetail table tbody tr td {
                text-align: right;
                padding: 5px;
                font-size: 17px;
                font-family: monospace;
            }

            .backbtn {
                float: right;
                display: inline-block;
                height: 36px;
                min-width: 100px;
                padding: 0 20px;
                border-radius: 2px;
                font-size: 16px;
                line-height: 36px;
                text-align: center;
                vertical-align: middle;
                background-color: #36B449;
                color: #FFF;
                margin-top: 20px;
            }
            .card-2 {
                box-shadow: 1px 1px 3px 0px rgb(112, 115, 139)
            }
        </style>


        <%
            OrderDetailBean Eodb = (OrderDetailBean) request.getAttribute("EorderDetail");
            OrderDetailBean Rodb = (OrderDetailBean) request.getAttribute("RorderDetail");
            int totalPrice = 0;
            int totalPoint = 0;
            double discount = 0.0;
            DecimalFormat df = new DecimalFormat("####0.00");
        %>
    </head>
    <body>
        <%@include  file="sideBar/MsideBar.jsp" %>
        <div class="container-fluid">
            <div class="db-breadcrumb">
                <h4 class="breadcrumb-title">Home Page</h4>
                <ul class="db-breadcrumb-list">
                    <li><a href="Member.jsp"><i class="fa fa-home"></i>Home</a></li>
                    <li>Order List</li>
                    <li>Order Detail</li>
                </ul>
            </div>

            <div class="row">
                <div style="width: 1200px;height: auto;border: 1px solid rgba(204, 204, 204, 0.7);margin-left: 25px;padding: 7px;">
                    <h2>OrderID: <%out.println(Eodb.getOList().get(0).getOrderID());%> <span style="margin-left: 12px;">Order Date: <%out.println(Eodb.getOList().get(0).getDate());%></span></h2>
                    <div style="padding-top: 15px;font-family: inherit;font-size: 15px;"><b>Payment Detail:</b></div>
                    <div style="border-bottom: 2px solid #EEEEEE;margin-bottom:8px; ">Master Card  - 5564 **** **** 2221</div>
                    <div style="font-size: 18px;">Receipt</div>
                    <!--item Detail-->
                    <%for (OrderDetailBean eob : Eodb.getOList()) {
                        if(eob.getPoint() > 0){
                            totalPoint += eob.getPoint();discount = eob.getDiscount();%>
                    <div class="row mt-4">
                        <div class="col">
                            <div class="card card-2">
                                <div class="card-body">
                                    <div class="media">
                                        <div class="media-body my-auto text-right">
                                            <div class="row my-auto flex-column flex-md-row">
                                                <div class="col"> <small><%out.println(eob.getComicName() + "EP" + eob.getEp() + "(" + eob.getEpTitle() + ")");%></small></div>
                                                <div class="col"> <small><%=eob.getStatus()%> </small></div>
                                                <div class="col"> <small><%=eob.getPoint()%> Points</small></div>
                                                <div class="col"> <small>Qty : </small></div>
                                                <div class="col">
                                                    <h6 class="mb-0">$ 0</h6>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%}}%>

                    <%for (OrderDetailBean rob : Rodb.getOList()) {
                            totalPrice += rob.getPrice() * rob.getQuantity();%>
                    <div class="row mt-4">
                        <div class="col">
                            <div class="card card-2">
                                <div class="card-body">
                                    <div class="media">
                                        <div class="media-body my-auto text-right">
                                            <div class="row my-auto flex-column flex-md-row">
                                                <div class="col"> <small> <%=rob.getBundleName()%></small></div>
                                                <div class="col"> <small><%=rob.getStatus()%> </small></div>
                                                <div class="col"> <small>0 Points</small></div>
                                                <div class="col"> <small>Qty: <%=rob.getQuantity()%></small></div>
                                                <div class="col">
                                                    <h6 class="mb-0">$ <%=rob.getPrice()%></h6>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%}%>


                    <!--Item Detail End -->

                    <!--Total Detail-->
                    <div class="totalDetail">
                        <table>
                            <tbody>
                                <tr>
                                    <td s>Total Price</td>
                                    <%if(discount > 0.0){%>
                                    <td>$ <%=df.format(totalPrice*discount)%></td>
                                    <%}else{%>
                                    <td>$ <%=totalPrice%></td>
                                    <%}%>
                                </tr>
                                <tr>
                                                                        
                                    <td>Total Point</td>
                                    <%if(discount > 0.0){%>
                                    <td>$ <%=df.format(totalPoint*discount)%></td>
                                    <%}else{%>
                                    <td>$ <%=totalPoint%></td>
                                    <%}%>
                                </tr>
                                <tr>
                                    <td>Discount</td>
                                    <%if(discount > 0.0){%>
                                    <td><%=discount%></td>
                                     <%}else{%>
                                     <td>No discount</td>
                                     <%}%>
                                </tr>
                                <tr>
                                    <td>Delivery Charges</td>
                                    <td>Free</td>
                                </tr>
                            </tbody>
                        </table>
                        <div><a href="reviewOrder?action=all" class="backbtn">Back</a></div>
                    </div>
                    <!--Total Detail End-->
                </div>
            </div>
        </div>
    </body>
</html>
