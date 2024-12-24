package chatroom.data;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class SendMessageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String userId = request.getParameter("userId");
        String message = request.getParameter("message");

        if (userId != null && message != null && !message.trim().isEmpty()) {
            ChatRoomBean chatRoom = new ChatRoomBean();
            chatRoom.addMessage(userId, message);
        }

        response.sendRedirect("message.jsp");
    }
}