<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ page import="save.data.Login" %>
        <%@ page import="chatroom.data.ChatRoomBean" %>
            <jsp:useBean id="loginBean" class="save.data.Login" scope="session" />
            <jsp:useBean id="chatRoomBean" class="chatroom.data.ChatRoomBean" scope="application" />

            <% request.setCharacterEncoding("UTF-8"); String userId=request.getParameter("userId"); String
                message=request.getParameter("message"); if(userId !=null && message !=null &&
                !message.trim().isEmpty()) { chatRoomBean.addMessage(userId, message); } // 重定向回消息页面
                response.sendRedirect("message.jsp"); %>