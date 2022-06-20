<%-- 
    Document   : rhome
    Created on : 2021-2-2, 12:38:16
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
            ArrayList<ImagenVO> listar = emp.Listar_ImagenVO();
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
                                <a class="nav-a" href="Main.jsp">
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
                <div class="small-search" id="searchArea">
                    <input type="text" name="search" id="search" class="search-input" placeholder="search">
                    <div class="search-btn">
                        <span class="icn"><a onclick="order('rsearch.jsp')" class="btn btn-success" target="_blank"></a></span>
                    </div>
                    <div class="search-hots" style="display: none;">
                        <ul class="hots-list">
                            <li style="opacity: 0; z-index: 0;">

                            </li>
                        </ul>
                    </div>
                </div>

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
                            <a href="ProductDetail.jsp?name=<%=imgvo.getName()%>&productID2=<%=imgvo.getBid()%>&descript=<%=imgvo.getDescript()%>&type=<%=imgvo.getType()%>&version=<%=imgvo.getVersion()%>&productID=<%=imgvo.getProductID()%>"><%=imgvo.getName()%></a></p>
                            <p class="Serial_title"></p>
                            <p class="desc">
                            </p>
                        </li><%}
                            }%>
                    </ul>
                </div>
                </body>
                </html>
