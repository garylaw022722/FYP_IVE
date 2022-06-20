<%-- 
    Document   : ReadBookSearching
    Created on : 20-Apr-2021, 11:06:44
    Author     : law
--%>

<%@page import="ict.db.contract"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ict.bean.ComicTypeBean"%>
<%@page import="ict.db.ComicTypeDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Read Book Searching</title>
        <link rel="stylesheet" href="css/searchBook.css">

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">
        <link rel="stylesheet" href="css/SEVR.css">

    </head>
    <body style="">
        <script src="https://cdn.jsdelivr.net/npm/vanilla-lazyload@17.3.1/dist/lazyload.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <script src="js/ImageTranslator.js"></script>

        <style type="text/css">




            #topNav {
                top: 0;
                background-color: #2e2e30;

            }

            #se {
                /*background-color: #2e2e30;*/
                width: 205%;
            }

            #searchBtn {
                padding-top: 3px;
            }

            #searchBtn:hover {
                color: red;
            }

            #sbAres{
                top:320px
            }

            #btNav{
                border: none;
                margin-top: 140px;
            }
            #topR {

                position: absolute;
                height: 0px;
                width: 0px;

                border-left: 0px solid transparent;
                border-right: 70px solid transparent;
                border-top: 70px solid rgba(119, 184, 200, 0.9);
                text-align: center;
                font-size: 15px;
                color: white;
            }

            #tr {
                color: white;
                position: absolute;
                z-index: 29;
                font-size: 18px;
                top:14px;
                margin-left: 4px;
                font-family: "Roboto Light";
                transform: rotate(-30deg);
                display: inline-block;

            }

            #cName{
                overflow: hidden;
                white-space: nowrap; 
                text-overflow: ellipsis; 
            }

            #p1 {
                margin-top: 7px;
                margin-left: 2%;
                /*border: 1px solid red;*/
                display: flex;
                flex-direction: row;
                width: 80%;
            }

            #ut {
                /*border: 1px solid red;*/
                font-size: 18px;
                display: flex;
                padding-top: 9px;
                font-family: "Al Nile";
                color: #696f79;
            }

            #timeslot {
                margin-top: 8px;
                font-size: 12px;
                border: 1px solid #aeb1b5;
                /*border: none;*/
                /*background: #5c6973;*/
                /*color: white;*/
                height: 24px;
                width: 100px;
                padding-left: 10px;
                margin-left: 20px;
                /*border-radius: 4px;*/
            }

            #serYear {
                border: 1px solid #aeb1b5;
                width: 80px;
                padding-left: 10px;
                height: 24px;
                margin-top: 8px;
                font-size: 12px;
                margin-left: 20px;
            }
            #glass{
                position: fixed;
                width: 100%;
                height: 100%;
                background: rgba(255,255,255,0.01);
                z-index: 2044;
            }
            #cmTypeList{

                box-shadow:  1px  2px 10px rgba(0,0,0,0.6);
                border-radius: 3px;
                background: white;
                width : 40%;
                height: 350px;
                top:170px;
                position: absolute;
                z-index: 2045;
                left: 30%;
                background: rgba(255,255,255,0.95);
            }
            #titleTP{
                border-bottom:3px solid #5ba6b7;
                font-size: 20px;
                font-family: AppleMyungjo;
                padding-top: 10px;
                padding-bottom: 4px;
                /*padding-left: 30px;*/
                text-align: center;
                color: #787a80;

            }
            #typeContainer{
                /*border: 1px solid red;*/
                width: 80%;
                /*height: 240px;*/
                display: flex;
                color: #787a80;
                flex-wrap: wrap;
                margin: auto;
                margin-top: 30px;
                margin-left: 13%;
            }
            #typeContainer div{
                width: 33.3%;
                font-size: 16px;
                /*border: 1px solid red;*/
                height: 30px;
                margin-bottom: 5px;
            }
            #checkTitle{
                padding-left: 20px;

            }
            #btnListx{
                /*border: 1px solid red;*/
                width: 100%;
            }
            #btnListx button{
                position: absolute;
                width: 15%;
                height: 20px;
                margin-top: 40px;
                background: #7e8899;
                border: none;
                top:240px;
                color: white;
                font-size: 13px;
                border-radius: 3px;
            }
            #ok{
                left: 80%;
            }
            #cnel{
                left: 60%;
            }
            input[type=checkbox]:checked {

                background-color: #444;
            }





        </style>

        <%
            ArrayList<String> conditionList = new ArrayList<String>();
            String comicType = "";
            String searchBy = "";

            String field = "Recent Update";

            if (request.getParameter("field") != null) {
                field = request.getParameter("field");

            }
            if (request.getParameter("searchBy") != null) {
                comicType = request.getParameter("comicType");
                searchBy = request.getParameter("searchBy");

            }


        %>


        <script>
            var defaultloadingComic = 6;
            var loadingBookIndex = 0;
            var finalIndex = 0;
            var loader = 1;
            var field = "<%=field%>"
            var condition = "";
            var singleComicType = "<%=comicType%>"
            var searchBy = "<%=searchBy%>"
            var comicList = [];
            var subCList = [];
            alert(singleComicType);

            var it = new ImageTranslator();





            function initialization(field, condition) {
                $("#glass").hide();

                condition = "Condition : Year - " + new Date().getFullYear();
//                  getSearchYear();                                  

                if (field == "Recent Update") {
                    btnRecent = btnColor(false, "#RecentUpdate")
                    $("#timeslot").prop("disabled", "disabled");
                    $("#serYear").prop("disabled", false);
                    if (searchBy == "comicType") {
                        btnComicType = btnColor(false, "#btnCp");
                        condition += ",<span style='padding-left:5px'>Comic Type - </span> " + singleComicType;
                        getBookSources("searchBook", getConditionList("Recent"));
//                                 getConditionList("Recent");
                    } else {
                        getBookSources(field, "")
                    }

                } else if (field == "New Serialization") {
                    btnSerialize = btnColor(false, "#NewSeri")
                    $("#serYear").prop("disabled", true);
                    getBookSources(field, "")

                }
                $("#SerHints").text(field);
                $("#SerQu").html(condition);



                if (condition == "Condition  : ") {
                    $("#SerHints").css({"margin-top": "2px", "font-size": "26px"})
                }




            }

            function getSearchYear() {
                $.ajax({
                    url: "SearchingEngine",
                    type: "get",
                    data: {operation: "epConfig", field: "getYear"},
                    success: function (res) {
                        var current = new Date().getFullYear();
                        var selected = "";
                        var item = JSON.parse(res);
                        for (var k = 0; k < item.length; k++) {
                            var year = item[k].year;
                            if (year === current)
                                selected = "  selected";
                            $("#serYear").append("<option value='" + year + "' " + selected + " >" + year + "</option>");
                        }

                    }

                })




            }



            function ReadDeatils(cid) {

                window.location.href = "ReadBookController?operation=SelectComic&comicId=" + cid

            }
            function showBundle(bid) {
               
                 window.location.href = "ReadBookController?operation=SelectBundle&bid=" +bid;


            }

            function getUpdateItemString(cid, ComicName, date, index) {
                var str = (index == 0 || index % 5 == 0) ? "<div id='book' style='margin-left: 7%'>" : "<div id='book'>";

                str += "<div id='cover' class='Up" + cid + "'></div>" +
                        "<div id='bookDetail'>" +
                        " <div id='date'>" + date + "</div>" +
                        " <div id='cName'><b>" + ComicName + "</b></div>" +
                        "<input id='seedDetail' type='button' value='Read More' onclick='ReadDeatils(" + cid + ")'>" +
                        "</div>" +
                        "</div>";

                return str;

            }
            function getBundleItemString(bid, bookName, date, index) {
                var str = (index == 0 || index % 5 == 0) ? "<div id='book' style='margin-left: 7%'>" : "<div id='book'>";

                str += "<div id='cover' class='Up" + bid + "'></div>" +
                        "<div id='bookDetail'>" +
                        " <div id='date'>" + date + "</div>" +
                        " <div id='cName'><b>" + bookName + "</b></div>" +
                        "<input id='seedDetail' type='button' value='Read More' onclick='showBundle(" + bid + ")'>" +
                        "</div>" +
                        "</div>";

                return str;

            }




            function  getBookSources(type, dt) {

                var count = 0;
                $.ajax({
                    url: "ProductController",
                    type: "get",
                    data: {operation: type, data: dt},
                    success: function (res) {
                        $("#bookList").html("");


                        var item = JSON.parse(res);
                        for (var s = 0; s < item.length; s++) {
                            var dateSet = item[s].date.split("-");

                            var date = dateSet[0] + "." + dateSet[1] + "." + dateSet[2].substring(0, 2);

                            var str = getUpdateItemString(
                                    item[s].cid,
                                    item[s].ComicName,
                                    date,
                                    s
                                    );
                            $("#bookList").append(str);
                            var blob = it.base64ToBlob(item[s].image);
                            var loaderId = ".Up" + item[s].cid
                            it.preLoad(blob, loaderId)


                        }
                        loader = 1;
                        loadingBookIndex = 0;
                        finalIndex = 0;
                        switchComic(defaultloadingComic, false);

                    }


                })






            }

            function  getBundle(type, dt) {

                var count = 0;
                $.ajax({
                    url: "ProductController",
                    type: "get",
                    data: {operation: type, data: dt},
                    success: function (res) {
                        $("#bookList").html("");


                        var item = JSON.parse(res);
                        for (var s = 0; s < item.length; s++) {
                            var dateSet = item[s].date.split("-");

                            var date = dateSet[0] + "." + dateSet[1] + "." + dateSet[2].substring(0, 2);
//                            alert(item.length);
                            var str = getBundleItemString(
                                      item[s].bid,
                                    item[s].BookName,
                                    date,
                                     s
                                    );
                            $("#bookList").append(str);
                            var blob = it.base64ToBlob(item[s].image);
                            var loaderId = ".Up" + item[s].bid
                            it.preLoad(blob, loaderId)


                        }
                        loader = 1;
                        loadingBookIndex = 0;
                        finalIndex = 0;
                        switchComic(defaultloadingComic, false);

                    }


                })
            }






            function readBookDetails() {
                window.open("");
            }

            function switchComic(num, bool) {
                var effect = (bool) ? "block" : "none"
                $("#bookList #book").slice(defaultloadingComic).css({display: effect});
                // $("#comicType").text($("#bookList").innerHeight())
            }

            function showRemainComic()
            {
                finalIndex = loadingBookIndex + defaultloadingComic;
                $("#bookList #book").slice(loadingBookIndex, finalIndex).fadeIn("slow");
                loadingBookIndex = finalIndex;
                // alert(scrIndex)
            }


            function topNavEffect(num, num2, searcherNav) {
                if (num >= num2) {
                    $("#dd").html(searcherNav)
                    $(".secNav").css({display: "none"})
                    // $("#searcher").css({borderTop:"none"})
                    // $("#searcher").removeClass("searcherE");
                    // $("#comicType").text($("#bookList").height())
                } else {
                    $("#dd").load("b1.html")
                    $(".secNav").css({display: "block"})
                }
            }


            function bookListEffect(num, num2) {
                var height = ($("#bookList").height() / 2) * loader;

                var x = height - num2
                if (num >= x) {
                    showRemainComic();
                    loader++;
//                             alert(loader)
                }

            }

            function scrollEffect() {
                $(window).scroll(function () {
                    var searcherNav = "<div id='searcher' style='top:0 ;background-color: #eef1f6'>" + $("#searcher").html() + "</div>";
                    // alert(searcherNav)
                    var num = $(window).scrollTop();
                    var num2 = $("#bookList").offset().top;
                    // topNavEffect(num, num2, searcherNav)
                    bookListEffect(num, num2)
                    $("#sideNav").css({height: "100vh"})
                    $("#searcher").css({background: "rgba(255,255,255,0.9)", borderTop: "none", color: "gray"})


                })
            }

            var btnSerialize = false;
            var btnRanking = false;
            var btnRecent = false;
            var btnRecommand = false
            var btnComicType = false;
            var btnBundle = false;


            $(document).ready(function () {
                loadingBookIndex = defaultloadingComic;
                $("#dd").load("parts/memberNav2.jsp")
                scrollEffect();
                switchComic(defaultloadingComic, false);
//                        $("#btNav").load("Footer.html");
                // $("#sideNav").css({left: "80%"})
                initialization(field, condition);







                $("#NewSeri").click(function () {
                    btnRecommand = btnColor(true, "#Rec");
                    btnSerialize = btnColor(btnSerialize, "#NewSeri");
                    $("#SerHints").text("New Serialization");
                    btnBundle = btnColor(true, "#btnBundle");
                    btnRecent = btnColor(true, "#RecentUpdate")
                    btnRanking = btnColor(true, "#TopRank");
                    $("#timeslot").prop("disabled", false);
                    getBookSources("searchBook", getConditionList("Serialize"));


                })





                $("#TopRank").click(function () {
                    var data = [];
                    $("#SerHints").text("Top Ranking");
                    $("#timeslot").prop("disabled", true);

                    btnRecommand = btnColor(true, "#Rec");
                    btnSerialize = btnColor(true, "#NewSeri");
                    btnRanking = btnColor(btnRanking, "#TopRank");
                    btnRecent = btnColor(true, " #RecentUpdate");

                    getConditionList();
                    $("#timeslot").prop("disabled", false);
                    getBookSources("searchBook", getConditionList("TopRank"));

                })

                $("#RecentUpdate").click(function () {
                    btnRecommand = btnColor(true, "#Rec");
                    btnRecent = btnColor(btnRecent, "#RecentUpdate");
                    $("#SerHints").text("Recent Update");
                    btnSerialize = btnColor(true, "#NewSeri")
                    btnRanking = btnColor(true, "#TopRank");
                    getBookSources("searchBook", getConditionList("Recent"));
                    $("#timeslot").prop("disabled", true);


                })
                $("#Rec").click(function () {

                    btnRecommand = btnColor(btnRecommand, "#Rec");
                    btnRecent = btnColor(true, " #RecentUpdate");
                    btnRanking = btnColor(true, "#TopRank");
                    btnSerialize = btnColor(true, "#NewSeri");



                })
                $("#btnCp").click(function () {
                    btnRecommand = btnColor(true, "#Rec");
                    btnComicType = btnColor(btnComicType, "#btnCp");
                    $("#glass").show();

                })
                $("#btnBundle").click(function () {
                    btnRecommand = btnColor(true, "#Rec");
                   
                    btnBundle = btnColor(btnBundle, "#btnBundle");
                    btnSerialize = btnColor(true, "#NewSeri");                  
                    getBundle("searchBook", getConditionList("bundle"));

                })

                $("#timeslot").change(function () {
                    if (btnRecent)
                        $(this).prop("disabled", true);
                    getBookSources("searchBook", getConditionList("timeslot"));
//                    checkAlltag();
                })

                $("#serYear").change(function () {
                    alert($(this).val())
                })

                $("#ok").click(function () {
                    subCList = comicList;
//                    if (subCList.length == 0) {
//                        alert("You have not any type");
//                        btnComicType = btnColor(true, "#btnCp");
//                        return;
//                    }
                    getBookSources("searchBook", getConditionList("comicType"));
                    $("#glass").hide();

                })

                $("#cnel").click(function () {
//                    comicList = [];
//                    for (var s = 0; s < $("input[name=ct]").length; s++) {
//                        $("input[name=ct]").eq(s).prop("checked", false);
//                        $("#typeContainer #checkTitle").eq(s).css({color: "#787a80"})
//
//                    }
                    btnComicType = btnColor(false, "#btnCp");
                    $("#glass").hide();

                })





                $("input[name=ct]").click(function () {

                    var tv = $(this).val();
                    var index = $(this).prop("alt");

                    if ($(this).prop("checked")) {

                        if (comicList.length == 3 || tv == "other") {
                            if (comicList.length == 3)
                                alert("Don't choose more than 3 types")
                            uncheckedLastOption(tv);
                            return;
                        }
                        $("#typeContainer #checkTitle").eq(index).css({color: "#5ba6b7"})
                        comicList.push(tv);
                    } else {
                        comicList = popType(tv);
                        $("#typeContainer #checkTitle").eq(index).css({color: "#787a80"})

                    }
//                    displayListContent();

                })



            })

            function  uncheckedLastOption(num) {
                for (var s = 0; s < $("input[name=ct]").length; s++) {
                    if ($("input[name=ct]").eq(s).val() == num)
                        $("input[name=ct]").eq(s).prop("checked", false);
                }




            }







            function btnColor(val, id) {
                if (val == true) {
                    $(id).css({background: "#3b506b"})
                    return false;
                } else {
                    $(id).css({background: "rgba(0,0,0,0.9)"})
                    return true;
                }
            }


            function checkAlltag() {
                var str = "Serialize  :" + btnSerialize +
                        "\nTopRank :" + btnRanking +
                        "\nRecent Updat  :" + btnRecent +
                        "\nRecommand  :" + btnRecommand +
                        "\nbtnComicType  :" + btnComicType +
                        "\nbtnBundle   :" + btnBundle;
                alert(str)

            }

            function popType(num) {
                var newList = [];
                for (var s = 0; s < comicList.length; s++) {
                    if (comicList[s] != num)
                        newList.push(comicList[s]);
                }
                return newList

            }

            function displayListContent() {
                var str = "";
                for (var s = 0; s < comicList.length; s++) {
                    if (s < comicList.length - 1)
                        str += comicList[s] + "-"
                    else
                        str += comicList[s]

                }
                alert(str);
            }





            function getTagSoruces() {
                var js = {}
                js.Serialize = btnSerialize;
                js.TopRank = btnRanking;
                js.Recent = btnRecent;
                js.Recommand = btnRecommand;
                js.comicType = btnComicType;
                js.bundle = btnBundle;
                return js;

            }
            function setCondition() {
                var condition = {};
                condition.btn = getConditionList();
                alert(JSON.stringify(condition));




            }


            function getConditionList(field) {

                var conditionList = {};
                conditionList.mainField = field;
                conditionList.comicTypeList = subCList;
                conditionList.bundle = "";
                conditionList.buttonList = getTagSoruces();
                conditionList.year = $("#serYear").val();
                conditionList.timeslot = $("#timeslot").val();
                alert(JSON.stringify(conditionList))
                return  JSON.stringify(conditionList)
            }


            function  setSearchField(name) {
//                var  condition  :

//                $("#SerQu").html(condition);


                //check field 
//                if



            }









        </script>
        <div id="glass">
            <div id="cmTypeList">
                <div id="titleTP">Comic Type List</div>
                <div id="typeContainer">
                    <%
                        ArrayList<ComicTypeBean> cb = new ComicTypeDB().getComicType().getTlist();

                        for (int s = 0; s < cb.size(); s++) {
                            String isChecked = "";
                            String name = cb.get(s).getComicType();
                            String id = cb.get(s).getTid();
                            if (name.equals(comicType) && !comicType.equals("")) {
                                isChecked = "checked";
                                int index = s + 1;

                    %>
                    <script>
                        comicList.push("<%=index%>");
                        subCList.push("<%=index%>");

                    </script>
                    <%}%>
                    <div><input type="checkbox" name="ct" value="<%=id%>" alt="<%=s%>" <%=isChecked%> ><span id="checkTitle"><%=name%></span></div>
                        <%}%>
                </div>
                <div id="btnListx">
                    <button id="ok">Ok</button>
                    <button id="cnel">Cancel</button>
                </div>

            </div>
        </div>

        <div id="dd"></div>
        <div id="SeVer">
            <div id="SerResult">
                <span id="SerHints"></span>
                <span id="SerQu"></span>
            </div>
            <div id="SeVer_Option_1">            
                <span id="NewSeri" class="">New Serialization</span>
                <span id="TopRank">Top Ranking</span>
                <span id="RecentUpdate">Recent Update</span>
                <span id="Rec">Recommendation</span>
                <span id="btnCp">Comic type</span>
                <span id="btnBundle">Bundle Set</span>
            </div>
            <div id="SerDayBar">
                <div id="p1">
                    <span id="ut">Update time slot</span>
                    <select  id="timeslot">
                        <option value='-' selected>-</option>
                        <option value='Sunday'>Sunday</option>
                        <option value='Monday'>Monday</option>
                        <option value="Tuesday">Tuesday</option>
                        <option value='Wednesday'>Wednesday</option>
                        <option value="Thursday">Thursday</option>
                        <option value='Friday'>Friday</option>
                        <option value='Saturday'>Saturday</option>
                        <option value="Monthly">Monthly</option>
                    </select>
                    <span id="ut" style="margin-left: 50px">Serialized Year</span>
                    <select name="" id="serYear">
                        <%

                            int CurYear = Calendar.getInstance().get(Calendar.YEAR);
                            for (String item : new contract().getContractYear()) {
                                String isSelected = "";
                                int year = Integer.valueOf(item);
                                if (year == CurYear) {
                                    isSelected = "Selected";
                                }


                        %>
                        <option value=<%=year%>  <%=isSelected%> ><%=year%> </option>
                        <%}%>
                    </select>

                </div>



            </div>
        </div>



        <div id="sbAres" style="">
            <div id="bookList">


            </div>
        </div>
        <div id="btNav"></div>
    </body>
</html>