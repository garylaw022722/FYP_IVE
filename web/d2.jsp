<%-- 
    Document   : d2
    Created on : Dec 31, 2020, 1:36:41 PM
    Author     : law
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       
        <h1>Hello World!</h1>
        <%
            String sa =  request.getSession().getAttribute("name").toString();
                out.print(sa);
        %>
        
    </body>
</html>
