<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="controller.StudentController2" %>
<%@ page import="model.StudentDTO" %>
<%@ page import="dbConn.MySqlConnectionMaker" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-09
  Time: 오후 4:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>학생 정보 수정하기</title>
</head>
<body>
<%
  int id = Integer.parseInt(request.getParameter("id"));
  ConnectionMaker connectionMaker = new MySqlConnectionMaker();
  StudentController2 controller2 = new StudentController2(connectionMaker.makeConnection());
  StudentDTO studentDTO = controller2.selectOne(id);
%>
<form action="/day0209/update_action.jsp?id=<%=studentDTO.getId()%>" method="post">
  <table>
    <tr>
      <td>번호: <%=studentDTO.getId()%></td>
      <td>이름: <%=studentDTO.getName()%></td>
    </tr>
    <tr>
      <td>국어: <input type="text" name="korean" value="<%=studentDTO.getKorean()%>"> </td>
      <td>영어: <input type="text" name="english" value="<%=studentDTO.getEnglish()%>"> </td>
      <td>수학: <input type="text" name="math" value="<%=studentDTO.getMath()%>"> </td>
    </tr>
    <tr>
      <td><button>수정하기</button></td>
    </tr>
  </table>
</form>

</body>
</html>
