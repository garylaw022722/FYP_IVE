<%-- 
    Document   : meetingRequestPanel
    Created on : 27-Feb-2021, 18:11:32
    Author     : law
--%>

<%@page import="ict.imageTranslator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ict.bean.meetingRequestBean"%>
<%@page import="ict.db.meetingRequestDB"%>
<%@page import="ict.servlet.meetingRequest"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="js/ImageTranslator.js"></script>
        <script src="https://kit.fontawesome.com/df4f1b5dd7.js" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
        <link rel="stylesheet" href="css/EditorController.css">
        <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.5.1/main.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.5.1/main.min.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
        <link rel="stylesheet" href="css/meetingRequest.css">
    </head>
    <script>
        var it = new ImageTranslator();
        $(document).ready(function () {



//            getAllRequest();

        })

        function getAllRequest() {
            $.ajax({
                url: "meetingRequest",
                type: "get",
                data: {operation: "getAllRequest"},
                success: function (res) {
                    var item = JSON.parse(res);
                    for (var s = 0; s < item.length; s++) {
                        var blob = it.base64ToBlob(item[s].pdf);
                        var url = it.ToObjectURL(blob);
                        var fileName = item[s].title;
                        document.write("<a href='" + url + "' download='" + fileName + "' >" + fileName + "</a><br>")
                    }
                }
            })
        }

    </script>
    <body>
        <div id="topNav"></div>
        <div id="left"></div>
        <div id="reight">
            <div id="contentInsert">

                <div id="toolBar">
                    <div id="toolBarList">
                        <div id="field">
                            <label for="meetingSE">Search Scope</label>
                            <input type="text" id="meetingSE" class="form-control"
                                   placeholder=" Available for  Author name ,contributor email Address ,contact Number "></div>
                        <div id="field">
                            <label for="meetingSE">Date Time</label>
                            <input class="form-control" type="datetime-local" value="2011-08-19T13:45:00" id="dateTime">
                        </div>
                        <div id="fieldSender">
                            <label class="form-check-label" for="sender" style="color: #858888;">Sender : </label>
                            <div style="display: inline-block;width: 3%"></div>

                            <input type="checkbox" class="form-check-input" id="sender">
                            <label class="form-check-label" for="exampleCheck1">Contributor</label>
                            <div style="display: inline-block;width: 3%"></div>

                            <input type="checkbox" class="form-check-input" id="exampleCheck1">
                            <label class="form-check-label" for="exampleCheck1">Responsible user</label>
                            <div style="display: inline-block;width: 3%"></div>

                            <input type="checkbox" class="form-check-input" id="exampleCheck1">
                            <label class="form-check-label" for="exampleCheck1">All</label>
                        </div>
                        <div id="find"><i class="bi bi-search"><span>Search</span></i></div>
                    </div>
                </div>
                <div id="checkList">
                    <table>
                        <tr>
                            <th>No of Request</th>
                            <th>Sender</th>
                            <th>Appellation</th>
                            <th>SendDate</th>
                            <th>Meeting Schedule </th>
                            <th>phone No </th>
                            <th>Call back time </th>
                            <th>Contribution file </th>
                            <th>Acceptance</th>
                        </tr>

                        <%
                   
                            for (meetingRequestBean item : new meetingRequestDB().getAllRequst().getList()) {
                                String fileName = item.getTitle() + ".pdf";
                                String url = new imageTranslator().genImage(item.getPdf());
                                String fileField = "sendFile"+ item.getReqNo();
                        %>
                           
                  
                        <tr>
                            <td><%=item.getReqNo()%></td>
                            <td id="<%=fileField%>"></td>
                        <script>
                            var fileName = "<%=fileName%>"
                            var blob = it.base64ToBlob("<%=url%>");
                            var url = it.ToObjectURL(blob);                           
                            $("<a href='" + url + "' download='" + fileName + "' >" + fileName + "</a>").appendTo("#"+"<%=fileField%>")
                        </script>
                            
                            
                            
                            
                        </tr>
                        <%
                               
                            }
                        %>

                    </table>
                </div>
            </div>
        </div>

    </body>
</html>
