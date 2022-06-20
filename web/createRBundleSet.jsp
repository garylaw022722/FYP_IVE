<%-- 
    Document   : createRBundleSet
    Created on : 2021/5/5, 上午 12:00:54
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ict.bean.CreateBundle" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Title</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">
    </head>
    <script src="https://cdn.jsdelivr.net/npm/vanilla-lazyload@17.3.1/dist/lazyload.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/createRealistic.css">


    <script>
        $(document).ready(function () {
            $("#findBid").click(function () {
                var findbid = $("#serachBid").val();
                $.ajax({
                    type: "get",
                    datatype: "json",
                    data: {bid: "findbid"},
                    url: "createRBundle?action=search&bid=" + findbid + "",
                    success: function (data) {
                        var json = JSON.parse(data);
                        alert(json.BundleDetail.length);
                        $("#coverUpdateSet").html("<img src='data:image/jpg;base64," + json.BundleDetail[0].CoverPage + "'>");
                        $("#BookName").text(json.BundleDetail[0].Name);
                        $("#bid").val(json.BundleDetail[0].bid);
                        $("#hiddenbid").val(json.BundleDetail[0].bid);
                    }
                })
            });
            $("#glass").hide();

            $("#NewItem").click(function () {
                $("#glass").show();
            });
            $("#cancel").click(function () {
                $("#glass").hide();
            });


            $(".glass2").hide();
            $(".edit").each(function (key, value) {
                $(this).click(function () {
                    $(".glass2").each(function (chi, value) {
                        if (key === chi) {
                            $(this).toggle();
                        }
                    });
                });
            });


        });
    </script>
    <%
        CreateBundle cb = (CreateBundle) request.getAttribute("cb");
    %>

    <body>
        <div style="position: fixed;z-index:2104;width: 8%;height: 92vh;background: rgba(255,255,255,0.6);top:60px">
            <div id="left">
                <div id="itemCall" class="mangePoint">
                    <a href="pointListManagement.jsp">
                        <div id="sideLogo"><img src="images/coin.svg" alt=""></div>
                        <div id="sideDescription">Point List Mangement</div>
                    </a>
                </div>
                <div id="spLine"></div>
                <div id="itemCall">
                    <div id="sideLogo"><img src="images/coin.svg" alt=""></div>
                    <div id="sideDescription">Comic Work Maintance</div>
                </div>

                <div id="spLine"></div>
                <div id="itemCall">
                    <a href="videoUpload.jsp">
                        <div id="sideLogo"><img src="images/videoUpload.svg" alt=""></div>
                        <div id="sideDescription">Video Upload</div>
                    </a>
                </div>
                <div id="spLine"></div>
                <div id="itemCall">
                    <a href="createRBundle?action=all">
                    <div id="sideLogo"><img src="images/open-book.svg" alt=""></div>
                    <div id="sideDescription">Create Realistric Book</div>
                    </a>
                </div>
                                <div id="spLine"></div>
                <div id="itemCall">
                    <a href="Voting?action=Product">
                        <div id="sideLogo"><img src="images/open-book.svg" alt=""></div>
                        <div id="sideDescription">Create Electric Book</div>
                    </a>
                </div>
                
                <div id="spLine"></div>
                <div id="itemCall">
                    <a href="login2?action=logout">
                        <div id="sideLogo"><img src="images/logout.svg" alt=""></div>
                        <div id="sideDescription">Logout</div>
                    </a>
                </div>

            </div>
        </div>

        <div id="StaffNav"></div>
        <!--<div id="classifier">-->
        <!--    <div style="margin-left: 20px">Create Bundle Set</div>-->
        <!--    <div>Point List Management</div>-->
        <!--    <div>Inventory Management</div>-->
        <!--    <div>Comic Works Maintanece</div>-->
        <!--    <div>Episode Sales</div>-->
        <!--</div>-->
        <div id="Content" >
            <div id="toolBar">
                <div id="pageNav">
                    <form action="createRBundle" method="get">
                        <div>
                            <input type="hidden" name="action" value="searchKey">
                            <input type="text" id="Se" name="key">
                            <input type="submit" id="go" value="Search">
                        </div>

                    </form>
                    <div><span id="pageNumber">0</span></div>
                    <button id="before"><i class="bi bi-chevron-left"></i></button>
                    <button id="after"><i class="bi bi-chevron-right"></i></button>
                    <button id="RemoveAll">Remove All</button>
                    <button id="NewItem">+New Item</button>
                </div>
            </div>


            <div id="glass">
                <div id="f2">
                    <span id="SetTitle">Create Item</span>
                    <input type="text" style="margin-left: 40%" name="serachBid" id="serachBid"><button id="findBid" style="margin-left: 10px;background: #3b506b;border: none;color: white">Search</button>
                    <div style="display: flex ;flex-direction: row">
                        <div id="coverUpdateSet" style="margin-right: 40px"></div>
                        <div id="updateBox" style="">
                            <form action="createRBundle" method="get">
                                <input type="hidden" name="action" value="insertProduct">
                                <div id="BookName" style="color: #2e2e30;font-size: 22px;font-family: AppleMyungjo;margin-bottom: 10px"></div>
                                <span>Bid</span>
                                <input class="form-control" type="text" value="" style="width: 40%;text-align: center;margin-bottom: 30px" id="bid" disabled="">
                                <input type="hidden" value="" id="hiddenbid" name="hiddenbid">
                                <span>Price</span>
                                <input class="form-control" type="text" value="42" style="width: 40%;text-align: center;margin-bottom: 30px" name="Insertprice">
                                <span>Stock</span>
                                <input class="form-control" type="number" value="42"  style="width: 40%;text-align: center;margin-bottom: 20px" name="InsertStock">
                                <span style="margin-right: 30px">Public</span>
                                <span style="margin-left: 10px ;margin-right: 20px">
                                    <select id="Insertpublic" class="form-control" style="width: 40%;text-align: center;margin-bottom: 20px" name="Insertpublic">
                                        <option value="T">True</option>
                                        <option value="F">False</option>
                                    </select></span>
                                <div id="bunSet">
                                    <input type="submit" id="create" value="Comfirm">
                                </div>
                            </form>
                            <button id="cancel">cancel</button>
                        </div>

                    </div>


                </div>

            </div>






            <table class="table" style="border: none" id="point">
                <thead>
                    <tr>
                        <th style="width: 80px;"></th>
                        <th scope="col" style="width:130px">#Prodouct ID</th>
                        <th scope="col" style="width: 150px">Cover Page </th>
                        <th scope="col" style="width: 150px;">Name</th>
                        <th scope="col" style="width: 150px">Type</th>
                        <th scope="col" style="width: 100px">Price</th>
                        <th scope="col" style="width: 60px">Stock</th>
                        <th scope="col" style="width: 200px">Status</th>
                        <th scope="col">Issue Date</th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <% for (CreateBundle ccb : cb.getOList()) {%>
                    <tr> 
                        <td><input type="checkbox"></td>
                        <td><%=ccb.getProduct_id()%></td>
                        <td><img src="data:image/jpg;base64,<%=ccb.getBase64Image()%>" alt="" style="width: 100px;height: 70px;"></td>
                        <td><%=ccb.getName()%></td>
                        <td><%=ccb.getType()%></td>
                        <td><%=ccb.getPrice()%></td>
                        <td><%=ccb.getStock()%></td>
                        <td><%=ccb.getPublic()%></td>
                        <td><%=ccb.getStartDate()%></td>
                        <td>
                            <a href="createRBundle?action=Delete&productID=<%=ccb.getProduct_id()%>"><i id="remove" class="far fa-trash-alt remove"></i></a>
                            <i id="edit" class="fas fa-edit edit"></i>
                        </td>

                    </tr>

                <div id="glass2" class="glass2">
                    <div id="f2">
                        <span id="SetTitle">Create Item</span>
                        <div style="display: flex ;flex-direction: row">
                            <div id="coverUpdateSet" style="margin-right: 40px"><img src="data:image/jpg;base64,<%=ccb.getBase64Image()%>"></div>
                            <div id="updateBox" style="">
                                <form action="createRBundle" method="get">
                                    <input type="hidden" name="action" value="UpdateProduct">
                                    <div id="BookName" style="color: #2e2e30;font-size: 22px;font-family: AppleMyungjo;margin-bottom: 10px"></div>
                                    <span>ProductID</span>
                                    <input class="form-control" type="text" value="<%=ccb.getProduct_id()%>" style="width: 40%;text-align: center;margin-bottom: 30px"  disabled="">
                                    <input type="hidden" value="<%=ccb.getProduct_id()%>" id="" name="UpdateproductID">
                                    <span>Price</span>
                                    <input class="form-control" type="text" value="<%=ccb.getPrice()%>" style="width: 40%;text-align: center;margin-bottom: 30px" name="Updateprice">
                                    <span>Stock</span>
                                    <input class="form-control" type="number" value="<%=ccb.getStock()%>"  style="width: 40%;text-align: center;margin-bottom: 20px" name="UpdateStock">
                                    <span style="margin-right: 30px">Public</span>
                                    <span style="margin-left: 10px ;margin-right: 20px">
                                        <select id="Insertpublic" class="form-control" style="width: 40%;text-align: center;margin-bottom: 20px" name="Updatepublic">
                                            <%if (ccb.getPublic().equals("T")) {%>
                                            <option value="T" selected>True Selected</option>
                                            <option value="F">False</option>
                                            <%} else {%>
                                            <option value="T">True</option>
                                            <option value="F" selected>False Selected</option>
                                            <%}%>
                                        </select></span>
                                    <div id="bunSet">
                                        <input type="submit" id="create" value="Comfirm">
                                    </div>
                                </form>
                            </div>

                        </div>


                    </div>

                </div>
                <%}%>







                </tbody>


            </table>
            <div id="btnPosition">
            </div>


        </div>
    </body>
</html>
