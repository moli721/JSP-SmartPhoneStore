package chatroom.data;

import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;
import chatroom.data.ChatMessage;
import chatroom.data.ChatUser;

public class ChatRoomBean {
    private DataSource dataSource;
    private List<ChatMessage> messages;
    private List<ChatUser> onlineUsers;

    public ChatRoomBean() {
        try {
            Context context = new InitialContext();
            Context envContext = (Context) context.lookup("java:comp/env");
            dataSource = (DataSource) envContext.lookup("mobileConn");
            messages = new ArrayList<>();
            onlineUsers = new ArrayList<>();
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }

    // 添加消息
    public void addMessage(String userId, String message) {
        try (Connection conn = dataSource.getConnection()) {
            String sql = "INSERT INTO chat_messages (user_id, message, send_time) VALUES (?, ?, NOW())";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            pstmt.setString(2, message);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 获取最新消息
    public List<ChatMessage> getLatestMessages() {
        List<ChatMessage> messages = new ArrayList<>();
        try (Connection conn = dataSource.getConnection()) {
            String sql = "SELECT id, user_id, message, send_time FROM chat_messages ORDER BY send_time DESC LIMIT 50";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                ChatMessage message = new ChatMessage(
                        rs.getInt("id"),
                        rs.getString("user_id"),
                        rs.getString("message"),
                        rs.getTimestamp("send_time"));
                messages.add(message);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return messages;
    }

    // 获取在线用户
    public List<ChatUser> getOnlineUsers() {
        List<ChatUser> users = new ArrayList<>();
        try (Connection conn = dataSource.getConnection()) {
            String sql = "SELECT user_id, login_time FROM online_users WHERE login_time >= NOW() - INTERVAL 5 MINUTE";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                ChatUser user = new ChatUser(
                        rs.getString("user_id"),
                        rs.getTimestamp("login_time"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    // 更新用户在线状态
    public void updateUserStatus(String userId) {
        try (Connection conn = dataSource.getConnection()) {
            String sql = "INSERT INTO online_users (user_id, login_time) VALUES (?, NOW()) " +
                    "ON DUPLICATE KEY UPDATE login_time = NOW()";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}