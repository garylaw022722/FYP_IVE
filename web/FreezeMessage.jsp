<%-- 
    Document   : FreezeMessage
    Created on : 2021/4/24, 下午 04:05:04
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.10.4/sweetalert2.css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.10.4/sweetalert2.all.min.js"></script>
    </head>
    <body>
        <script>
            $(document).ready(function () {
                Swal.fire({
                    icon: 'error',
                    title: 'Try again',
                    text: 'Your account have been freezed, please call 35164878 to query details ',
                }).then(function () {
                    location.href = 'Login2.jsp';
                });
            })
        </script>
    </body>
</html>
