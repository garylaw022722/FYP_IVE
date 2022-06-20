<%@page import="java.sql.Blob"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Title</title>
        <link rel="stylesheet" href="css/readBook.css">
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"
              />

        <script src="js/wow.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/underscore@1.11.0/underscore-min.js"></script>
    </head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="js/mousewheel.js"></script>
    <style>

    </style>
    <script src="js/readBookConfig.js"></script>
    <script src="js/ImageTranslator.js"></script>
    <script src="js/readBookUI.js"></script>
    <script>
        var countPageLoad = 0, movingPixel = 0, default_Page_Speed = 0.6;
        var it = new ImageTranslator();

        var pageSpeed;
        var getPage = 2;
        var cusId;

        // var op;
        var page = parseInt($('.bothSideModePage').length);
        // var size ;
        // var scroll_each_pixel =$('.slider').width();
        // var  scrollPercent_showPage = 100*(scroll_each_pixel/(page-1))/scroll_each_pixel;
        // var z = 100*(5/(page-1))/scroll_each_pixel;
        // var unit = scrollPercent_showPage-z


        var end = "animationend oAnimationEnd mozAnimationEnd webkitAnimationEnd";
        $(document).ready(function () {
            var status;
            var pageNo;
            $("#bookDownload").hide();

            $('.svgImage').load('html/loadSvg.html')
            var debounceSpeed = checkBrowser();
            setoPageScroll();
            setPageSpeed(default_Page_Speed);
            mouswheell_Trigger(debounceSpeed);
            preHoverEffect();
            nextHoverEffect();
            init();


                $(".backToMainNav").mouseleave(function(){
                    $("#bookDownload").hide()
                })
                $(".backToMainNav").mouseover(function(){
//                    $("#backToMainNav").css({height:"40px"})
            
                    $("#bookDownload").css({position:"absolute",top:"637px",left:"5%"}).show()
                })


            $('#fullScreen').click(function () {
                var elem = document.querySelector('.readingArea');
                exeFullScreen(elem);
            })

            $('.next').on('click', function () {
                nextPages();
            })

            $('.pre').on('click', function () {
                previousPages();
            })


            $(document).on('keypress', function (e) {
                var elem = document.querySelector('.readingArea');
                if (e.keyCode === 37) {
                    e.preventDefault();
                    nextPages();
                }
            });

            $("#bookDownload").click(function () {

                $(this).trigger("Click");


            })





        })
        function dowload() {
            $.ajax({
                url: "texting",
                tpye: "get",
                data: {operation: "download", cid: cusId},
                success: function (res) {
                    var item = JSON.parse(res);
                    var blob = it.base64ToBlob(item[0].sources);
                    var book = it.ToObjectURL(blob);
                    $("#bookDownload a").attr("href", book).attr("download", item[0].name + ".pdf")


                }
            })


        }
        function init() {
            $.ajax({
                url: "ReadBookController",
                type: "get",
                data: {
                    operation: "getSources"

                            //                        pageNum: "2",
                            //                        getNumPage : getPage,
                            //                        comic_id :"20120301",
                            //                        episode:"1"
                },
                success: function (res) {
                    alert(res);

                    var item = JSON.parse(res);
                    status = item[0].Status;



                    var pageItem = item[0].page;
                    var count = 0;
                    var str = "";
                    var pageHandle = 0;

                    alert(pageItem.length)
                    for (var w = 0; w < pageItem.length; w++) {
                        var blob = it.base64ToBlob(pageItem[w]);
                        var url = it.ToObjectURL(blob);
                        if (count == 1) {
                            str += "<div id='even'><img src='" + url + "'></div></div>"
                            $('.bothSideMode').append(str);
                            pageHandle++;
                            page = pageHandle;
                            str = "";
                            count = 0;
                        } else if (pageItem.length % 2 != 0 && w == pageItem.length - 1 && count == 0) {
                            alert("it's called")
                            var Bstr = "";

                            Bstr += "<div class='bothSideModePage'><div id='odd'><img src='" + url + "'></div>"
                            Bstr += "<div id='even'></div></div>"
                            $('.bothSideMode').append(Bstr);
                        } else if (count == 0) {
                            //                                 var classN = "odd"+w;
                            //                                  $('.bothSideMode').append("<div class='bothSideModePage'><div id='odd' class='"+classN+"'></div>");
                            str += "<div class='bothSideModePage'><div id='odd'><img src='" + url + "'></div>"
                            //                                preview(blob,classN);
                            count++;
                        }

                    }

                    if (item[0].cusId != null) {
                        cusId = item[0].cusId;
                        dowload();
                    }




                    //                           var str =createDoublePanle(item);
                    //                           $('.bothSideMode').append("<img src='"+status[0]+"'>");
                }

            })
        }

        function preview(file, classN) {
            var reader = new FileReader();

            reader.addEventListener("loadend", function () {
                var image = new Image();
                image.src = this.result;
                image.width = "100%";
                image.height = "100%";
                $("." + classN).append(image);
            }, false);

            reader.readAsDataURL(file);
        }







        function  parseObjectURL(Blob) {

            return  URL.createObjectURL(Blob)

        }




        document.addEventListener("fullscreenchange", function () {
            fullScreenOperation(document.fullscreenElement)
        });

        document.addEventListener("webkitfullscreenchange", function () {
            setPageSpeed(0.01);
            fullScreenOperation(document.webkitFullscreenElement);
        });


    </script>
    <style>

        #bookDownload a{ 
            color: #fc5a9f;outline: none; font-style: none; text-decoration: none;
            
        }
        #bookDownload{
            /*margin-top: 10px;*/
            background: #3f4a56;
            width: 20%;
            height: 30px;
            font-size: 15px;
            text-align: center
        }
        #bookDownload a{
            /*padding-top: 30px;*/
        }

    </style>
    <body>
        <!--<body onwheel="myFunction(event)">-->
        <script>new WOW().init();</script>
        <div class="readingArea">
            <div class="chapter">

                <div class="bothSideMode"></div>

                <div class="oneSideMode"></div>
            </div>
            <div class="transpageNav">
                <div class="next"><svg><use xlink:href="#nextPagebtn"></use></svg></div>
                <div class="pre"><svg><use xlink:href="#prePagebtn"></use></svg></div>
            </div>

        </div>


        <div class="bottomNav">
            <div class="rangeSlider">
                <div class="backToMainNav" style="">
                    <div id="bookDownload"><a style="padding-top:10px;"><i class='bi bi-download'></i> Download</a></div>
                    <div><svg><use href="#backToMain"></use></svg></div>

                </div>
                <div class="nextChapter">Next Chapter</div>

                <div class="slidecontainer">
                    <div class="pageShow"></div>
                    <input type="range" min="1" max="3" value="1" class="slider" id="pageScroll">
                </div>

                <div class="preChapter">Previous Chapter</div>
            </div>
            <div class="mainBottomNav"></div>
        </div>

        <div id="fullScreen">
            <span>Full Screen</span>
            <svg><use href="#expandScreen"></use></svg>
        </div>


        <div class="svgImage"></div>
    </body>


</html>