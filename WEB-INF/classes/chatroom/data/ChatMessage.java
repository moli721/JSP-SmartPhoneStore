package chatroom.data;

import java.sql.Timestamp;

public class ChatMessage {
    private int id;
    private String userId;
    private String message;
    private Timestamp sendTime;

    // 构造方法
    public ChatMessage() {
    }

    public ChatMessage(int id, String userId, String message, Timestamp sendTime) {
        this.id = id;
        this.userId = userId;
        this.message = message;
        this.sendTime = sendTime;
    }

    // getter和setter方法
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Timestamp getSendTime() {
        return sendTime;
    }

    public void setSendTime(Timestamp sendTime) {
        this.sendTime = sendTime;
    }
}