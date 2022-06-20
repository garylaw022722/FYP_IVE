<%@page import="ict.bean.ComicTypeBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ict.db.ComicTypeDB"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Title</title>
        <link rel="stylesheet" href="css/Rank.css">
        <!--<script src="https://kit.fontawesome.com/df4f1b5dd7.js" crossorigin="anonymous"></script>-->
        <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>-->
        <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">-->
        <!--<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">-->
        <!--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>-->
        <!--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">-->

 

    </head>

    <style>
        #rList{
            width: 90%;
            margin: auto;
            left: 5%;
            box-shadow: none;
            height: 500px;

            /*background: #eef1f6;*/


        }
        /*#rankName{*/
        /*    color: #e34079;*/
        /*    font-family: "Al Nile";*/
        /*}*/
        #rankingTitleSession{
            text-align: center;
            font-family: "Al Nile";
            color: #f3d351;
            margin-bottom: 15px;
        }

        #rankTypeContent{
            margin-bottom: 19px;
        }
        #typeheading span{
            font-size:16px;

            /*background: #3f4a56;*/
        }
    </style>
    <script>
        var ctBarWidth;
        var outerEnd = 3;
        var outerStart = 0;
        var it = new ImageTranslator();
        var exist;
        var pageSpeed = 0.5;
        var index;
        $(document).ready(function () {
            ctBarWidth = $("#typeheading div").width();
            $("#tbar").css({width: ctBarWidth})

            $("#typeheading span").eq(0).css({color: " #d76b8b"})
            exist = ctBarWidth;
            $("h4").html("<div style='height: 20px;border: none'></div>")
            headingScrolling();
            scrollingListener()


            $("#rkItem").click(function () {
                alert($(this).width())
            })



        })



        function scrollingListener() {
            document.getElementById("tbar").addEventListener("transitionrun", function () {
                var typeNav = $("#typeheading").width();
                var position = (index + 1) * ctBarWidth;
                if (position >= typeNav) {
                    var more = position - typeNav;
                    var moving = index * ctBarWidth - more;
                    var movingPixel = "translateX(+" + moving + "px) ";
                    transform("#tbar", movingPixel);
                    $("#typeheading").animate({scrollLeft: more}, 500)
                } else {
                    $("#typeheading").animate({scrollLeft: 0}, 500)

                }
            })

        }


        function transform(id, movingPixel) {
            $(id).css({
                transition: "transform " + pageSpeed + "s ease-in-out",
                transform: movingPixel
            })
        }

        function headingScrolling() {
            $("#typeheading div").click(function (e) {
              
                index = parseInt($(this).index());
                var exist = ctBarWidth * index;
                var movingPixel = "translateX(" + exist + "px) ";
                $("#typeheading div ").find("span").css({color: "#d1d2d4"})
                $(e.target).css({color: " #ef4278"})
                $(e.target).find("span").css({color: " #ef4278"})
                transform("#tbar", movingPixel);
                getRank(e.target.id);
//                alert(e.target.id)
            })


        }


        function add3ListTable(item) {


            var str = "<div id='rankListContainer' style='width:385.438px'><h4><span id='th' style='visibility:hidden'>Fighting</span></h4>"
            str += createListItem(item)
            str += "</div>"
//                alert(str)

            return str;
        }
        
        function EmptyList(){
             var str = "<div id='rankListContainer'><h4><span id='th' style='visibility:hidden'>Fighting</span></h4>"
             
              str += "</div>"
              return str;
            
            
        }

        function createListItem(item) {
            var str ="";
           
            
            for (var k = 0; k < item.length; k++) {
                if (k < outerStart)
                        continue;
               
                                var code = "rank" +k;
                str+="<div id='rkItem' onclick='ReadDeatils("+item[k].cid+")'>"+
                    "<div id='imageViewer'>"+
                        "<div class='"+code+"'></div>"+
                    "</div>"+
                    "<div id='textContent'>"+
                        "<span id='rank'>"+rankList(k)+"</span><br>"+
                        "<span id='listCN'>"+item[k].ComicName+"</span><br>"+
                        "<span id='listAth'>"+item[k].penName+"</span>"+
                    "</div>"+
                  "</div>";



                var imageParse = it.base64ToBlob(item[k].image)
                it.preLoad(imageParse, "."+code);


                if (k == (outerEnd-1) ){
                    outerEnd += 3;
                    outerStart = k + 1;
                    break;
            
                }



            }


            return str;
         

        }



        function rankList(index) {
            var num = "", unit = "";
            if (index == 0)
                unit = " st"
            else if (index == 1)
                unit = " nd"
            else if (index == 2)
                unit = " rd"
            else
                unit = " rd"

            return (index + 1) + unit
        }

        function getRank(field) {

            $.ajax({
                url: "ProductController",
                type: "get",
                data: {operation: "getTopRank", rankComic: field},
                success: function (res) {
                      $("#rankTypeContent").html("");
                    var item = JSON.parse(res);
                    var numLoop = Math.ceil(item.length / 3);
//                    alert(numLoop)
                     outerEnd = 3;
                     outerStart = 0;
                    if(numLoop>3)
                        numLoop = 2;
                    for (var w = 0; w < numLoop; w++) {
                                    
                            $("#rankTypeContent").append(add3ListTable(item)); 
                    }
                    

                }

            })


        }

    </script>
    <body style="background-color: #eef1f6">


        <h1  id="rankingTitleSession"><i  id='crow' class="fas fa-crown"></i> <span id="rankName">Ranking</span></h1>
        <div id="rList">
            <div id="typeheading">
                <%
                    ArrayList<ComicTypeBean> a = new ComicTypeDB().getComicType().getTlist();
                    String start = "";
                    for (int s = 0; s < a.size(); s++) {
                        String name = a.get(s).getComicType();
                        String fullName = "Rank" + name;
                        if (s == 0) {
                            start = fullName;
                        }

                %>
                <div id="<%=fullName%>"><span id="<%=fullName%>"><%=name%></span></div>

                <%
                    }
                %>
                <script> getRank("<%=start%>")</script>
            </div>
            <div id="tbar"></div>
            <div id="rankTypeContainer">
                <div id="rankTypeContent">





                </div>
            </div>
        </div>
    </body>
</html>