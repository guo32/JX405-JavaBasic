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

@WebServlet(name = "ReplyDeleteServlet", value = "/reply/delete")
public class ReplyDeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String status = "";
        JsonObject object = new JsonObject();
        PrintWriter writer = response.getWriter();

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            HttpSession session = request.getSession();
            UserDTO login = (UserDTO) session.getAttribute("login");

            ConnectionMaker connectionMaker = new MySqlConnectionMaker();
            ReplyController replyController = new ReplyController(connectionMaker);
            ReplyDTO temp = replyController.selectOne(id);

            if (temp == null || temp.getWriterId() != login.getId()) {
                throw new NullPointerException();
            }

            replyController.delete(id);

            status = "success";
        } catch (Exception e) {
            status = "fail";
        }

        object.addProperty("status", status);
        writer.print(object);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
