<%@ page contentType="text/html" %>
    <%@ page pageEncoding="utf-8" %>
        <%@ page import="java.util.List" %>
            <%@ page import="chatroom.data.ChatUser" %>
                <%@ page import="chatroom.data.ChatRoomBean" %>
                    <jsp:useBean id="chatRoomBean" class="chatroom.data.ChatRoomBean" scope="session" />

                    <html>

                    <head>
                        <title>在线用户</title>
                        <style>
                            .member-list {
                                padding: 10px;
                            }

                            .member {
                                margin: 5px;
                                padding: 8px;
                                background-color: white;
                                border-radius: 4px;
                                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                            }

                            .online-indicator {
                                display: inline-block;
                                width: 8px;
                                height: 8px;
                                background-color: #2ecc71;
                                border-radius: 50%;
                                margin-right: 5px;
                            }
                        </style>
                        <meta http-equiv="refresh" content="10">
                    </head>

                    <body>
                        <div class="member-list">
                            <h3>在线用户</h3>
                            <% List<ChatUser> users = chatRoomBean.getOnlineUsers();
                                if(users != null && !users.isEmpty()) {
                                for(ChatUser user : users) {
                                %>
                                <div class="member">
                                    <span class="online-indicator"></span>
                                    <%=user.getUserId()%>
                                </div>
                                <% } } else { %>
                                    <div class="no-users">当前没有其他在线用户</div>
                                    <% } %>
                        </div>
                    </body>

                    </html>