<%@ page import="model.UserDTO" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.BoardController" %>
<%@ page import="model.BoardDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-10
  Time: 오후 2:14
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
  BoardController boardController = new BoardController(connectionMaker);

  BoardDTO b = boardController.selectOne(id);
  if (b.getWriterId() == login.getId()) {
    boardController.delete(id);
  }

  response.sendRedirect("/board/printList.jsp");
%>

</body>
</html>
