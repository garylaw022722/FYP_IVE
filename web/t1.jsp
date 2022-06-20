<%-- 
    Document   : index
    Created on : Jan 12, 2021, 4:25:58 PM
    Author     : law
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="js/ImageTranslator.js"></script>
        <style type="text/css">
            h1{color:red}
            img{
                width: 100%;
                height: 100%;
            }
            #item{
                border: 1px solid red;          
                height: 500px;
                width: 60%;
            }

        </style>
    </head>
    <body>

        <script>
            $(document).ready(function () {
                const container = {};
                container.comicType = [];
                initSerachEngine();
                function  initSerachEngine() {
                    initYearField();
                    initAuthorFiled();
                    initComicField();
                    initComicTypeField();
                }

                var sa = new ImageTranslator();

                function resultSetLayout(comicName, penName, comicType, coverPage, comicDescript) {
                    var str = "";
                    var objecturl = sa.ToObjectURL(sa.base64ToBlob(coverPage));
                    str += "<div id='item'><img src='" + objecturl + "'></div>"



                    return str;
                }

                function initYearField() {
                    $.ajax({
                        url: "SearchingEngine",
                        type: "get",
                        data: {
                            field: "getYear",
                            operation: "epConfig"
                        },
                        success: function (res) {
                            var tag = "<option value='-'>year</option>";
                            ;
                            var item = JSON.parse(res);
                            for (var s = 0; s < item.length; s++)
                                tag += "<option value='" + item[s].year + "'>" + item[s].year + "</option>";
                            $('#year').html(tag);
                        }
                    })

                }

                function initAuthorFiled() {
                    $.ajax({
                        url: "SearchingEngine",
                        type: "get",
                        enctype: 'multipart/form-data',
                        data: {
                            field: "getAuthor",
                            operation: "epConfig"
                        },
                        success: function (res) {
                            var tag = "<option value='-'>Author</option>";
                            var item = JSON.parse(res);
                            for (var s = 0; s < item.length; s++)
                                tag += "<option value='" + item[s].Author + "'>" + item[s].Author + "</option>";
                            $('#author').html(tag);
                        }
                    })
                }

                function initComicField() {
                    $.ajax({
                        url: "SearchingEngine",
                        type: "get",
                        data: {
                            field: "getComicWorks",
                            operation: "epConfig"
                        },
                        success: function (res) {
                            var tag = "<option value='-'>Comic Name</option>";
                            ;


                            var item = JSON.parse(res);
                            alert(res);
                            for (var s = 0; s < item.length; s++)
                                tag += "<option value='" + item[s].comic + "'>" + item[s].comic + "</option>";
                            $('#comic').html(tag);
                        }
                    })
                }

                function   initComicTypeField() {
                    $.ajax({
                        url: "SearchingEngine",
                        type: "get",
                        data: {
                            field: "getComicType",
                            operation: "epConfig"
                        },
                        success: function (res) {
                            var tag = "";
                            var item = JSON.parse(res);
                            for (var s = 0; s < item.length; s++)
                                tag += "<span style='border:1px solid red ;margin:10px'>" + item[s].type + "</span>"
                            $('#tagBar').append(tag);
                        }


                    })
                }


                function SearchAuthorByYear(years) {
                    $.ajax({
                        url: "SearchingEngine",
                        type: "get",
                        data: {
                            operation: "epConfig",
                            field: "getAuthorByYear",
                            year: years
                        }, success: function (res) {
                            var item = JSON.parse(res);
                            var str = "<option value='-'>Author</option>";
                            for (var s = 0; s < item.length; s++)
                                str += "<option>" + item[s] + "</option>";
                            $('#author').html(str);
                        }

                    })
                }
                
                function  SearchingComicByAuthor(authors ,years){
                     $.ajax({
                        url: "SearchingEngine",
                        type: "get",
                        data: {
                            operation: "epConfig",
                            field: "getComicByAuthor",
                             author:authors,
                             year:years                             
                        }, success: function (res) {
//                            alert(res)
                            var item = JSON.parse(res);
                            var str = "<option value='-'>ComicName</option>";
                            for (var s = 0; s < item.length; s++)
                                str += "<option>" + item[s] + "</option>";
                            $('#comic').html(str);
                        }

                    })
                }




                $("#author").change(function () {
                    var  author  = $(this).val();
                    var year  =$("#year").val();
                    if (author === "-") {
                        initComicField();
                    } else{
                        SearchingComicByAuthor(author,year);
                    }
                })

                $("#year").change(function () {
                    var years = $(this).val()
                    if (years === "-") {
                         initAuthorFiled();
                    }else{
                         SearchAuthorByYear(years);
                    }
                })



                $('#send').click(function () {
                    var years = $('#year').val();
                    var authors = $('#author').val();
                    var comic = $('#comic').val();
//                
                    var typeString = JSON.stringify(container);
                    alert(typeString)
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
                            $('#saas').empty();
                            var tag = "";
                            alert(res);
                            var item = JSON.parse(res);
                            for (var s = 0; s < item.length; s++) {
                                var comicName = item[s].comicName;
                                var penName = item[s].penName;
                                var comicType = item[s].comicTypeMatch;
                                var coverPage = item[s].coverPage;
                                var comicDescript = item[s].Desc;
                                tag += resultSetLayout(comicName, penName, comicType, coverPage, comicDescript)

                            }

//                                       tag+=item[s].comicTypeMatch[0];
//                                    tag+="<img src='"+item[s].coverPage+"'>";                                    
                            $('#saas').append(tag);
                        }


                    })

                })

                $('#decode').click(function () {
                    var leng = $('#saas').find('div').length;
                    var container = {};
                    container.decodeImage = [];
                    var formData = new FormData();
                    for (var s = 0; s < leng; s++) {
                        var decodeSrc = $('#saas div img').eq(s).attr('src');
                        var img = base64ToBlob(decodeSrc);
//                            alert(img);
//                          $('#image').val(decodeSrc);
                        formData.append('image', img);
                        container.decodeImage.push(decodeSrc);
                    }


                    var codeString = JSON.stringify(container);
                    alert(codeString);
                    formData.append('operation', 'createPDF');
                    var s = formData.get('operation');
                    var url = "FileHandler";
                    alert(s);
                    $.ajax({
                        url: "FileHandler",
                        type: "get",
                        data: formData,
                        processData: false,
                        success: function (res) {
                            alert(res);
                        }
                    })
//                    


                })
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

//                    function base64ToBlob(base64String) {
//                    var byteString = atob(base64String.split(',')[1]);
//                            var ab = new ArrayBuffer(byteString.length);
//                            var ia = new Uint8Array(ab);
//                            for (var i = 0; i < byteString.length; i++) {
//                    ia[i] = byteString.charCodeAt(i);
//                    }
//                    return new Blob([ab], {type: 'image/jpeg'});
//                    }

                function previewFile(base64String) {
                    var img = new Image();
                    const reader = new FileReader();
                    reader.addEventListener("load", function () {
                        // convert image file to base64 string
                        img.src = reader.result;
                    }, false);
                    reader.readAsDataURL(base64String);
                }


















            })
        </script>

        <div id="sa" style="border:1px solid red" >assaassa</div>

        <select name="year" id="year" selected >
            <option value="-">Year</option>
        </select>


        <select name="author" id="author" selected>
            <option value="-">Author</option>
        </select>


        <select name="comic" id="comic" selected>
            <option value="-">Comic Works</option>
        </select>


        <div id="tagBar" style="margin:20px">



        </div>

        <button id="send">item</button>
        <button id="decode">Decode Image</button>
        <div id="saas" style="width:100%"></div>
        <form id="dva" action="FileHandler" method="get">
            <input type="hidden" id="image" name="image" value="">                       
        </form>
        <h2 id="s"></h2>
    </body>
</html>
