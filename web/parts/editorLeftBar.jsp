<%-- 
    Document   : editorLeftBar
    Created on : 2021/5/3, 下午 10:03:07
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <style>
        #itemCall{
            margin-bottom: 30px;
            width: 100%;
            height: 70px;
            text-align: center;
        }
        #sideLogo{
            width: 30px;
            height: 30px;
            margin: auto;
        }
        #sideDescription{
            margin-top: 15px;
            font-size: 13px;
            font-family: AppleMyungjo;
            text-align: center;
            color: #6e7e8c;
        }
    </style>
    <body>
        <div id="itemCall">
            <a href="EditorController.jsp">
                <div id="sideLogo"><img src="images/home.svg" alt=""></div>
                <div id="sideDescription">Main.jsp</div>
            </a>
        </div>

        <div id="spLine"></div>
        <div id="itemCall">
            <a href="meetingRequest.jsp">
                <div id="sideLogo"><img src="images/meeting.svg" alt=""></div>
                <div id="sideDescription">Meeting Request</div>
            </a>
        </div>
        <div id="spLine"></div>
        <div id="itemCall">
            <a href="showVote.jsp">
                <div id="sideLogo"><img src="images/vote.svg" alt=""></div>
                <div id="sideDescription">Review Vote</div>
            </a>
        </div>

        <div id="itemCall">
            <a href="EditorContract.jsp">
                <div id="sideLogo"><img src="images/contract.svg" alt=""></div>
                <div id="sideDescription">Contract</div>
            </a>
        </div>

        <div id="itemCall">
            <a href="EditorContribution.jsp">
                <div id="sideLogo"><img src="images/contribution.svg" alt=""></div>
                <div id="sideDescription">Contribution</div>
            </a>
        </div>

        <div id="itemCall">
            <a href="login2?action=logout">
                <div id="sideLogo"><img src="images/logout.svg" alt=""></div>
                <div id="sideDescription">Logout</div>
            </a>
        </div>
    </body>
</html>
