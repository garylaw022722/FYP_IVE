<%-- 
    Document   : Pagina2
    Created on : 19/12/2017, 04:00:50 PM
    Author     : David
--%>

<%@page import="ict.bean.meetingRequestBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style1.css" type="text/css" media="screen"/>
        <title>JSP Page</title>
    </head>
    <body>

        <%
            Integer dato = 0;
            try {
                meetingRequestBean img = (meetingRequestBean) request.getAttribute("row");
                dato = img.getReqNo();
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
            boolean icono = false;
            try {
                icono = (Boolean) request.getAttribute("row2");
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
        %>


        <form name="formimg" action="ControllerMeeting" method="post" enctype="multipart/form-data">
            <div class="datagrid">
                <table>
                    <thead>
                        <tr>
                            <th></th>
                            <th>reqNo eAddress approver Status title comment phoneCallTime</th>
                    </thead>
                    <tbody>
                        <tr>
                            <td><label for="id"> </label>
                            </td>  
                            <td>
                                <input type="text" name="eAddress" value="<c:out value="${row.eAddress}" />"/>
                                <input type="text" name="approver" value="<c:out value="${row.approver}" />"/>
                                <input type="text" name="status" value="<c:out value="${row.status}" />"/>
                                <input type="text" name="title" value="<c:out value="${row.title}" />"/>
                                <input type="text" name="comment" value="<c:out value="${row.comment}" />"/>
                                <select class="form-control" name="phoneCallTime">
                                                        <option value="10:30:00">10:30AM</option>
                                                        <option value="11:30:00">11:30PM</option>
                                                        <option value="13:30:00">13:30PM</option>
                                                        <option value="14:30:00">14:30PM</option>
                                                    </select>
                            </td>
                        </tr>
                        </tr>
                        <tr>
                            <td colspan="7" style="text-align: center"><input type="submit" value="Enviar Archivo" name="submit" id="btn" class="btn"/></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </form>
        <a href="Pagina11.jsp">Regresar</a>
    </body>
</html>
