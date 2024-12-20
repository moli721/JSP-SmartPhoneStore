package save.data;

public class Register {
   private String logname = "";
   private String password = "";
   private String phone = "";
   private String address = "";
   private String realname = "";
   private String backNews = "请输入信息";

   // 用户名验证规则
   private static final int MIN_USERNAME_LENGTH = 3;
   private static final int MAX_USERNAME_LENGTH = 20;

   // 密码验证规则
   private static final int MIN_PASSWORD_LENGTH = 6;
   private static final int MAX_PASSWORD_LENGTH = 20;

   // 手机号验证规则
   private static final String PHONE_REGEX = "^1[3-9]\\d{9}$";

   // Getters and Setters with validation
   public void setLogname(String logname) {
      if (logname == null || logname.trim().isEmpty()) {
         this.backNews = "用户名不能为空";
         return;
      }
      if (logname.length() < MIN_USERNAME_LENGTH || logname.length() > MAX_USERNAME_LENGTH) {
         this.backNews = "用户名长度必须在" + MIN_USERNAME_LENGTH + "-" + MAX_USERNAME_LENGTH + "个字符之间";
         return;
      }
      this.logname = logname.trim();
   }

   public String getLogname() {
      return logname;
   }

   public void setPhone(String phone) {
      if (phone != null && !phone.trim().isEmpty()) {
         if (!phone.matches(PHONE_REGEX)) {
            this.backNews = "请输入有效的手机号码";
            return;
         }
      }
      this.phone = phone;
   }

   public String getPhone() {
      return phone;
   }

   public void setAddress(String address) {
      if (address != null && address.length() > 100) {
         this.backNews = "地址长度不能超过100个字符";
         return;
      }
      this.address = address;
   }

   public String getAddress() {
      return address;
   }

   public void setRealname(String realname) {
      if (realname != null && realname.length() > 30) {
         this.backNews = "真实姓名长度不能超过30个字符";
         return;
      }
      this.realname = realname;
   }

   public String getRealname() {
      return realname;
   }

   public void setBackNews(String backNews) {
      this.backNews = backNews;
   }

   public String getBackNews() {
      return backNews;
   }

   // 验证用户输入的所有信息
   public boolean validateUserInput() {
      // 验证必填字段
      if (logname.trim().isEmpty()) {
         backNews = "用户名不能为空";
         return false;
      }

      if (password.trim().isEmpty()) {
         backNews = "密码不能为空";
         return false;
      }

      // 验证密码长度
      if (password.length() < MIN_PASSWORD_LENGTH || password.length() > MAX_PASSWORD_LENGTH) {
         backNews = "密码长度必须在" + MIN_PASSWORD_LENGTH + "-" + MAX_PASSWORD_LENGTH + "个字符之间";
         return false;
      }

      // 验证手机号(如果提供)
      if (!phone.isEmpty() && !phone.matches(PHONE_REGEX)) {
         backNews = "请输入有效的手机号码";
         return false;
      }

      return true;
   }

   // 清除用户信息(用于注销或重置)
   public void clearUserInfo() {
      logname = "";
      password = "";
      phone = "";
      address = "";
      realname = "";
      backNews = "请输入信息";
   }
}
