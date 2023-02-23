<%@ page import="model.UserDTO" %>
<%@ page import="model.ReplyDTO" %>
<%@ page import="controller.ReplyController" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-13
  Time: 오후 1:22
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
  int boardId = Integer.parseInt(request.getParameter("boardId"));
  String content = request.getParameter("content");

  ReplyDTO replyDTO = new ReplyDTO();
  replyDTO.setBoardId(boardId);
  replyDTO.setWriterId(login.getId());
  replyDTO.setContent(content);

  ConnectionMaker connectionMaker = new MySqlConnectionMaker();
  ReplyController replyController = new ReplyController(connectionMaker);
  replyController.insert(replyDTO);

  response.sendRedirect("../board/printOne.jsp?id=" + boardId);
%>
</body>
</html>
