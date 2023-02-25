package servlet.reply;

import com.google.gson.JsonObject;
import controller.ReplyController;
import dbConn.ConnectionMaker;
import dbConn.MySqlConnectionMaker;
import model.ReplyDTO;
import model.UserDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "WriteServlet", value = "/reply/write")
public class WriteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDTO login = (UserDTO) session.getAttribute("login");
        JsonObject object = new JsonObject();

        try {
            int boardId = Integer.parseInt(request.getParameter("boardId"));
            int writerId = login.getId();
            String content = request.getParameter("content");

            ReplyDTO r = new ReplyDTO();
            r.setWriterId(writerId);
            r.setBoardId(boardId);
            r.setContent(content);

            ConnectionMaker connectionMaker = new MySqlConnectionMaker();
            ReplyController replyController = new ReplyController(connectionMaker);
            replyController.insert(r);

            object.addProperty("status", "success");
        } catch (Exception e) {
            object.addProperty("status", "fail");
        }
        PrintWriter writer = response.getWriter();
        writer.print(object);
    }
}
