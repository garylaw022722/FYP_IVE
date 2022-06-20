<%@page import="ict.bean.ComicTypeBean"%>
<%@page import="ict.db.ComicTypeDB"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Customer Book Panel</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">
        <link rel="stylesheet" href="css/CustombookPanel.css">

        <script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.10.2/Sortable.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">

        <script src="js/ImageTranslator.js"></script>
        <script src="js/ComicPageSelection.js"></script>
    </head>

    <script>
        var date;
        var selectedComic;
        var selectedChapter;
        var it = new ImageTranslator();
        var comicObjectList = [];
        var pageSelection = [];
        var btnCustom = false;
        var btnSearch = true;
        var comicType = [];
        var json = {};
        json.pageCode = [];
        json.sequence = [];




        function pageScreen(index) {
            var code = "." + selectedComic + "-" + selectedChapter + "-" + index
            

            if (pageSelection.includes(code)) {

                pageSelection = removeformTheList(code);
                $(code).find("#Pages").css({"box-shadow": " 1px 2px 10px rgba(0,0,0,0.05)"})

            } else {
                pageSelection.push(code);
                onclickPages = code;
                $(code).find("#Pages").css({"box-shadow": "1px 2px 15px #8eeaea"})
            }
  
        }


        function showChapterList(cid) {
            selectedComic = cid;
            var comicName = getObjectById(cid);
            $("#MainSearch").css({color: " #98a3ac"});
            $("#extend1").show()
            $("#extend2").hide();
            $("#select").hide();
            $("#SelectedEpisode").hide()
            $("#SelectedComic").text(comicName).css({color: "#3b506b"})
            $("#SelectedComic").show();


            getPurchasedChapter();

        }

        function showPages(ep) {
            selectedChapter = ep;
            $("#PageSet").html("");
            $("#chapterResultSet").hide()
            $("#SelectedComic").css({color: " #98a3ac"});
            $("#extend2").show()
            $("#SelectedEpisode").text("Episode " + ep).css({color: "#3b506b"}).show();
            $("#PageSet").show();
            $("#glass").show();
            $("#zoom").show();
            $("#select").show();
            $.ajax({
                url: "SearchingEngine",
                type: "get",
                data: {
                    operation: "createCustomBook",
                    cid: selectedComic,
                    ep: selectedChapter
                }, success: function (res) {

                    var item = JSON.parse(res);
                    var str = "";
                    var cm = item[2].comicName
                    var title = item[3].title;

                    var codeKey = item[1].code;
                    var sources = item[0].sourcesCopy;
                    for (var k = 0; k < sources.length; k++) {
                        var str = createPageLayout(sources[k], title, cm, k, codeKey);

                        $("#PageSet").append(str);

                    }
                    $("#glass").hide();
                }

            })

        }







        $(document).ready(function () {
            var el = document.getElementById('container');
            var sortable = Sortable.create(el, {
                group: "grid",
                onEnd: function (/**Event*/evt) {
                    var s = evt.oldIndex; // element's old index within old parent
                    var k = evt.newIndex; // element's new index within new parent
                  
                }
            })

            startUp();
            getAllPurchased();
            navshow()
            fieldColor("Searcher", btnSearch);
            $("#createCustom").hide();
            $("#select").hide();
            $("#glassZoom").hide();

            $("#select").click(function () {
                for (var s = 0; s < pageSelection.length; s++) {
                    var page = $(pageSelection[s]);
                    page.find("#Pages").css({"box-shadow": " 1px 2px 10px rgba(0,0,0,0.05)"})
                    var item = "<div id='items'>" + page.html() + "</div>"
                    $("#container").append(item);

                }
                pageSelection = [];



            })

            $("#zoom").click(function () {
                var ks = $(pageSelection[ pageSelection.length - 1]).find("img").prop("src")
                $("#glassZoom").find("img").prop("src", ks)
                $("#glassZoom").show()


            })

            $("#closeZoom").click(function () {
                $("#glassZoom").hide();


            })

            $("#Searcher").click(function () {
                btnSearch = true;
                btnCustom = false;
                $("#createCustom").hide();
                fieldColor("Searcher", btnSearch);
                fieldColor("Custom", btnCustom);
                if ($("#SearchBookPanel").hide()) {
                    $("#container").hide()
                    $("#SearchBookPanel").show();
                }
            })

            $("#Custom").click(function () {
                btnSearch = false;
                btnCustom = true;
                $("#createCustom").show();
                fieldColor("Searcher", btnSearch);
                fieldColor("Custom", btnCustom);

                if ($("#container").hide()) {
                    $("#SearchBookPanel").hide();
                    $("#container").show();
                }
            })




            $("#SelectedComic").click(function () {
                setColor("SelectedComic");
                $("#SearchPage").hide();
                $("#PageSet").hide();
                $("#select").hide()
                $("#zoom").hide()
                $("#chapterResultSet").show();
            })


            $("#SelectedEpisode").click(function () {
                setColor("SelectedEpisode");

                $("#SearchPage").hide();
                $("#PageSet").show();
                $("#select").show()
                $("#zoom").show()
                $("#chapterResultSet").hide();
            })




            $("#MainSearch").click(function () {
                $("#SearchPage").show()
                $("#chapterResultSet").hide()
                $("#select").hide()
                $("#zoom").hide()
                $("#PageSet").hide();
                setColor("MainSearch")

            })

            $("input[name='comicType']").click(function () {
                var w = $(this).val()

                if ($(this).prop("checked"))
                    comicType.push(w);
                else
                    comicType = removeItem(w)


                searchBook();

            })
//            $("#SelectedEpisode").click(function () {
//                $("#chapterResultSet").hide()
//                $("#SearchPage").hide();
//                $("#PageSet").show();
//
//            })

            $("#createCustom").click(function () {
                if ($("#container div").length < 1) {
                    alert("No any page Selected")
                    return;
                }
                $("#glassCreate").show();


            })

            $("#close").click(function () {
                $("#glassCreate").hide();

            })

            $("#coverPage").change(function () {
                $("#fileName").text($("#coverPage")[0].files[0].name)



            })
            $("#createBook").click(function () {

//                $("#fileName").text($("#coverPage")[0].files[0].name)
                var key = filterComicSession();

                for (var w = 0; w < key.length; w++) {
                    var obj = new ComicPageSelection(key[w]);
                    obj.setComicPage(identifyComicPage(key[w]));
                    json.pageCode.push(obj);
                }
                getSequenceNumber();

                var jsonString = JSON.stringify(json)
                var formData = new FormData();
                formData.append("coverPage", $("#coverPage")[0].files[0]);
                formData.append("jsonString", jsonString);
                formData.append("bookName", $("#cbName").val());

//                alert(jsonString);

                $("#glassCreate").hide();
                $("#container").html("")
                $("#cbName").val("");
                $("#fileName").text("");
                $("#title").text("The book is creating....")
                $("#glass").show();

                $.ajax({
                    type: "post",
                    url: "texting",
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function (res) {
                           $("#glass").hide();
                           $("#title").text("The page is prepared")
                           $("#Searcher").trigger("click")
                           $("#MainSearch").trigger("click")
                           alert("YOu file has been uploaded")
                           

                    }

                })
            })


            $("input[name=payTime]").click(function () {
                var val = $(this).val();
                $("input[type=date]").val("")
                lockedDown(val)
                if (val == "others") {
                    $("#dateSet input").prop("disabled", false);

                } else
                    $("#dateSet input").prop("disabled", true);

                searchBook();
            })
            $("#start,#before").change(function () {
                searchBook();
            })

            $("#find").click(function () {

                searchBook();
            })






        })

        function startUp() {
            $("#container").hide();
            $("#chapterResultSet").hide();
            $("#dateSet input").prop("disabled", true);
            $("#PageSet").hide();
            $("#glass").hide();
            $("#glassCreate").hide();
            $("#zoom").hide();
        }


        function removeItem(val) {
            var arr = []
            for (var s = 0; s < comicType.length; s++) {

                if (comicType[s] !== val)
                    arr.push(comicType[s])
            }
            return arr;

        }
        function  showRemove() {
            var str = "The sTring is ";

            for (var k = 0; k < comicType.length; k++) {
                var unit = "-"
                if (k == comicType.length - 1)
                    unit = ""
                str += comicType[k] + unit
            }


            return str;



        }

        function  lockedDown(val) {
            for (var s = 0; s < $("input[name=payTime]").length; s++) {
                var item = $("input[name=payTime]").eq(s);
                if (item.val() !== val)
                    item.prop("checked", false);


            }


        }

        function setColor(id) {
            var k = $("#SearchNav span");
            for (var g = 0; g < k.length; g++) {
                var codeId = k.eq(g).prop("id");
                if (codeId !== "extend1" && codeId != "extend2" && codeId !== id) {
                    k.eq(g).css({color: " #98a3ac"})

                }
            }

            $("#" + id).css({color: "#3b506b"})


        }


        function  getAllPurchased() {
            $.ajax({
                url: "OrderController",
                type: "get",
                data: {operation: "getAllPurchased"},
                success: function (res) {
                    var item = JSON.parse(res);
                    for (var k = 0; k < item.length; k++) {
                        $("#ComicResultSet").append(createComicLayout(item[k]));
                    }
                }
            })

        }



        function getPurchasedChapter() {
            $.ajax({

                url: "OrderController",
                type: "get",
                data: {operation: "getPurchasedChapter", cid: selectedComic},
                success: function (res) {
                    $("#chapterList").html("");

                    var item = JSON.parse(res);
                    for (var k = 0; k < item.length; k++) {
                        $("#chapterList").append(createChapterLayOut(item[k], k))
                    }

                    $("#SearchPage").hide();
                    $("#chapterResultSet").show()


                }

            })




        }




        function  getAllPurchased() {


            $.ajax({

                url: "OrderController",
                type: "get",
                data: {operation: "getAllPurchased"},
                success: function (res) {
                    var item = JSON.parse(res);
                    for (var k = 0; k < item.length; k++) {

                        $("#ComicResultSet").append(createComicLayout(item[k], k));

                    }

                }

            })


        }

        function createComicLayout(item, k) {

            var code = "Cm" + k
            var obj = new comicObject(item.cid, item.name);
            comicObjectList.push(obj);



            var str = "<div id='ComicSearchedItem' onclick='showChapterList(" + item.cid + ")'>" +
                    "<div id='comicField'>" +
                    "<div id='ComicImageContainer' class='" + code + "'></div>" +
                    "<div id='ComicImageDescri'>" +
                    "<span id='ccName'>" + item.name + "</span>" +
                    "<span id='ccA' >" + typeList(item.list) + "</span>" +
                    "</div></div></div>";
            var blob = it.base64ToBlob(item.image)
            it.preLoad(blob, "." + code);



            return str;
        }

        function typeList(arr) {
            var str = "";
            for (var j = 0; j < arr.length; j++) {
                str += "<span style='padding-right: 10px'>" + arr[j] + "</span> "
            }
            return str;

        }
        function createPageLayout(image, title, cm, index, codeKey) {

            var code = "pageKey" + index;
            var sCode = selectedComic + "-" + selectedChapter + "-" + index
            var blob = it.base64ToBlob(image)
            var url = it.ToObjectURL(blob);

            var str = "<div id='items'  class='" + sCode + "' onclick='pageScreen(" + index + ")'>" +
                    "<div id='Pages'>" +
                    "<div id='imageViewer' class='" + code + "'><img src='" + url + "' name='" + index + "' alt='" + codeKey + "'></div>" +
                    "<div id='content'>" +
                    "<span id='ComicName'>" + cm + "</span>" +
                    "<span id='chapter'>" + title + "</span>" +
                    "<span id='pageNo'> page." + (index + 1) + "</span>" +
                    "</div></div></div>";

//            it.preLoad_KeyCode(blob, "." + code, index, codeKey);


            return str;


        }
        function createChapterLayOut(item, s) {

            var code = "chapter" + s
            var s = item.title.trim().split(":");
            var title = s[0] + " - " + s[1]


            var str = "<div id='chaperContainer' onclick='showPages(" + item.ep + ")'>" +
                    "<div id='chapterContent'>" +
                    "<div id='chapterCover' class='" + code + "'></div>" +
                    "<div id='chapterDescript'>" +
                    "<div id='reComicName'>" + item.name + "</div>" +
                    "<div id='reChaperTitle'>" + title + "</div>" +
                    "<div id='purchaseDate'>Purchase on " + item.date + "</div>"
            "</div></div></div>"

            var blob = it.base64ToBlob(item.image)
            it.preLoad(blob, "." + code);
            return str;

        }
        
        $("#seText").change(function(){   searchBook();})

        function searchBook() {
            $("#ComicResultSet").html("")
            $("#extend1").hide();
            $("#extend2").hide();
            $("#SelectedComic").text("").hide();
            $("#SelectedEpisode").text("").hide()



            var inputField = $("#seText").val();
   
            var payTime = $("input[name='payTime']:checked").val();
            if (payTime == null)
                payTime = null;

            var start = $("#start").val();
            var end = $("#before").val();



  
            var ct = comicType;
            
            $.ajax({
                url: "OrderController",
                tpye: "get",
                data: {
                    operation: "searchBook",
                    keyword: inputField,
                    payTimePeriod: payTime,
                    start: start,
                    end: end,
                    comicType: ct.toString()
                },
                success: function (res) {
                    var item = JSON.parse(res);
                    for (var k = 0; k < item.length; k++) {
                        $("#ComicResultSet").append(createComicLayout(item[k], k))

                    }
                }

            })





        }


        function fieldColor(id, field) {
            if (field)
                $("#" + id).css({background: "#e7ecea", color: "#291d1d"})

            else
                $("#" + id).css({background: "none", color: "#6e7e8c"})


        }

        function navshow() {
            $("#extend1").hide();
            $("#extend2").hide();
            $("#select").hide();
            $("#SelectedComic").hide();
            $("#SelectedEpisode").hide()
            $("#MainSearch").css({color: "#3b506b"})



        }



    </script>
    <script>
        function comicObject(comicId, name) {
            this.comicId = comicId;
            this.name = name;

            comicObject.prototype.setId = function (comicId) {
                this.comicId = comicId;
            }

            comicObject.prototype.setName = function (name) {
                this.name = name;
            }
            comicObject.prototype.getName = function () {
                return this.name;
            }

            comicObject.prototype.getId = function () {
                return this.comicId;
            }

        }

        function getObjectById(id) {

            for (var s = 0; s < comicObjectList.length; s++) {
                if (comicObjectList[s].getId() == id) {

                    return  comicObjectList[s].getName();
                }
            }

            return null;
        }


        function removeformTheList(val) {
            var newList = [];
            for (var k = 0; k < pageSelection.length; k++) {
                if (pageSelection[k] != val)
                    newList.push(pageSelection[k]);
            }
            return newList;
        }


        function  showAllSelectionPage() {
            var str = "The sTring is ";

            for (var k = 0; k < pageSelection.length; k++) {
                var unit = "-"
                if (k == pageSelection.length - 1)
                    unit = ""
                str += pageSelection[k] + unit
            }


            return str;



        }

//---------------------------------------------------------- Custom book Sorting  -------------------------------------------------------------------


        function  getSequenceNumber() {
            var page = $("#container").find("img");
            for (var s = 0; s < page.length; s++) {
                var pageNo = page.eq(s).attr("name");
                var comicKey = page.eq(s).attr("alt");
                json.sequence.push(comicKey + "-" + pageNo);
            }
        }
        function  identifyComicPage(key) {
            var pageSet = [];
            var page = $("#container").find("img");
            for (var s = 0; s < page.length; s++) {
                var session = page.eq(s)
                if (key == session.attr("alt"))
                    pageSet.push(session.attr("name"));
            }
            return pageSet;
        }


        function   filterComicSession() {
            var comicdKey = [];
            var page = $("#container").find("img");
            for (var s = 0; s < page.length; s++) {
                var session = page.eq(s).attr("alt");
                if (!comicdKey.includes(session))
                    comicdKey.push(session);
            }
            return comicdKey;
        }




















    </script>
    <style>

        #loader{
            /*width: 130px;*/
            /*height: 30px;*/
            width: 20%;
            margin-left: 40%;

            color: #5ba6b7;
        }
        img{width: 100%;height: 100%;}

        #layout{
            height: 200px;
            width: 30%;
            text-align: center;
            background: rgba(134, 153, 164, 0.8);
            position: absolute;
            top:25%;
            left: 35%;

        }
        #title{
            color:#eef1f6;
            display: inline-block;
            margin-top: 40px;
            font-size: 20px;
            font-family: AppleMyungjo;
        }

        #back {
            display: inline-block;
            position: absolute;
            /*background: #5ba6b7;*/
            width: 50px;
            top: 8px;

            left: 2%;
            font-size: 30px;
            color: #7a7d80;
            /*left: 0;*/
        }

        #back:hover {
            color: #ef2c7a;
        }
        #select ,#createCustom,#zoom{
            /*width:100px;*/
            /*height: 0px;*/
            top:83px;
            left: 67%;
            text-align: center;
            position: absolute;
            font-size: 14px;
            color: #ded5d5;
            z-index: 103;
            width: 120px;
            height: 30px;
            padding: 6px 0px 0px;
            border-radius: 1px;
            font-family: "Al Nile";
            padding-top: 6px;

            background: #3f4748;
        }
        #select:hover ,#createCustom:hover{
            cursor: pointer;
        }

        #createCustom{
            width: 150px;

            left: 64%;
        }

        #zoom{
            left: 57%;

            background: #3b506b;
        }


        #glassZoom{
            background: rgba(0,0,0,0.5);
            width: 100%;
            position: fixed;
            z-index: 400;
            height: 100%;
            overflow: auto;
        }
        #imageZooming{
            box-shadow: 1px 2px 20px #aeb1b5;
            position: absolute;
            width: 50%;
            top:20px;
            left: 25%;
            height: 800px;
            overflow: auto

        }
        #closeZoom{
            position: absolute;
            z-index: 509;
            left: 80%;
            color: #aeb1b5;
            font-size: 70px;
        }
        #closeZoom:hover{
            color: #3f4a56;
        }

        #Key{
            width: 
                60%;
            margin-left: 15px;
            padding-left: 0px;
            text-align: center

        }

        input[type='date']{
            width: 84%;
            text-align: center
        }
        #typeContainer{
            margin-top: 6px
        }

        .back span img{
            margin-left: 50px;
            width: 50px;
            height: 50px;
        }
        .back{
            font-size: 25px;
            padding: 10px;
        }
        .back span a{
            color:white;
            text-decoration: none;
        }

    </style>
    <body>
        <div id="glass">
            <div id="layout">
                <span id="title">The page is prepared</span>
                <div id="loader"><img src="images/load.svg" alt=""></div>
            </div>
        </div>
        <div id="glassZoom">
            <div id="closeZoom"><i class="fas fa-times"></i></div>
            <div id="imageZooming"><img src="" alt=""></div>
        </div>
        <div id="glassCreate">
            <div id="createDialog">
                <div  id="createHeading" style="background: #3f4a56">Custom Book Creation</div>
                <div id="mainCreate">
                    <span>BookName </span><br>
                    <input type="text" style="text-align: center" id="cbName">
                    <label id="btnSelect" for="coverPage" >Selected Images</label>
                    <input type="file" id="coverPage" style="display: none">
                    <span id="fileName"></span>
                    <div id="btnSet">
                        <button id="createBook">Create</button>
                        <button id="close">Close</button>
                    </div>
                </div>

            </div>

        </div>





        <div id="headNav">
            <div class="back">
                <span><a href="bookcase.jsp"><img src="images/home.svg"><span id="tt"> Back</span></a></span>

            
            </div>
        </div>
        <div id="control">
            <div id="Searcher"><span>Search Book</span></div>
            <div id="Custom"><span>Custom Panel</span></div>
        </div>
        <div id="SearchBookPanel">
            <div id="SearchNav">
                <span id="MainSearch">Main Search</span>
                <span id="extend1">></span>
                <span id="SelectedComic">HalloWorld</span>
                <span id="extend2">></span>
                <span id="SelectedEpisode">Episode 42</span>
            </div>
            <div id="SearchPage">
                <div id="sePanel">

                    <div id="sch">
                        <input type="text" id="seText" placeholder="Author, Comic Name">
                        <button id="find"><i class="bi bi-search"></i></button>
                    </div>
                    <div id="Key">Payment Record(s)</div><br>
                    <div id="paymentOption">
                        <div><input type="checkbox" name="payTime" value="7 Day"><span id="payItem">Recent 7 days</span></div>
                        <div><input type="checkbox" name="payTime" value="14 Day"><span id="payItem">Recent 14 days</span></div>
                        <div><input type="checkbox" name="payTime" value="30 Day"><span id="payItem">Recent 1 Months</span></div>
                        <div><input type="checkbox" name="payTime" value="others"><span id="payItem">Others</span></div>
                    </div>
                    <div id="dateSet">
                        <span style="padding-bottom: 2px">From</span><br>
                        <input type="date" id="start"><br>
                        <span>To</span><br>
                        <input type="date" id="before">
                    </div>
                    <div id="Key" style="background-Color:#3f4a56;margin-top: 30px">Comic Type(s)</div>
                    <div id="typeContainer">
                        <%
                            for (ComicTypeBean cn : new ComicTypeDB().getComicType().getTlist()) {
                                String type = cn.getComicType();
                                String id = cn.getTid();

                        %>
                        <div><input type="checkbox" name="comicType" value="<%=id%>"><span id="tpyeItem" style="padding-left:10px"><%=type%></span></div>            
                            <%}%>
                    </div>


                </div>

                <div id="ComicResultSet"></div>
            </div>
            <div id="chapterResultSet">
                <div id="chapterList"></div>
            </div>

            <div id="select" ><span>Select Page(s)</span></div>
            <div id="zoom" ><span>Zoom</span></div>

            <div id="PageSet"></div>


        </div>
        <div id="createCustom" ><span>Create Custom Book</span></div>

        <div id="container"></div>





        <div id="bottom"></div>


    </body>
</html>