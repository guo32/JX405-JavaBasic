<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.StudentController2" %>
<%@ page import="model.StudentDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-09
  Time: 오후 5:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
  ConnectionMaker connectionMaker = new MySqlConnectionMaker();
  StudentController2 controller2 = new StudentController2(connectionMaker.makeConnection());
  StudentDTO studentDTO = new StudentDTO();
  String name = request.getParameter("name");
  int korean = Integer.parseInt(request.getParameter("korean"));
  int english = Integer.parseInt(request.getParameter("english"));
  int math = Integer.parseInt(request.getParameter("math"));
  studentDTO.setName(name);
  studentDTO.setKorean(korean);
  studentDTO.setEnglish(english);
  studentDTO.setMath(math);

  controller2.insert(studentDTO);
  response.sendRedirect("/day0209/printList.jsp");
%>

</body>
</html>
