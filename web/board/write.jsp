<%@ page import="model.UserDTO" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.BoardController" %>
<%@ page import="model.BoardDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-10
  Time: 오후 2:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        request.setCharacterEncoding("utf-8");
        UserDTO login = (UserDTO) session.getAttribute("login");
        if (login == null) {
            response.sendRedirect("/index.jsp");
        }
    %>
    <title>글 작성하기</title>
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
            crossorigin="anonymous"></script>
</head>
<body>
<div class="container-fluid" style="background-color: #212529">
    <div class="row align-items-center vh-100 justify-content-center">
        <div class="col-10">
            <form action="/board/write_logic.jsp" method="post">
                <table class="table table-striped table-dark">
                    <tr>
                        <th class="col-2">제목</th>
                        <td class="col-10">
                            <input type="text" name="title" class="form-control">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <textarea name="content" class="form-control"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <button class="btn btn-outline-success">작성하기</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>
</body>
</html>
