package handle.data;

import save.data.Login;
import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class HandleUpdate extends HttpServlet {
   public void init(ServletConfig config) throws ServletException {
      super.init(config);
   }

   public void service(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
      request.setCharacterEncoding("utf-8");
      String amount = request.getParameter("update");
      String goodsId = request.getParameter("goodsId");

      if (amount == null) {
         amount = "1";
      }

      int newAmount = 0;
      try {
         newAmount = Integer.parseInt(amount);
         if (newAmount < 0) {
            newAmount = 1;
         }
      } catch (NumberFormatException exp) {
         newAmount = 1;
      }

      Connection con = null;
      PreparedStatement pre = null;
      Login loginBean = null;
      HttpSession session = request.getSession(true);

      try {
         loginBean = (Login) session.getAttribute("loginBean");
         if (loginBean == null || loginBean.getLogname() == null || loginBean.getLogname().length() == 0) {
            response.sendRedirect("login.jsp");
            return;
         }

         Context context = new InitialContext();
         Context contextNeeded = (Context) context.lookup("java:comp/env");
         DataSource ds = (DataSource) contextNeeded.lookup("mobileConn");
         con = ds.getConnection();

         String updateSQL = "update shoppingForm set goodsAmount=? where goodsId=? and logname=?";
         pre = con.prepareStatement(updateSQL);
         pre.setInt(1, newAmount);
         pre.setString(2, goodsId);
         pre.setString(3, loginBean.getLogname());
         pre.executeUpdate();

         response.sendRedirect("lookShoppingCar.jsp");
      } catch (Exception e) {
         response.getWriter().print("更新失败：" + e.getMessage());
      } finally {
         try {
            if (con != null) {
               con.close();
            }
         } catch (Exception ee) {
         }
      }
   }
}
