<%-- 
    Document   : votingUI
    Created on : 2021年1月24日, 下午05:12:45
    Author     : user
--%>

<%@page import="ict.bean.Account"%>
<%@page import="ict.bean.ComicBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="sideBar/MsideBar.jsp" />
<link href="barCss/css/bootstrap.min.css" rel="stylesheet">
<link href="barCss/css/simple-sidebar.css" rel="stylesheet">
<link href="barCss/css/dashboard.css" rel="stylesheet">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
    <head>

        <meta charset="UTF-8">
        <title>`Title`</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">  
        <style type="text/css">
            body{
                background: #eef1f6;
            }
            #outer{
                display: flex;
                align-items: center;
                justify-content: center;
                width: 100%;
                height: 600px;
                display: flex;
                flex-wrap: wrap;
                padding: 20px;


            }

            #outer div{
                margin-right: 50px;
                border-radius: 4px  ;
                width: 18%;
                height: 400px;
                margin-bottom: 20px;
            }
            #Voteimg{
                height: 90%;
                width: 100%;
            }
            .ComicInfo{
                background: white;
                height: 10%;
            }
        </style>
    </head>

    <body>
        
        <script>

            $(document).ready(function () {
            <%
                String question = (String) request.getAttribute("question");
                String event_Id = (String) request.getAttribute("event_Id");
                ArrayList<ComicBean> comicList = (ArrayList<ComicBean>) request.getAttribute("comicList");
                for (int i = 0; i < comicList.size(); i++) {
                    ComicBean c = comicList.get(i);
                    out.println("$('#" + c.getComic_Id() + "').click(function(){");
                    out.println("$('#ComicTitle').empty();");
                    out.println("$('#ComicTitle').append('" + c.getName() + "');");
                    out.println("$('#comic_Id').val('"+c.getComic_Id()+"');");
                    out.println("$('#exampleModal').modal('show');");
                    out.println("});");
                }
            %>

            });
        </script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>  
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
        
        <div id="outer">
            <%
                Account member = (Account) request.getSession().getAttribute("member");
                String username = member.geteAddress();
                for (int i = 0; i < comicList.size(); i++) {
                    ComicBean c = comicList.get(i);
                    out.println("<div id=" + c.getComic_Id() + "><image id='Voteimg' src='data:image/jpg;base64," + c.getCoverPage() + "'><p class='ComicInfo'> "+c.getName()+"</p></div>");
                }
            %>
        </div>
        

        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <form action="Voting">
                <input hidden name="action" value="add"/>
                <input hidden name="event_id" value="<%= event_Id%>"/>
                <input hidden name="eAddress" value="<%= username%>"/>
                <input hidden name="comic_Id" id="comic_Id" value=""/>
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="ComicTitle"></h5>
                        </div>
                        <div class="modal-body">
                            <form>
                                <div class="form-group">
                                    <label for="recipient-name" class="col-form-label" id="Question"><% out.println(question);%></label>
                                    <input type="text" class="form-control" id="yearRange" name="yearRange">
                                </div>
                                <div class="form-group">
                                    <label for="message-text" class="col-form-label">Response</label>
                                    <textarea class="form-control" id="message-text" name="repsonse"></textarea>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Confirm</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </body>
</html>
