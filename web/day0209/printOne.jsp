<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.StudentController2" %>
<%@ page import="model.StudentDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-09
  Time: 오후 3:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <%
    int id = Integer.parseInt(request.getParameter("id"));
  %>
    <title>개별 학생 보기</title>
  <script>
    function showConfirm() {
      let result = confirm("정말로 삭제하시겠습니까?");
      if (result) {
        location.href = "delete.jsp?id=" + <%=id%>;
      }
    }
  </script>
  <style>
    /* 태그 선택하기 */
    table {
      border : 2px solid black;
    }
    .info_row {
      font-size: 20px;
      color: royalblue;
    }
    #a-update {
      text-decoration: none;
      font-size: 30px;
      color: darkorange;
    }
    tr.selection_row {
      font-size: 40px;
      color: mediumseagreen;
    }
    tr td {
      border: 1px dotted sienna;
    }
  </style>
</head>
<body>
<%
  ConnectionMaker connectionMaker = new MySqlConnectionMaker();
  StudentController2 controller2 = new StudentController2(connectionMaker.makeConnection());
  StudentDTO studentDTO = controller2.selectOne(id);
  int sum = studentDTO.getKorean() + studentDTO.getEnglish() + studentDTO.getMath();
  double average = (double)sum / 3;
%>
<table>
  <tr class="info_row">
    <td>번호: <%=studentDTO.getId()%>번</td>
    <td>이름: <%=studentDTO.getName()%></td>
  </tr>
  <tr class="info_row">
    <td>국어: <%=studentDTO.getKorean()%>점</td>
    <td>영어: <%=studentDTO.getEnglish()%>점</td>
    <td>수학: <%=studentDTO.getMath()%>점</td>
  </tr>
  <tr class="info_row">
    <td>총점: <%=sum%>점</td>
    <td>평균: <%=average%>점</td>
  </tr>
  <tr class="selection_row">
    <td><a href="/day0209/update.jsp?id=<%=studentDTO.getId()%>" id="a-update">수정</a> </td>
    <td><a onclick="showConfirm()">삭제</a> </td>
  </tr>
</table>
<a href="/day0209/printList.jsp">목록으로</a>
</body>
</html>
