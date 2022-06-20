<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ict.bean.ImagenVO"%>
<%@page import="ict.db.ImagenDAO"%>
<%@ page import="ict.bean.RCommendBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>JSP Page</title>
            <link href="/css/v1/comic-1.0.4.css" rel="stylesheet" type="text/css">
                <link rel="stylesheet" href="css/item.css">
                    <link rel='stylesheet' type='text/css' href='css/tipsy.css' />
                    <link rel='stylesheet' type='text/css' href='css/starry.min.css' />
                    <link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
                        <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
                        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
                        <script src="js/number.js"></script>
                        <script src="" name="MTAH5" sid="500624013"></script>
                        <script type="text/javascript" src="https://rs.sfacg.com/web/common/js/jquery.min.js"></script>
                        <script type="text/javascript" src="https://rs.sfacg.com/web/common/js/jquery.bigautocomplete.js"></script>
                        <script type="text/javascript" src="https://rs.sfacg.com/web/manhua/js/v1/request-1.0.6.js"></script>
                        <script type="text/javascript" src="https://rs.sfacg.com/web/manhua/js/v1/common-1.0.6.js"></script>
                        <script type='text/javascript' language='javascript' src='js/tipsy.js'></script>
                        <script type='text/javascript' language='javascript' src='js/starry.min.js'></script>
                        </head>
                        <style type="text/css">
                            #reader {
                                display: block;
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

                            #reader ol li ul li {
                                float: left;
                            }
                            .container {
                                margin-left: -300px; 
                            }
                        </style>

                        <%
                            int one = 0;
                            int two = 0;
                            int three = 0;
                            int four = 0;
                            int five = 0;
                            double ratingValue = 0;
                            String productID = request.getParameter("productID");
                            ArrayList<RCommendBean> ecb = (ArrayList<RCommendBean>) request.getSession().getAttribute("Rcomment");
                            if (ecb != null) {
                                for (RCommendBean eb : ecb) {
                                    if (productID.equals(eb.getProductID())) {
                                        if (eb.getRatingstar() == 5) {
                                            ++five;
                                        } else if (eb.getRatingstar() == 4) {
                                            ++four;
                                        } else if (eb.getRatingstar() == 3) {
                                            ++three;
                                        } else if (eb.getRatingstar() == 2) {
                                            ++two;
                                        } else if (eb.getRatingstar() == 1) {
                                            ++one;
                                        }
                                        ratingValue = (double) (5 * five + 4 * four + 3 * three + 2 * two + 1 * one) / (five + four + three + two + one);
                                    }
                                }
                            } else {
                                out.println("<h1>Nohthing!</h1>");
                            }

                        %>
                        <%String name = (String) request.getParameter("name");
                            int productID2 = (int) Integer.parseInt(request.getParameter("productID2"));
                            String descript = (String) request.getParameter("descript");
                            String type = (String) request.getParameter("type");
                            String version = (String) request.getParameter("version");
                            
                            String commodity = name;

                            String cookieKey = "NOTEBOOK_" + commodity;

                            Cookie waitingForDelCookie = null;

                            Cookie[] cookies = request.getCookies();

                            List<Cookie> listCookie = new ArrayList<Cookie>();

                            if (cookies != null && cookies.length > 0) {
                                System.out.println("cookies!=null");
                                for (Cookie tmpCookie : cookies) {
                                    if (tmpCookie.getName().startsWith("NOTEBOOK_")) {
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

                        <body>
                            <div class="wrap" style="margin-top:10px;">
                                <div class="head">
                                    <div class="logo"><a href=""></a></div>
                                    <div style="float:left; padding-top:12px;">
                                    </div>
                                </div>
                                <div class="menu">
                                    <ul class="whitefont">
                                        <li style="width:100px;margin-right:700px;">
                                            <a href="rhome.jsp">Home</a>
                                        </li>
                                </div>
                            </div>

                            <link href="https://rs.sfacg.com/web/manhua/css/v1/starcss-1.0.2.css" rel="stylesheet" type="text/css">
                                <script type="text/javascript" src="https://rs.sfacg.com/web/common/js/star.js"></script>
                                <script type="text/javascript" src="https://rs.sfacg.com/web/manhua/js/v1/detail-1.0.10.js"></script>
                                <script type="text/javascript">
                                    var cid = 1920;
                                </script>
                                <div class="wrap">
                                    <h1><%=name%></h1>
                                    <div style="width:980px;height:1px;background-color:#ffffff;overflow:hidden;"></div>
                                    <div class="BreadcrumbNavigation">
                                        <ul>
                                            <li></li>
                                        </ul>
                                    </div>
                                    <div class="plate_top" style="padding-bottom: 10px;">
                                        <ul class="menu_title whitefont clearer2">
                                            <li class="menu_title_UP"><a href="javascript:"></a></li>
                                            <li><a href="javascript:"></a></li>
                                        </ul>
                                        <ul class="synopsises_font">
                                            <li class="cover" style="height:241px;">
                                                <img src="imagen?id=<%=productID2%>"
                                                     width="184" height="230" style="display:block;">
                                            </li>
                                            <li style="	margin-left: 15px;padding-top:4px;width:434px;">
                                                <span><%=name%></span><br>Descript: <%=descript%>
                                                    <br>
                                                        <span class="broken_line" style="margin:7px 0;width:434px;"></span>
                                                        <span></span><a href="javascript:"></a><span>Type: <%=type%> </span><a
                                                            href="＃"></a>　<span>Version: <%=version%></span><a href="＃"></a><br>


                                                            <div class="interaction_Focus"><a href="ShoppingCart?action=add&productId=<%=productID%>">Add to car</a>
                                                                
                                                              </div><br>
                                                                <div class="container">
                                                                    <div class="row">
                                                                        <div class="col-xs-3 col-xs-offset-3">

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                </li>

                                                                <li style="margin-left: 15px;width:272px;height:222px;background-color:#fffefe;padding:4px 14px 14px 14px;">
                                                                    <div style="margin-bottom:10px;">
                                                                        <span>Score：</span><br>
                                                                            <span style="float:left;">
                                                                                <div id='starry_first' name='starry_first'>

                                                                                </div>
                                                                            </span>
                                                                            <strong><%=ratingValue%></strong>
                                                                    </div>

                                                                    </ul>
                                                                    <ul class="interaction_block clearer2">
                                                                        <li><a href="#" class="redfont_input2" style="margin:0 20px 0 40px;"></a></li>
                                                                        <div id="fb-root"></div>
                                                                        <script async defer crossorigin="anonymous"
                                                                        src="https://connect.facebook.net/zh_HK/sdk.js#xfbml=1&version=v8.0" nonce="2pB8ZWKA"></script>
                                                                        <li><span class="interaction_icon4"></span><div class="fb-share-button" data-href="https://developers.facebook.com/docs/plugins/" data-layout="button"
                                                                                                                        data-size="small">
                                                                                <a target="_blank" href="https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fdevelopers.facebook.com%2Fdocs%2Fplugins%2F&amp;src=sdkpreparse"
                                                                                   class="fb-xfbml-parse-ignore">Share</a></div></li>

                                                                    </ul>
                                                                    </div>
                                                                    <div><img src="https://rs.sfacg.com/web/manhua/images/synopsises_bg.gif"></div>
                                                                    </div>
                                                                    <div class="wrap">
                                                                        <div class="wrap_left">
                                                                            <div class="content_left1">


                                                                            </div>



                                                                            <div class="content_left2">
                                                                                <span class="content_title">Comment<span style="font-size:12px;font-weight: normal;"></span></span>
                                                                                <div id="reader">
                                                                                    <ol>
                                                                                        <li>
                                                                                            <%
                                                                                                if (ecb != null) {
                                                                                                    for (RCommendBean c : ecb) {
                                                                                                        if (c.getProductID().equals(productID)) {
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

                                                                                            </div>
                                                                                            <%}
                                                                                                    }
                                                                                                }%>
                                                                                        </li>
                                                                                    </ol>
                                                                                </div>
                                                                                <div class="clearer"></div>
                                                                                <span class="broken_line" style="margin:10px 0px 10px 0px;"></span></div>
                                                                        </div>
                                                                    </div>


                                                                    </body>
                                                                    </html>
                                                                    <script>
                                    $(document).ready(function () {
                                        var count;
                                        var starry_first;
                                        starry_first = new Starry('#starry_first');
                                        starry_first.init({
                                            stars: 5,
                                            starSize: 24,
                                            startValue: <%=ratingValue%>,
                                            readOnly: true,
                                            iconPath: '../icons/8/'
                                        });
                                        count = starry_first.getRating();
                                        var c = document.getElementById("starvalue");
                                        c.value = count;
                                    });
                                                                    </script>