package chatroom.data;

import java.sql.Timestamp;

public class ChatUser {
    private String userId;
    private Timestamp loginTime;

    // 构造方法
    public ChatUser() {
    }

    public ChatUser(String userId, Timestamp loginTime) {
        this.userId = userId;
        this.loginTime = loginTime;
    }

    // getter和setter方法
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Timestamp getLoginTime() {
        return loginTime;
    }

    public void setLoginTime(Timestamp loginTime) {
        this.loginTime = loginTime;
    }
}