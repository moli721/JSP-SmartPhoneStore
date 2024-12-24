<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="java.text.SimpleDateFormat" %>
            <%@ page import="chatroom.data.ChatMessage" %>
                <%@ page import="chatroom.data.ChatRoomBean" %>
                    <jsp:useBean id="chatRoomBean" class="chatroom.data.ChatRoomBean" scope="application" />

                    <html>

                    <head>
                        <title>聊天消息</title>
                        <style>
                            .message {
                                margin: 10px;
                                padding: 10px;
                                border-radius: 5px;
                                background-color: #f0f0f0;
                            }

                            .sender {
                                font-weight: bold;
                                color: #2c3e50;
                                margin-bottom: 5px;
                            }

                            .time {
                                color: #7f8c8d;
                                font-size: 0.8em;
                                margin-left: 10px;
                            }

                            .content {
                                margin-top: 5px;
                                padding: 8px;
                                background-color: white;
                                border-radius: 4px;
                            }
                        </style>
                        <meta http-equiv="refresh" content="3">
                    </head>

                    <body>
                        <% SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); List<ChatMessage> messages
                            = chatRoomBean.getLatestMessages();
                            if(messages != null) {
                            for(ChatMessage msg : messages) {
                            %>
                            <div class="message">
                                <div class="sender">
                                    <%=msg.getUserId()%>
                                        <span class="time">
                                            <%=sdf.format(msg.getSendTime())%>
                                        </span>
                                </div>
                                <div class="content">
                                    <%=msg.getMessage()%>
                                </div>
                            </div>
                            <% } } %>
                    </body>

                    </html>