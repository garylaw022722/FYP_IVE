<%-- 
    Document   : CreateVoteForm
    Created on : 2021年1月27日, 上午11:24:19
    Author     : tytap
--%>

<%@page import="ict.bean.ComicBean"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    </head>
    <style>
        #div{
            border: 1px solid red;
            width: 100%;
            height: 300px;
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

    </style>
    <script>
        $(document).ready(function () {
            var div = "<div id='div'></div>"
            $('#character').change(function () {
                $('#outer').append("<div>123</div>");
            });
            $("#outer").click(function () {
                alert("213");
            });
        });
    </script>
    <body>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <!------ Include the above in your HEAD tag ---------->
        <form action="Voting">
            <input hidden name="action" value="Create"/>
            <div class="container">
                <!-- Begin Modal Body -->
                <label for='basicInfo' class='text-primary display-5'>Basic Action Info:</label>
                <div class='border border-dark p-4 rounded' id='basicInfo'>
                    <div class='form-group edit' data-toggle='collapse'>
                        <label for='actionStatus' class='text-primary'>Descript</label>
                        <input type='text' class='form-control' placeholder='Action Title' name="descript">
                    </div>
                    <!-- End Action Status -->
                    <!-- Begin Action Title -->
                    <div class='form-group'>
                        <label for='actionTitle' class='text-primary'>Question</label>
                        <input type='text' class='form-control' placeholder='Action Title' name="question">
                        <div class='text-danger collapse' id='valTitle'>Action Title is required.</div>
                    </div>
                    <!-- End Action Title -->

                    <!-- Begin Action Description -->
                    <div class='form-group'>
                        <label for='samsDesc' class='text-primary'>Entries</label>
                        <%
                            ArrayList<ComicBean> comicList = (ArrayList<ComicBean>) request.getAttribute("comicList");
                            for (int i = 0; i < comicList.size(); i++) {
                                ComicBean c = comicList.get(i);
                                out.println("<div class='form-check'>");
                                out.println("<input type='checkbox' class='form-check-input' name='checks' value='"+c.getComic_Id()+"'>");
                                out.println("<label class='form-check-label' for='materialUnchecked'>12"+c.getName()+"</label>");
                                out.println("</div>");
                            }
                        %>
                        <div id='selected'></div>
                        <div class='text-danger collapse' id='valDesc'>Action Description is required.</div>
                    </div>
                    <!-- End Action Description -->

                    <!-- Begin Action Dept/Due/Assigned -->
                    <div class='form-group row'>
                        <div class='col'>
                            <label for='samsDept' class='text-primary'>Start Day</label>
                            <div class='input-group date' data-provide='datapicker'>
                                <input type='date' class='form-control' name="startDate">
                            </div>
                            <div class='text-danger collapse' id='valDept'>Department is required.</div>
                        </div>
                        <div class='col'>
                            <label for='samsDue' class='text-primary'>End Day</label>
                            <div class='input-group date' data-provide='datapicker'>
                                <input type='date' class='form-control' name="endDate">
                            </div>
                            <div class='text-danger collapse' id='valDue'>Due Date is required.</div>
                        </div>
                        <div class='col'>
                            <label for='assignedTo' class='text-primary'>Create</label>
                            <div class='input-group date' data-provide='datapicker'>
                                <input type='submit' class='form-control'>
                            </div>
                        </div>
                    </div>
                    <!-- Begin Action Dept/Due/Assigned -->

                </div>
            </div>

            <!-- Begin Sub-Actions -->
        </form>
        <div id="outer">

        </div>
        <!-- End Modal Body -->
    </div>
</body>
</html>
