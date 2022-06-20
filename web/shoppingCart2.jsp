<%-- 
    Document   : shoppingCart2
    Created on : 2021年1月30日, 下午06:46:57
    Author     : tytap
--%>

<%@page import="ict.bean.ComicBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ict.bean.Account" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>    
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">

        <link rel="stylesheet" href="css/memberNav.css">
    </head>
    <style>
        #glassLayOut ,#msgLayOut{
            background: rgba(0, 0, 0, 0.05);
            width: 100%;
            height: 100%;
            position: fixed;
            z-index: 999;
        }
        #msgLayOut{
            background: none;
        }

        #layout1 {
            background: rgba(
                255,
                255,
                255,
                0.3
                );
            /*top:400px;*/
            background: white;
            width: 26%;
            border-radius: 3px;
            top: 110px;
            height: 320px;
            position: absolute;
            /*z-index: 501;*/
            left: 36%;
            box-shadow: 1px 2px 10px #a49fa0;
            /*box-shadow: 1px 2px 15px #c7fffd;*/
        }

        #productDetails{
            /*border: 1px solid red;*/
            width: 100%;
            height: 87%;
        }
        #ConfirButton{
            width: 100%;
            height: 13%;
            display: flex;
            flex-direction: row;
            text-align: center;
            font-family: Roboto;
            color : #98a2ab;
            font-size: 20px;

            margin: auto;
        }
        #cancel ,#Confirm {
            width: 50%;
            border: 1px solid gainsboro;
            border-bottom: none;
            padding-top: 7px;
            /*background: #edf1f5;*/
        }
        #cancel{
            border-radius: 0px 0px 0px 3px;
            /*background: #fc5a9f;*/
            border-right: none;
        }
        #Confirm{
            border-radius: 0px 0px 3px 0px;

            /*background: #fc5a9f;*/

        }
        #layout1 span{
            text-align: center;
            display: inline-block;
            width: 100%;
        }
        #pName{
            color: #3b506b;
            font-size: 28px;
            /*border:1px solid red;*/
            /*padding: 10px 0px;*/
            margin-top:16%;
            margin-bottom: 5%;
            font-family: "Al Bayan";
        }
        #priceL{
            color: #aeb1b5;
            color: #3b506b;;
            font-size: 19px;
            margin-bottom: 30px;
        }
        #extraPointL{
            font-size: 17px;
            color: #90939b;

        }
        #ConfirButton div:hover{
            background: #dee4ec;
            color:white;
            cursor: pointer;


        }


        .effect {

            background: rgba(0, 0, 0, 0.05);
        }

        #contentBoxPay{
            top:-480px;
            background: white;
            /*                width: 80%;*/
            box-shadow: 1px 2px 10px #a49fa0;
            height:480px;
            /*width:80%;*/
            position: fixed;
            z-index: 1081;
            border-radius: 3px;
            padding: 10px;
            left:23%;

        }

        #cardList{
            /*border: 1px solid red;*/
            display:flex;
            flex-direction: row;
            width: 80%;
            /*margin;*/
            /*padding: 30px;*/
            margin-left:12%;
            height:50px;
            margin-top: 20px;
            margin-bottom: 30px;
        }
        #cardList div{
            border-radius: 3px;
            width:  100px;
            padding: 10px;
            margin-right: 20px;
            height: 100%;
            box-shadow: 1px 2px 10px rgba(0,0,0,0.3);
        }
        img{
            width: 100%;
            height: 100%;
        }


        #CardNum ,#CardName,#Secode{
            margin-top: 5px;
            width: 76%;
            text-align: center;
            margin-left: 12%;
            margin-top: 10px;
            margin-bottom: 14px;

        }


        #fieldName{
            margin-left: 12%;
            color: #3f4a56;
            margin-bottom: -4px;
        }
        #CardName, #due{
            width:30%;
        }

        #ed{
            position: absolute;
            top:217px;
            width: 100%;
            left:46.5%;
        }
        #ed #fieldName{
            margin: 0;
            margin-bottom: 100px;
            margin-left: 2px;
            /*margin-bottom: 10px;*/
        }
        #due{
            margin-top: 8px;
            width: 40%;
        }

        #Secode{
            width: 50%;

        }

        #cancelF,#paymentF{
            margin-top: 50px;
            float: right;
            border: none;
            background: #3b506b;
            color: #eef1f6;
            display: inline-block;
            width: 15%;
            border-radius: 2px;
            padding: 4px 5px;

        }
        #paymentF{
            margin-right: 20px;
            margin-left: 20px;
        }
        #cancelF{
            background: #869096;
        }

        #msgBox {
            width:  35%;
            position: fixed;
            z-index :1200;
            height: 200px;
            top:180px;
            box-shadow: 1px 2px 10px rgba(0,0,0,0.2);
            left:30%;
            background:  white;

        }
        #msgLogo{
            width: 60px;
            height: 60px;
            display : inline-block ;
            margin-left: 20%
        }
        #msgLogo ,#msg{
            margin-top: 50px;
            color:  #aeb1b5;
            font-size: 23px;
            font-family: ppleMyungjo;
        }
        #titleS{
            text-align: center;
            margin-top: 30px;
            font-size: 14px;
            color:#aeb1b5;
            /*            border:1px solid #90939b;*/
        }

        #mainCon{
            text-align: center;
            margin-top: 30px;
            font-size: 16px;
            color:  #3b506b;

        }

        #closePayment{
            display:inline-block;
            width: 30%;
            background:  #3f4a56;
            margin: auto;
            padding: 4px 0px;
            color: white;
            margin-top: 40px;

        }
    </style>
    <%
        int totalPrice = 0;
        int totalPoint = 0;
        Account member = (Account) request.getSession().getAttribute("member");
        Account admin = (Account) request.getSession().getAttribute("admin");
        Account editor = (Account) request.getSession().getAttribute("editor");
        Account staff = (Account) request.getSession().getAttribute("staff");
        String user;
        if (member != null) {
            user = member.geteAddress();
        } else if (admin != null) {
            user = admin.geteAddress();
        } else if (editor != null) {
            user = editor.geteAddress();
        } else if (staff != null) {
            user = staff.geteAddress();
        } else {
            user = "";
        }
    %>
    <script>
        $(document).ready(function () {
            var cu = '<%=user%>';
            $("#glassLayOut").hide();
            $("#msgLayOut").hide();

            

            $("#msgBox").click(function (e) {
                if ($(this).find("#closePayment")) {
                    if (e.target.id == "closePayment") {
                        $("#msgLayOut").hide();
                        $('#pt').text(newPoint);
                    }


                }

            })
            $("#cancel").click(function () {

                $("#glassLayOut").hide();


            })
            $("#cancelF").click(function () {

                $("#glassLayOut").hide();
                $("#contentBoxPay").css({top: "-480px"})


            })



            $("#Confirm").click(function (e) {
//                 alert("isiass")
                if (cu !== '') {
                    $("#layout1").css({visibility: "hidden"})
                    $("#contentBoxPay").css({visibility: "visible"}).animate({top: "+=520px"}, 600)
                } else {
                    window.location.href = 'Login2.jsp';
                }



            })


            $("#CardNum").keydown(function (e) {
                var val = $(this).val();
                var leng = val.length;
                if (leng == cardSpace && leng < 18) {
                    $(this).val(val + " ");
                    cardSpace += 5;
                }

            })





            
        });


    </script>
    <body>
        <jsp:include page="parts/memberNav2.jsp"/>
        <p>123</p>
        <p>123</p>
        <p>123</p>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>    
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <!------ Include the above in your HEAD tag ---------->

        <div class="container">
            <div class="row">
                <div class="col-sm-12 col-md-10 col-md-offset-1">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th></th>
                                <th class="text-center">Price</th>
                                <th class="text-center">Total</th>
                                <th> </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <%
                                    //try{
                                    ArrayList<ComicBean> ShoppingCartList = (ArrayList<ComicBean>) request.getAttribute("ShoppingCartList");
                                    ArrayList<ComicBean> price = (ArrayList<ComicBean>) request.getAttribute("Price");
                                    //}catch(ex){};

                                    for (int i = 0; i < ShoppingCartList.size(); i++) {
                                        ComicBean c = ShoppingCartList.get(i);
                                        ComicBean p = price.get(i);
                                        out.println("<td class='col-sm-8 col-md-6'>");
                                        out.println("<div class='media'>");
                                        if (c.getCoverPage() != null) {
                                            out.println("<a class='thumbnail pull-left' href='#'> <image src='data:image/jpg;base64," + c.getCoverPage() + "' style='width: 72px; height: 72px;'/> </a>");
                                        } else {
                                            out.println("");
                                        }
                                        out.println("<div class='media-body'>");
                                        out.println("<h4 class='media-heading'><a href='#'>" + c.getName() + "</a></h4>");
                                        out.println("<h5 class='media-heading'> by <a href='#'>Brand name</a></h5>");

                                        if (p.getPrice() != 0) {
                                            out.println("<span>Status: </span><span class='text-success'><strong>In Stock</strong></span>");
                                            out.println("</div>");
                                            out.println("</div></td>");
                                            out.println("<td class='col-sm-1 col-md-1' style='text-align: center'>");
                                            out.println("<td class='col-sm-1 col-md-1 text-center'><strong>$" + p.getPrice() + "</strong></td>");
                                            out.println("<td class='col-sm-1 col-md-1 text-center'><strong>$" + p.getPrice() + "</strong></td>");
                                            totalPrice += p.getPrice();
                                        } else if (p.getPoint() != 0) {
                                            out.println("<span>Status: </span><span class='text-success'><strong>Ebook</strong></span>");
                                            out.println("</div>");
                                            out.println("</div></td>");
                                            out.println("<td class='col-sm-1 col-md-1' style='text-align: center'>");
                                            out.println("<td class='col-sm-1 col-md-1 text-center'><strong>" + p.getPoint() + "PT</strong></td>");
                                            out.println("<td class='col-sm-1 col-md-1 text-center'><strong>" + p.getPoint() + "PT</strong></td>");
                                            totalPoint += p.getPoint();
                                        }
                                        out.println("<td class='col-sm-1 col-md-1'><a href='ShoppingCart?action=remove&bookID=" + p.getProduct_Id() + "'><button type='submit'  class='btn btn-danger'><span class='glyphicon glyphicon-remove'></span> Remove</button></a></td></tr>");
                                    }
                                %>

                            <tr>
                                <td>   </td>
                                <td>   </td>
                                <td>   </td>
                                <td><h3>Total Price</h3></td>
                                <td class="text-right" ><h3><strong id="totalPrice"><%= totalPrice%></strong></h3></td>
                            </tr>
                            <tr>
                                <td>   </td>
                                <td>   </td>
                                <td>   </td>
                                <td><h3>Total PT</h3></td>
                                <td class="text-right" ><h3><strong id="totalPoint"><%= totalPoint%></strong></h3></td>
                            </tr>
                            <tr>
                                <td><strong>coupond : </strong>
                                    <select id="coupond">
                                        <option value="1"></option>
                                        <% 
                                            ArrayList cplist = (ArrayList) request.getAttribute("couponList");
                                            for(int i = 0; i<cplist.size();i++){
                                                if(cplist.get(i).equals("1"))
                                                    out.println("<option value='0.8'>80% off</option>");
                                                else if(cplist.get(i).equals("2"))
                                                    out.println("<option value='0.9'>90% off</option>");
                                            }
                                        %>
                                    </select>   
                                </td>
                                <td>   </td>
                                <td>   

                                </td>
                                <td>
                                    <button type="button" class="btn btn-default"><a href="Main.jsp">
                                            <span class="glyphicon glyphicon-shopping-cart"></span> Continue Shopping
                                        </a>

                                    </button></td>
                                <td>
                                    <button type="button" class="btn btn-success" id="BtnPay">
                                        Checkout <span class="glyphicon glyphicon-play"></span>
                                    </button></td>
                            </tr>
                        <div>
                            <div id="msgLayOut">
                                <div id="msgBox"></div>
                            </div>  
                            <div id="glassLayOut">
                                <div id="layout1">
                                    <div id="productDetails">
                                        <span id="pName"></span>
                                        <span id="priceL">Total Price : <strong id="PayTotalPrice"><%= totalPrice%></strong></span>
                                        <span id="extraPointL">Total Point : <strong id="PayTotalPoint"><%= totalPoint%></strong></span>
                                    </div>
                                    <div id="ConfirButton">
                                        <div id="cancel">Cancel</div>
                                        <div id="Confirm">Purchase</div>
                                    </div>
                                </div>
                            </div>

                            <div id="contentBoxPay"  style="width:52%;visibility: hidden">
                                <h4 style="text-align: center">Online Payment Service</h4>
                                <!--        <span>Select  one cards :</span>-->
                                <div id="cardList">
                                    <div><img src="images/payPal.jpg" alt=""></div>
                                    <div><img src="images/Master.jpg" alt=""></div>
                                    <div><img src="images/MasterTro.jpg" alt=""></div>
                                    <div><img src="images/Visa.png" alt=""></div>
                                    <div><img src="images/jcb.png" alt=""></div>
                                </div>
                                <div id="leftCon">
                                    <span id="fieldName"> Cards Numbers</span>
                                    <input type="text" class="form-control"  id="CardNum" maxlength="19">
                                    <span id="fieldName">Card owner</span>
                                    <input type="text" class="form-control"  id="CardName" maxlength="16" placeholder="e.g Wong Tai Man" maxlength="20">
                                    <div id="ed">
                                        <span id="fieldName">Due Date</span>
                                        <input type="text" class="form-control"  id="due"  style="text-align: center" placeholder="MM/DD" maxlength="5">
                                    </div>
                                    <span id="fieldName">Security Code</span>
                                    <input type="password" class="form-control"  id="Secode" style="text-align: center"  placeholder="* * *" maxlength="3">
                                </div>
                                <button id="paymentF">payment</button>
                                <button id="cancelF" data-dismiss="modal" >Cancel</button>


                            </div>
                        </div>
                        <script>
        $(document).ready(function () {
            $('#BtnPay').click(function (e) {
                if (e.target.tagName == "BUTTON") {
                    if(<%= totalPrice%> > 0){
                    $("#layout1").css({visibility: "visible"})
//                    Selected_ProductId = e.target.value;
//                    var product = getProductById(Selected_ProductId);
//                    if (product.getExtra() !== 0) {
//                        $("#extraPointL").text("(Extra " + product.getExtra() + "pt)");
//                    } else
//                        $("#extraPointL").text("")
                    $("#glassLayOut").show();

//                        return



                }
            }
            })
            $("#coupond").change(function () {
                $("#totalPoint").text(<%= totalPoint%> * $("#coupond").val());
                $("#totalPrice").text(<%= totalPrice%> * $("#coupond").val());
                $("#PayTotalPrice").text(<%= totalPrice%> * $("#coupond").val());
                $("#PayTotalPoint").text(<%= totalPoint%> * $("#coupond").val());
                $("#btnCheckout").attr("href", "ShoppingCart?action=Checkout&totalPrice=<%= totalPrice%>&totalPoint=<%= totalPoint%>");
            })
            $("#paymentF").click(function () {

                $("#contentBoxPay").css({top: "-480px"})
                $("#glassLayOut").hide();
                $("#contentBoxPay").css({visibility: "hidden"})
                setTimeout(function () {
                    $("#msgBox").html("<div id='titleS'>Payment Successful Message<div><div id='mainCon'>" + "Thank you for your purchase" + "<div><a href='ShoppingCart?action=Checkout&Discount= "+$("#coupond").val()+"&totalPrice="+<%= totalPrice%> * $("#coupond").val()+"&totalPoint="+<%= totalPoint%> * $("#coupond").val()+"' id='btnCheckout'><div id='closePayment'>OK<div></a>");

                }, 4000);
                $("#msgBox").html("<div id='msgLogo'><img src='images/load.svg'></div><span id='msg' >Your Request is handling</span>")
                totalPrice = totalPrice * $("#coupond").val();
                totalPoint = totalPoint * $("#coupond").val();
                
                $("#msgLayOut").show();

            })
            $("#cancelF").click(function () {
                $("#glassLayOut").hide();
                $("#contentBoxPay").css({visibility: "hidden"})
                
            })
        });
                        </script>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </body>
</html>
