<%-- 
    Document   : AccountManage
    Created on : Jan 25, 2021, 12:19:46 PM
    Author     : law
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/AdminSidebar.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <title>Account Management</title>
    </head>
    <script>
        $(document).ready(function () {
//            var pageLoad = "AccountManage.jsp";
            var pageLoad = "upload.jsp"
            // var pageLoad ="AppointList.html";
            $(document).ready(function () {
                controller(pageLoad);

                $('#AccountOpt').click(function () {
                    pageLoad = "AccountManage.jsp";
                    controller(pageLoad);
                })
                $('#Appointment').click(function () {
                    pageLoad = "t1.jsp";
                    controller(pageLoad);
                })
                $('#Posted').click(function () {
                    pageLoad = "internalRegForm.jsp";
                    controller(pageLoad);
                })


                $("#buildCon").click(function () {
                    pageLoad = "upload.jsp";
                    controller(pageLoad);
                })

                $("#userInfo").click(function () {
                    pageLoad = "upload.jsp";
                    controller(pageLoad);
                })
                $("#bannerUpload").click(function () {
                    pageLoad = "bannerList.jsp";
                    controller(pageLoad);
                })
                $("#leave").click(function () {
                    window.location.href = "Main.jsp";

                })
                $("#createBundle").click(function(){
                    pageLoad = "createBundleProduct.jsp";
                    controller(pageLoad);
                })

                $("#orderManagement").click(function(){
                    pageLoad = "Pagina1.jsp";
                    controller(pageLoad);
                })
                
                $("#createVoting").click(function(){
                     window.location.href = 'Voting?action=CreateForm';
                })
                $("#handlemeeting").click(function(){
                     pageLoad = "Pagina11.jsp";
                    controller(pageLoad);
                })

            })
            function  controller(page) {
                $('#pageSetUP').load(page);
            }

        })
    </script>
    <body>
        <jsp:include page="parts/AdminSidebar.jsp"/>
    </body>
</html>
