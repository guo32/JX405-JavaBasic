<%@ page import="model.BoardDTO" %>
<%@ page import="controller.BoardController" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="model.UserDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-10
  Time: 오후 3:36
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

    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    BoardController boardController = new BoardController(connectionMaker);
    BoardDTO b = new BoardDTO();

    b.setWriterId(login.getId());
    b.setTitle(request.getParameter("title"));
    b.setContent(request.getParameter("content"));

    boardController.insert(b);

    response.sendRedirect("/board/printList.jsp");
%>
</body>
</html>
