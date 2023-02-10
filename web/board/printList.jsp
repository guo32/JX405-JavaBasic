<%@ page import="model.UserDTO" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.BoardController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.BoardDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-10
  Time: 오전 11:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시판</title>
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
            crossorigin="anonymous"></script>
</head>
<body>
<div class="container-fluid">
    <%
        UserDTO login = (UserDTO) session.getAttribute("login");

        if (login == null) {
            response.sendRedirect("/index.jsp");
        }

        ConnectionMaker connectionMaker = new MySqlConnectionMaker();
        BoardController controller = new BoardController(connectionMaker);

        ArrayList<BoardDTO> list = controller.selectAll();

        if (list.isEmpty()) {
    %>
    <div class="row">
        <div class="col-6">
            <span>아직 등록된 글이 존재하지 않습니다.</span>
        </div>
    </div>
    <%
    } else {
    %>
    <div class="table">
        <div class="row">
            <div class="col">번호</div>
            <div class="col">제목</div>
            <div class="col">작성자</div>
        </div>
        <%
            for (BoardDTO b : list) {
        %>
        <div class="row">
            <div class="col"><%=b.getId()%></div>
            <div class="col"><%=b.getTitle()%></div>
            <div class="col"><%=b.getWriterId()%></div>
        </div>
        <%
            }
        %>
    </div>
    <%
        }
    %>
</div>
</body>
</html>
