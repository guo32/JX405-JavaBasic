<%@ page import="model.UserDTO" %>
<%@ page import="controller.ReplyController" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="model.ReplyDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-13
  Time: 오전 10:15
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

        int id = Integer.parseInt(request.getParameter("id"));
        int boardId = Integer.parseInt(request.getParameter("boardId"));

        ConnectionMaker connectionMaker = new MySqlConnectionMaker();
        ReplyController replyController = new ReplyController(connectionMaker);
        ReplyDTO replyDTO = replyController.selectOne(id);
    %>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <title>댓글 수정</title>

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
    <div class="row align-items-center vh-100 justify-content-center" style="background-color: #212529">
        <div class="col-10">
            <form action="/reply/update_logic.jsp?id=<%=id%>&boardId=<%=boardId%>" method="post">
                <table class="table table-striped table-dark">
                    <tr>
                        <td class="col-9">
                            <textarea name="content" placeholder="댓글을 입력해주세요." class="form-control col-10"><%=replyDTO.getContent()%></textarea>
                        </td>
                        <td>
                            <button type="submit" class="btn btn-outline-info">수정</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>
</body>
</html>
