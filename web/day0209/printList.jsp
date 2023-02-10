<%@ page import="model.Student" %>
<%@ page import="model.StudentDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.StudentController2" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-09
  Time: 오후 3:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>학생 목록</title>
  <style>
    .btn {
      background: #34d9bb;
      background-image: -webkit-linear-gradient(top, #34d9bb, #2bb8aa);
      background-image: -moz-linear-gradient(top, #34d9bb, #2bb8aa);
      background-image: -ms-linear-gradient(top, #34d9bb, #2bb8aa);
      background-image: -o-linear-gradient(top, #34d9bb, #2bb8aa);
      background-image: linear-gradient(to bottom, #34d9bb, #2bb8aa);
      -webkit-border-radius: 28;
      -moz-border-radius: 28;
      border-radius: 28px;
      font-family: Arial;
      color: #ffffff;
      font-size: 22px;
      padding: 10px 20px 10px 20px;
      text-decoration: none;
    }

    .btn:hover {
      background: #fcdf3c;
      background-image: -webkit-linear-gradient(top, #fcdf3c, #d97634);
      background-image: -moz-linear-gradient(top, #fcdf3c, #d97634);
      background-image: -ms-linear-gradient(top, #fcdf3c, #d97634);
      background-image: -o-linear-gradient(top, #fcdf3c, #d97634);
      background-image: linear-gradient(to bottom, #fcdf3c, #d97634);
      text-decoration: none;
    }
  </style>
</head>
<body>
<%
  ConnectionMaker connectionMaker = new MySqlConnectionMaker();
  StudentController2 studentController = new StudentController2(connectionMaker.makeConnection());
  ArrayList<StudentDTO> list = studentController.selectAll();

%>
<table>
  <tr>
    <td>번호</td>
    <td>이름</td>
  </tr>
  <%
    for(StudentDTO s : list) {
  %>
  <tr>
    <td><%=s.getId()%></td>
    <td><a href="/day0209/printOne.jsp?id=<%=s.getId()%>"><%=s.getName()%></a></td>
  </tr>
  <%
    }
  %>
</table>
<button onclick="location.href = '/day0209/insert.jsp'" class="btn">학생 추가하기</button>

</body>
</html>
