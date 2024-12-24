<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ page import="save.data.Login" %>
        <%@ page import="chatroom.data.ChatRoomBean" %>
            <jsp:useBean id="loginBean" class="save.data.Login" scope="session" />
            <jsp:useBean id="chatRoomBean" class="chatroom.data.ChatRoomBean" scope="application" />

            <% String logname="" ; try { logname=loginBean.getLogname(); if(logname==null || logname.trim().length()==0)
                { response.sendRedirect("../login.jsp"); return; } chatRoomBean.updateUserStatus(logname); }
                catch(Exception e) { response.sendRedirect("../login.jsp"); return; } %>

                <!DOCTYPE html>
                <html>

                <head>
                    <title>聊天室</title>
                    <style>
                        .chat-container {
                            display: flex;
                            height: calc(100vh - 100px);
                            padding: 20px;
                            gap: 20px;
                            background-color: #f5f5f5;
                        }

                        .chat-main {
                            flex: 1;
                            display: flex;
                            flex-direction: column;
                            background: white;
                            border-radius: 10px;
                            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                            padding: 15px;
                        }

                        .members-list {
                            width: 250px;
                            background: white;
                            border-radius: 10px;
                            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                            padding: 15px;
                        }

                        .chat-messages {
                            flex: 1;
                            margin-bottom: 15px;
                        }

                        .chat-form {
                            display: flex;
                            gap: 10px;
                            padding: 15px;
                            background: #f8f9fa;
                            border-radius: 8px;
                        }

                        .message-input {
                            flex: 1;
                            padding: 12px;
                            border: 2px solid #e9ecef;
                            border-radius: 6px;
                            font-size: 16px;
                            transition: border-color 0.3s;
                        }

                        .message-input:focus {
                            outline: none;
                            border-color: #4dabf7;
                        }

                        .send-button {
                            padding: 12px 24px;
                            background-color: #339af0;
                            color: white;
                            border: none;
                            border-radius: 6px;
                            font-size: 16px;
                            cursor: pointer;
                            transition: background-color 0.3s;
                        }

                        .send-button:hover {
                            background-color: #228be6;
                        }

                        iframe {
                            border: none;
                            width: 100%;
                            height: 100%;
                            border-radius: 8px;
                            background: #fff;
                        }

                        .chat-header {
                            padding: 10px 15px;
                            background: #f8f9fa;
                            border-radius: 8px;
                            margin-bottom: 15px;
                        }

                        .chat-header h2 {
                            margin: 0;
                            color: #495057;
                            font-size: 1.2em;
                        }
                    </style>
                    <script>
                        // 修改主页链接的处理
                        function fixHomeLink() {
                            var links = document.getElementsByTagName('a');
                            for (var i = 0; i < links.length; i++) {
                                if (links[i].getAttribute('href') === 'index.jsp') {
                                    links[i].setAttribute('href', '../index.jsp');
                                }
                            }
                        }
                        window.onload = fixHomeLink;
                    </script>
                </head>

                <body>
                    <%@ include file="../head.txt" %>

                        <div class="chat-container">
                            <div class="chat-main">
                                <div class="chat-header">
                                    <h2>聊天室 - 欢迎 <%=logname%>
                                    </h2>
                                </div>
                                <div class="chat-messages">
                                    <iframe src="message.jsp" name="messageFrame"></iframe>
                                </div>
                                <form class="chat-form" action="send.jsp" method="post" target="messageFrame">
                                    <input type="hidden" name="userId" value="<%=logname%>">
                                    <input type="text" name="message" class="message-input" placeholder="输入消息..."
                                        required>
                                    <button type="submit" class="send-button">发送</button>
                                </form>
                            </div>
                            <div class="members-list">
                                <iframe src="members.jsp"></iframe>
                            </div>
                        </div>
                </body>

                </html>