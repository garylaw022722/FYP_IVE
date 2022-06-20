<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Title</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">
    </head>
    <script src="https://cdn.jsdelivr.net/npm/vanilla-lazyload@17.3.1/dist/lazyload.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="b1.css">
    <body style=" background: #eef1f6;">
        <style>
            #layout {
                /*border: 1px solid #3b506b;*/
                width: 90%;
                height: 550px;
                position: absolute;
                z-index: 100;
                top: 100px;
                background: white;
                margin-left: 5%;
                border-radius: 3px;
                padding: 3%;

            }

            #innerLayout {

                /*border: 1px solid gainsboro;*/
                height: 430px;
                display: flex;
                flex-direction: row;

            }

            #imageViewer {
                width: 100%;
                border: 1px solid gainsboro;
                height: 400px;
            }

            img {
                width: 100%;
                height: 100%;
            }

            #preView {
                margin-top: 20px;
                background: #7ad8d9;
                border: none;
                border-radius: 3px;
                font-family: AppleMyungjo;
                padding: 7px 0px;
                color: white;
            }

            #Descri {
                /*border: 1px solid red;*/
                width: 70%;
                height: 450px;
                padding-left: 5%;

            }

            #version {
                font-size: 15px;
                border: 1px solid;
                color: #8d9098;
                padding: 2px 5px;
            }

            #BookName {
                font-size: 32px;
                color: #3f4a56;
                font-family: "Al Nile";
            }

            #title {
                font-size: 17px;
                color: #3f4a56;
                margin-bottom: 3px;
                display: inline-block;

            }

            #Point {
                color: red;
                font-size: 20px;
            }

            .sa {
                display: inline-block;
                margin-bottom: 30px;
                font-size: 15px;
            }

            #btnSet {
                position: relative;
                z-index: 102;
                width: 20%;
                color: white;
                margin-bottom: 10px;
                /*border: 1px solid gainsboro;*/
                left: 75%;
                top: -400px;

            }

            #Purchase {
                background: #3f4a56;
                text-align: center;
                height: 30px;

                margin-bottom: 20px;
            }

            #addToCart {
                background: #6e8496;
                text-align: center;


            }

            #btnSet div {
                border-radius: 3px;
                padding-top: 5px;
                height: 35px;
                font-size: 17px;
                box-shadow: 6px 4px #aeb1b5;
            }

            #content {
                width: 100%;
                /*height: 100%;*/
                position: absolute;
                z-index: 100;
                top: 600px;
                background: white;
                margin-left: -3%;
                border-radius: 3px;
                padding: 3%;
                min-height: 500px;

            }

            #contentMenu {
                display: flex;
                flex-wrap: wrap;
                width: 80%;

                /*margin: auto;*/
                /*border: 1px solid red;*/
            }

            #author, #ComicWorks ,#chapter {
                width: 33%;
                text-align: center;
                font-size: 17px;
                height: 40px;
                border: 1px solid gainsboro;
                border-bottom: none;
            }
            #CommentArea{
                margin-top: 40px;
                width: 100%;
                height: 200px;
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
                /*margin-right: 30px;*/
                /*padding: 3px 0px;*/
                /*margin-left: 10px;*/
            }
            #Pur{
                margin-right: 10px;
                                margin-left: 10px;

            }
            





        </style>
        <script src="js/ImageTranslator.js"></script>

        <script>
            $(document).ready(function () {
                $("#topNavX").load("parts/memberNav2.jsp");
            })


        </script>

        <%
            if (request.getAttribute("json") != null);
            String str = request.getAttribute("json").toString();
        %>
        <script>
            var json =<%=str%>
            var it = new ImageTranslator();
            var bid = json[0].bid
            var date = json[0].date;
            var name = json[0].name;
            var type = json[0].type;
            var point = json[0].point;
            var des = json[0].desc;
            var content = json[0].content;

            var blob = it.base64ToBlob(json[0].cover);
            var url = it.ToObjectURL(blob)
            var pid = json[0].pid;
            


            




            $(document).ready(function () {
                
                $("#glassPayment").hide()

                $("#date").text(date);
                $("#type").text(type);
                $("#Point").text(point + "pt")
                $("#BookName").text(name);
                $("#descri").text(des);

                for (var s = 0; s < content.length; s++) {
                    var item = content[s].split("-");

                    var str = "<div id='author' style='background: #e9efef'>" + item[1] + "</div>" +
                            "<div id='ComicWorks' style='background:white'>" + item[0] + "</div>" +
                            "<div id='chapter' style='background:white'>" + item[2] + "</div>"


                    $("#contentMenu").append(str);



                }

                $("#picture").attr("src", url);
                
                
                $("#Purchase").click(function(){
                    
                    $("#glassPayment").show()
                    $("#payIcon").attr("src",url)
                    $("#comicNameP").text(name)
                    $("#comicTitle").text(type)
                    $("#comicPoint").text(point +" pt")
                    
                    
                })
                
                $("#Cancel").click(function(){
                    
                    $("#glassPayment").hide();
                    
                })
                
                $("#Pur").click(function(){
                    alert("js")
                   
                       $.ajax({
                        url : "ReadBookController",
                        type :"get",
                        data:{operation:"purchaseBuyBook",pid:pid},
                        success:function(res){
                        
                             
    
                        }
                        
                    })                   
                   
                   
                     $.ajax({
                        url : "ReadBookController",
                        type :"get",
                        data:{operation:"readBundle",bid:bid},
                        success:function(res){
                            window.location.href='readBookGallery.jsp'
                        }                                                
                    })                   
                         
                   
                })
                
                
                $("#preView").click(function(){
                  
                   $.ajax({
                        url : "ReadBookController",
                        type :"get",
                        data:{operation:"preView",bid:bid},
                        success:function(res){
                            window.location.href='readBookGallery.jsp'
                        }                                                
                    })                   
                         
                })

            })


            function getComicSources(opt){
                
                
                                            
                
                
            }



        </script>
        <div id="glassPayment">
            <div id="PaymentDialog">
                <div style="display: flex ;flex-direction: row;background: #ebeeee">
                    <div id="bookViewer"><img id='payIcon' alt=""></div>
                    <div id="bookDescritpion">
                        <span id="comicNameP"></span><br>
                        <span id="comicTitle"></span><br>
                        <span id="comicPoint"></span>
                    </div>

                </div>
                <div  id="btnSetSS">                    
                    <button id="Pur">Confirm</button>
                    <button id="Cancel">Cancel</button>
                </div>

            </div>


        </div>




        <div id="topNavX" ></div>
        <div id="layout">
            <div id="innerLayout">
                <div style="display:flex ;flex-direction: column;width: 26%;padding-left: 30px;">
                    <div id="imageViewer"><img id='picture' src=""></div>
                    <button id="preView"><i class="bi bi-book-half" style="font-size:20px"></i><span style="font-size: 19px"> Preview</span>
                    </button>
                </div>
                <div id="Descri">
                    <span id="version">Electric Version</span>
                    <p style="margin-top: 15px"><span id="BookName"></span></p>

                    <span id="title" style="padding-right: 30px">Issue Date </span><span id="date" class="sa"
                                                                                         style=";padding-right: 50px"></span>
                    <span id="title" style="padding-right: 30px">Book Type </span>
                    <span id="type" class="sa"></span><br>
                    <span id="title">Point required</span><br>
                    <span id="Point" class="sa"></span><br>
                    <span id="title">Description</span><br>
                    <span id="descri" class="sa"></span><br>


                </div>
            </div>
            <div id="btnSet">
                <div id="Purchase">Purcahse</div>
                <div id="addToCart" style=""><i class="bi bi-cart"></i>&nbsp;Add To Cart</div>
            </div>
            
            <div id="content">
                <div style="background: #3f4a56;margin-bottom: 20px ;width: 100%;height: 40px;padding-left:10px ;color: gainsboro;font-size: 23px">
                    Contenet
                </div>
                <li style="font-size: 16px ">Comic Name & Author & Episode</li>
                <div id="contentMenu" style="margin-top:40px;margin-left: 10%">


                </div>

            </div>
            <hr style="margin-top: 490px">
            <h4 style="text-align: center">Command</h4>
            <div id="CommentArea" style="width: 105%;height: 400px;margin-left:-3%;background: white">sassa</div>


        </div>


    </body>
</html>