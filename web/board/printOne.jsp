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
    <%
        request.setCharacterEncoding("utf-8");
        UserDTO login = (UserDTO) session.getAttribute("login");
        if (login == null) {
            response.sendRedirect("/index.jsp");
        }

        int id = Integer.parseInt(request.getParameter("id"));

        ConnectionMaker connectionMaker = new MySqlConnectionMaker();
        BoardController boardController = new BoardController(connectionMaker);
        UserController userController = new UserController(connectionMaker);
        ReplyController replyController = new ReplyController(connectionMaker);
        ArrayList<ReplyDTO> replyList = replyController.selectAll(id);

        BoardDTO b = boardController.selectOne(id);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM일 dd일 HH시 mm분 ss초");
        pageContext.setAttribute("userController", userController);
    %>
    <script>
        function confirmDelete() {
            let result = confirm("정말로 삭제하시겠습니까?");
            if (result) {
                location.href = "/board/delete.jsp?id=" +
                <%=id%>
            }
        }
    </script>
    <c:set var="replyList" value="<%=replyList%>"/>
    <c:set var="login" value="<%=login%>"/>
    <c:set var="b" value="<%=b%>"/>
    <title>${b.title}
    </title>
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
    <div class="row align-items-center vh-100 justify-content-center">
        <div class="col-10 mb-3">
            <div class="btn btn-outline-info" onclick="location.href='/board/printList.jsp'">목록으로</div>
            <table class="table table-striped table-light" id="table-board">
                <tr>
                    <th class="col-2">글번호</th>
                    <td class="col-10">${b.id}
                    </td>
                </tr>
                <tr>
                    <th class="col-2">제목</th>
                    <td class="col-10">${b.title}
                    </td>
                </tr>
                <tr>
                    <th class="col-2">작성자</th>
                    <td class="col-10"><%=userController.selectOne(b.getWriterId()).getNickname()%>
                    </td>
                </tr>
                <tr>
                    <th class="col-2">작성일</th>
                    <td class="col-10"><fmt:formatDate value="${b.entryDate}" pattern="yyyy년 MM월 dd일 HH시 mm분 ss초"/>
                    </td>
                </tr>
                <tr class="mb-2">
                    <th class="col-2">수정일</th>
                    <td class="col-10"><fmt:formatDate value="${b.modifyDate}" pattern="yyyy년 MM월 dd일 HH시 mm분 ss초"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="text-center">
                        <%=b.getContent()%>
                    </td>
                </tr>
                <c:if test="${login.id eq b.writerId}">
                    <tr>
                        <td colspan="2" class="text-center">
                            <div class="btn btn-outline-success"
                                 onclick="location.href='/board/update.jsp?id=<%=b.getId()%>'">수정하기
                            </div>
                            <div class="btn btn-outline-danger" onclick="confirmDelete()">삭제하기</div>
                        </td>
                    </tr>
                </c:if>
                <tr id="tr-new-row">
                    <td colspan="2" class="text-end" onclick="addNewRow()">
                        새 줄 추가하기
                    </td>
                </tr>
            </table>
            <form action="/reply/write.jsp?id=<%=id%>" method="post">
                <table class="table table-light table-hover">
                    <tr>
                        <td class="col-9">
                            <textarea name="content" placeholder="댓글을 입력해주세요." class="form-control col-10"></textarea>
                        </td>
                        <td>
                            <button type="submit" class="btn btn-outline-info">등록</button>
                        </td>
                    </tr>
                </table>
            </form>
            <table class="table table-light table-hover">
                <c:if test="${replyList.size() == 0}">
                    <tr class="table-right">
                        <td>아직 등록된 댓글이 없습니다.</td>
                    </tr>
                </c:if>
                <c:forEach var="reply" items="${replyList}">
                    <tr class="table-light">
                        <td>
                                ${reply.id}
                        </td>
                        <td class="col-6">
                                ${reply.content}
                        </td>
                        <td>
                                ${userController.selectOne(reply.writerId).nickname}
                        </td>
                        <td>
                            <fmt:formatDate value="${reply.entryDate}" pattern="yy/MM/dd"/>
                        </td>
                        <td>
                            <c:if test="${reply.writerId == login.id}">
                                <div class="btn btn-outline-success btn-sm"
                                     onclick="location.href='../reply/update.jsp?id=${reply.id}&boardId=<%=id%>'">
                                    수정
                                </div>
                                <div class="btn btn-outline-danger btn-sm"
                                     onclick="if(confirm('정말로 삭제하시겠습니까?')){location.href='../reply/delete.jsp?id=${reply.id}&boardId=<%=id%>'}">
                                    삭제
                                </div>
                            </c:if>
                        </td>
                    </tr>
                    <tr class="table-light updateForm"></tr>
                </c:forEach>
            </table>
        </div>
        <div class="col-10">
            <form action="../reply/write_action.jsp?boardId=${b.id}" method="post">
                <table class="table table-striped">
                    <c:choose>
                        <c:when test="${empty replyList}">
                            <tr>
                                <td>
                                    아직 등록된 댓글이 존재하지 않습니다.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${replyList}" var="replyDTO">
                                <tr>
                                    <td>
                                            ${userController.selectOne(replyDTO.writerId).nickname} ${replyDTO.id} ${replyDTO.content}
                                        <fmt:formatDate value="${replyDTO.entryDate}" pattern="yy/MM/dd"/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    <tr>
                        <input type="text" name="content" class="form-control">
                        <button class="btn btn-light">댓글 달기</button>
                    </tr>
                </table>
            </form>
        </div>
    </div>
    <script>
        let addNewRow = () => {
            let newRow = document.getElementById('tr-new-row');
            let table = document.getElementById('table-board');

            console.log(table.children[0].children);
            table.children[0].removeChild(newRow);

            let tr = document.createElement('tr');
            let td = document.createElement('td');
            td.colSpan = 2;
            tr.appendChild(td);
            table.children[0].appendChild(tr);
            table.children[0].appendChild(newRow);
        }
    </script>
</div>
</body>
</html>
