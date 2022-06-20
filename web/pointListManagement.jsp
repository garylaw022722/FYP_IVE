<!DOCTYPE html>
<html lang="en">
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
    <link rel="stylesheet" href="css/PointManagement.css">
    <body>
        <script>
            function createPoint(point, Extra, Price, pid) {
                this.point = point;
                this.extra = Extra;
                this.price = Price;
                this.pid = pid;

                createPoint.prototype.setPrice = function (price) {
                    this.price = price;
                }
                createPoint.prototype.setExtra = function (extra) {
                    this.extra = extra;
                }
                createPoint.prototype.setPoint = function (price) {
                    this.point = point
                }
                createPoint.prototype.setPid = function (pid) {
                    this.pid = pid;
                }

                createPoint.prototype.getPrice = function () {
                    return this.price
                }
                createPoint.prototype.getExtra = function () {
                    return this.extra
                }
                createPoint.prototype.getPoint = function () {
                    return this.point;
                }
                createPoint.prototype.getPid = function () {
                    return this.pid;
                }

            }


        </script>
        <script>
            var pointList = [];
            var checkList = [];
            var removeClick;
            var addClick = 0;
            var maxIndex = 8;
            var start = 0;
            var focusIndex;
            var maxPage = getPageNumber();
            var pageNo = 1;
            var end = 0;
            var currentIndex = 0;
            $(document).ready(function () {
                refresh();


                // alert($("#point tbody tr").length)

                $("#edit").click(function () {

                    // alert("ksa")
                })
                $("#after").click(function () {

                    if (end === $("#point tbody tr").length || $("#point tbody tr").length <= 8) {
                        alert("No More result")
                        return
                    }
                    SliceHide()
                    start = end++;
                    end = (start + maxIndex);
                    setPAgeNumber(pageNo += 1);
                    checkNum();
                    SliceShow();
                })
                $("#cancel").click(function () {
                    $("#glass").hide();

                })

                $("#remove").click(function () {
                    alert("sa")

                })


                $("#create").click(function () {
                    var item = [];
                    var point, extra, price;
                    for (var k = 0; k < $("#newPointTable tbody tr").length; k++) {
                        point = $("#newPointTable tbody tr").eq(k).find("#nMainPoint").val();
                        extra = $("#newPointTable tbody tr").eq(k).find("#nExtra").val();
                        price = $("#newPointTable tbody tr").eq(k).find("#nPrice").val();

                        if (point !== "" && price !== "") {
                            item.push(new createPoint(point, extra, price, null));
                        }
                    }
                    alert(JSON.stringify(item));
                    $.ajax({
                        url: "buyPointController",
                        type: "get",
                        data: {operation: "createItem", str: JSON.stringify(item)},
                        success: function (res) {
                            $("#glass").hide();

                            refresh();

                            alert(item.length + " Point Item is created")
                        }




                    })

                })
                $("#newPointTable tbody").click(function (e) {
                    if ($(this).find("tr")) {
                        if (e.target.tagName == "INPUT")
                            focusIndex = $(e.target).prop("alt")
                        // alert(focusIndex)
                        // alert($(e.target).prop("alt"))
                        //         alert($("#newPointTable tbody tr").length)
                    }

                })

                $("#RemoveAll").click(function () {


                })


//                $()
                $("#addRow").click(function () {
                    addClick++;

                    var str = (addClick % 2 !== 0) ?
                            "<tr id='" + addClick + "' style='background: white'>" :
                            "<tr id='" + addClick + "' style='background: rgb(238,240,241)'>"


                    str += "<td><input type='text' maxlength='5' id='nMainPoint' alt='" + addClick + "'></td>" +
                            "<td><input type='text' maxlength='4' id='nExtra' alt='" + addClick + "'></td>" +
                            "<td><input type='text' maxlength='3' id='nPrice' alt='" + addClick + "'></td>" +
                            "</tr>"
                    $("#newPointTable").append(str);

                })

                $("#removeRow").click(function () {
                    if (focusIndex != null) {
                        var sa = $("#newPointTable tbody tr").eq(getIndex(focusIndex));
                        sa.remove();
                        focusIndex == null;
                    } else {
                        var n = $("#newPointTable tbody tr");
                        n.eq(n.length - 1).remove();
                    }
                    // addClick -=1;

                })
                $("#NewItem").click(function () {
                    $("#glass").show();
                })


                $("#before").click(function () {

                    if (start == 0) {
                        alert("No any previous page result");
                        return
                    }
                    setPAgeNumber(pageNo -= 1);
                    SliceHide();
                    // alert(end);
                    if (end % maxIndex != 0) {
                        start = end - maxIndex - (end % maxIndex);
                        end = end - (end % maxIndex)
                    } else {
                        end = start
                        start = end - maxIndex
                    }

                    SliceShow();


                })

                $("#RemoveAll").click(function () {

                    $.ajax({
                        url: "buyPointController",
                        type: "get",
                        data: {operation: "removeAll", removeList: checkList.toString()},
                        success: function () {
                            refresh();
                            alert(checkList.length + " record(s) has been removed");
                        }

                    })
                })
                $("#upCancel").click(function () {

                    $("#glassUpdate").hide();

                })

                $("#upUpdate").click(function () {
                    var str2 = $(".pItem").text()

                    var pid = str2.charAt(str2.length - 1);


                    var str = $("#upPoint").val() + "-" + $("#upExtra").val() + "-" + $("#upPrice").val() + "-" + pid;
                    $.ajax({
                        url: "buyPointController",
                        type: "get",
                        data: {operation: "updateItem", data: str},
                        success: function () {
                            $("#glassUpdate").hide();
                            alert("The Poin item :" + pid + " is Updated");
                            refresh();
                        }
                    })

                })

                $("#Se").keydown(function (e) {
                    var code = e.KeyCode | e.which

                    if (code == 8 && $(this).val().length == 1)//          
                        refresh();

                })

                $("#go").click(function () {
                    var w = $("#Se").val();
                    if (w.charAt(0) != "#") {
                        alert("Wrong format")
                        return
                    }
                    $.ajax({
                        url: "buyPointController",
                        type: "get",
                        data: {operation: "search", data: w.substring(1)},
                        success: function (res) {

                            var item = JSON.parse(res)

                            if (item.length == 0) {
                                alert("NO Record(s) has been found");
                            }
                            $("#point tbody").html("")
                            for (var s = 0; s < item.length; s++) {
                                $("#point tbody").append(create_pointLayout(item[s], s));
                            }
                            init();


                        }
                    })




                })





            })

            function getIndex(u) {
                for (var s = 0; s < $("#newPointTable tbody tr").length; s++) {
                    var w = $("#newPointTable tbody tr").eq(s);
                    if (w.prop("id") === u) {
                        return s;
                    }
                }

                return null;
            }

            function SliceShow() {
                $("#point tbody tr").slice(start, end).show();
            }

            function SliceHide() {
                $("#point tbody tr").slice(start, end).hide();
            }

            function getPageNumber() {
                var number = $("#point tbody tr").length / maxIndex;
                return Math.ceil(number)
            }

            function checkNum() {
                if (end > $("#point tbody tr").length) {
                    end = $("#point tbody tr").length;
                }

            }

            function getAddRowIndex(index) {
                focusIndex = index;


                // alert(index)

            }


            function addCheckList(id) {
                if (checkList.includes(id))
                    checkList = removeCheckItem(id);
                else
                    checkList.push(id);
            }


            function  removeCheckItem(id) {
                var emptyList = []
                for (var s = 0; s < checkList.length; s++) {
                    if (checkList[s] != id)
                        emptyList.push(checkList[s]);
                }

                return  emptyList;
            }







            function setPAgeNumber(pageNum) {
                $("#pageNumber").text("page " + pageNum + " / " + maxPage)

            }

            function refresh() {

                $.ajax({
                    url: "buyPointController",
                    type: "get",
                    data: {operation: "showList"},
                    success: function (res) {
                        $("#point tbody").html("")
                        pointList = [];
                        var item = JSON.parse(res);
                        for (var s = 0; s < item.length; s++) {
                            $("#point tbody").append(create_pointLayout(item[s], s))
                        }
                        maxPage = getPageNumber();

                        init();


                    }

                })


            }



            function init() {
                $("#glassUpdate").hide();
                checkList = [];
                removeClick = 0;
                addClick = 0;
                maxIndex = 8;
                start = 0;
                focusIndex = 0;
                pageNo = 1;
                end = 0;
                $("#newPointTable tbody tr").slice(1).html("")
                $("#nMainPoint").val("")
                $("#nExtra").val("")
                $("#nPrice").val("")

                $("tr:even").css("backgroundColor", "white");
                $("tr:odd").css("background-color", "rgb(238,240,241)");
                for (var s = 1; s < $("#point tr").length; s++) {
                    $("#point tr").eq(s).find("td").css({"height": "60px", "paddingTop": "20px"})
                }
                $("#glass").hide();
                maxPage = Math.ceil($("#point tbody tr").length / maxIndex)
                setPAgeNumber(pageNo)
                $("#point tbody tr").hide();
                end = maxIndex;
                SliceShow();
            }



            function create_pointLayout(item, index) {
                pointList.push(new createPoint(item.point, item.extraPoint, item.price, item.pid));
                var str = "<tr id='" + item.pid + "'>" +
                        "<td><input type='checkbox'  onclick='addCheckList(" + item.pid + ")'></td>" +
                        "<td>#" + item.pid + "</td>" +
                        "<td>" + item.point + "pt</td>" +
                        "<td>" + item.extraPoint + "pt</td>" +
                        "<td>$" + item.price + "</td>" +
                        "<td>" +
                        "<i id='remove' class='far fa-trash-alt' onclick='removeItem(" + item.pid + ")' ></i>" +
                        "<i id='edit' class='fas fa-edit' onclick='updateItem(" + item.pid + ")'></i>" +
                        "</td>" +
                        "</tr>"

                return str;

            }

            function updateItem(pid) {
                $("#glassUpdate").show();
                $(".pItem").text("Update Item : #" + pid)
                var p = getObjectById(pid);

                $("#upPoint").val(p.getPoint())
                $("#upExtra").val(p.getExtra())
                $("#upPrice").val(p.getPrice())



            }

            function getObjectById(pid) {

                for (var s = 0; s < pointList.length; s++) {

                    if (pointList[s].getPid() == pid)
                        return pointList[s];

                }

                return null;
            }

            function removeItem(pid) {
                alert(pid)
                $.ajax({
                    url: "buyPointController",
                    type: "get",
                    data: {operation: "removeItem", pointId: pid},
                    success: function (res) {
                        refresh();
                    }
                })
            }



        </script>
        <style>
            #glassUpdate{
                background: rgba(0, 0, 0, 0.03);
                width: 100%;
                height: 100%;
                position: fixed;
                z-index: 3000;
            }
            #uBox{
                width: 40%;
                height: 240px;
                z-index: 3001;
                top: 140px;
                left: 30%;
                position: absolute;
                box-shadow: 1px 2px 10px   #3f4748;
                background: rgba(255, 255, 255, 0.9);
            }
            #updateTable{
                margin-left:60px;
                margin-top: 10px;
            }


            #btnSetUp button{
                margin-top: 50px;
                float: right;     
                background: #dcdcdc;
                border:none;
                border-radius :2px;
                padding: 3px 10px;
            }
            #upUpdate{
                margin-left: 20px;
                margin-right: 70px;
            }




        </style>
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
                        <div id="sideLogo"><img src="images/open-book.svgg" alt=""></div>
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
        <div id="glass">
            <div id="f2">
                <span id="SetTitle">New Item</span>
                <button id="addRow">Add Row</button>
                <button id="removeRow">Remove Row</button>
                <table id="newPointTable">
                    <thead>
                        <tr>
                            <th>Main Point</th>
                            <th>Extra Point</th>
                            <th>Price (HKD)</th>
                        </tr>
                    <thead>
                    <tbody>
                        <tr id="0">
                            <td><input type="text" id="nMainPoint" alt="0" maxlength="5"></td>
                            <td><input type="text" id="nExtra" alt="0" maxlength="4"></td>
                            <td><input type="text" id="nPrice" alt="0" maxlength="3"></td>
                        </tr>
                    </tbody>
                </table>
                <div id="bunSet">
                    <button id="create">Create</button>
                    <button id="cancel">Cancel</button>
                </div>
            </div>
        </div>


        <div id="glassUpdate">
            <div id="uBox">
                <span id="SetTitle" class="pItem"   style="margin-top:10px; margin-left: 10px;"></span><br>
                <table id="updateTable" >
                    <thead>
                        <tr>
                            <th>Main Point</th>
                            <th>Extra Point</th>
                            <th>Price (HKD)</th>
                        </tr>
                    <thead>
                    <tbody>
                        <tr id="0">
                            <td><input type="text" id="upPoint" alt="0" maxlength="5"></td>
                            <td><input type="text" id="upExtra" alt="0" maxlength="4"></td>
                            <td><input type="text" id="upPrice" alt="0" maxlength="3"></td>
                        </tr>
                    </tbody>

                </table>
                <div id="btnSetUp">
                    <button id="upUpdate">Update</button>
                    <button id="upCancel">Cancel</button>
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
        <div id="Content">
            <div id="toolBar">
                <div id="pageNav">
                    <div><input type="text" id="Se" placeholder="# point id"></div>
                    <div>
                        <button id="go">Search</button>
                    </div>
                    <div><span id="pageNumber">0</span></div>
                    <button id="before"><i class="bi bi-chevron-left"></i></button>
                    <button id="after"><i class="bi bi-chevron-right"></i></button>
                    <button id="RemoveAll">Remove All</button>
                    <button id="NewItem">+New Item</button>
                </div>
            </div>


            <table class="table" style="border: none" id="point">
                <thead>
                    <tr>
                        <th style="width: 80px;"></th>
                        <th scope="col" style="width:230px">#Point List ID</th>
                        <th scope="col">Main Point</th>
                        <th scope="col" style="width: 100px;">Extra Point</th>
                        <th scope="col" style="width: 200px">Price (HKD)</th>
                        <th scope="col">Opreation</th>
                    </tr>
                </thead>
                <tbody>



                </tbody>


            </table>
            <div id="btnPosition">
            </div>


        </div>

    </body>
</html>