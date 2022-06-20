<%-- 
    Document   : Pagina11
    Created on : 19/12/2017, 03:29:08 PM
    Author     : David
--%>

<%@page import="ict.bean.meetingRequestBean"%>
<%@page import="ict.db.MeetingDAO"%>
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
        MeetingDAO emp = new MeetingDAO();
        meetingRequestBean imgvo = new meetingRequestBean();
        ArrayList<meetingRequestBean> listar = emp.Listar_ImagenVO();
    %>

    <div class="datagrid">
        <table>
            <thead>
                <tr>
                    <th>reqNo</th>
                    <th>eAddress</th>
                    <th>sendDate</th>
                    <th>meetingDate</th>
                    <th>approver</th>
                    <th>Status</th>
                    <th>title</th>
                    <th>comment</th>
                    <th>phoneCallTime</th>
                </tr>
            </thead>
            <tfoot>
          
            </tfoot>
            <tbody>
                <%if (listar.size() > 0) {
                        for (meetingRequestBean listar2 : listar) {
                            imgvo = listar2;
                %>
                <tr>
                    <td><%=imgvo.getReqNo()%></td>
                    <td><%=imgvo.geteAddress()%></td>
                    <td><%=imgvo.getSendDate()%></td>
                    <td><%=imgvo.getMeetingDate()%></td>
                    <td><%=imgvo.getApprover()%></td>
                     <td><%=imgvo.getStatus()%></td>
                     <td><%=imgvo.getTitle()%></td>
                     <td><%=imgvo.getComment()%></td>
                     <td><%=imgvo.getCallBackTime()%></td>
                    
                    
                   

                    <td>
                      
                        <a href="ControllerMeeting?action=edit&id=<%=imgvo.getReqNo()%>"> <img src="images/editar.png" title="Modificar"/></a>-
                        <a href="ControllerMeeting?action=delete&id=<%=imgvo.getReqNo()%>"> <img src="images/delete.png" title="Eliminar"/></a>
                    </td>
                </tr>
                <%}
                    }%>
            </tbody>
        </table>
    </div>

</body>
</html>
