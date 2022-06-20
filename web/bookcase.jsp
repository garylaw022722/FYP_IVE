<%-- 
    Document   : bookcase
    Created on : 2020年10月25日, 下午07:32:17
    Author     : user
--%>

<%@page import="ict.imageTranslator"%>
<%@page import="ict.bean.ComicWorks"%>
<%@page import="ict.db.ComicWorksDB"%>
<%@page import="ict.db.BookDb"%>
<%@page import="java.lang.String"%>
<%@page import="ict.bean.ComicBean"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<link href="barCss/css/bootstrap.min.css" rel="stylesheet">
<link href="barCss/css/simple-sidebar.css" rel="stylesheet">
<link href="barCss/css/dashboard.css" rel="stylesheet">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bookcase</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    </head>
    <script>
    </script>
    <style>
        html, body{min-width: 300px; width: 100%; max-width: 100%; background-color: #fff; margin: 0px; padding: 0px; border-spacing: 0px; font-size: 14px; letter-spacing: -0.05rem; box-sizing: border-box; text-decoration: none; border-collapse: collapse;
                   -webkit-font-smoothing: antialiased; 
                   -webkit-overflow-scrolling: touch; outline: none; 
                   -webkit-touch-callout: none; -webkit-touch-select: none; -ms-user-select:none; -moz-user-select: none; -webkit-user-select: none; -webkit-text-size-adjust: none; -moz-text-size-adjust: none; -ms-text-size-adjust: none; -webkit-tap-highlight-color:rgba(0,0,0,0); -o-user-select:  none; user-select: none; /* Mobile 선택/복사 이벤트 방지 */
        }
        body[data-lang='tw']{font-family: 'Noto Sans TC', sans-serif;}
        div, span, p, ul, li, dl, dt, dd, a, i, header, nav, main, aside, section, article, footer, input, textarea{-webkit-box-sizing: border-box; -moz-box-sizing: border-box; -ms-sizing: border-box; -o-sizing: border-box; box-sizing: border-box; padding: 0px; margin: 0px; list-style-type: none; outline: none;}
        img{will-change: transform; border: none; outline: none; vertical-align: middle;}
        a, a:hover, a:active{text-decoration: none; outline: none; border: none; color: #666;}
        table{border-collapse: collapse; padding: 0; border-spacing: 0;}
        input[type='submit'], input[type='button']{-webkit-appearance:none;}
        input[type='button']:focus{outline: none;}
        button{outline: none; border: none; cursor: pointer; background-color: #fff;}
        i{font-style: normal;}
        select{padding: 3px 20px 3px 5px; border: 1px solid #c7c7c7; background-color: #eee; font-family: inherit; border-radius: 3px; -webkit-appearance: none; -moz-appearance: none; appearance: none; background-size: 17px; background-repeat: no-repeat; background-position: right 10px center; background-image: url(//ballerina.toptoon.net/assets/v1/img/layout/icon_selectboxArrow.png);}
        select::-ms-expand {display: none;}

        .liLastNoLine li:last-child:after{content: '.'; visibility: hidden; display: block; height: 0; clear: both;}
        .arTit{position: absolute; width: 1px; height: 1px; font-size: 1px; overflow: hidden; opacity: 0;}
        .notScroll{position: relative; overflow: hidden;}
        @media (max-width: 639px) {.notScroll767{position: relative; overflow: hidden;}}
        .statImg{display: none;}

        /*我的最愛條BAR*/
        .title_wrap .show1199, .title_wrap .show1200{display: none;}
        @media (max-width: 1199px) {.title_wrap .show1199{display: block;}}
        @media (min-width: 1200px) {.title_wrap .show1200{display: block;}}
        .title_wrap{border-bottom: 1px solid #ddd;}
        @media (max-width: 1199px) {.title_wrap{width: 100%;}}
        @media (min-width: 1200px) {.title_wrap{width: 1200px; margin: 20px auto 0; height: 50px;}}
        @media (max-width: 1199px) {.title_wrap.sticky{position: sticky; top: 40px; z-index: 2;}}
        @media (max-width: 1199px) {.title_wrap .title_area{display: none;}}
        @media (min-width: 1200px) {.title_wrap .title_area{float: left; height: 50px; line-height: 50px;}}
        .title_wrap i.pageTitlePoint{width: 32px; height: 32px; background: url(//ballerina.toptoon.net/assets/v1/img/layout/icon_bullet_red.png) no-repeat center; background-size: contain; display: inline-block; vertical-align: middle;}
        .title_wrap i.pageTitleEvent{width: 32px; height: 32px; background: url(//ballerina.toptoon.net/assets/v1/img/layout/icon_event2.png) no-repeat center; background-size: 20px 20px; display: inline-block; vertical-align: middle;}
        @media (min-width: 1200px) {.title_wrap .title_area .title{color: #e63740; font-size: 18px; height: 50px; vertical-align: middle;}}
        .subMenuTab{display: flex; flex-direction: row; flex-wrap: nowrap; justify-content: space-between;}
        @media (max-width: 1199px) {.subMenuTab{width: 100%; background: #f6f6f6; overflow: hidden; align-items: center; padding-bottom: 1px;}}
        @media (min-width: 1200px) {.subMenuTab{float: right;}}
        .subMenuTab li{text-align: center;}
        @media (max-width: 1199px) {.subMenuTab li{position: relative; flex-grow: 1;}}
        @media (min-width: 1200px) {.subMenuTab li{float: left; line-height: 50px;}}

        .subMenuTab a.active{color: #e63740;}
        .subMenuTab a{display: inline-block; color: #111; text-align: center; position: relative; width: 100%; font-size: 12px;}
        @media (max-width: 1199px) {.subMenuTab a{line-height: 37px; margin-bottom: 2px;}}
        @media (min-width: 1200px) {.subMenuTab a{font-size: 15px; margin-top: 3px; width: 130px;}}
        @media (max-width: 1199px) {.subMenuTab a.active{margin-bottom: 0; border-bottom: 2px solid #E74C3C;}}
        @media (min-width: 1200px) {.subMenuTab a.active{height: 50px; border-radius: 10px 10px 0px 0px; border-top: 3px solid #E74C3C; border-left: 1px solid #ddd; border-right: 1px solid #ddd; border-bottom: 0px; background-color: #FFF; margin-top: 0;}}
        .subMenuTab img{height: 16px; margin-right: 10px;}
        /* Comic list */
        .comic_area{font-size: 0px;/*dom 사이 여백 없애기 위한 처리*/}
        @media (max-width: 1199px) {.comic_data_wp{width: 100%; padding-top: 7px !important;}}
        @media (min-width: 1200px) {.comic_data_wp{width: 1200px; margin: 0 auto !important; padding-top: 15px !important; clear: both;}}
        .comic_data_wp .comic_area{position: relative;}
        @media (max-width: 1199px) {.comic_data_wp .comic_area{min-height: 40vh; padding: 0 3px;}}
        @media (min-width: 1200px) {.comic_data_wp .comic_area{width: 1200px; min-height: 400px; margin: 0 auto; margin-bottom: 5px;}}
        .comic_data_wp .loading-container{position: absolute !important; display: block;}
        @media (max-width: 1199px) {.comic_data_wp .loading-container{top: 10vh;}}
        @media (min-width: 1200px) {.comic_data_wp .loading-container{top: 180px;}}
        /*Photo*/
        .comic_area .list_area li{display: inline-block; background: #fff; position: relative; margin: 0 5px 15px; text-align: left; font-size: 14px;}
        @media (max-width: 320px) {.comic_area .list_area li{width: calc((100% - 20px) / 2);}} /* 페이지당 출력수 / x 개 */
        @media (min-width: 321px) and (max-width: 430px) {.comic_area .list_area li{width: calc((100% - 30px) / 3);}}
        @media (min-width: 431px) and (max-width: 639px) {.comic_area .list_area li{width: calc((100% - 40px) / 4);}}
        @media (min-width: 640px) and (max-width: 1199px) {.comic_area .list_area li{width: calc((100% - 50px) / 5);}}
        @media (min-width: 1200px) {.comic_area .list_area li{width: calc((100% - 60px) / 6); border: 1px solid #ddd; border-radius: 10px;}}
        .comic_area .thumb_area{position: relative;}
        .comic_area .scale{border-radius: 9px; overflow: hidden;}
        .comic_area .thumb.square, .comic_area .thumb.rectangle{display: none;} /* 두 종류의 썸네일은 기본적으로 비노출 */
        .comic_area .thumb .thumb_img{background-size: cover; background-position: center; width: 100%; height: 0px; padding-top: 149%; background-color: #efefef;} 
        .comic_area .thumb_info{margin-top: 5px; font-size: 11px; color: #666; position: relative; text-overflow: ellipsis; white-space: nowrap; overflow: hidden;}
        @media (min-width: 1200px) {.comic_area .thumb_info{font-size: 12px; line-height: 16px; padding: 10px 12px;}}
        .comic_area .line_tit{margin-bottom: 2px; display: flex; flex-direction: row; flex-wrap: nowrap; justify-content: flex-start; align-items: stretch;}
        .comic_area .line_tit .title{font-size: 12px; color: #000; letter-spacing: -1px; padding-right: 2px; text-overflow: ellipsis; overflow: hidden; white-space: nowrap; display: inline-block;}
        @media (min-width: 1200px) {.comic_area .line_tit .title{font-size: 15px;}}
        .comic_area .ep_title{float: left; width: calc(100% - 35px); line-height: 18px; margin-bottom: 3px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;}
        .comic_area .ep_title_viewed{display: none;}
        .comic_area .ep_subTitle{display: none;}
        .comic_area .ep_subTitle::before{content: " - "}
        .main_area_01 .comic_area .ep_subTitle{display: inline;}
        .comic_area .ep_point{float: right; letter-spacing: -0.4px;}
        @media (max-width: 1199px) {.comic_area .ep_point{line-height: 14px;}}
        @media (min-width: 1200px) {.comic_area .ep_point{line-height: 18px;}}
        .comic_area .epicon_starpoint:after{content: '★'; font-size: 14px; color: #e73844;}
        /* 뱃지,작가 */
        .comic_area .author{display: none;}
        .comic_area .freeCnt{display: none;}
        .comic_area .badge{width: 100%; overflow: hidden; float: left; margin-top: 2px; position: relative;}
        @media (max-width: 767px) {.comic_area .badge{ height: 16px;}}
        @media (min-width: 768px) {.comic_area .badge{ height: 18px;}}
        .comic_area .badgeList{position: absolute;}
        .comic_area .hashTag{display: none;}
        .comic_area .viewedCntInfo{display: none;}  

        .comic_area .list_area_none{width:100%; height:500px; text-align:center; margin-top:200px; font-size: 14px;}
        .comic_area .list_area_none .noneTxt{display:none;}
        .comic_area .list_area_none .noneTxt[data-type='default']{display:block;}
        /* 뱃지 아이콘 */
        .list_area .rank{display: none;}
        .list_area .adult{background: rgb(230, 55, 64); color: #fff; font-family: 'arial', 'tahoma', 'sans-serif'; font-weight: bold; position: absolute; border-radius: 20px; text-align: center; letter-spacing: -1px; z-index: 3; font-size: 11px; display: block; padding-right: 2px;}
        @media (max-width: 767px) {.list_area .adult{width: 18px; height: 18px; line-height: 18px; top: 4px; right: 4px;}}
        @media (min-width: 768px) {.list_area .adult{width: 20px; height: 20px; line-height: 20px; top: 6px; right: 6px;}}
        .list_area .adult:after{content: "18"}
        @media (max-width: 1199px) {.list_area .adult{opacity: 0.7;}}
        .list_area .thumb_area.opacity{filter: opacity(0.3);}
        .list_area .purchase100{position: absolute; width: 100%; height: 0px; padding-top: 150%; left: 0px; top: 0px;}
        .list_area .comicBox[data-lang='tw'] .purchase100{background: url(//ballerina.toptoon.net/assets/v1/img/layout/badge/tw/collectAll.png) no-repeat center; background-size: 60%;}
        .list_area .comicBox .leftSideIcon{position: absolute; bottom: 0; left:calc(6 / 30 * 15% * -1); width: 100%; padding-bottom: 12px;}
        .list_area .comicBox .onePlusOne{display: block; height: 0;}
        @media (max-width: 767px) {.list_area .comicBox .onePlusOne{width: 22%; padding-top: calc(34 / 30 * 22%);}}
        @media (min-width: 768px) {.list_area .comicBox .onePlusOne{width: 18%; padding-top: calc(34 / 30 * 18%);}}
        .list_area .comicBox .waitFree{display: block; width: 30%; height: 0; padding-top: calc(38 / 83 * 30%);}
        .list_area .comicBox[data-lang='tw'] .onePlusOne{background: url(//ballerina.toptoon.net/assets/v1/img/layout/badge/tw/onePlusOne.png) no-repeat center; background-size: contain;}
        .list_area .comicBox[data-lang='tw'] .waitFree{background: url(//ballerina.toptoon.net/assets/v1/img/layout/badge/tw/waitFree.png) no-repeat center; background-size: contain;}

        .list_area .comicBox .thumb_info i{float: left; margin-right: 3px;}
        .list_area .comicBox .badgeUp .tagUp{margin: 2px 3px; width: 20px; height: 13px; background: url(//ballerina.toptoon.net/assets/v1/img/layout/badge/tw/up.png) no-repeat center; background-size: contain;}
        @media (max-width: 1199px) {.list_area .comicBox .badgeUp .tagUp{margin: 3px 0 0 3px; width: 20px;}}
        @media (min-width: 1200px) {.list_area .comicBox .badgeUp .tagUp{margin: 2px 3px; width: 20px;}}

        .list_area .comicBox[data-lang='tw'] .badge .new{background: url(//ballerina.toptoon.net/assets/v1/img/layout/badge/tw/new.png) no-repeat center; background-size: contain;}
        .list_area .comicBox[data-lang='tw'] .badge .recommend{background: url(//ballerina.toptoon.net/assets/v1/img/layout/badge/tw/recommend.png) no-repeat center; background-size: contain;}
        .list_area .comicBox[data-lang='tw'] .badge .free{background: url(//ballerina.toptoon.net/assets/v1/img/layout/badge/tw/free.png) no-repeat center; background-size: contain;}
        .list_area .comicBox[data-lang='tw'] .badge .discount{background: url(//ballerina.toptoon.net/assets/v1/img/layout/badge/tw/discount.png) no-repeat center; background-size: contain;}
        .list_area .comicBox[data-lang='tw'] .badge .end{background: url(//ballerina.toptoon.net/assets/v1/img/layout/badge/tw/end.png) no-repeat center; background-size: contain;}
        .list_area .comicBox[data-lang='tw'] .badge .end2{background: url(//ballerina.toptoon.net/assets/v1/img/layout/badge/tw/end2.png) no-repeat center; background-size: contain;}
        .list_area .comicBox[data-lang='tw'] .badge .bl{background: url(//ballerina.toptoon.net/assets/v1/img/layout/badge/tw/bl.png) no-repeat center; background-size: contain;}
        .list_area .comicBox[data-lang='tw'] .badge .lang_cn{background: url(//ballerina.toptoon.net/assets/v1/img/layout/tw/badge/lang_cn.png) no-repeat center; background-size: contain;}
        .list_area .comicBox[data-lang='tw'] .badge .see{background: url(//ballerina.toptoon.net/assets/v1/img/layout/badge/tw/see.png) no-repeat center; background-size: contain;}
        .list_area .comicBox[data-lang='tw'] .badge .gift{background: url(//ballerina.toptoon.net/assets/v1/img/layout/badge/tw/gift.png) no-repeat center; background-size: contain;}
        @media (min-width: 768px) {
            .list_area .comicBox[data-lang='tw'] .badge .new{width: 28px; height: 18px;}
            .list_area .comicBox[data-lang='tw'] .badge .recommend{width: 28px; height: 18px;}
            .list_area .comicBox[data-lang='tw'] .badge .free{width: 28px; height: 18px;}
            .list_area .comicBox[data-lang='tw'] .badge .discount{width: 28px; height: 18px;}
            .list_area .comicBox[data-lang='tw'] .badge .end{width: 28px; height: 18px;}
            .list_area .comicBox[data-lang='tw'] .badge .end2{width: 50px; height: 18px;}
            .list_area .comicBox[data-lang='tw'] .badge .bl{width: 20px; height: 18px;}
            .list_area .comicBox[data-lang='tw'] .badge .lang_cn{width: 41px; height: 18px;}
            .list_area .comicBox[data-lang='tw'] .badge .see{width: 49px; height: 18px;}
            .list_area .comicBox[data-lang='tw'] .badge .gift{width: 49px; height: 18px;}
        }


        /* lazy load */
        .lazy{background-size: cover; background-position: center; background-image: url(//ballerina.toptoon.net/assets/v1/img/layout/img_nowloading.png);} 
    </style>


    <style>
        #btnSet{
            width: 20%;
            /*border: 1px solid red;*/
            height: 100%;
            display: flex;
            flex-direction: row;
            color: #3f4a56;
        }
        #btnSet div{
            margin-top: 35px;
            border:1px solid gainsboro;
            width: 50%;
            height: 30px;
            text-align: center;
            color: #3f4a56;

            padding-top: 2px;;     
        }
        /*
        */      
        #CollectionContent ,#CustomContent{
            display: flex;
            width: 100%;
            margin-left: 5%;
            margin-top: 80px;
            flex-wrap :wrap;
            /*border: 1px solid gainsboro;*/
            width: 68%;

        }


        #cm ,#customItem{
            /*border: 1px solid red;*/
            width: 25%;
            height: 400px;
            padding: 20px;

        }
        #customItem{
            height: 300px;

        }
        #collection ,#CustomContainer{
            width: 100%;
            height: 100%;
            /*border: 1px solid red;*/

        }
        #imageViewer{
            width: 100%;
            /*border: 1px solid red;*/
            height: 80%;

            box-shadow: 5px 3px #dce0e5;
            border-radius: 3px;


        }
        img{
            width: 100%;
            height: 100%;
        }/*
        */        #desCri{
            width: 100%;
            height: 10%;
            margin-top: 20px;
            border: none;
        }

        #comicName{
            color: #6e7e8c;
            text-align: center;
            display: inline-block;
            font-size: 16px;
            width: 100%;
            font-family: AppleMyungjo;

        }
        #customizeContainer{
            /*border: 1px solid red;*/
            /*border-radius: 50px;*/
            width: 100%;
            box-shadow: 5px 3px #dce0e5;
            /*height: %;*/

        }


        #circle{
            height: 120px;
            width: 120px;
            border-radius: 50%;
            display: inline-block;
            border: 1px dotted #3b506b;
            text-align: center;
            margin-top: 35px;
            margin-left: 40px;


        }
        #circle>span{
            color: #aeb1b5;
        }
        #plus{
            font-size: 20px;
            margin-top: 20px;

            display: inline-block;
        }

        #customCover{
            height:80%;
            width: 100%;
        }
        #CustomContainer{
            box-shadow: 3px 1px 10px #b0b0de;
            border-radius: 3px;
        }
        #cusDes{
            text-align: center;
            color: #c2c4c8;
        }
        #custName{
            display: inline-block;
            margin-top: 2px;
        }
        #custDate{
            font-size: 13px;
        }
        #gItem{         
            position: absolute;
            width: 14.3%;
            height: 260px;
            z-index: 30;

            background:rgba(0,0,0,0.6);
            visibility: hidden;
        }
        #gItem:hover{
            visibility: visible;
        }



    </style>
    <script src="js/ImageTranslator.js"></script>
    <script>

        var it = new ImageTranslator();
        var btnCus = false;
        var btnCol = true;
        var customList = [];

        function getCustomBook() {


            $.ajax({
                url: "texting",
                type: "get",
                data: {operation: "getCustomBook"},
                success: function (res) {
                    $("#CustomContent").html("");

                    var s = "<div id='customItem' onclick='createBookPanel()'>" +
                            "<div id='CustomContainer' style='box-shadow:1px 2px 10px rgba(169, 164, 164, 0.6);'>" +
                            "<div id='circle'>" +
                            "<span id='plus'>+</span><br>" +
                            "<span>Create New Book</span>" +
                            "</div>" +
                            "</div>" +
                            "</div>"





                    $("#CustomContent").append(s);
                    var item = JSON.parse(res);
                    for (var w = 0; w < item.length; w++) {

                        $("#CustomContent").append(createCustomLayout(item[w], w));



                    }
                    alert($("#CustomContent #customItem").length)
                }


            })

        }

//        

        function remove() {

            for (var i = 1; i < $("#CustomContent #customItem").length; i++)
                $("#CustomContent #customItem").eq(i).remove()


        }
        function showItem(index) {
            window.location.href = "texting?operation=showBook&cid=" + index
//        alert(index);
        }

        function sendRedirect(cid) {

            window.open("ReadBookController?operation=SelectComic&comicId=" + cid)
//            window.location.href="";



        }


        $(document).ready(function () {

            $("#CustomContent").hide();
//            $("#CollectionContent").hide();


            getComicWorks()
            setColor(btnCol, "#Collections");
            $("#Custom").click(function () {
                btnCus = true
                btnCol = false;
                optEffection()
                $("#CollectionContent").hide();
                $("#CustomContent").show();
                getCustomBook()



            })

            $("#Collections").click(function () {
                btnCus = false;
                btnCol = true;
                optEffection()
                $("#CollectionContent").show();
                $("#CustomContent").hide();
                getComicWorks()
            })


        })
        function getComicWorks() {
            $("#CollectionContent").html("")
            $.ajax({
                url: "Bookcase",
                type: "get",
                data: {action: "showCollection"},
                success: function (res) {
                    var item = JSON.parse(res);

                    for (var s = 0; s < item.length; s++) {
                        var no = "Collection" + s
                        var blob = it.base64ToBlob(item[s].img);
                        var str = "<div id='cm' >" +
                                "<div id='collection'>" +
                                "<div id='imageViewer' class='" + no + "' onclick='sendRedirect(" + item[s].cid + ")'></div>" +
                                "<div id='desCri'><span id='comicName'>" + item[s].name + "</span></div>" +
                                "</div></div>";
                        it.preLoad(blob, "." + no)
                        $("#CollectionContent").append(str);
                    }
                }

            })






        }

        function optEffection() {
            setColor(btnCus, "#Custom")
            setColor(btnCol, "#Collections")
        }

        function  setColor(btn, id) {
            if (btn)
                $(id).css({background: "#7c96b8", color: "white"})
            else
                $(id).css({background: "none", color: "#3f4a56"})
        }

        function  createCustomLayout(item, index) {

            var blob = it.base64ToBlob(item.cover);
            var code = "Cust" + item.cid;
            var str = "<div id='customItem'>" +
                    "<div id='CustomContainer' onclick='showItem(" + item.cid + ")'>" +
                    "<div id='customCover' class='" + code + "'></div>" +
                    "<div id='cusDes'>" +
                    "<span id='custName'>" + item.name + "</span><br>" +
                    "<span id='custDate'>Created on " + item.date + "</span>" +
                    "</div></div></div>";

            it.preLoad(blob, "." + code);
            return str;


        }

        function createBookPanel() {
            window.location.href = 'CustomBook2.jsp';
        }




    </script>
    <script>


        function CustomBook(url, cid) {
            this.url = url;
            this.cid = cid;

            CustomBook.prototype.getUrl = function () {
                return this.url;
            }
            CustomBook.prototype.getCid = function () {
                return this.cid;
            }



        }



    </script>

    <body>
        <jsp:include page="sideBar/MsideBar.jsp" />
        <div style="position: absolute;z-index: 40;left: 75%;width: 100%;height: 100%;color: red">
            <div id="btnSet">
                <div id="Collections">Collections</div>
                <div id="Custom">Custom</div>              
            </div>
        </div>
        <div id='CustomContent'>
            <div id='customItem'>
                <div id='CustomContainer' style="box-shadow:1px 2px 10px rgba(169, 164, 164, 0.6);">
                    <div id="circle">
                        <span id="plus">+</span><br>
                        <span>Create New Book</span>
                    </div>
                </div>
            </div>

        </div>








        <div id="CollectionContent"></div>


    </body>
</html>
