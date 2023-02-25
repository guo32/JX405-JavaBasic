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
    <title>글 수정하기</title>
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
            crossorigin="anonymous"></script>
    <script src="../assets/js_library/build/ckeditor.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <script src="../assets/js/board/update.js"></script>
    <style>
        .ck-editor__editable {
            height: 300px;
            color: black;
        }
    </style>
</head>
<body onload="initPage()">
<div class="container-fluid">
    <div class="row align-items-center vh-100 justify-content-center" style="background-color: #212529">
        <div class="col-10">
            <table class="table table-striped table-dark">
                <tr>
                    <th class="col-2">글번호</th>
                    <td class="col-10"><input type="text" id="input-id" class="form-control" disabled/></td>
                </tr>
                <tr>
                    <th class="col-2">제목</th>
                    <td class="col-10">
                        <input type="text" id="input-title" class="form-control">
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <textarea id="editor" name="content">

                        </textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div class="btn btn-outline-success" onclick="updateBoard()">수정하기</div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>
</body>
</html>
