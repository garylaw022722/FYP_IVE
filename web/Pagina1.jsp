<%-- 
    Document   : Pagina1
    Created on : 19/12/2017, 03:29:08 PM
    Author     : David
--%>

<%@page import="ict.bean.OrderBean"%>
<%@page import="ict.db.orderDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style1.css" type="text/css" media="screen"/>
        <title>JSP Page</title>
    </head>
    <body>
    <center>
    </center>

    <%
        orderDAO emp = new orderDAO();
        OrderBean imgvo = new OrderBean();
        ArrayList<OrderBean> listar = emp.Listar_ImagenVO();
    %>

    <div class="datagrid">
        <table>
            <thead>
                <tr>
                    <th>eAddress</th>
                    <th>product_id</th>
                    <th>ord_id</th>
                    <th>sendDate</th>
                    <th>ordDiscount</th>
                    <th>status</th>
                    <th>updateTime</th>
                    <th>approver</th>
                    <th>amount</th>
                    <th>store_id</th>
                </tr>
            </thead>
            <tfoot>
          
            </tfoot>
            <tbody>
                <%if (listar.size() > 0) {
                        for (OrderBean listar2 : listar) {
                            imgvo = listar2;
                %>
                <tr>
                    <td><%=imgvo.geteAddress()%></td>
                    <td><%=imgvo.getPid()%></td>
                    <td><%=imgvo.getOrdId()%></td>
                    <td><%=imgvo.getSendDate()%></td>
                    <td><%=imgvo.getOrdDiscount()%></td>
                    <td><%=imgvo.getStatus()%></td>
                    <td><%=imgvo.getUpdateTime()%></td>
                    <td><%=imgvo.getApprover()%></td>
                    <td><%=imgvo.getAmount()%></td>
                    <td><%=imgvo.getStoreId()%></td>
                    <td>
                      
                        <a href="ControllerOrder?action=edit&id=<%=imgvo.getOrdId()%>"> <img src="images/editar.png" title="Modificar"/></a>-
                        <a href="ControllerOrder?action=delete&id=<%=imgvo.getOrdId()%>"> <img src="images/delete.png" title="Eliminar"/></a>
                    </td>
                </tr>
                <%}
                    }%>
            </tbody>
        </table>
    </div>

</body>
</html>
