package servlet.board;

import com.google.gson.JsonObject;
import controller.BoardController;
import dbConn.ConnectionMaker;
import dbConn.MySqlConnectionMaker;
import model.BoardDTO;
import model.UserDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "UpdateServlet", value = "/board/update")
public class UpdateServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String status = "";
        String nextPath = "";
        String message = "";
        JsonObject object = new JsonObject();
        PrintWriter printWriter = response.getWriter();

        try {
            HttpSession session = request.getSession();
            UserDTO login = (UserDTO) session.getAttribute("login");

            int id = Integer.parseInt(request.getParameter("id"));

            ConnectionMaker connectionMaker = new MySqlConnectionMaker();
            BoardController boardController = new BoardController(connectionMaker);
            BoardDTO b = boardController.selectOne(id);

            if (b == null || b.getWriterId() != login.getId()) {
                throw new NullPointerException();
            }

            b.setTitle(request.getParameter("title"));
            b.setContent(request.getParameter("content"));
            boardController.update(b);

            status = "success";
            nextPath = "/board/printOne.jsp?id=" + id;
            message = "성공적으로 수정되었습니다.";
        } catch (Exception e) {
            status = "error";
            nextPath = "/board/printList.jsp?pageNo=1";
            message = "오류가 발생했습니다.";
        }

        object.addProperty("status", status);
        object.addProperty("message", message);
        object.addProperty("nextPath", nextPath);

        printWriter.print(object);
    }
}
