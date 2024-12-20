package save.data;

import java.util.*;

public class Login {
   private String logname = "";
   private String password = "";
   private String backNews = "未登录";
   private boolean logged = false;

   public void setLogname(String logname) {
      this.logname = logname;
   }

   public String getLogname() {
      return logname;
   }

   public void setPassword(String password) {
      this.password = password;
   }

   public String getPassword() {
      return password;
   }

   public void setBackNews(String s) {
      this.backNews = s;
   }

   public String getBackNews() {
      return backNews;
   }

   public void setLogged(boolean logged) {
      this.logged = logged;
   }

   public boolean getLogged() {
      return logged;
   }
}
