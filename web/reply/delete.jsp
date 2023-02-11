<%@ page import="model.UserDTO" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.ReplyController" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-11
  Time: 오후 3:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    UserDTO login = (UserDTO) session.getAttribute("login");
    if (login == null) {
        response.sendRedirect("/index.jsp");
    }
    int id = Integer.parseInt(request.getParameter("id"));
    int boardId = Integer.parseInt(request.getParameter("boardId"));
    System.out.println(id + " " + boardId);

    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    ReplyController replyController = new ReplyController(connectionMaker);

    replyController.delete(id);

    response.sendRedirect("/board/printOne.jsp?id=" + boardId);
%>
</body>
</html>
