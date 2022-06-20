<%-- 
    Document   : Pagina2
    Created on : 19/12/2017, 04:00:50 PM
    Author     : David
--%>

<%@page import="ict.bean.OrderBean"%>
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
                OrderBean img = (OrderBean) request.getAttribute("row");
                dato = img.getOrdId();
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


        <form name="formimg" action="ControllerOrder" method="post" enctype="multipart/form-data">
            <div class="datagrid">
                <table>
                    <thead>
                        <tr>
                            <th></th>
                            <th>eAddress product_id ordDiscount status approver amount store_id</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><label for="id"> </label>
                            </td>  
                            <td>
                                <input type="text" name="eAddress" value="<c:out value="${row.eAddress}" />"/>
                                <input type="text" name="pid" value="<c:out value="${row.pid}" />"/>
                                <input type="number" name="ordDiscount" value="<c:out value="${row.ordDiscount}" />"/>
                                <input type="text" name="status" value="<c:out value="${row.status}" />"/>
                                <input type="text" name="approver" value="<c:out value="${row.approver}" />"/>
                                <input type="number" name="amount" value="<c:out value="${row.amount}" />"/>
                                <input type="number" name="storeId" value="<c:out value="${row.storeId}" />"/>
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
        <a href="AdminControl.jsp">Regresar</a>
    </body>
</html>
