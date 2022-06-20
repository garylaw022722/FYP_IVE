
<%-- 
    Document   : customBook
    Created on : Feb 4, 2021, 7:14:21 PM
    Author     : law
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="js/ComicPageSelection.js"></script>
        <link rel="stylesheet" href="css/CustomBook.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    </head>
    <body>
        <script src="js/ImageTranslator.js"></script>
        <script>
            var json = {};
            var it = new ImageTranslator()

            json.pageCode = [];
            json.sequence = []; 
            $(document).ready(function () {
                $("#outsider").css({visibility: "hidden"})

                $("#showMenu").click(function () {

                    $("#outsider").css({visibility: "visible"})

                })


                $("#main").click(function (e) {

                    if (e.target.tagName !== "DIV") {
                        var k = e.target.parentNode;
                        $("#selection").append(k)
                    }
                })


                $("#close").click(function () {
                    $("#main").children().empty();
                    $("#outsider").css({visibility: "hidden"})

                })



                $("#create").click(function () {
                    var key = filterComicSession();
                    for (var w = 0; w < key.length; w++) {
                        var obj = new ComicPageSelection(key[w]);
                        obj.setComicPage(identifyComicPage(key[w]));
                        json.pageCode.push(obj);
                    }                    
                    getSequenceNumber(); 
             
                    var jsonString = JSON.stringify(json)
                    var formData  = new FormData();
                    formData.append("coverPage",$("#ccp")[0].files[0]);
                    formData.append("jsonString",jsonString);
                    formData.append("bookName","mother fucker");
                
                    alert(jsonString);
                    $.ajax({
                        type: "post",
                        url: "texting",
                        data: formData,             
                        processData: false,
                        contentType: false,
                        success: function (res) {
                            alert(res)
                        }

                    })
//                    window.location.href = "";


                })

                $("#searchBtn").click(function () {
                    $.ajax({
                        url: "SearchingEngine",
                        type: "get",
                        data: {
                            operation: "createCustomBook",
                            cid: $("#cid").val(),
                            ep: $("#ep").val()
                        }, success: function (res) {
                            var item = JSON.parse(res);
                            var str = "";
                            var cm = item[2].comicName
                            alert(cm);
                            var codeKey = item[1].code;
                            var sources = item[0].sourcesCopy;
                            for (var k = 0; k < sources.length; k++) {
                                var blob = it.base64ToBlob(sources[k]);
                                var url = it.ToObjectURL(blob);
                                $("#main").append("<div><img src='" + url + "' name='" + k + "' alt='" + codeKey + "'><div>");

                            }

                            alert(sources[k]);
                        }



                    })
                })

            })

            function  getSequenceNumber() {
                var page = $("#selection div img");
                for (var s = 0; s < page.length; s++) {
                    var pageNo = page.eq(s).attr("name");
                    var comicKey = page.eq(s).attr("alt");
                    json.sequence.push(comicKey + "-" + pageNo);
                }
            }
            function  identifyComicPage(key) {
                var pageSet = [];
                var page = $("#selection div img");
                for (var s = 0; s < page.length; s++) {
                    var session = page.eq(s)
                    if (key == session.attr("alt"))
                        pageSet.push(session.attr("name"));
                }
                return pageSet;
            }


            function   filterComicSession() {
                var comicdKey = [];
                var page = $("#selection div img");
                for (var s = 0; s < page.length; s++) {
                    var session = page.eq(s).attr("alt");
                    if (!comicdKey.includes(session))
                        comicdKey.push(session);
                }
                return comicdKey;
            }



        </script>
        <button id="showMenu">ShowMenue</button>
        <div id="selection"></div>
        <div id="outsider">
            <div id="main"></div>
            <div id="create">Create</div>
            <div id="searchBtn">Search</div>
            <div id="close">close</div>
            <select name="" id="cid">
                <option value="-">Comic id</option>
                <option value="1">1</option>
            </select>
            <select name="" id="ep">
                <option value="-">Episode </option>
                <option value="1">1</option>
                <option value="3113">3113</option>              
                <option value="3165">3165</option>
            </select>
            <input type="file" id="ccp">

        </div>



    </body>
</html>
