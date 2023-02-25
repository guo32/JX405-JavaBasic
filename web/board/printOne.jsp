<%@ page import="model.UserDTO" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.BoardController" %>
<%@ page import="model.BoardDTO" %>
<%@ page import="controller.UserController" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="controller.ReplyController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.ReplyDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-10
  Time: 오후 1:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title></title>
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <script src="/assets/js/board/printOne.js"></script>
    <script src="/assets/js/reply/replyUtil.js"></script>
</head>
<body onload="initPage()">
<div class="container-fluid">
    <div class="row align-items-center vh-100 align-item-center">
        <div class="row justify-content-center">
            <div class="col-10">
                <table class="table table-striped table-warning" id="table-board">
                    <tr>
                        <th>글 번호</th>
                        <td id="td-id"></td>
                    </tr>
                    <tr>
                        <th>글 제목</th>
                        <td id="td-title"></td>
                    </tr>
                    <tr>
                        <th>작성자</th>
                        <td id="td-writer"></td>
                    </tr>
                    <tr>
                        <th>작성일</th>
                        <td id="td-entry-date"></td>
                    </tr>
                    <tr>
                        <th>수정일</th>
                        <td id="td-modify-date"></td>
                    </tr>
                    <tr>
                        <th colspan="2" class="text-center">내용</th>
                    </tr>
                    <tr>
                        <td colspan="2" id="td-content"></td>
                    </tr>
                    <tr>
                        <th colspan="2" class="text-center">
                            댓글
                        </th>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <table class="table table-light table-striped" id="table-reply">
                                <tbody id="tbody-reply">
                                <tr>
                                    <td >
                                        <input type="text" class="form-control" id="input-reply"/>
                                    </td>
                                    <td>
                                        <div class="btn btn-outline-secondary w-100" onclick="writeReply()">등록</div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
