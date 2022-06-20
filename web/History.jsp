<%-- 
    Document   : ReadBookSearching
    Created on : 20-Apr-2021, 11:06:44
    Author     : law
--%>

<%@page import="ict.db.contract"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="ict.bean.Imagen"%>
<%@page import="ict.db.CImagenDB"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ict.bean.ComicTypeBean"%>
<%@page import="ict.db.ComicTypeDB"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@page import ="java.util.List" %>
<%@page import ="java.util.Arrays" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <style>

        #glassPayment {
            width: 100%;
            height: 100%;
            position: fixed;
            z-index: 502;
            background: rgba(255, 255, 255, 0.9);
        }



        #bookViewer {
            border: 1px solid #dcdcdc;
            width: 130px;
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

        #comicName {
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
    <body>
        <%
            CImagenDB emp = new CImagenDB();
            Imagen imgvo = new Imagen();
            Cookie[] cookies = request.getCookies();
            ArrayList<String> name = new ArrayList();
            if (cookies != null && cookies.length > 0) {
                for (Cookie tmpCookie : cookies) {
                    if (tmpCookie.getName().startsWith("ComicBOOK_")) {
                        name.add(tmpCookie.getValue());
                    }
                }
            }
            ArrayList<Imagen> listar = new ArrayList();
            ArrayList<Imagen> lista = new ArrayList();
            ArrayList<Imagen> list = new ArrayList();
            ArrayList<Imagen> lis = new ArrayList();
            ArrayList<Imagen> li = new ArrayList();
            ArrayList<Imagen> l = new ArrayList();
            ArrayList<Imagen> a = new ArrayList();
            ArrayList<Imagen> s = new ArrayList();
            ArrayList<Imagen> d = new ArrayList();
            ArrayList<Imagen> f = new ArrayList();
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
        <%if (listar.size() > 0) {
                for (Imagen listar2 : listar) {
                    imgvo = listar2;
        %>
        <div style="display: flex ;flex-direction: row;background: #ebeeee ;width: 50%;margin-left: 20px">
            <div id="bookViewer"><%
                if (imgvo.getCoverPage2() != null) {
                %><img src="img?id=<%=imgvo.getComcid()%>" alt=""><%
                    } else {
                        out.print("No disponible");
                    }
                %></div>
            <div id="bookDescritpion">
                <span id="comicName"><%=imgvo.getName()%></span><br>
                <span id="comicTitle">Author: <%=imgvo.getPenName()%></span><br>
                <span id="ComicType"></span>
            </div>
        </div>
        <%}
            }%>
        <%if (lista.size() > 0) {
                for (Imagen lista2 : lista) {
                    imgvo = lista2;
        %>
        <div style="display: flex ;flex-direction: row;background: #ebeeee ;width: 50%;margin-left: 20px">
            <div id="bookViewer"><%
                if (imgvo.getCoverPage2() != null) {
                %><img src="img?id=<%=imgvo.getComcid()%>" alt=""><%
                    } else {
                        out.print("No disponible");
                    }
                %></div>
            <div id="bookDescritpion">
                <span id="comicName"><%=imgvo.getName()%></span><br>
                <span id="comicTitle">Author: <%=imgvo.getPenName()%></span><br>
                <span id="ComicType"></span>
            </div>
        </div>
        <%}
            }%><%if (list.size() > 0) {
                        for (Imagen list2 : list) {
                            imgvo = list2;
        %>
        <div style="display: flex ;flex-direction: row;background: #ebeeee ;width: 50%;margin-left: 20px">
            <div id="bookViewer"><%
                if (imgvo.getCoverPage2() != null) {
                %><img src="img?id=<%=imgvo.getComcid()%>" alt=""><%
                    } else {
                        out.print("No disponible");
                    }
                %></div>
            <div id="bookDescritpion">
                <span id="comicName"><%=imgvo.getName()%></span><br>
                <span id="comicTitle">Author: <%=imgvo.getPenName()%></span><br>
                <span id="ComicType"></span>
            </div>
        </div>
        <%}
            }%><%if (lis.size() > 0) {
                        for (Imagen lis2 : lis) {
                            imgvo = lis2;
        %>
        <div style="display: flex ;flex-direction: row;background: #ebeeee ;width: 50%;margin-left: 20px">
            <div id="bookViewer"><%
                if (imgvo.getCoverPage2() != null) {
                %><img src="img?id=<%=imgvo.getComcid()%>" alt=""><%
                    } else {
                        out.print("No disponible");
                    }
                %></div>
            <div id="bookDescritpion">
                <span id="comicName"><%=imgvo.getName()%></span><br>
                <span id="comicTitle">Author: <%=imgvo.getPenName()%></span><br>
                <span id="ComicType"></span>
            </div>
        </div>
        <%}
            }%><%if (li.size() > 0) {
                        for (Imagen lista2 : lista) {
                            imgvo = lista2;
        %>
        <div style="display: flex ;flex-direction: row;background: #ebeeee ;width: 50%;margin-left: 20px">
            <div id="bookViewer"><%
                if (imgvo.getCoverPage2() != null) {
                %><img src="img?id=<%=imgvo.getComcid()%>" alt=""><%
                    } else {
                        out.print("No disponible");
                    }
                %></div>
            <div id="bookDescritpion">
                <span id="comicName"><%=imgvo.getName()%></span><br>
                <span id="comicTitle">Author: <%=imgvo.getPenName()%></span><br>
                <span id="ComicType"></span>
            </div>
        </div>
        <%}
            }%><%if (l.size() > 0) {
                        for (Imagen l2 : l) {
                            imgvo = l2;
        %>
        <div style="display: flex ;flex-direction: row;background: #ebeeee ;width: 50%;margin-left: 20px">
            <div id="bookViewer"><%
                if (imgvo.getCoverPage2() != null) {
                %><img src="img?id=<%=imgvo.getComcid()%>" alt=""><%
                    } else {
                        out.print("No disponible");
                    }
                %></div>
            <div id="bookDescritpion">
                <span id="comicName"><%=imgvo.getName()%></span><br>
                <span id="comicTitle">Author: <%=imgvo.getPenName()%></span><br>
                <span id="ComicType"></span>
            </div>
        </div>
        <%}
            }%><%if (a.size() > 0) {
                        for (Imagen a2 : a) {
                            imgvo = a2;
        %>
        <div style="display: flex ;flex-direction: row;background: #ebeeee ;width: 50%;margin-left: 20px">
            <div id="bookViewer"><%
                if (imgvo.getCoverPage2() != null) {
                %><img src="img?id=<%=imgvo.getComcid()%>" alt=""><%
                    } else {
                        out.print("No disponible");
                    }
                %></div>
            <div id="bookDescritpion">
                <span id="comicName"><%=imgvo.getName()%></span><br>
                <span id="comicTitle">Author: <%=imgvo.getPenName()%></span><br>
                <span id="ComicType"></span>
            </div>
        </div>
        <%}
            }%><%if (s.size() > 0) {
                        for (Imagen s2 : s) {
                            imgvo = s2;
        %>
        <div style="display: flex ;flex-direction: row;background: #ebeeee ;width: 50%;margin-left: 20px">
            <div id="bookViewer"><%
                if (imgvo.getCoverPage2() != null) {
                %><img src="img?id=<%=imgvo.getComcid()%>" alt=""><%
                    } else {
                        out.print("No disponible");
                    }
                %></div>
            <div id="bookDescritpion">
                <span id="comicName"><%=imgvo.getName()%></span><br>
                <span id="comicTitle">Author: <%=imgvo.getPenName()%></span><br>
                <span id="ComicType"></span>
            </div>
        </div>
        <%}
            }%><%if (d.size() > 0) {
                        for (Imagen d2 : d) {
                            imgvo = d2;
        %>
        <div style="display: flex ;flex-direction: row;background: #ebeeee ;width: 50%;margin-left: 20px">
            <div id="bookViewer"><%
                if (imgvo.getCoverPage2() != null) {
                %><img src="img?id=<%=imgvo.getComcid()%>" alt=""><%
                    } else {
                        out.print("No disponible");
                    }
                %></div>
            <div id="bookDescritpion">
                <span id="comicName"><%=imgvo.getName()%></span><br>
                <span id="comicTitle">Author: <%=imgvo.getPenName()%></span><br>
                <span id="ComicType"></span>
            </div>
        </div>
        <%}
            }%><%if (f.size() > 0) {
                        for (Imagen f2 : f) {
                            imgvo = f2;
        %>
        <div style="display: flex ;flex-direction: row;background: #ebeeee ;width: 50%;margin-left: 20px">
            <div id="bookViewer"><%
                if (imgvo.getCoverPage2() != null) {
                %><img src="img?id=<%=imgvo.getComcid()%>" alt=""><%
                    } else {
                        out.print("No disponible");
                    }
                %></div>
            <div id="bookDescritpion">
                <span id="comicName"><%=imgvo.getName()%></span><br>
                <span id="comicTitle">Author: <%=imgvo.getPenName()%></span><br>
                <span id="ComicType"></span>
            </div>
        </div>
        <%}
            }%>

    </body>
</html>