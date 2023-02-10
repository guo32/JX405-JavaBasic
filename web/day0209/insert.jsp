<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.StudentController2" %>
<%@ page import="model.StudentDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-09
  Time: 오후 5:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>학생 추가</title>
</head>
<body>
<form action="/day0209/insert_action.jsp" method="post">
  <table>
    <tr>
      <th colspan="2"> 학생 추가 </th>
    </tr>
    <tr>
      <td>이름</td>
      <td><input type="text" name="name" placeholder="이름"></td>
    </tr>
    <tr>
      <td>국어</td>
      <td><input type="text" name="korean" placeholder="국어 점수">점</td>
    </tr>
    <tr>
      <td>영어</td>
      <td><input type="text" name="english" placeholder="영어 점수">점</td>
    </tr>
    <tr>
      <td>수학</td>
      <td><input type="text" name="math" placeholder="수학 점수">점</td>
    </tr>
    <tr>
      <td colspan="2"><button type="submit">등록</button> </td>
    </tr>
  </table>
</form>

</body>
</html>
