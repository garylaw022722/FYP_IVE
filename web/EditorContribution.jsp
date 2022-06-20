<%-- 
    Document   : meetingRequestPanel
    Created on : 27-Feb-2021, 18:11:32
    Author     : law
--%>

<%@page import="ict.bean.ContributeBean"%>
<%@page import="ict.db.ContributeDB"%>
<%@page import="ict.imageTranslator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ict.bean.meetingRequestBean"%>
<%@page import="ict.db.meetingRequestDB"%>
<%@page import="ict.servlet.meetingRequest"%>
<%@page  import="ict.bean.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="js/ImageTranslator.js"></script>
        <script src="https://kit.fontawesome.com/df4f1b5dd7.js" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
        <link rel="stylesheet" href="css/EditorController.css">
        <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.5.1/main.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.5.1/main.min.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>

        <link rel="stylesheet" href="css/EditorContri.css">
    </head>
    <style>
        #scan ,#scan2 {
            background: #eef1f8;

            width: 50%;
            height: 270px;
            overflow: auto;
            opacity: 0.9;
            left: 22%;
            position: fixed;
            box-shadow: 1px 1px 20px rgba(0, 0, 0, 0.7);
            top: 150px;
            border-radius: 2px;
            display: none;
            z-index: 120;

        }
        #scan2{
            top:50px;
        }
        #alBar {
            background-color: #3b506b;
            padding: 10px;
            color: #eef1f6;
        }

        #closeBtnn {
            font-size: 20px;
            display: flex;
            float: right;

        }

        textarea {
            margin-top: 20px;
        }

        #titleAlert {
            font-size: 18px;
            font-family: ".AppleSystemUIFont ";
            display: inline-block;
            width: 100%;
        }

        #alertContact {

            padding: 10px;
            width: 65%;
            padding-left: 15px;
            /*background-color: #3b506b;*/
            /*color: whitesmoke;*/
            /*border: 1px solid #ccccd0;*/
            /*margin: auto;*/
            color: #3f4a56;
            margin-left: 21%;
            margin-top: 10px;

            line-height: 33px;
        }

        #smr {
            display: inline-block;
            /*float: right;*/

            background-color: #3b506b;
            margin-left: 35%;
            margin-top: 14px;
            width: 30%;
            padding: 5px;
            color: #eef1f6;
        }

        #commentArea div {
            /*margin-top: 0px;*/
            margin-bottom: 13px;
            margin-left: 3%;
            /*border-bottom: 2px solid grey;*/
        }
        #commentArea{
            margin-top: 15px;
        }
        #scan2 {
            height: 460px;
            width: 70%;
        }

        #ss {
            font-size: 17px;
            color: #3f4a56;
        }
        #sst{
            font-size:17px;
            font-style: italic;
        }

        #cmt{
            background-color:#3b506b;
            color: white;
            float: right;
            padding: 5px;
            width: 10%;
            margin-right: 30px;
            margin-top: 8px

        }
        #scan2 textarea{
            width: 95%;
            margin: auto
        }
        #scan2{
            top:100px;
            left:15%
        }

        #editButton{
            visibility: hidden;
            position: absolute;
            z-index: 60;
            top:150px;
            border: none;
            left: 92%;
            color: white;
            background-color: #3b506b;

        }

    </style>
       <%Account editor = (Account)request.getSession().getAttribute("editor");%>
    
    <%if(editor==null){%>
    <script>window.location.href = "Login2.jsp";</script>
    <%}%>
    
    <script>
        var it = new ImageTranslator();

        $(document).ready(function () {
//            $("#dateTime").val(new Date.getUTCDate())
            var sender = "";
            var preIndex;
            var boxIndex;

            getAllContribution();

            $("#scan2 #closeBtnn ,#scan #closeBtnn").mouseenter(() => {
                $("#scan2 #closeBtnn ,#scan #closeBtnn").css({color: "#98c8b5"})
            })
            $("#scan2 #closeBtnn ,#scan #closeBtnn").mouseleave(() => {
                $("#scan2 #closeBtnn ,#scan #closeBtnn").css({color: "white"})
            })

            $("#closeBtnn ,.closeCommant").click(() => {
                $("#msgBox").hide();
            })



            $("#cmt").click(function () {

                $("#scan2").hide()
                var comment = $("#commenta").val();
               
                $.ajax({
                    type: "get",
                    url: "Contribution",
                    data: {operation: "comment", conId: boxIndex, com: comment},
                    success: function (res) {
                        alert("Commend Successful")


                    }
                })


            })

            $("table").click(function (e) {
                var func;
                var operation;
                var con;
                if (e.target.tagName == "A" && e.target.id != "fn") {
                    con = $(e.target).attr("alt")
                    boxIndex = e.target.className;
                    alert("it is called")
                    if (e.target.id == "comment") {
                        operation = "getComment"
                        func = Comment;
                    } else if (e.target.id == "viewDetails") {
                        operation = "showContributeDetails"
                        func = displayDetails;
                        alert("viewDetails button is callee ,  conId = " + e.target.className);
                    } else if (e.target.id == "cont") {

                        operation = "showContact"
                        func = showSenderContact;
//                        alert("contact button is called , conId = " + e.target.className);

                    }
                    $.ajax({
                        type: "get",
                        url: "Contribution",
                        data: {operation: operation, conId:boxIndex},
                        success: function (res) {
                            $("#msgBox").show();
                            var item = JSON.parse(res)
                            callBack(func, item, con);
                        }


                    })

                }

            })

            $("#fieldSender #sender").click(function () {


                if (sender == $(this).val())
                    sender = "";
                else
                    sender = $(this).val()

                var leng = $(this).siblings().length;
                checkboxLogic(leng, $(this));





            })

            $("#find").click(() => {
                for (var s = $("table tr").length; s >= 1; s--) {

                    $("table tr").eq(s).remove();

                }


                var result = "";
                var text = $("#meetingSE").val();
                var date = $("#dateTime").val();
                alert(date + "\n" + text + "\n" + sender)

                $.ajax({
                    type: "get",
                    url: "Contribution",
                    data: {operation: "searchContribute", textContent: text, Date: date, Sender: sender},
                    success: function (res) {
                        alert(res);


                        if (res.length == 2)
                            alert("no Matching result")
                        else {
                            var sa = JSON.parse(res);
                            alert(sa.length)
                            configData(sa);
//                        alert(leng)



                        }

                    }
                })

            })



        })

        function callBack(func, item, con) {

            func(item, con);
        }

        function showSenderContact(item, con) {
            var app = "", ComicName = "", S = "";

            alert(JSON.stringify(item))
            $("#scan").siblings().hide();
            $("#scan").show();

            if (getTableData(con, 3) !== "N/A") {
                ComicName = getTableData(con, 4) + ", ";
                app = getTableData(con, 3) + "(" + item[0].name + ")";
            } else {
                app = item[0].name;
            }
            S = getTableData(con, 5);

            $("#sendItem").text(ComicName + S)
            $("#sendName").text(app);
            $("#tel").text(item[0].contactNo);
            $("#period").text(item[0].period)




        }
        function getTableData(rowNum, colNum) {
            return  $("#checkList tr").eq(rowNum).find("td").eq(colNum).text()
        }

        function Comment(item, con) {
            var sender = "";
            var msg = "";
            $("#scan2").siblings().hide();

            var eAddress = getTableData(con, 2);
            var title = getTableData(con, 5)
            var cm = "";

            if (getTableData(con, 3) != "N/A") {
                sender = eAddress + " - " + getTableData(con, 3)
                cm = getTableData(con, 4) + " - "
            } else {
                sender = eAddress
            }
//            if(item[0].comment == null)
//                alert("ssa")
//            else {
            msg = item[0].comment;
//                $("#commenta").prop("disabled" ,true)
//            }
           
//          
            $("#reciver").text(sender)
            $("#sst").text("  " + cm + title)
            $("#commenta").val(msg);
            $("#scan2").show()




        }
        function displayDetails(item, con) {

            alert(item)
            alert(con)
        }

        function  checkboxLogic(leng, id) {

            for (var s = 0; s < leng; s++) {
                if ($(id).siblings().eq(s).prop("tagName") == "INPUT") {
                    $(id).siblings().eq(s).prop("checked", false)

                }



            }



        }

        function preloader(file, classN, fileName) {
            var reader = new FileReader();

            reader.addEventListener("loadend", function () {
                var sk = document.createElement("A");
                var m = document.createElement("I");
                m.class = "bi bi-download";
                sk.href = this.result;
                sk.download = fileName;
                sk.appendChild(m);
                sk.appendChild(document.createTextNode("Download"));
                $("." + classN).prepend(sk);
            }, false);

            reader.readAsDataURL(file);
        }




        function tableLayout(conId, subDate, eAddress, penName, comicName, title, url, fileName, color, index) {

            var str = "<tr  style='background-color:" + color + ";'>" +
                    "<td>" + conId + "</td>" +
                    "<td>" + subDate + "</td>" +
                    "<td>" + eAddress + "</td>" +
                    "<td>" + penName + "</td>" +
                    "<td>" + comicName + "</td>" +
                    "<td>" + title + "</td>" +
                    "<td class='" + conId + "'><a id='fn' href='" + url + "' download='" + fileName + "'><i class='bi bi-download'></i> Download</a></td>" +
                    "<td id='optionContainer'>" +
                    "<div class='dropdown' style='display: inline'>" +
                    "<button class='btn btn-primary dropdown-toggle' type='button' data-toggle='dropdown' id='" + conId + "'>" +
                    "<span id='progressBtn'>...</span>" +
                    "</button>" +
                    "<ul class='dropdown-menu' style='margin-left: -40px;margin-top: 20px;''>" +
                    "<li id='contact'><a id ='cont' class='" + conId + "' alt='" + index + "'>Contact to Sender</a></li>" +
                    "<li ><a id='comment' class='" + conId + "' alt='" + index + "'>Comment</a></li>" +
                    "<li><a id='viewDetails' class='" + conId + "' alt='" + index + "'>View details</a></li>" +
                    "</ul>" +
                    "</div>" +
                    "</td>" +
                    "</tr>"


            return str;
        }
        function configData(item) {
            for (var s = 0; s < item.length; s++) {
                var blob = it.base64ToBlob(item[s].file);
                var url = it.ToObjectURL(blob);
                var fileName = item[s].fileName;
                var color = (s % 2 != 0) ? "white" : "none"
                $(tableLayout(item[s].conId, item[s].subDate, item[s].eAddress, item[s].penName,
                        item[s].comicName, item[s].title, url, fileName, color, (s + 1))).appendTo("table")
//                                preloader(blob,item[s].conId ,item[s].fileName)

            }



        }
        function getAllContribution() {
            $.ajax({
                url: "Contribution",
                type: "get",
                data: {operation: "getAllContribution"},
                success: function (res) {
                    var item = JSON.parse(res);
                    configData(item);
                }
            })
        }

    </script>
    <body>
        <div id="msgBox">
            <div id="scan">
                <div id="alBar">
                    Contact information
                    <!--        Sender : garyLakawiwi@gmail.com-->
                    <i class="far fa-times-circle" id="closeBtnn"></i>
                </div>
                <div id="alertContact">
                    <span id="titleAlert">Contribution: <span id="sendItem"></span></span>
                    <!--        <span id="titleAlert">Sender :     garyLakawiwi@gmail.com- </span>-->
                    <span id="titleAlert">Applelican : <span id="sendName"></span></span>
                    <span id="titleAlert">ContactNumber :<span id="tel"></span></span>
                    <span id="titleAlert">Call Back  Time (Available) : <span id="period"></span></span>
                </div>
                <button id="smr">Send Meeting Request</button>         
            </div>
            <div id="scan2">
                <div id="alBar">
                    Comment to Sender
                    <i class="far fa-times-circle closeCommant" id="closeBtnn"></i>
                </div>
                <div id="commentArea">
                    <button id="editButton"><i class="bi bi-pencil"></i></button>
                    <div style="font-size: 17px ;"> To : <span id="reciver"></span></div>
                    <div style="font-size: 15px ;"><span id="ss">Subject  :</span><span id="sst"> MyBoosMyHero, chapter 23</span></div>
                    <textarea  id="commenta" class="form-control"  rows="13" cols="116"></textarea>
                </div>
                <button id="cmt">Comment</button>
            </div>
        </div>
        <div id="topNav"></div>
        <div id="left">
           <%@include file="parts/editorLeftBar.jsp" %>
        </div>
        <div id="reight">
            <div id="contentInsert">

                <div id="toolBar">
                    <div id="toolBarList">
                        <div id="field">
                            <label for="meetingSE">Search Scope</label>
                            <input type="text" id="meetingSE" class="form-control"
                                   placeholder=" Available for Contribution ID, Author name , email Address ,ComicName">
                        </div>
                        <div id="field">
                            <label for="meetingSE">Submission date Time </label>
                            <input class="form-control" type="date"  id="dateTime">
                        </div>
                        <div id="fieldSender">
                            <label class="form-check-label" style="color: #858888;">Sender : </label>
                            <div style="display: inline-block;width: 3%"></div>

                            <input type="checkbox" class="form-check-input" id="sender" value='Member' alt="0" >
                            <label class="form-check-label" >Member</label>
                            <div style="display: inline-block;width: 3%"></div>

                            <input type="checkbox" class="form-check-input" id="sender" value='Author' alt="1">
                            <label class="form-check-label" for="exampleCheck1">Responsible Author</label>
                            <div style="display: inline-block;width: 3%"></div>

                            <input type="checkbox" class="form-check-input" id="sender" value='All' alt="2">
                            <label class="form-check-label" for="exampleCheck1">All</label>
                        </div>

                        <div id="find"><i class="bi bi-search"><span>Search</span></i></div>
                    </div>
                </div>
                <div id="checkList">
                    <table>

                        <tr>
                            <th>Contibution id</th>
                            <th>Submission on</th>
                            <th>Sender</th>
                            <th>Author</th>
                            <th>Comic Name</th>
                            <th>Comic works Title</th>
                            <th>uploded file</th>
                            <th></th>
                        </tr>


                    </table>
                </div>
            </div>


        </div>






    </body>
</html>
