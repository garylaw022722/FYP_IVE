


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Front Pages </title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" href="css/lightslider.css">
        <link rel="stylesheet" href="css/MainCss.css">

        <script src="js/lightslider.js"></script>

        <!--    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">
        <script src="js/ImageTranslator.js"></script>
    </head>
    <body>
        <style>


            #topNav {
                position: absolute;
                top: 0;
                /*position: relative;*/
            }

            #Ban {
                margin-top: 80px;
                margin-bottom: 100px;
            }

            #rankListXT {
                /*margin-top: 200px;*/

            }

            #promotion {
                width: 100%;
                height: 650px;
                background: #f4f7fc;
                padding: 10px 20px;
            }

            #dayUpdate {
                width: 95%;
                margin: auto;
            }

            #seriContainer {
                margin-top: 10px;
                /*border: 1px solid red;*/
                width: 100%;
                height: 100%;
                display: flex;
                margin-left: 20px;

                color: #aeb1b5;

            }

            #sRead {
                margin-top: 5px;
                margin-right: 20px;
                color: #6e7e8c;
            }

            #sRead:hover ,#uRead:hover{
                color: #3b506b;
            }

            #seriLeft {
                width: 100%;
                flex-wrap: wrap;
                /*background: #3b506b;*/
                padding-left: 10px;
                padding-top: 5px;
                flex-direction: row;
                display: flex;

            }

            #seriComic {
                width: 23%;
                height: 250px;
                margin-right: 20px;
                /*background: #fffdfd;*/
                margin-bottom: 20px;
                box-shadow: 1px 2px 10px rgba(0, 0, 0, 0.3);
                /*border: 1px solid red;*/
            }


            #serDes {
                padding: 4px;
                padding-left: 10px;

            }



            #promotionBar div {
                height: 20%;
                margin: 5px;


            }

            #serImage {
                width: 100%;
                height: 175px;
                margin-bottom: 10px;
                border-radius: 2px;
                border: 1px solid gainsboro;
            }

            #serName {
                color: black;
                font-family: "New Peninim MT";
                font-size: 15px;
                display: block;
                margin-top: -10px;
            }

            #serDate {
                border: 1px solid;
                color: #fc5a9f;
                /*color: #aae0ec;*/
                border-radius: 4px;
                font-size: 10px;
                text-align: center;
                padding: 2px;
                /*background: #cf256e;*/
                /*background: #fc5a9f;*/


                width: 25%;
                /*color: white;*/
                display: inline-block;

            }

            #bm {
                color: #ff8805;
                font-size: 20px;
                padding-right: 5px;
            }

            #serAe {
                display: inline-block;
                margin-bottom: 3px;
                font-size: 14px;
            }

            #serDatess {
                float: right;
                display: inline-block;
                margin-top: 2px;
                font-family: "Damascus";
                color: #6e7e8c;
                padding-right: 20px;
                font-size: 13px;
            }

            #typeSet {
                width: 100%;
                height: 100%;
                margin-top: 600px;
            }

            #week {
                font-size: 13px;
            }

            #footerFin {
                position: absolute;
                top: 2600px;
                width: 100%;
            }

            #toDay {
                background: orange;
                color: white;
                font-family: AppleMyungjo;
                text-align: center;
                width: 15%;
                display: inline-block;
                padding: 2px 0px;
                font-size: 14px;
            }

            #dateTitle {
                display: flex;
                flex-direction: column;
                margin-bottom: 10px;

            }

            #UText {
                font-size: 24px;
                color: #3b506b;
                padding-left: 3px;
                display: inline-block;
                padding-bottom: 5px;
                text-shadow: 2px 2px 20px #e3f5f8;
                font-family: AppleMyungjo;
            }

            #uRead{
                position: absolute;
                left: 92%;
                font-size: 13px;
                margin-top: 45px;
                color: #6e7e8c;

            }

            #UpAuthor{
                font-size: 10px;
                color: #6e7e8c;
                padding-bottom: 9px;
            }
            #UpCN{
                font-size: 16px;
            }
            #UpCHN{
                font-size: 14px;
                font-family: "Al Bayan";
                color: #3f4a56;
            }
            #UPTN{
                color: #6e7e8c;
                font-size: 11px;
                /*background: #fc5a9f;*/
                display: flex;
                flex-wrap: wrap;
                width: 100%;
                margin-top: 10px;

            }
            #UPTN  a {
                text-decoration: none;
                margin-right: 10px;
                background: #ef73b3;
                /*color: #ef73b3;*/
                /*background: #8cd8e0;*/
                /*background: #fda63d;*/
                /*background:linear-gradient( to right ,#8cd8e0, #b9f5fc);*/
                text-align: center;
                color: white;
                width: 27%;
                border-radius: 3px;
                /*border
                : 1px solid;*/
                padding: 2px;
            }
            #tagType{
                padding-left: 5px;
                
            }
            #sk{
                 white-space: nowrap; 
                  overflow: hidden;
                  text-overflow: ellipsis; 
            }
            #UpAuthor{
                font-size: 12px;
            }
            #UpCHN{
                font-size: 14px;
            }


        </style>
        <script>
            var slideIsLoad = false;
            var it = new ImageTranslator();
            $(document).ready(function () {
                $("#topBarX").load("parts/memberNav2.jsp");

                $('#Ban').load('parts/slideShow.jsp');
                setTimeout(function () {
                    $('#rankListXT').load('parts/rank.jsp');                   
                }, 1000)
                $("#typeSet").load('parts/typeList.jsp')
                $('#footerFin').load('parts/footer.jsp');
                $("#sRead").click(function () {
                    window.location.href = "slideShow.html"
                })

                $("#seriContainer #seriComic ").click(function () {
                    var index = $(this).index();

                    var sa = $("#seriContainer #seriComic #serName").eq(index).text();
//                    alert(sa)

                })
                setDateWeek();
                getFirst8Seri();
                getNewUpdatedEpisoded();



                // $("#topNav ").attr("style","position: absolute")
            })

            function setDateWeek() {
                var d = new Date();
                var weekday = new Array(7);
                weekday[0] = "Sunday";
                weekday[1] = "Monday";
                weekday[2] = "Tuesday";
                weekday[3] = "Wednesday";
                weekday[4] = "Thursday";
                weekday[5] = "Friday";
                weekday[6] = "Saturday";
                var dateString;
                var n = weekday[d.getDay()];

                var day = d.getDate();
                var month = d.getMonth() + 1;
                day = day.toString()
                month = month.toString();


                if (day.length === 1)
                    day = "0" + day;
                if (month.length === 1)
                    month = "0" + month;


                var year = d.getFullYear();
                dateString = day + "." + month + "." + year


                $("#week").text(n);

                $("#toDay").text(dateString);
            }

            function getFirst8Seri() {

                $.ajax({
                    url: "ProductController",
                    type: "get",
                    data: {operation: "getFirst8Seri"},
                    success: function (res) {
                        alert(res);
                        var js = JSON.parse(res);
                        for (var s = 0; s < js.length; s++) {
                            var classN = ".Seri" + s
                            var blob = it.base64ToBlob(js[s].image);
                            var str = "<div id='seriComic' onclick='ReadDeatils(" + js[s].cid + ")'><div id='serImage' class=Seri" + s + " ></div><div id='serDes'>" +
                                    "<span id='serName'>" + js[s].ComicName + "</span>" +
                                    "<span id='serAe'>" + js[s].penName + "</span><br>" +
                                    "<span id='serDate'>" + js[s].SerDate + "</span></div>" +
                                    "</div>"
                            $("#seriLeft").append(str);
                            it.preLoad(blob, classN);

                        }


                    }

                })

            }
            function ReadDeatils(cid ,event) {
//            
                  
                window.location.href = "ReadBookController?operation=SelectComic&comicId=" + cid

            }
            function getNewUpdatedEpisoded() {

                $.ajax({
                    url: "ProductController",
                    type: "get",
                    data: {operation: "invokeIndex", field: "getNewRelease"},
                    success: function (res) {
       
                        var item = JSON.parse(res);

                        for (var s = 0; s < item.length; s++) {
//                            alert(item[s].Latest_EpTitle)
                            if (s == 7)
                                return;
                            var typeList = item[s].typeList;
                            var blob = it.base64ToBlob(item[s].image);
                            var loaderId = ".Up" + item[s].cid
                               var str =
                                    getUpdateItemString(
                                            item[s].penName,
                                            item[s].Latest_EpTitle,
                                            item[s].ComicName,
                                            item[s].cid,
                                            item[s].typeList
                                            );

                                $("#update").append(str);
                                 it.preLoad(blob, loaderId)
                    
                                         
                    

                        }

                    }

                })


            }


            function getUpdateItemString(penName, Lastest_EpTitle, ComicName, cid, typeList) {


                var str = "<div onclick='ReadDeatils(" + cid + ",event)'>" +
                        "<div id='mangaBoxForUpdateList' class='Up" + cid + "'></div>" +
                        "<div id='updateT'>" +
                        "<span id='UpCN'>" + ComicName + "</span>" +
                        "<span id='UpAuthor'>" + penName + "</span>" +
                        "<span id='UpCHN'>" + Lastest_EpTitle + "</span>" +
                        "<span id='UPTN'>";
                for (var s = 0; s < typeList.length; s++)
                    str += "<a id='sk' href='ReadBookSearching.jsp?field=Recent Update&searchBy=comicType&comicType="+typeList[s]+"' ><i class='bi bi-tags'></i><span id='tagType'>" + typeList[s] + "</span></a>"
                str += "</span>" + "</div>" + "</div>";

                return str;

            }
            
        


        </script><!--
        --><div id="topBarX" style=""></div>
        <div id="Ban"></div>
        <div id="SuggestionArea"></div>
        <div id="promotion">
            <i class="bi bi-bookmark-fill" id="bm"></i>
            <span style="font-size: 22px ;font-family:'New Peninim MT'">New Serialization </span>
            <div id="sRead" style="display: inline-block;float:right">
                <span style="font-size: 15px ;font-family:'New Peninim MT'" onclick="window.open('ReadBookSearching.jsp?field=New Serialization')">ReadMore </span>
                <i class="bi bi-chevron-right"></i>

            </div>

            <div id="seriContainer"><div id="seriLeft"></div></div>

        </div>

        <div id="dayUpdate">
            <div id="UpdateList">
                <div id="dateTitle">
                    <span id="UText">Update List <span id="week">Thur</span></span>
                    <span id="toDay"> 21.02.2021</span>
                    <div id="uRead" style="display: inline-block;float:right">
                        <span style="font-size: 15px ;font-family:'New Peninim MT'" onclick="window.open('ReadBookSearching.jsp?field=Recent Update')">ReadMore </span>
                        <i class="bi bi-chevron-right"></i>

                    </div>

                </div>
                <div id="srLine"></div>
                <div id="update">


                </div>
            </div>            
        </div>
           <div id="rankListXT"></div>
           <div id="typeSet"></div>
           <div id="footerFin" style="margin-top: 600px"></div>

     
    </body>
</html>