<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="model.UserDTO" %>
<%@ page import="controller.ReplyController" %>
<%@ page import="model.ReplyDTO" %>
<%@ page import="java.time.LocalDate" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-13
  Time: 오전 10:23
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
    int boardId = Integer.parseInt(request.getParameter("boardId"));

    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    ReplyController replyController = new ReplyController(connectionMaker);
    ReplyDTO replyDTO = replyController.selectOne(id);

    if (replyDTO.getWriterId() != login.getId()) {
        response.sendRedirect("../board/printOne.jsp?id=" + boardId);
    }

    replyDTO.setContent(request.getParameter("content"));
    replyController.update(replyDTO);
    response.sendRedirect("../board/printOne.jsp?id=" + boardId);
%>
</body>
</html>
