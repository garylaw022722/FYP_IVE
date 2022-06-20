<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
    <head>
<META http-equiv="Content-Type" content="text/html; charset=Shift_JIS">
        <title>Title</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">

        <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.5.1/main.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.5.1/main.min.css">
        <link rel="stylesheet" href="css/clientS.css">
        <script src="js/ImageTranslator.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
    </head>
    <style type="text/css">
        #topNav{
            top:0;
        }

        #contentRS {
            /*background-color: #859dc1;*/
            width: 62%;
            margin: auto;
        }

        #searchBtnX {
            background-color: #5c6d83;
            border: none;
            outline: none;
            border-radius: 3px;
            padding: 12px;
        }

        #SEheading {
            position: absolute;
            font-family: "Al Nile";
            color: #859dc1;
            top: 160px;
            left: 20%;
            /*font-size;*/
            text-align: center;
            /*border: 1px solid red;*/
            width: 50%;


        }

        #sez {
            background-color: #3f4a56;
        }

        #displayRS {
            display: flex;
            /*border: 1px solid red;*/
            width: 100%;

            margin-top: 25%;

        }

        #contentRS h4 {
            color: #aba8a8;
            padding: 5px;
            /*box-shadow: 0px 5px 10px #3b506b;*/
            padding-bottom: 10px;
            border-bottom: 1px solid #bcbec1;
            font-style: italic;
            margin-bottom: 20px;
        }

        #resultMS {
            display: flex;
            flex-wrap: wrap;
        }

        #contentItem {
            width:47.5%;
            height: 150px;
            flex-direction: row;
            display: flex;
            background-color: rgba(255, 255, 255, 0.8);
            margin-bottom: 20px;
            /*margin-left: 10px;*/
            margin-right: 2.5%;
            /*border-radius: px;*/
            /*box-shadow: 4px 5px 10px #bbbfc4;*/
            padding-top: 5px;


            border-bottom: 1px solid #d8dde5;
        }

        #imgv {
            width: 35%;
            padding: 8px;
            /*border:1px solid red;*/
            height: 100%;
        }

        #contentSa {
            width: 65%;
            padding: 15px;
            padding-left: 20px;


            /*border: 1px solid red;*/
            height: 100%;
            /*background-color: #3b506b;*/
        }

        img {
            width: 100%;
            height: 100%;
        }

        #hd {
            font-size: 22px;
            color: #3f4748;
            font-family: "Al Nile";
        }

        #ad {
            font-size: 16px;
            color: #acacb5;
        }

        #readDetails {
            /*width: 100%;*/
            /*padding: 5px;*/
            border: none;
            background-color: #ff6491;
            /*background-color: #c5f4fc;*/
            color: whitesmoke;
            /*padding: 4px;*/
            border-radius: 2px;
            margin-top: 15px;
        }
        #resultSet{
            background: rgba(255,255,255,0.9);
        }
        #resultSet div:hover{
            background: #e1e1e1;
            cursor: pointer;

        }
    </style>
    <body>



        <script>

            $(document).ready(() => {

                var Hintscount = 0;
                var backFirst = true;
                var hintTest = "";




                $("#searchBtnX").click(function () {
                    send();

                })

            <%
                String json = "";
                if (request.getAttribute("jsonResult") != null) {
                    json = request.getAttribute("jsonResult").toString();%>

                var item = <%=json%>
                $("#key").text("<%=request.getAttribute("key")%>")
                for (var s = 0; s < item.length; s++) {
                    var str = setResultSet(item[s].cover, item[s].name, item[s].penName, item[s].cid, s);
                    $(str).appendTo("#resultMS");
                }

            <%
                    request.removeAttribute("jsonResult");
                    request.removeAttribute("key");
                }

            %>




                $("#clientEngine").keyup(function (e) {

                    var key = $(this).val();


                    var code = e.keyCode || e.which;

                    if ( code == 13)
                        send();


                    else if (code == '40' && $("#resultSet div").length > 0) {
                        if (!backFirst) {
                            Hintscount += 1;
                            backFirst = true;
                        }

                        if (Hintscount == $("#resultSet div").length)
                            Hintscount = 0;
                        console.log(Hintscount)
                        ScreenEffect($(this), Hintscount);
                        Hintscount++;

                        return;
                    } else if (code == '38' && $("#resultSet div").length > 0) {

                        if (backFirst) {
                            Hintscount -= 1;
                            backFirst = false
                        }
                        if (Hintscount < 0)
                            Hintscount = $("#resultSet div").length - 1;
                        Hintscount--;
                        ScreenEffect($(this), Hintscount);
                        return;
                    } else if (/^\s+?/.test(key))
                        return;

                    else if ($("#clientEngine").val().length == 0) {
                        $("#resultSet").html("");
                        return
                    }



                    $.ajax({
                        url: "SearchingEngine",
                        type: "get",
                        data: {
                            operation: "eBookSearch",
                            keyWords: key,
                            stage: "searching"
                        }, success: function (res) {
                            var item = JSON.parse(res);
                            var str = "";
                            for (var s = 0; s < item.length; s++) {
                                var output = item[s];

                                str += "<div>" + output + "</div>";

                            }
                            Hintscount = 0;
                            backFirst = true;
                            hintTest = "";
                            $("#resultSet").html(str);
                            //                           alert(str);
                        }


                    })
                })



            })

            function  ScreenEffect(dir, Hintscount) {
                dir.val($("#resultSet div").eq(Hintscount).text())
                $("#resultSet div").eq(Hintscount).css({backgroundColor: "#e1e1e1"})
                $("#resultSet div").eq(Hintscount).siblings().css({backgroundColor: "rgba(255,255,255,0.9)"})
            }

            function send() {

                var keys = $("#clientEngine").val();
                var query = "SearchingEngine?operation=eBookSearch&key=" + keys + "&stage=searched";
                window.location.href = query;

            }


            function  setResultSet(img, name, author, cid, index) {
                var layout = (index % 2 == 0) ? " <div id='contentItem'>" : "<div id='contentItem' style='margin-left:2.5%;margin-right: 0%'>"
                var it = new ImageTranslator();

                var sa =
                        layout +
                        "<div id='imgv' class='" + index + "'></div>" +
                        "<div id='contentSa'>" +
                        "<div id='hd'>" + name + "</div>" +
                        "<div id='ad'>" + author + "</div>" +
                        "<button id='readDetails'   onclick='find(" + cid + ")'>Read details</button>" +
                        " </div> "
                var ts = "." + index;
                preLoad(it.base64ToBlob(img), ts);


                return sa;
            }

            function find(cid) {

                window.location.href = "ReadBookController?operation=SelectComic&comicId=" + cid
            }


            function  preLoad(Blob, id) {
                var reader = new FileReader();
                reader.addEventListener("loadend", function () {
                    var image = new Image();
                    image.src = this.result;
                    $(id).append(image);
                }, false);

                reader.readAsDataURL(Blob);
            }






        </script>
        <div id='nav2'>
            <jsp:include page="parts/memberNav2.jsp"/>
        </div>


        <div id="sez">

            <h2 id="SEheading">---------- Comic Works Name && Author ---------</h2>
            <div id="clientSearchContainer" class="ske">
                <input type="text"  id="clientEngine"> <button id="searchBtnX">Search</button>
                <div id="resultSet"></div>
            </div>
        </div>
        <div id="displayRS">
            <div id="contentRS">
                <h4>「<span id="key"></span>」 founded Result </h4>
                <div id="resultMS"></div>
            </div>
        </div>
    </div>


</body>
</html>