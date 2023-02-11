<%@ page import="model.UserDTO" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="controller.ReplyController" %>
<%@ page import="model.ReplyDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-10
  Time: 오후 9:43
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

  ConnectionMaker connectionMaker = new MySqlConnectionMaker();
  ReplyController replyController = new ReplyController(connectionMaker);
  ReplyDTO r = new ReplyDTO();
  r.setWriterId(login.getId());
  r.setBoardId(id);
  r.setContent(request.getParameter("content"));
  replyController.insert(r);

  response.sendRedirect("/board/printOne.jsp?id=" + id);
%>
</body>
</html>
