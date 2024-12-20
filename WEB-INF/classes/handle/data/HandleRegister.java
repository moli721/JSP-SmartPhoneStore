package handle.data;

import save.data.Register;
import java.sql.*;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

public class HandleRegister extends HttpServlet {
   public void init(ServletConfig config) throws ServletException {
      super.init(config);
   }

   public void service(HttpServletRequest request,
         HttpServletResponse response)
         throws ServletException, IOException {
      request.setCharacterEncoding("utf-8");
      Connection con = null;
      PreparedStatement sql = null;
      Register userBean = new Register();
      request.setAttribute("userBean", userBean);
      String logname = request.getParameter("logname").trim();
      String password = request.getParameter("password").trim();
      String again_password = request.getParameter("again_password").trim();
      String phone = request.getParameter("phone").trim();
      String address = request.getParameter("address").trim();
      String realname = request.getParameter("realname").trim();

      if (logname == null)
         logname = "";
      if (password == null)
         password = "";
      if (!password.equals(again_password)) {
         userBean.setBackNews("两次密码不同，注册失败！");
         RequestDispatcher dispatcher = request.getRequestDispatcher("inputRegisterMess.jsp");
         dispatcher.forward(request, response);
         return;
      }

      boolean isLD = true;
      for (int i = 0; i < logname.length(); i++) {
         char c = logname.charAt(i);
         if (!(Character.isLetterOrDigit(c) || c == '_'))
            isLD = false;
      }

      boolean boo = logname.length() > 0 && password.length() > 0 && isLD;
      String backNews = "";
      try {
         Context context = new InitialContext();
         Context contextNeeded = (Context) context.lookup("java:comp/env");
         DataSource ds = (DataSource) contextNeeded.lookup("mobileConn");
         con = ds.getConnection();
         String insertCondition = "INSERT INTO user VALUES (?,?,?,?,?)";
         sql = con.prepareStatement(insertCondition);

         if (boo) {
            sql.setString(1, logname);
            password = Encrypt.encrypt(password, "javajsp");
            sql.setString(2, password);
            sql.setString(3, phone);
            sql.setString(4, address);
            sql.setString(5, realname);
            int m = sql.executeUpdate();
            if (m != 0) {
               backNews = "注册成功";
               userBean.setBackNews(backNews);
               userBean.setLogname(logname);
               userBean.setPhone(phone);
               userBean.setAddress(address);
               userBean.setRealname(realname);
            }
         } else {
            backNews = "信息填写不完整或名字中有非法字符";
            userBean.setBackNews(backNews);
         }
         con.close();
      } catch (SQLException exp) {
         backNews = "该用户名已被注册，请重新输入" + exp;
         userBean.setBackNews(backNews);
      } catch (NamingException exp) {
         backNews = "没有设置连接池" + exp;
         userBean.setBackNews(backNews);
      } finally {
         try {
            con.close();
         } catch (Exception ee) {
         }
      }
      RequestDispatcher dispatcher = request.getRequestDispatcher("inputRegisterMess.jsp");
      dispatcher.forward(request, response);
   }
}
