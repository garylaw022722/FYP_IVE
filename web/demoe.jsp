<%@page import="ict.db.contract"%>
<%@page import="ict.bean.contractBean"%>
x<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ict.imageTranslator"%>
<%!
    private ArrayList<String> yearList = new ArrayList<String>();

    public String copyImg(String path, int index) {
        String str = "", f = "";
        try {
            f = "sa_" + index + ".jpg";
            File imageURL = new File(path);
            BufferedImage bi = ImageIO.read(imageURL);
            ImageIO.write(bi, "jpg", new File("/Users/law/NetBeansProjects/demo/web/Comic" + "/" + f));
        } catch (Exception ez) {
        }

        return "Comic/" + f;
    }

    public void initSearching() {

        setYearField();

    }

    public String setYearField() {
        String str = "";
        contract ss = new contract();
        ArrayList<contractBean> contract = ss.getContract().getContract();
        for (contractBean item : contract) {
            String year = "" + item.getSignYear(item.getSignDate());
            if (!yearList.contains(year)) {
                yearList.add(year);
            }
        }

        for (String yearItem : yearList) {
            str += "<option value='" + yearItem + "'>" + yearItem + "</option>";
        }

        return str;
    }

%>
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
        <%                 
                ArrayList<String> ele;
                 String ite = "";
                 if (request.getSession().getAttribute("tag") != null) {
                   ele = (ArrayList<String>) request.getSession().getAttribute("tag");
             %>    
           
            <%
     
            String str = "";                       
            int count = 0;
            if (request.getSession().getAttribute("tag") != null) {
               ele = (ArrayList<String>) request.getSession().getAttribute("tag");
//  
                for (String sa : ele) {
                    str += "<div id='page'><img src='" + copyImg(sa, count) + "'></div>";
//
                    count++;
//
                }
//
            }

            //    out.println(dir);
            %>
  
        <script>
            $(document).ready(function () {
                var pages = [];           
                var clickForInitComic = 0;
                setTimeout(function () {               }, 12000);
                 $('#leftContainer').append(<%=str%>)
                $('img').on("load", function () {})
                var el = document.getElementById('leftContainer');
                var sortable = Sortable.create(el, {
                    group: "grid",
                    onEnd: function (/**Event*/evt) {
                        var s = evt.oldIndex;  // element's old index within old parent
                        var k = evt.newIndex;  // element's new index within new parent
                        alert("old index " + (s + 1) + " ," + "new Index" + (k + 1));

                    },

                })

                $('#comicName').click(function () {
                    var year = $('#year').val();

                    $(this).empty();
                    $(this).append("<option value='-' selected>Comic Name</option>")



                    $.ajax({
                        url: "Searching",
                        type: "get",
                        data: {
                            type: "bookConfig",
                            years: year,
                            Stage: "getComicName"

                        },
                        success: function (res) {
                            var item = JSON.parse(res);
                            var opt = ""
                            for (var i = 0; i < item.length; i++) {
                                opt += "<option value='" + item[i].comicName + "'>" + item[i].comicName + "</option>";
                            }

                            $('#comicName').append(opt);
                        }
                    })




                })


            })





        </script>

        <datalist id="seris">
            <option value="BundleSet">BundleSet</option>
            <option value="ep">Episode</option>
        </datalist>
        <form action="" id="f1" style="display: inline-block;visibility:hidden">
            <!--<div id="mainNav"></div>-->
            <div id="leftContainer">


            </div>
            <div id="rightMenu">
                <div id="rightContainer">
                    <div id="Ctype">
                        <div id="bs">Bundle Set</div>
                        <div id="ep">Episode</div>
                    </div>

                    <div id="EpInfo" style="height: 540px">
                        <div id="title">
                            <inline id="infoCon">Comic Information</inline>
                        </div>
                        <select  id="year" class="form-select" style="margin-top:10px;margin-left:2%;width: 96%">
                            <option value="-" selected>Years for registration</option>                    
                        </select>
                        <select   id="comicName"   class="form-select" style="margin-top:10px;margin-left:2%;width: 96%">
                            <option value="-" selected>Comic Name</option>

                        </select>
                        <select  id="author" class="form-select" style="margin-top:10px;margin-left:2%;width: 96%">
                            <option value="-" selected>Comic Works</option>

                        </select>
                        <div id="searchBtn">Search</div>
                    </div>

                    <div id="comicInfo" style="height: 650px">
                        <div id="title">
                            <inline id="infoCon">Comic Information</inline>
                        </div>
                        <div></div>
                        <input class="form-control" id="worksName" name="bName" placeholder="Select  or Input  Comic Seris"
                               list="seris" style="width: 100%">
                        <hr style="border: 1px solid #bdbaba">
                        <span style="color: #6CD0DE; font-size: 12px">Version</span><br>
                        <input type="checkbox" name="comicType" id=""> <span id="t2">Electric</span>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="comicType" id=""> <span
                            id="t2">Realistic</span><br>
                        <span style="color: #6CD0DE; font-size: 12px">Bundle Type </span><br>
                        <input type="radio" name="BundleType" id=""> <span id="t2">Megazine</span>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="BundleType" id=""> <span id="t2">Pamphlet</span>
                    </div>
                    <div id="tagBar">
                        <div id="title">
                            <inline>Topic type</inline>
                        </div>
                        <span>Happy</span>
                        <span>Love</span>
                        <span>suspicious</span>
                        <span>Schools</span>
                        <span>others</span>
                    </div>
                    <div></div>
                    <div></div>


                </div>
            </div>

        </form>


    </body>
</html>