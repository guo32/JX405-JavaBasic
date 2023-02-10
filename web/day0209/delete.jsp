<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.StudentController2" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-09
  Time: 오후 4:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    StudentController2 controller2 = new StudentController2(connectionMaker.makeConnection());

    controller2.delete(id);

    response.sendRedirect("/day0209/printList.jsp");
%>
</body>
</html>
