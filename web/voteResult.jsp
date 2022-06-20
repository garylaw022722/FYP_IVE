<%-- 
    Document   : voteResult
    Created on : 2021/1/28, 下午 09:39:03
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="ict.bean.Account"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="barCss/css/bootstrap.min.css" rel="stylesheet">
        <link href="barCss/css/simple-sidebar.css" rel="stylesheet">
        <link href="barCss/css/dashboard.css" rel="stylesheet">
        <link rel="stylesheet" href="css/EditorController.css">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="js/canvasjs.min.js"></script>

        <style type="text/css">
            button {
                position: relative;
                display: inline-block;
                cursor: pointer;
                outline: none;
                border: 0;
                vertical-align: middle;
                text-decoration: none;
                font-size: 1.5rem;
                color: var(--colorShadeA);
                font-weight: 700;
                text-transform: uppercase;
                font-family: inherit;
            }

            button.big-button {
                padding: 1em 2em;
                border: 2px solid var(--colorShadeA);
                border-radius: 1em;
                background: var(--colorShadeE);
                transform-style: preserve-3d;
                transition: all 175ms cubic-bezier(0, 0, 1, 1);
            }

            button.big-button::before {
                position: absolute;
                content: '';
                width: 100%;
                height: 100%;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: var(--colorShadeC);
                border-radius: inherit;
                box-shadow: 0 0 0 2px var(--colorShadeB), 0 0.75em 0 0 var(--colorShadeA);
                transform: translate3d(0, 0.75em, -1em);
                transition: all 175ms cubic-bezier(0, 0, 1, 1);
            }

            button.big-button:hover {
                background: var(--colorShadeD);
                transform: translate(0, 0.375em);
            }

            button.big-button:hover::before {
                transform: translate3d(0, 0.75em, -1em);
            }

            button.big-button:active {
                transform: translate(0em, 0.75em);
            }

            button.big-button:active::before {
                transform: translate3d(0, 0, -1em);
                box-shadow: 0 0 0 2px var(--colorShadeB), 0 0.25em 0 0 var(--colorShadeB);
            }
        </style>
        <script>
            setInterval(function () {
                $.post("showVoteResult.jsp", {eventID: "" + <%=request.getParameter("eventID")%> + ""}, function (data) {
                    $("#loading").hide();
                    $(".big-button").show();
                    $(".voteTitle").show();
                    $(".voteComment").show();
                    $(".row").html(data);
                });
            }, 2000);
        </script>

        <%Account editor = (Account) request.getSession().getAttribute("editor");%>

        <%if (editor == null) {%>
        <script>window.location.href = "Login2.jsp";</script>
        <%}%>
    </head>
    <body>
        <div id="topNav"></div>
        <div id="left">
            <%@include file="parts/editorLeftBar.jsp" %>
        </div>
        <h1 id="loading">Loading!!!</h1>
        <div class="container">
            <h1 style="padding: 10px;display: none;" class="voteTitle">Vote Result</h1>
            <h4 style="color: red;display: none;" class="voteComment">* = your comic have Shortlisted on vote ranking </h4>
            <button class="big-button" style="margin-bottom: 30px;display: none;" id="showchart">Column Chart</button>
            <button class="big-button" style="margin-bottom: 30px;display: none;" id="showBarchar">Bar Chart</button>
            <button class="big-button" style="margin-bottom: 30px;display: none;" id="showPiechar">Pie Chart</button>
            <div class="row">

            </div>
            <div id="chart" style="height: 380px; width: 100%;"></div>
            <div id="chart2" style="height: 380px; width: 100%;"></div>
            <div id="chart3" style="height: 380px; width: 100%;"></div>
        </div>
    </body>
</html>
