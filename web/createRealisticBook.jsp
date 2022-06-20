<%-- 
    Document   : ComicWorkList
    Created on : 04-May-2021, 14:27:28
    Author     : law
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="css/createRealistic.css">
<script src="js/ImageTranslator.js"></script>

<body>

      <script>
            function createBundle(pid,bid ,coverURL,Name,price,type,stock,Status,Description) {
                this.pid = pid;
                this.bid = bid  ; 
                this.coverURL = coverURL ;
                this.Name = Name;
                this.price = price;
                this.stock = stock;  
                this.type = type;
                this.Status =Status;  
                this.Description = Description;                
                createComic.prototype.getbid =function(){return this.bid}
                createComic.prototype.getCoverURL=function(){return this.coverURL}
                createComic.prototype.getName =function(){return this.Name}
                createComic.prototype.getPrice = function(){return this.price}
                createComic.prototype.getStock = function(){return  this.stock}     
                createComic.prototype.getStatus = function(){return  this.Status}     
                
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
            var it =new ImageTranslator();
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
                $("#upCancel").click(function(){
                    
                     $("#glassUpdate").hide();
                    
                })
                
                $("#upUpdate").click(function(){
                    var str2 =$(".pItem").text()
                    
                    var  pid=str2.charAt(str2.length-1);
                    
                  
                    var str = $("#upPoint").val()+"-"+$("#upExtra").val()+"-"+ $("#upPrice").val()+"-"+pid;              
                    $.ajax({
                        url:"buyPointController",
                         type: "get",
                         data: {operation: "updateItem", data:str},    
                         success:function(){
                                 $("#glassUpdate").hide();
                                alert("The Poin item :"+pid+" is Updated");
                                refresh();                                                                                            
                         }
                    })
         
                })
                
                $("#Se").keydown(function(e){
                    var code = e.KeyCode | e.which
                
                    if( code ==8 && $(this).val().length==1 )//          
                        refresh();
                    
                })
                
                $("#go").click(function(){
                    var w = $("#Se").val();
                    if(w.charAt(0) !="#"){
                        alert("Wrong format")
                        return
                    }
                   $.ajax({
                        url:"ComicWorkController",
                         type: "get",
                         data: {operation: "search", data:w.substring(1)},    
                         success:function(res){
                
                                var item  = JSON.parse(res)
                               
                                if(item.length ==0){
                                        alert("NO Record(s) has been found");                                         
                                }
                               $("#point tbody").html("")
                                for(var s =0 ;s < item.length ;s++){
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
                    url: "ProductController",
                    type: "get",
                    data: {operation: "showAllRealistic"},
                    success: function (res) {
                        alert(res);
                        $("#point tbody").html("")
                        pointList = [];
                        var item = JSON.parse(res);
                        for (var s = 0; s < item.length; s++) {
                            $("#point tbody").append(create_pointLayout(item[s], s))
                        }
                        maxPage = getPageNumber();
                        alert(pointList.length)

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
                    $("#point tr").eq(s).find("td").css({"height": "150px", "paddingTop": "20px"})
                    $("#point tr").eq(s).find("td").eq(2).css({"paddingTop": "10px"})
                }
                $("#glass").hide();
                maxPage = Math.ceil($("#point tbody tr").length / maxIndex)
                setPAgeNumber(pageNo)
                $("#point tbody tr").hide();
                end = maxIndex;
                SliceShow();
            }



            function create_pointLayout(item, index) {
                var pid = item.pid
                var stock = item.stock;
                var price  = item.price ;
                var public = item.Public;
                var blob  = it.base64ToBlob(item.cover);
                var url  =it.ToObjectURL(blob);
                var name = item.name;
                var desc = item.desc;
                var type = item.type
                var issue =item.issue;
            
                public =(public == "T")?"treue":"false"
                       
             
//                var k  =  new createComic(cid ,url , Name, Author ,Schedule , Status . Responsor)
                
                
//                pointList.push(k);
                var str = "<tr id='" + item.pid+ "'>" +
                        "<td><input type='checkbox' onclick='addCheckList(" + item.pid + ")'></td>" +
                        "<td>"+item.pid + "</td>" +
                        "<td><img src='"+url+"'></td>"+                 
                        "<td>" + name + "</td>" +
                         "<td>" +item.type + "</td>" +
                        "<td>" + item.price + "</td>" +
                        "<td>" + item.stock + "</td>" +
                        "<td>" + public + "</td>" +
                        "<td>" + item.issue + "</td>" +                        
                        "<td>" +
                        "<i id='remove' class='far fa-trash-alt' onclick='removeItem(" + item.pid + ")' ></i>" +
                        "<i id='edit' class='fas fa-edit' onclick='updateItem(" + item.pid + ")'></i>" +
                        "</td>" +
                        "</tr>"

                return str;

            }

            function updateItem(pid) {
                 $("#glassUpdate").show();
                 $(".pItem").text("Update Item : #"+pid)
                 var p = getObjectById(pid);

                 $("#upPoint").val(p.getPoint())
                 $("#upExtra").val(p.getExtra())
                 $("#upPrice").val(p.getPrice())
                 
                 

            }
            
            function getObjectById(pid){
             
                for(var s = 0; s<pointList.length;s++){
            
                    if(pointList[s].getPid()==pid)
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
<div style="position: fixed;z-index:2104;width: 8%;height: 92vh;background: rgba(255,255,255,0.6);top:60px">
    <div id="left">
        <div id="itemCall" class="mangePoint">
            <div id="sideLogo"><img src="coin.svg" alt=""></div>
            <div id="sideDescription">Point List Mangement</div>
        </div>
        <div id="spLine"></div>
        <div id="itemCall">
            <div id="sideLogo"><img src="coin.svg" alt=""></div>
            <div id="sideDescription">Comic Work Maintance</div>
        </div>
        <div id="spLine"></div>
        <div id="itemCall"></div>
        <div id="spLine"></div>
        <div id="itemCall"></div>

    </div>
</div>
<div id="glass">
        <div id="f2">
        <span id="SetTitle">Create Item</span>
        <input type="text" style="margin-left: 40%"><button id="findBid" style="margin-left: 10px;background: #3b506b;border: none;color: white">Search</button>
        <div style="display: flex ;flex-direction: row">
        <div id="coverUpdateSet" style="margin-right: 40px"><img src="s9.jpg" alt=""></div>
        <div id="updateBox" style="">
            <div id="BookName" style="color: #2e2e30;font-size: 22px;font-family: AppleMyungjo;margin-bottom: 10px">Hallow World  Chapter 1-8 (MagaZine)</div>
            <span>Price</span>
            <input class="form-control" type="text" value="42" style="width: 40%;text-align: center;margin-bottom: 30px">
            <span>Stock</span>
            <input class="form-control" type="number" value="42"  style="width: 40%;text-align: center;margin-bottom: 20px">
            <span style="margin-right: 30px">Public</span>
            <input type="checkbox" name="True" ><span style="margin-left: 10px ;margin-right: 20px">True</span>
            <input type="checkbox" name="False" >
            <span style="margin-left: 10px" >False</span>
        </div>
        </div>


        <div id="bunSet">
            <button id="create">Comfirm</button>
            <button id="cancel">Cancel</button>
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
            <div><input type="text" id="Se"></div>
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
        <tr>
            <td><input type="checkbox"></td>
            <td>#1</td>
            <td><img src="sad.jpg" alt=""></td>
            <td>Barserker</td>
            <td>berusaruku</td>
            <td>Thursday</td>
            <td>Serialized</td>
            <td>Garylaw@gmail.com</td>
            <td>
                <i id="remove" class="far fa-trash-alt"></i>
                <i id="edit" class="fas fa-edit"></i>
            </td>
        </tr>
        <tr>
            <td><input type="checkbox"></td>
            <td>#1</td>
            <td><img src="sad.jpg" alt=""></td>
            <td>Barserker</td>
            <td>berusaruku</td>
            <td>Thursday</td>
            <td>Serialized</td>
            <td>Garylaw@gmail.com</td>
            <td>
                <i id="remove" class="far fa-trash-alt"></i>
                <i id="edit" class="fas fa-edit"></i>
            </td>
        </tr>
        <tr>
            <td><input type="checkbox"></td>
            <td>#1</td>
            <td><img src="sad.jpg" alt=""></td>
            <td>Barserker</td>
            <td>berusaruku</td>
            <td>Thursday</td>
            <td>Serialized</td>
            <td>Garylaw@gmail.com</td>
            <td>
                <i id="remove" class="far fa-trash-alt"></i>
                <i id="edit" class="fas fa-edit"></i>
            </td>
        </tr>
        <tr>
            <td><input type="checkbox"></td>
            <td>#1</td>
            <td><img src="sad.jpg" alt=""></td>
            <td>Barserker</td>
            <td>berusaruku</td>
            <td>Thursday</td>
            <td>Serialized</td>
            <td>Garylaw@gmail.com</td>
            <td>
                <i id="remove" class="far fa-trash-alt"></i>
                <i id="edit" class="fas fa-edit"></i>
            </td>
        </tr>







        </tbody>


    </table>
    <div id="btnPosition">
    </div>


</div>

</body>
</html>