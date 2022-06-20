<%-- 
    Document   : rhistory
    Created on : 2021-5-2, 6:41:18
    Author     : user
--%>

<%@page import="ict.db.contract"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="ict.bean.ImagenVO"%>
<%@page import="ict.db.ImagenDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ict.bean.ComicTypeBean"%>
<%@page import="ict.db.ComicTypeDB"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@page import ="java.util.List" %>
<%@page import ="java.util.Arrays" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>rbook</title>
        <meta name="renderer" content="webkit">
        <link rel="stylesheet" type="text/css" href="https://rs.sfacg.com/web/manhua/css/v2/manhua.css">
    </head>
    <body>
        <%
            ImagenDAO emp = new ImagenDAO();
            ImagenVO imgvo = new ImagenVO();
            Cookie[] cookies = request.getCookies();
            ArrayList<String> name = new ArrayList();
            if (cookies != null && cookies.length > 0) {
                for (Cookie tmpCookie : cookies) {
                    if (tmpCookie.getName().startsWith("NOTEBOOK_")) {
                        name.add(tmpCookie.getValue());
                    }
                }
            }
            ArrayList<ImagenVO> listar = new ArrayList();
            ArrayList<ImagenVO> lista = new ArrayList();
            ArrayList<ImagenVO> list = new ArrayList();
            ArrayList<ImagenVO> lis = new ArrayList();
            ArrayList<ImagenVO> li = new ArrayList();
            ArrayList<ImagenVO> l = new ArrayList();
            ArrayList<ImagenVO> a = new ArrayList();
            ArrayList<ImagenVO> s = new ArrayList();
            ArrayList<ImagenVO> d = new ArrayList();
            ArrayList<ImagenVO> f = new ArrayList();
            if (name.size() > 0) {
                listar = emp.Listar_CBookVO(name.get(0));
            }
            if (name.size() > 1) {
                lista = emp.Listar_CBookVO(name.get(1));
            }
            if (name.size() > 2) {
                list = emp.Listar_CBookVO(name.get(2));
            }
            if (name.size() > 3) {
                lis = emp.Listar_CBookVO(name.get(3));
            }
            if (name.size() > 4) {
                li = emp.Listar_CBookVO(name.get(4));
            }
            if (name.size() > 5) {
                l = emp.Listar_CBookVO(name.get(5));
            }
            if (name.size() > 6) {
                a = emp.Listar_CBookVO(name.get(6));
            }
            if (name.size() > 7) {
                s = emp.Listar_CBookVO(name.get(7));
            }
            if (name.size() > 8) {
                d = emp.Listar_CBookVO(name.get(8));
            }
            if (name.size() > 9) {
                f = emp.Listar_CBookVO(name.get(9));
            }

        %>
        <script src="https://cdn.jsdelivr.net/npm/vanilla-lazyload@17.3.1/dist/lazyload.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <script src="js/ImageTranslator.js"></script>
        <script>
            function order(page) {
                input_value = document.getElementById("search").value;
                location.href = page + "?search=" + input_value;

            }
        </script>
        <div class="container">
            <!-- 頭部 -->
            <div class="header">
                <div class="wrap clearfix">
                    <!-- logo -->

                    <!-- 頭部導航 -->
                    <div class="header-nav">
                        <ul class="nav-list clearfix">
                            <li>
                                <a class="nav-a" href="rhome.jsp">
                                    <span class="icn"></span>
                                    <span class="text">home</span>
                                </a>
                            </li>
                        </ul>
                    </div>

                    <div class="user-bar">
                        <div class="user-mask">
                            <a href="">
                                <img src=".jpg" class="block-img" alt="">
                            </a>
                        </div>
                        <div class="top-link">


                            <a href="rhistory.jsp" class="large-btn">
                                <i class="icn"></i>
                                <span>history</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 頂部標簽欄 -->
        <div class="tags-row">
            <div class="wrap">


                <div class="right-info">
                </div>
            </div>
        </div>

        <div class="column">
            <div class="wrap">
                <!-- 主內容 -->
                <div class="main-part fl">
                    <!-- 標題 -->
                    <div class="common-title">
                        <h3 class="title-text">
                            <span class="icn yellow"></span>
                            <span class="main-title">Realistic books</span>
                            <span class="sub-title"></span>
                        </h3>
                    </div>

                    <ul class="story-list">
                        <%if (listar.size() > 0) {
                                for (ImagenVO listar2 : listar) {
                                    imgvo = listar2;
                        %>
                        <li>
                            <div class="pic">
                                <a href="">
                                    <%
                                        if (imgvo.getCoverPage2() != null) {
                                    %>
                                    <img src="imagen?id=<%=imgvo.getBid()%>" width="130px" height="160px"/>
                                    <%
                                        } else {
                                            out.print("No disponible");
                                        }
                                    %>
                                </a>
                                <div class="info-layer">
                                    <a href="" target="_blank">
                                        <div class="bg"></div>
                                        <div class="on">
                                            <div class="author-info">
                                                <span class="mask">
                                                </span>
                                                <span class="name"></span>
                                            </div>
                                            <div class="book-info">
                                                <p><span class="highlight"></span></p>
                                                <p><span class="highlight"></span></p>
                                                <p><span class="highlight"></span></p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                            <p class="title"><a href="ProductDetail.jsp" target="_blank"></a></p>
                            <a href="ProductDetail.jsp?name=<%=imgvo.getName()%>&productID2=<%=imgvo.getBid()%>&descript=<%=imgvo.getDescript()%>&type=<%=imgvo.getType()%>&version=<%=imgvo.getVersion()%>"><%=imgvo.getName()%></a></p>
                            <p class="Serial_title"></p>
                            <p class="desc">
                            </p>
                        </li><%}
                            }%>
                        <%if (lista.size() > 0) {
                                for (ImagenVO lista2 : lista) {
                                    imgvo = lista2;
                        %>
                        <li>
                            <div class="pic">
                                <a href="">
                                    <%
                                        if (imgvo.getCoverPage2() != null) {
                                    %>
                                    <img src="imagen?id=<%=imgvo.getBid()%>" width="130px" height="160px"/>
                                    <%
                                        } else {
                                            out.print("No disponible");
                                        }
                                    %>
                                </a>
                                <div class="info-layer">
                                    <a href="" target="_blank">
                                        <div class="bg"></div>
                                        <div class="on">
                                            <div class="author-info">
                                                <span class="mask">
                                                </span>
                                                <span class="name"></span>
                                            </div>
                                            <div class="book-info">
                                                <p><span class="highlight"></span></p>
                                                <p><span class="highlight"></span></p>
                                                <p><span class="highlight"></span></p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                            <p class="title"><a href="ProductDetail.jsp" target="_blank"></a></p>
                            <a href="ProductDetail.jsp?name=<%=imgvo.getName()%>&productID2=<%=imgvo.getBid()%>&descript=<%=imgvo.getDescript()%>&type=<%=imgvo.getType()%>&version=<%=imgvo.getVersion()%>"><%=imgvo.getName()%></a></p>
                            <p class="Serial_title"></p>
                            <p class="desc">
                            </p>
                        </li><%}
                            }%>
                        <%if (list.size() > 0) {
                                for (ImagenVO list2 : list) {
                                    imgvo = list2;
                        %>
                        <li>
                            <div class="pic">
                                <a href="">
                                    <%
                                        if (imgvo.getCoverPage2() != null) {
                                    %>
                                    <img src="imagen?id=<%=imgvo.getBid()%>" width="130px" height="160px"/>
                                    <%
                                        } else {
                                            out.print("No disponible");
                                        }
                                    %>
                                </a>
                                <div class="info-layer">
                                    <a href="" target="_blank">
                                        <div class="bg"></div>
                                        <div class="on">
                                            <div class="author-info">
                                                <span class="mask">
                                                </span>
                                                <span class="name"></span>
                                            </div>
                                            <div class="book-info">
                                                <p><span class="highlight"></span></p>
                                                <p><span class="highlight"></span></p>
                                                <p><span class="highlight"></span></p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                            <p class="title"><a href="ProductDetail.jsp" target="_blank"></a></p>
                            <a href="ProductDetail.jsp?name=<%=imgvo.getName()%>&productID2=<%=imgvo.getBid()%>&descript=<%=imgvo.getDescript()%>&type=<%=imgvo.getType()%>&version=<%=imgvo.getVersion()%>"><%=imgvo.getName()%></a></p>
                            <p class="Serial_title"></p>
                            <p class="desc">
                            </p>
                        </li><%}
                            }%>
                        <%if (lis.size() > 0) {
                                for (ImagenVO lis2 : lis) {
                                    imgvo = lis2;
                        %>
                        <li>
                            <div class="pic">
                                <a href="">
                                    <%
                                        if (imgvo.getCoverPage2() != null) {
                                    %>
                                    <img src="imagen?id=<%=imgvo.getBid()%>" width="130px" height="160px"/>
                                    <%
                                        } else {
                                            out.print("No disponible");
                                        }
                                    %>
                                </a>
                                <div class="info-layer">
                                    <a href="" target="_blank">
                                        <div class="bg"></div>
                                        <div class="on">
                                            <div class="author-info">
                                                <span class="mask">
                                                </span>
                                                <span class="name"></span>
                                            </div>
                                            <div class="book-info">
                                                <p><span class="highlight"></span></p>
                                                <p><span class="highlight"></span></p>
                                                <p><span class="highlight"></span></p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                            <p class="title"><a href="ProductDetail.jsp" target="_blank"></a></p>
                            <a href="ProductDetail.jsp?name=<%=imgvo.getName()%>&productID2=<%=imgvo.getBid()%>&descript=<%=imgvo.getDescript()%>&type=<%=imgvo.getType()%>&version=<%=imgvo.getVersion()%>"><%=imgvo.getName()%></a></p>
                            <p class="Serial_title"></p>
                            <p class="desc">
                            </p>
                        </li><%}
                            }%>
                        <%if (li.size() > 0) {
                                for (ImagenVO li2 : li) {
                                    imgvo = li2;
                        %>
                        <li>
                            <div class="pic">
                                <a href="">
                                    <%
                                        if (imgvo.getCoverPage2() != null) {
                                    %>
                                    <img src="imagen?id=<%=imgvo.getBid()%>" width="130px" height="160px"/>
                                    <%
                                        } else {
                                            out.print("No disponible");
                                        }
                                    %>
                                </a>
                                <div class="info-layer">
                                    <a href="" target="_blank">
                                        <div class="bg"></div>
                                        <div class="on">
                                            <div class="author-info">
                                                <span class="mask">
                                                </span>
                                                <span class="name"></span>
                                            </div>
                                            <div class="book-info">
                                                <p><span class="highlight"></span></p>
                                                <p><span class="highlight"></span></p>
                                                <p><span class="highlight"></span></p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                            <p class="title"><a href="ProductDetail.jsp" target="_blank"></a></p>
                            <a href="ProductDetail.jsp?name=<%=imgvo.getName()%>&productID2=<%=imgvo.getBid()%>&descript=<%=imgvo.getDescript()%>&type=<%=imgvo.getType()%>&version=<%=imgvo.getVersion()%>"><%=imgvo.getName()%></a></p>
                            <p class="Serial_title"></p>
                            <p class="desc">
                            </p>
                        </li><%}
                            }%>                        <%if (l.size() > 0) {
                                for (ImagenVO l2 : l) {
                                    imgvo = l2;
                        %>
                        <li>
                            <div class="pic">
                                <a href="">
                                    <%
                                        if (imgvo.getCoverPage2() != null) {
                                    %>
                                    <img src="imagen?id=<%=imgvo.getBid()%>" width="130px" height="160px"/>
                                    <%
                                        } else {
                                            out.print("No disponible");
                                        }
                                    %>
                                </a>
                                <div class="info-layer">
                                    <a href="" target="_blank">
                                        <div class="bg"></div>
                                        <div class="on">
                                            <div class="author-info">
                                                <span class="mask">
                                                </span>
                                                <span class="name"></span>
                                            </div>
                                            <div class="book-info">
                                                <p><span class="highlight"></span></p>
                                                <p><span class="highlight"></span></p>
                                                <p><span class="highlight"></span></p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                            <p class="title"><a href="ProductDetail.jsp" target="_blank"></a></p>
                            <a href="ProductDetail.jsp?name=<%=imgvo.getName()%>&productID2=<%=imgvo.getBid()%>&descript=<%=imgvo.getDescript()%>&type=<%=imgvo.getType()%>&version=<%=imgvo.getVersion()%>"><%=imgvo.getName()%></a></p>
                            <p class="Serial_title"></p>
                            <p class="desc">
                            </p>
                        </li><%}
                            }%>   
                        <%if (a.size() > 0) {
                                for (ImagenVO a2 : a) {
                                    imgvo = a2;
                        %>
                        <li>
                            <div class="pic">
                                <a href="">
                                    <%
                                        if (imgvo.getCoverPage2() != null) {
                                    %>
                                    <img src="imagen?id=<%=imgvo.getBid()%>" width="130px" height="160px"/>
                                    <%
                                        } else {
                                            out.print("No disponible");
                                        }
                                    %>
                                </a>
                                <div class="info-layer">
                                    <a href="" target="_blank">
                                        <div class="bg"></div>
                                        <div class="on">
                                            <div class="author-info">
                                                <span class="mask">
                                                </span>
                                                <span class="name"></span>
                                            </div>
                                            <div class="book-info">
                                                <p><span class="highlight"></span></p>
                                                <p><span class="highlight"></span></p>
                                                <p><span class="highlight"></span></p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                            <p class="title"><a href="ProductDetail.jsp" target="_blank"></a></p>
                            <a href="ProductDetail.jsp?name=<%=imgvo.getName()%>&productID2=<%=imgvo.getBid()%>&descript=<%=imgvo.getDescript()%>&type=<%=imgvo.getType()%>&version=<%=imgvo.getVersion()%>"><%=imgvo.getName()%></a></p>
                            <p class="Serial_title"></p>
                            <p class="desc">
                            </p>
                        </li><%}
                            }%>                          
                            <%if (s.size() > 0) {
                                for (ImagenVO s2 : s) {
                                    imgvo = s2;
                        %>
                        <li>
                            <div class="pic">
                                <a href="">
                                    <%
                                        if (imgvo.getCoverPage2() != null) {
                                    %>
                                    <img src="imagen?id=<%=imgvo.getBid()%>" width="130px" height="160px"/>
                                    <%
                                        } else {
                                            out.print("No disponible");
                                        }
                                    %>
                                </a>
                                <div class="info-layer">
                                    <a href="" target="_blank">
                                        <div class="bg"></div>
                                        <div class="on">
                                            <div class="author-info">
                                                <span class="mask">
                                                </span>
                                                <span class="name"></span>
                                            </div>
                                            <div class="book-info">
                                                <p><span class="highlight"></span></p>
                                                <p><span class="highlight"></span></p>
                                                <p><span class="highlight"></span></p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                            <p class="title"><a href="ProductDetail.jsp" target="_blank"></a></p>
                            <a href="ProductDetail.jsp?name=<%=imgvo.getName()%>&productID2=<%=imgvo.getBid()%>&descript=<%=imgvo.getDescript()%>&type=<%=imgvo.getType()%>&version=<%=imgvo.getVersion()%>"><%=imgvo.getName()%></a></p>
                            <p class="Serial_title"></p>
                            <p class="desc">
                            </p>
                        </li><%}
                            }%>                      <%if (d.size() > 0) {
                                for (ImagenVO d2 : d) {
                                    imgvo = d2;
                        %>
                        <li>
                            <div class="pic">
                                <a href="">
                                    <%
                                        if (imgvo.getCoverPage2() != null) {
                                    %>
                                    <img src="imagen?id=<%=imgvo.getBid()%>" width="130px" height="160px"/>
                                    <%
                                        } else {
                                            out.print("No disponible");
                                        }
                                    %>
                                </a>
                                <div class="info-layer">
                                    <a href="" target="_blank">
                                        <div class="bg"></div>
                                        <div class="on">
                                            <div class="author-info">
                                                <span class="mask">
                                                </span>
                                                <span class="name"></span>
                                            </div>
                                            <div class="book-info">
                                                <p><span class="highlight"></span></p>
                                                <p><span class="highlight"></span></p>
                                                <p><span class="highlight"></span></p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                            <p class="title"><a href="ProductDetail.jsp" target="_blank"></a></p>
                            <a href="ProductDetail.jsp?name=<%=imgvo.getName()%>&productID2=<%=imgvo.getBid()%>&descript=<%=imgvo.getDescript()%>&type=<%=imgvo.getType()%>&version=<%=imgvo.getVersion()%>"><%=imgvo.getName()%></a></p>
                            <p class="Serial_title"></p>
                            <p class="desc">
                            </p>
                        </li><%}
                            }%>   
                        <%if (s.size() > 0) {
                                for (ImagenVO f2 : f) {
                                    imgvo = f2;
                        %>
                        <li>
                            <div class="pic">
                                <a href="">
                                    <%
                                        if (imgvo.getCoverPage2() != null) {
                                    %>
                                    <img src="imagen?id=<%=imgvo.getBid()%>" width="130px" height="160px"/>
                                    <%
                                        } else {
                                            out.print("No disponible");
                                        }
                                    %>
                                </a>
                                <div class="info-layer">
                                    <a href="" target="_blank">
                                        <div class="bg"></div>
                                        <div class="on">
                                            <div class="author-info">
                                                <span class="mask">
                                                </span>
                                                <span class="name"></span>
                                            </div>
                                            <div class="book-info">
                                                <p><span class="highlight"></span></p>
                                                <p><span class="highlight"></span></p>
                                                <p><span class="highlight"></span></p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                            <p class="title"><a href="ProductDetail.jsp" target="_blank"></a></p>
                            <a href="ProductDetail.jsp?name=<%=imgvo.getName()%>&productID2=<%=imgvo.getBid()%>&descript=<%=imgvo.getDescript()%>&type=<%=imgvo.getType()%>&version=<%=imgvo.getVersion()%>"><%=imgvo.getName()%></a></p>
                            <p class="Serial_title"></p>
                            <p class="desc">
                            </p>
                        </li><%}
                            }%>   
                    </ul>
                </div>
                </body>
                </html>

