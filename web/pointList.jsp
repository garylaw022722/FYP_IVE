<%-- 
    Document   : pointList
    Created on : Jan 23, 2021, 4:27:20 PM
    Author     : law
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ict.bean.Account" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>    
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

        <link rel="stylesheet" href="css/pointList.css">
        <!--<link rel="stylesheet" href="css/memberNav2.css">-->
    </head>

    <style>
        body {
            margin: 0;
            padding: 0;
        }

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

        var ProductList = [];
        var Selected_ProductId;
        var newPoint;


        function Product(pid, point, price, extra) {
            this.pid = pid;
            this.point = point;
            this.price = price;
            this.extra = extra;

            Product.prototype.getPrice = function () {
                return this.price;

            }
            Product.prototype.getPid = function () {
                return this.pid;

            }
            Product.prototype.getPoint = function () {

                return this.point;
            }
            Product.prototype.getExtra = function () {
                return this.extra;
            }
        }

        $(document).ready(function () {
            var cu = '<%=user%>';
            InitialPriceList();
            $("#glassLayOut").hide();
            $("#msgLayOut").hide();




            function  InitialPriceList() {

                $.ajax({
                    url: "buyPointController",
                    type: "get",
                    data: {"operation": "init"},
                    success: function (res) {
                        var item = JSON.parse(res);
                        var str = "";
                        $('#pt').text(item[0].remainingPoint);
                        for (var j = 1; j < item.length; j++)
                            str += createListView(item[j].price, item[j].pid, item[j].extraPoint, item[j].point);
                        $('tbody').append(str);
                    }

                })

            }

            $('tbody').click(function (e) {
                if (e.target.tagName == "BUTTON") {
                    $("#layout1").css({visibility: "visible"})
                    Selected_ProductId = e.target.value;
                    var product = getProductById(Selected_ProductId);
                    $("#pName").text("Selected Product : " + product.getPoint() + "pt")
                    $("#priceL").text("Price :  $" + product.getPrice() + " HKD");
                    if (product.getExtra() !== 0) {
                        $("#extraPointL").text("(Extra " + product.getExtra() + "pt)");
                    } else
                        $("#extraPointL").text("")
                    $("#glassLayOut").show();

//                        return



                }

            })

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
                if(cu !== ''){
                $("#layout1").css({visibility: "hidden"})
                $("#contentBoxPay").css({visibility: "visible"}).animate({top: "+=520px"}, 600)
                }else{
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



            $("#paymentF").click(function () {

                $("#contentBoxPay").css({top: "-480px"})
                $("#glassLayOut").hide();
                $("#contentBoxPay").css({visibility: "hidden"})
                payment(Selected_ProductId);
                $("#msgBox").html("<div id='msgLogo'><img src='images/load.svg'></div><span id='msg' >Your Request is handling</span>")


                $("#msgLayOut").show();

            })

            $("#cancelF").click(function () {
                $("#glassLayOut").hide();
                $("#contentBoxPay").css({visibility: "hidden"})

            })



            function payment(productId) {

                $.ajax({
                    url: "buyPointController",
                    type: "get",
                    data: {operation: "buyPoint", pid: productId},
                    success: function (res) {

                        newPoint = JSON.parse(res);

//                         $("#msgLayOut").hide() 
                        var pd = getProductById(Selected_ProductId)
                        var str = "Product : " + pd.getPoint() + "pt has been purchased "
                        setTimeout(function () {
                            $("#msgBox").html("<div id='titleS'>Payment Successful Message<div><div id='mainCon'>" + str + "<div><div id='closePayment'>OK<div>");

                        }, 4000);


                    }
                })



            }


            function createListView(price, pid, extraPoint, Point) {
                var product = new Product(pid, Point, price, extraPoint)
                ProductList.push(product);

                var str = "<tr><td style='padding: 10px;width:30%; height:80px; padding-top:25px ;'><div id='coin'>" +
                        "<img src='images/coin.svg'></div><span id='point'>" + Point + "pt</span></td>";

                if (extraPoint != 0)
                    str += "  <td style='width:55%;padding-top:25px'>extra point : " + extraPoint + "pt</td>"
                else
                    str += "<td style='width:55%'></td>"
                str += "<td><button id='price'  value='" + pid + "' >$" + price + " HKD</button></td></tr>"
                return str
            }



            function getProductById(id) {
                for (var s = 0; s < ProductList.length; s++) {
                    var pd = ProductList[s];
                    if (pd.pid == id)
                        return pd;
                }
            }















        })


    </script>
    <body>
        <div id="msgLayOut">
            <div id="msgBox"></div>
        </div>  
        <div id="glassLayOut">
            <div id="layout1">
                <div id="productDetails">
                    <span id="pName"></span>
                    <span id="priceL"></span>
                    <span id="extraPointL"></span>
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
    <%@include file="CDN.jsp" %>
    <jsp:include page="parts/memberNav2.jsp"/>
    <div id="conRemain" style=""><h3>Point Remain: <span id="pt"></span>pt </h3></div>
    <div id="pointList" style="top:160px">
        <table id="tb" class="table">
            <thead></thead>
            <tbody>

            </tbody>
        </table>

    </div>




</body>
</html>
