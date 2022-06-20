<%@page import="ict.db.contract"%>
<%@page import="ict.bean.contractBean"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ict.imageTranslator"%>



<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Title</title>

        <link rel="stylesheet" href="css/comic.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">


        <%@page  import="ict.pdf_Generator" %>

    </head>
    <body>
        <%@include file="CDN.jsp"%>
        <script src="js/searchingUI.js"></script>
        <script src="js/ImageTranslator.js"></script>
        <script src="js/comicWorkResult.js"></script>
        <script src="js/ImageTranslator.js"></script>

        <script>

            $(document).ready(function () {
                var selectedComic
                var comicWork = [];
                const container = {};
                container.comicType = [];
                var se = new Searching();
                var pages = [];
                var clickForInitComic = 0;

                getPreviewMaterial()
                initSerachEngine(se);
                function  initSerachEngine(se) {
                    se.initYearField();
                    se.initAuthorFiled();
                    se.initComicField();
                    se.initComicTypeField();
                }




                function getPreviewMaterial() {
                    var formData = new FormData();
                    formData.append('MJ', 'sasa');

                    $.ajax({
                        url: "createState",
                        type: "post",
                        data: formData,
                        processData: false,
                        contentType: false,
                        success: function (res) {
                            var tag = "";
                            var item = JSON.parse(res);
                            alert(res);
//                            alert(item[0].pageCode);
                            for (var s = 0; s < item.length; s++) {
                                var pageCode = item[s].pageCode;
                                var coverPage = item[s].sources;
                                tag = resultSetLayout(coverPage, pageCode);
                                $('#leftContainer').append(tag);                              
                            }
                            
                        }



                    })


                }






                $('img').on("load", function () {})
                var el = document.getElementById('leftContainer');
                var sortable = Sortable.create(el, {
                    group: "grid",
                    onEnd: function (/**Event*/evt) {
                        var s = evt.oldIndex; // element's old index within old parent
                        var k = evt.newIndex; // element's new index within new parent
                        alert("old index " + (s + 1) + " ," + "new Index" + (k + 1));
                    }
                })

                $("#author").change(function () {
                    var author = $(this).val();
                    var year = $("#year").val();
                    if (author === "-") {
                        se.initComicField();
                    } else {
                        se.SearchingComicByAuthor(author, year);
                    }
                })

                $("#year").change(function () {
                    var years = $(this).val()
                    if (years === "-") {
                        se.initAuthorFiled();
                    } else {
                        se.SearchAuthorByYear(years);
                    }
                })


                $('#searchBtn').click(function () {
                    var years = $('#year').val();
                    var authors = $('#author').val();
                    var comic = $('#comic').val();

                    $("#resultContainer").empty();
                    comicWork = [];

                    var typeString = JSON.stringify(container);
                    alert(typeString)
                    $("#modal").css({visibility: "visible"})
                    $.ajax({
                        url: "SearchingEngine",
                        type: "get",
                        data: {
                            field: "getSearchingResult",
                            operation: "epConfig",
                            comicTypes: typeString,
//                            comicTypes : comicType,
                            year: years,
                            author: authors,
                            comicWorks: comic
                        },
                        success: function (res) {
                            var item = JSON.parse(res);
                            for (var s = 0; s < item.length; s++) {
                                var coverPage = item[s].coverPage;
                                var comicName = item[s].comicName;
                                var author = item[s].penName;
                                var comicType = item[s].comicTypeMatch;
                                var date = item[s].Date;
                                var comicId = item[s].comicId;
                                createSearchingResultForConfig(coverPage, comicName, author, comicType, date, comicId, s)
                            }
//                            var comicDescript = item[0].Desc;
                            alert(comicName + " ," + author + "," + comicType + "," + date);
                        }

                        
                    })

                })

                $('#uploadServer').click(function () {
                    var pageCode = {};
                    pageCode.page = [];
                    pageCode.sources = [];                   
                    var container = $('#leftContainer div');
                    for (var s = 0; s < container.length; s++) {
                        var code = $('#leftContainer div img').eq(s).attr("name")
                        var src = $('#leftContainer div img').eq(s).attr("src")
                        pageCode.sources.push(src);
                        pageCode.page.push(code);
                    }
                    pageCode.comicId =$("#sid").text();
                    pageCode.title =$("#worksName").val();
                    pageCode.epNo  =$("#epNo").val();
                    pageCode.Des =$("#Desc").val() ;    
                          
                    var jsonString = JSON.stringify(pageCode);
                    alert(jsonString)
                    var formData = new FormData();
                     formData.append("coverPage",$("#ccp")[0].files[0])
                    formData.append('create', jsonString);
                 
//                    formData.append('coverPage',$('#ccp')[0].files[0]);
                    $.ajax({
                        url: "createState",
                        type: "post",
                        data: formData,
                        processData: false,
                        contentType: false,
                        success: function (res) {
                            alert("it is success");
                        }
                    })


                        window.location.href="AdminControl.jsp"
                })


                $("#modal").click(function (e) {
                    var s = e.target.id;
                    if (s == "modal" || (s != "resultItem" && s == "resultContainer"))
                        $("#modal").css({visibility: "hidden"})


                })
                function resultSetLayout(coverPage, PageCode) {
                    var str = "";
                    var objecturl = se.ToObjectURL(se.base64ToBlob(coverPage));
                    str += "<div id='page'><img src='" + objecturl + "' name ='" + PageCode + "'></div>"
                    return str;
                }


                function createSearchingResultForConfig(coverPage, name, author, type, date, comicId, index) {
                    var str = "";
                    var objecturl = se.ToObjectURL(se.base64ToBlob(coverPage));
                    comicWork.push(new ComicWork(coverPage, author, name, date, type, comicId));
                    str += "<div id='resultItem' name='" + index + "'>" +
                            "<input type='hidden'  id='comicId' value='" + comicId + "'>" +
                            "<div id='cover' name='" + index + "'><img id='img'  name='" + index + "' src='" + objecturl + "'></div>" +
                            "<div id='content' name='" + index + "'>" +
                            "<span id='name'    name='" + index + "'      > " + name + "</span><br>" +
                            "<span id='details' name='" + index + "'>Author: " + author + "</span><br>" +
                            "<span id='details' name='" + index + "'>Type : " + type.toString() + "</span><br>" +
                            "<span id='details' name='" + index + "'>Date:" + date + "</span><br>" +
                            "</div></div>"
                    $("#resultContainer").append(str);
                }

                $("#resultContainer").click(function (e) {
                    var s = e.target.id;
                    if (s === "img" || s == "details" || s == "name" || s == "content" || s === "cover" || s == "resultItem") {
                        var index = e.target.getAttribute('name');
                        var comicID = $("#resultContainer #resultItem ").eq(index).find("input").val();
                        setSelectInfo(comicID);

                        $("#modal").css({visibility: "hidden"})
                    }



                })


                function Preview(input) {
                    if (input.files && input.files[0]) {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            $('#previewZ').attr('src', e.target.result);
                        }

                        reader.readAsDataURL(input.files[0]);
                    }
                }
                ;
//               

                function setSelectInfo(id) {
                    comicWork.forEach(function (entry) {
                        if (entry.getComicId() == id) {
                            $("#scv").attr("src", entry.getCover())
                            $("#sName").text(entry.getName());
                            $("#sAuhthor").text(entry.getAuthor());
                            $("#sType").text(entry.getType());
                            $("#sid").text(entry.getComicId());



                        }
                    });

                }
                $('#tagBar').click(function (event) {
                    if (event.target.tagName == "SPAN") {
                        var item = event.target.textContent;
                        if (!container.comicType.includes(item)) {
                            $(event.target).css({color: "orange"})
                            container.comicType.push(item);
                        } else {
                            var itemIndex = container.comicType.indexOf(item);
                            $(event.target).css({color: "red"})
                            container.comicType[itemIndex] = "";
                        }
                    }
                })


                $("#lbCover").click(function () {
                    $("#preview").animate({height: "280px"}, 1000)


                })

                $("#ccp").change(function () {

                    var fileName = $(this).val().split('\\').pop()
                    $("#fileName").text("File Name : " + fileName)
                    Preview(this);
                })


              $("#seBook").click(function(e){
                  alert(e.target.clientWidth)
              })

            })


           


        </script>

        <datalist id="seris">
            <option value="BundleSet">BundleSet</option>
            <option value="ep">Episode</option>
        </datalist>
        <form action="" id="f1" style="display: inline-block;visibility:hidden">
            <div id="mainNav">
                <div id="uploadServer" >upload</div>
            </div>
            <div id="leftContainer">

            </div>
            <div id="rightMenu" style="height: ">
                <div id="rightContainer">

                    <div id="EpInfo" style="height: 640px">
                        <h3  id="controlT"style="text-align: center">Control Penal</h3>
                        <hr style="border: 1px solid #bdbaba">
                        <div id="opt">
                            <div id="episode">Episode</div>
                            <div id="Bundle">Bundle Set</div>
                        </div>

                        <div id="title" style="margin-bottom: 20px;margin-top: 3px;">
                            <inline id="infoCon">Comic Information</inline>
                        </div>
                        <select  id="year" class="form-select" style="margin-top:10px;margin-left:2%;width: 96%">

                        </select>
                        <select   id="author" id="author"  class="form-select" style="margin-top:10px;margin-left:2%;width: 96%">

                        </select>
                        <select id="comic" class="form-select" style="margin-top:10px;margin-left:2%;width: 96%">

                        </select>
                        <hr style="border: 1px solid #bdbaba">
                        <div id="tagBar">
                            <div id="title"> <inline>Topic type</inline> </div>
                        </div>
                        <!--<hr style="border: 1px solid #bdbaba">-->

                        <div id="searchBtn" data-toggle="modal" data-target="#ck">Search</div>
                    </div>

                    <div id="comicInfo" style="height: 100%">
                        <div id="title">
                            <inline id="infoCon">Chapter Configuration</inline>
                        </div>
             
                    
                        <input class="form-control" id="worksName" name="bName" placeholder="Chapter Title"
                               style="width: 100%;margin-bottom: 10px; margin-top: 10px">
                         <input class="form-control" id="epNo" name="epNo" placeholder="episode number"
                               style="width: 100% ;margin-bottom: 10px;">
                          <input class="form-control" id="Desc" name="bName" placeholder="Description"
                               style="width: 100%">
                  
                        <hr style="border: 1px solid #bdbaba">
                        <div id="seBookList">
                            <div id="seBook"><img id="scv"></div>
                            <div id="seContent">
                                <div id="setitle" style="">Comic Name</div>
                                <div id="sName"></div>
                                <div id="setitle">Author</div>
                                <div id="sAuhthor"></div>
                                <div id="setitle">Comic Type </div>
                                <div id="sType"></div>
                                <div id="setitle">Comic id </div>
                                <div id="sid"></div>
                                <!--<div id="setitle">Date :12.21.31 </div>-->
                                <!--<div id="sDate">12.21.31</div>-->                                  
                            </div>                              
                        </div>
                        <hr style="border: 1px solid #bdbaba">
                        <div id="title">
                            <inline id="infoCon">Chapter Cover</inline>
                        </div>
                        <div id="coverBox">
                            <div id="preview"><img id="previewZ"></div>


                            <input type="file" id="ccp" style="display: none">
                            <span id='fileName' style="">File Name : </span>    <br>
                            <label for="ccp"  id="lbCover" style >Upload</label>

                        </div>
                                             
                    </div>
                    <!--                    <div id="tagBar">
                                         <div id="title"> <inline>Topic type</inline> </div>
                                        </div>-->


                </div>

            </div>


        </form>
        <div id="modal">

            <div id="contentModal">
                <h1 id="ht">Matching Result</h1>
                <div id="resultContainer"></div>
            </div>

        </div> 




    </body>
</html>