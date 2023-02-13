<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.BoardController" %>
<%@ page import="model.BoardDTO" %>
<%@ page import="model.UserDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-10
  Time: 오후 3:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
  request.setCharacterEncoding("utf-8");
  UserDTO login = (UserDTO) session.getAttribute("login");
  if (login == null) {
    response.sendRedirect("/index.jsp");
  }

  int id = Integer.parseInt(request.getParameter("id"));

  ConnectionMaker connectionMaker = new MySqlConnectionMaker();
  BoardController boardController = new BoardController(connectionMaker);
  BoardDTO b = boardController.selectOne(id);

  if (b.getWriterId() != login.getId()) {
    response.sendRedirect("/board/printOne.jsp?id=" + id);
  }

  b.setTitle(request.getParameter("title"));
  b.setContent(request.getParameter("content"));

  boardController.update(b);

  response.sendRedirect("/board/printOne.jsp?id=" + id);
%>
</body>
</html>
