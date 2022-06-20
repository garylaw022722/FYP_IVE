<%-- 

Document   : selectComicPage
    Created on : Feb 1, 2021, 4:29:36 PM
    Author     : law
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ict.bean.Account"%>
<%@ page import="java.util.ArrayList" %>
<%@page import="ict.bean.ECommendBean"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>    
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
        <link rel="stylesheet" href="css/pointList.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">

        <!--<link rel="stylesheet" href="css/memberNav.css">-->
        <link rel="stylesheet" href="css/comicSelect.css">
    </head>
    <script src="js/ImageTranslator.js"></script>
    <style>
        body{
            background: #eef1f6
        }
        #cover{
            /*border: 1px solid red;*/
            height: 430px;
        }

        #respond{

            margin:0 auto;
        }
        #respond p{
            margin-bottom: 20px;
        }

        #respond .commentfields {
            float: left;
            margin-bottom: 10px;
            width: 100%;
        }

        #respond .cmxform{
            width:620px;
        }

        #respond span{
            color: #e91450;
        }

        #respond label.name{
            margin-right: 8px;
        }
        #respond label.email{
            margin-right: 12px;
        }
        #respond label.website{
            margin-right: 5px;
        }

        label.error { float: none; color: #E91450; padding-left: .5em; vertical-align: top; font-family: Verdana; font-size:11px;}
        #respond .comment-textarea {
            border: 1px solid #CCCCCC;
            border-radius: 5px 5px 5px 5px;
            font-family: Verdana,Arial,Helvetica,sans-serif;
            font-size: 12px;
            margin: 0;
            overflow: hidden;
            padding: 5px;
            width: 100%;
            float:left;
            height:150px;
        }
        #respond .commentbtn{
            float:right;
            font-family:Verdana, Arial, Helvetica, sans-serif;
            border-radius: 5px 5px 5px 5px;
            border: 1px solid #CCCCCC;
            cursor:pointer;
            padding:5px;
            -moz-box-shadow: 0 0 5px #ccc; -webkit-box-shadow: 0 0 5px #ccc; 
            box-shadow: 0 0 5px #ccc; color: #183a52; font-size: 12px; font-weight: bold; letter-spacing: -0.02em; text-decoration: none; -moz-box-text-shadow: 0 1px 0 #fff; text-shadow: 0 1px 0 #fff;
        }
        #respond .commentbtn:hover{
            border-radius: 5px 5px 5px 5px;
            border: 1px solid #29B5EA;
            cursor:pointer;
            padding:5px;
            -moz-box-shadow: 0 0 5px #ccc; -webkit-box-shadow: 0 0 5px #ccc; 
            box-shadow: 0 0 5px #ccc; color: #183a52; font-size: 12px; font-weight: bold; letter-spacing: -0.02em; text-decoration: none; -moz-box-text-shadow: 0 1px 0 #fff; text-shadow: 0 1px 0 #fff;
        }
        #respond .comment-input:hover,#respond .comment-textarea:hover{
            border: 1px solid #127FBB;
        }

        #respond .comment-input:focus,#respond .comment-textarea:focus  {
            background: #D4EDF6;
            border: 1px solid #127FBB;
        }

        #reader {
            float: left;
            width: 100%;
        }
        #reader ol {
            margin: 0;
            padding: 0;
        }

        #reader li {
            list-style: none outside none;
            margin-bottom:6px;
        }
        #reader .comment_box {
            background: none repeat scroll 0 0 #F6F6F6;
            float: left;
            margin-bottom: 20px;
            padding: 5px;
            box-sizing: content-box;
            border: 1px solid #CCCCCC;
            width:100%;

        }
        #reader .arrow-down {
            width: 0; 
            height: 0; 
            border-left: 10px solid transparent;
            border-right: 10px solid transparent;	
            border-top: 10px solid #CCCCCC;
            position:relative;
            top:42px;
        }

        #reader .comment_box:hover{
            border: 1px solid #127FBB;
        }

        #reader .comment_box img {
            border: 1px solid #C9C9C9;
            box-shadow: 0 2px 7px #DFDFDF;
            margin-right: 10px;
            padding: 3px;
            float:left;
            width:48px;
            height:48px;
        }

        #reader .comment_box img:hover{
            border: 1px solid #127FBB;
        }

        #reader .comment-meta {
            margin-bottom: 4px;
            overflow: auto;
        }

        #reader .commentsuser {
            float: left;
            font-size: 12px;
            color: #000000;
            font-weight:bold;
        }
        #reader .comment_date {
            float: right;
            font-size: 12px;
            color:#000;
        }

        #reader .comment-body {
            color: #848484;
            font-size: 12px;
        }


        #reader .reply img{   
            background: -moz-linear-gradient(center top , #EFEFEF 0%, #D1D1D1 100%) repeat scroll 0 0 transparent;
            border: 1px solid #CCCCCC;
            border-radius: 5px 5px 5px 5px;
            box-shadow: 0 0 5px #CCCCCC;
            color: #183A52;
            cursor: pointer;
            font-family: Verdana,Arial,Helvetica,sans-serif;
            font-size: 12px;
            font-weight: bold;
            letter-spacing: -0.02em;
            padding: 5px;
            text-decoration: none;
            text-shadow: 0 1px 0 #FFFFFF;
            display:block; 
            float:right; 
        }
        #reader .reply a:hover{
            border-radius: 5px 5px 5px 5px;
            border: 1px solid #29B5EA;
            cursor:pointer;
            padding:5px;
            -moz-box-shadow: 0 0 5px #ccc; -webkit-box-shadow: 0 0 5px #ccc; 
            box-shadow: 0 0 5px #ccc; color: #183a52; font-size: 12px; font-weight: bold; letter-spacing: -0.02em; text-decoration: none; -moz-box-text-shadow: 0 1px 0 #fff; text-shadow: 0 1px 0 #fff;
        }
        #reader ol li ul li {
            float: left;
        }


        #reader .children{
            display: none;
            margin-left: 5%;
            width: 95%;
        }

    </style>
    <%
        Account member = (Account) request.getSession().getAttribute("member");
        Account admin = (Account) request.getSession().getAttribute("admin");
        Account editor = (Account) request.getSession().getAttribute("editor");
        Account staff = (Account) request.getSession().getAttribute("staff");
        String user = "";
        ArrayList<ECommendBean> ecb = (ArrayList<ECommendBean>) request.getSession().getAttribute("comment");
        ArrayList<ECommendBean> reply = (ArrayList<ECommendBean>) request.getSession().getAttribute("replyComment");
        String comicID = request.getParameter("comicID");
        if (member != null) {
            user = member.geteAddress();
        } else if (admin != null) {
            user = admin.geteAddress();
        } else if (editor != null) {
            user = editor.geteAddress();
        } else if (staff != null) {
            user = staff.geteAddress();
        }
    %>

    <%
        String commodity = comicID;

        String cookieKey = "ComicBOOK_" + commodity;

        Cookie waitingForDelCookie = null;

        Cookie[] cookies = request.getCookies();

        List<Cookie> listCookie = new ArrayList<Cookie>();

        if (cookies != null && cookies.length > 0) {
            System.out.println("cookies!=null");
            for (Cookie tmpCookie : cookies) {
                if (tmpCookie.getName().startsWith("ComicBOOK_")) {
                    listCookie.add(tmpCookie);
                    if (tmpCookie.getName().equals(cookieKey)) {
                        waitingForDelCookie = tmpCookie;
                    }
                }
            }
        }

        if (waitingForDelCookie != null) {
            waitingForDelCookie.setMaxAge(0);
            response.addCookie(waitingForDelCookie);
        }
        Cookie cookie = new Cookie(cookieKey, commodity);
        response.addCookie(cookie);
    %>

    <script>


        $(document).ready(function () {
            
            var comicId = "";
            var ep ="";
            var productId =""
            var comicName = "";
            var point  = "";
            init();

            $("#glassPayment").hide();


//
            $("#chapterList").click(function (e) {
                if (e.target.tagName !== "LEGNED") {
                    var index = e.target.getAttribute("name");
                     ep = $(" #chapterList #episodeNum").eq(index).text();
                    var title=  $(" #chapterList #epiTitle").eq(index).text();
                     point = $(" #chapterList #point").eq(index).text();
                        var url =$("#ChapterCover img").prop("src")
                    alert(title);
                    productId =$("#chapterList input").eq(index).val();
                    $("#comicNameP").text(comicName)
                    $("#comicTitle").text(title)
                    $("#comicPoint").text(point)
                    $("#payIcon").attr("src",url)
//                     readBook(index);
//                    alert(comicId)
                    $("#glassPayment").show();

                    return;

                }




            })
            
            $("#Cancel").click(function(){
                
                 $("#glassPayment").hide();
                
            })
            
            $("#Purchase").click(function(){
                
                ////  check amount &login  ,point
                
                
    
                
               $.ajax({
                   url : "OrderController",
                   tpye :"get",
                   data:{operation:"purchaseBuyBook",pid:productId },
                   success:function(res){
                
                        alert("it is  successful ");
                       setTimeout(function(){                                                      
                           window.location.href = "ReadBookController?operation=read&comicId=" + comicId + "&ep=" + ep;
                            }, 400);
                      
                   }
                   
                   
               })
                
                
                
                
            })





//            function  readBook(index){
//                $.ajax({
//                       url: "ReadBookController",
//                       type: "get",
//                       data:{},
//                       success:function(res){
//                           
//                       }
//                    
//                    
//                    
//                    
//                })
//                
//                                
//
//        
//            }

            function init() {
                $.ajax({
                    url: "ReadBookController",
                    type: "get",
                    data: {operation: "getComicDetails"},
                    success: function (res) {

                        var sa = new ImageTranslator();
                        var item = JSON.parse(res);

                        comicName = item[0].ComicWork;
                        var s = sa.base64ToBlob(item[0].coverPage);
                        var url = sa.ToObjectURL(s);
                        var ctype = item[0].typeList;
                        comicId = item[0].comicId;
                        $("#upDateTime").text(item[0].latestDate)
                        $("#epNumber").text(" Episode " + item[0].latestEp)
                        $('#comicName').text(item[0].ComicWork);
                        $("#seriDate").text(item[0].Schedule);
                        $("#status").text(item[0].status);
                        $("#author").text(item[0].penName);
                        sa.preLoad(s, ".m2");

                        for (var s = 0; s < ctype.length; s++) {
                            $("#ComicType").append("<span>" + ctype[s] + "</span>")
                        }
                        for (var h = 1; h < item.length; h++) {
                            s = sa.base64ToBlob(item[h].chapterCover);
                            url = sa.ToObjectURL(s)
                            var index = (h - 1);
                       
                            
//                            var item = new   episode(comicName, comicId, ep, point, title, url);
//                            pool.push(item);
                            
                            var str = "<div id='chapter' name='" + index + "' >" +
                                    "<div id='ChapterCover'  name='" + index + "' >" +
                                    "<img  src='" + url + "'  name='" + index + "'>" +
                                    "</div>" +"<input type='hidden' value='"+item[h].pid+"'>"+
                                    "<span id='episodeNum'  name='" + index + "'>" + item[h].ep + "</span>" +
                                    "<span id='epiTitle'  name='" + index + "' >" + item[h].epTitle + "</span>" +
                                    "<span id='epdate'  name='" + index + "' >" + item[h].chapterDate + "</span>" +
                                    "<span id='point'  name='" + index + "'>" + item[h].point + "pt</span>" +
                                    "</div>"
                            $("#chapterList").append(str);
                        }
                        comicName = item[0].ComicWork;
                        $("#rescomicName").val(comicName);
                        $("#rescomicID").val(comicId);
                        $("#replycomicName").val(comicName);
                        $("#replycomicID").val(comicId);

                    }

                })


            }
            $(".reply").each(function (key, value) {
                $(this).click(function () {
                    $(".children").each(function (chi, value) {
                        if (key === chi) {
                            $(this).toggle();
                        }
                    });
                });

            });

            
            
            
        })




    </script>


    <style>
        #viewX{
            border: 1px solid red;
            color: red;
        }
        #read,#AutoPayment{
            padding-top: 10px;
        }


        #glassPayment {
            width: 100%;
            height: 100%;
            position: fixed;
            z-index: 502;
            background: rgba(0, 0,0, 0.1);
        }

        #PaymentDialog {
            background: rgba(
                255,
                255,
                255,
                0.9
                );
            width: 40%;
            height: 250px;
            margin-left: 30%;
            margin-top: 70px;
            box-shadow: 1px 2px 10px #2e2e30;

        }

        body {
            background: #2e2e30;
        }

        #bookViewer {
            border: 1px solid #dcdcdc;
            width: 30%;
            height: 120px;
        }

        img {
            width: 100%;
            height: 100%;
        }

        #bookDescritpion {
            padding-top: 5px;
            /*border: 1px solid red;*/
            width: 70%;
            padding-left: 20px;
        }

        #comicNameP {
            font-family: AppleMyungjo;
            font-size: 23px;
        }
        #btnSetSS button{
            float: right;
            margin-top: 80px;
            border: none;
            width: 120px;
            border-radius: 2px;
            /*background: #3b506b;*/
            padding: 3px 0px;
        }
        #addCart{
            margin-right: 30px;
            /*padding: 3px 0px;*/
            margin-left: 10px;
        }
        #Purchase{
            margin-left: 10px;
        }


    </style>

    <body style="background:#eef1f6">
        <jsp:include page="parts/memberNav2.jsp"/>
        <div id="glassPayment">
            <div id="PaymentDialog">
                <div style="display: flex ;flex-direction: row;background: #ebeeee">
                    <div id="bookViewer"><img id='payIcon' alt=""></div>
                    <div id="bookDescritpion">
                        <span id="comicNameP">HAllo Wrold</span><br>
                        <span id="comicTitle">Session : 12133191 919313</span><br>
                        <span id="comicPoint">240 pt</span>
                    </div>

                </div>
                <div  id="btnSetSS">
                    <button id="addCart"><a href="" id="sendCart">Add To Cart</a></button>
                    <button id="Purchase">Purchase</button>
                    <button id="Cancel">Cancel</button>
                </div>

            </div>


        </div>


        <div id="ComicIntro">
            <div id="deatails">
                <div id="cover">
                    <div id="CoverBox" class='m2'></div>
                </div>
                <div id="Content">
                    <h3 id="ComicTitle">Update on &nbsp; <span id="upDateTime"> </span></h3>
                    <h2 id="comicName" style="padding-left:10px;"></h2>
                    <p id="title">Author :<span id="author"></p>
                    <p id="title">Status :<span id="status"></p>
                    <p id="title"> Update Priod :<span id="seriDate"></p>
                    <p id="title"> Update to :<span id="epNumber"></p>                   
                    <p id="title" class="ct"> Comic type :
                        <span id="ComicType">

                        </span>
                    </p>


                    <div id="btn" style='margin-top:-50px;'>
                        <div id="read">Read Latest Chapter</div>
                        <div id="AutoPayment">Add My Collection</div>
                    </div>

                </div>


            </div>
            <fieldset id="chapterList">
                <legned id="chapTitle">Chapter List</legned>


            </fieldset>

            <!--respond-->
            <div id="respond" class="container" style="margin-top: 30px;">
                <%if (member != null || editor != null || admin != null || staff != null) {%>
                <h3>Comment Now</h3>
                <form id="commentForm" method="post" class="cmxform" action="newEcomment">
                    <input type="hidden" name="comicName" id="replycomicName" value="">
                    <input type="hidden" name="comicID" id="replycomicID" value="">
                    <input type="hidden" name="eAddress" value="<%if (member != null) {%><%=member.geteAddress()%><%} else if (editor != null) {%><%=editor.geteAddress()%><%} else if (admin != null) {%><%=admin.geteAddress()%><%} else if (staff != null) {%><%=staff.geteAddress()%><%}%>">
                    <div class="commentfields">
                        <label>Comments <span>*</span></label>
                        <textarea id="ccomment" class="comment-textarea required" name="comment" required></textarea>
                    </div>
                    <div class="commentfields">
                        <input class="commentbtn" type="submit" value="Post Comment">
                    </div>
                </form>
                <%} else {
                        out.println("<h1>Login First</h1>" + "<br>" + "<a href='Login2.jsp'>LoginNow</a>");
                    }%>
            </div>

            <div id="reader" class="container">
                <ol>
                    <li>
                        <%
                            if (ecb != null) {
                                for (ECommendBean c : ecb) {
                                    if (c.getComicID().equals(comicID)) {
                        %>
                        <div class="comment_box"><img src="images/user.svg" alt="avatar">
                            <div class="inside_comment">
                                <div class="comment-meta">
                                    <div class="commentsuser"><%=c.getName() + " " + c.getCommentID()%></div>
                                    <div class="comment_date"><%=c.getCurrentDate()%></div>
                                </div>
                            </div>
                            <div class="comment-body">
                                <p><%=c.getComment()%></p>
                            </div>
                            <div class="reply"><img src="images/comment.svg" style="width:30px;height: 30px;"></div>

                        </div>

                        <ul class="children">
                            <li> 
                                <%if (reply != null) {
                                        for (ECommendBean c2 : reply) {
                                            if (c.getCommentID() == c2.getCommentID()) {%>
                                <!--Comment Box 2-->
                                <div class="comment_box">  <img src="images/user.svg" alt="avatar">
                                    <div class="inside_comment">
                                        <div class="comment-meta">
                                            <div class="commentsuser"><%=c2.getName()%></div>
                                            <div class="comment_date"><%=c2.getCurrentDate()%></div>
                                        </div>
                                    </div>
                                    <div class="comment-body">
                                        <p><%=c2.getComment()%></p>
                                    </div>
                                </div>


                                <%}
                                        }
                                    }%>
                                <%if (member != null || editor != null || admin != null || staff != null) {%>
                                <form method="post" class="replyform" action="reply">
                                    <input type="hidden" name="comicName" id="rescomicName" value="">
                                    <input type="hidden" name="comicID"  value="<%=comicID%>">
                                    <input type="hidden" name="eAddress" value="<%if (member != null) {%><%=member.geteAddress()%><%} else if (editor != null) {%><%=editor.geteAddress()%><%} else if (admin != null) {%><%=admin.geteAddress()%><%} else if (staff != null) {%><%=staff.geteAddress()%><%}%>">
                                    <input type="hidden" name="commentID" value="<%=c.getCommentID()%>">
                                    <div class="commentfields">
                                        <div>Reply <span>*</span></div>
                                        <textarea id="ccomment" class="comment-textarea required" name="comment" required></textarea>
                                    </div>
                                    <div class="commentfields">
                                        <input class="commentbtn" type="submit" value="Post Comment">
                                    </div>
                                </form>
                                <%} else {
                                        out.println("<h1>Login First</h1>" + "<br>" + "<a href='Login2.jsp'>LoginNow</a>");
                                    }%>
                            </li>
                        </ul>

                        <%
                                    }
                                }
                            } else {

                                out.println("No one comment here!");
                            }%>

                    </li>
                </ol>
            </div>

        </div>
        <div id="recommend"></div>
    </body>
</html>
