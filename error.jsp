<%@ page contentType="text/html" %>
    <%@ page pageEncoding="utf-8" %>
        <%@ page isErrorPage="true" %>
            <html>

            <head>
                <title>错误页面</title>
            </head>

            <body>
                <h2>发生错误</h2>
                <p>错误信息：<%= exception.getMessage() %>
                </p>
                <p>错误类型：<%= exception.getClass() %>
                </p>
            </body>

            </html>