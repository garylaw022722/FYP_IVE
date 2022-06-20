<%@page import="ict.imageTranslator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ict.bean.ComicTypeBean"%>
<%@page import="ict.db.ComicTypeDB"%>
<%@page import="ict.db.ComicTypeDB"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Title</title>
        <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>-->
        <!--    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">-->
        <!--        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>-->
        <!--    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">-->

    </head>
    <style type="text/css">
        #typeList {
            /*border: 1px solid  red;*/
            display: flex;
            flex-direction: row;
            width: 80%;
            flex-wrap: wrap;
            margin: auto;
        }

        #typeContainer {
            width: 24%;
            margin-bottom: 20px;
            margin-right: 10px;
            height: 95px;
            padding: 5px;
            border-radius: 3px;
            box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.2);
            display: flex;
        }

        img {
            width: 100%;
            height: 100%;
        }

        #typeImage {
            width: 40%;
        }

        #typeText {
            color: #3b506b;
            font-family: "New Peninim MT";
            margin-left: 40px;
            padding-top: 28px;
            font-size: 18px;
            /*border: 1px solid red;*/

        }

        #ype {
            color: #ea6e8a;
            font-size: 20px;
            margin-bottom: 60px;
            background: rgba(255,255,255,0.8);
            width: 79%;
            /*text-align: center;*/
            padding: 10px;
            /*padding-left: 30px;*/
            border: 1px solid;
            margin-left: 10%;
            padding-left: 20px;
            /*border-left: px;*/
            border: none;
            margin-top: 30px;
            border-left: 8px solid ;

            box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.2);

        }

    </style>
    <script>
        $(document).ready(function () {
            getType();

            $("#typeList").click(function (e) {

                var sources = $(e.target).attr("alt").trim();
                window.location.href = "ReadBookSearching.jsp?field=Recent Update&searchBy=comicType&comicType=" + sources
            })




        })
        function getType() {
            $.ajax({
                url: "ProductController",
                type: "get",
                data: {operation: "getType"},
                success: function (res) {
                    var item = JSON.parse(res);
                    for (var s = 0; s < item.length; s++)
                        $("#typeList").append(createTypeList(item[s], s))
                }

            })





        }

        function createTypeList(item, s) {

            var code = 'tl' + s;
            var str = "<div id='typeContainer' alt='" + item.type + "'>" +
                    "<div id='typeImage'  alt='" + item.type + "' class='" + code + "'></div>" +
                    "<div id='typeText' alt='" + item.type + "' >" + item.type + "</div>" +
                    "</div>";
            var imageParse = it.base64ToBlob(item.image)
            it.preLoad(imageParse, "." + code);


            return str;

        }

        function getTypeSearch(sources) {
            window.location.href = "ReadBookSearching.jsp?field=Recent Update&searchBy=comicType&comicType=" + sources
        }

    </script>
    <body>
        <div id="ype"><i class="bi bi-bookmarks" style="padding-right: 10px"></i><span>Comic Type List</span></div>
        <div id="typeList">


        </div>

    </body>
</html>