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

public class HandleDelete extends HttpServlet {
   public void init(ServletConfig config) throws ServletException {
      super.init(config);
   }

   public void service(HttpServletRequest request,
         HttpServletResponse response)
         throws ServletException, IOException {
      request.setCharacterEncoding("utf-8");
      String goodsId = request.getParameter("goodsId");
      Connection con = null;
      PreparedStatement pre = null; // Ԥ������䡣
      Login loginBean = null;
      HttpSession session = request.getSession(true);
      try {
         loginBean = (Login) session.getAttribute("loginBean");
         if (loginBean == null) {
            response.sendRedirect("login.jsp");// �ض��򵽵�¼ҳ�档
            return;
         } else {
            boolean b = loginBean.getLogname() == null ||
                  loginBean.getLogname().length() == 0;
            if (b) {
               response.sendRedirect("login.jsp");// �ض��򵽵�¼ҳ�档
               return;
            }
         }
      } catch (Exception exp) {
         response.sendRedirect("login.jsp");// �ض��򵽵�¼ҳ�档
         return;
      }
      try {
         Context context = new InitialContext();
         Context contextNeeded = (Context) context.lookup("java:comp/env");
         DataSource ds = (DataSource) contextNeeded.lookup("mobileConn");// ������ӳء�
         con = ds.getConnection();// ʹ�����ӳ��е����ӡ�
         String deleteSQL = "delete  from shoppingForm where goodsId=? and logname=?"; // ӹﳵɾ
         pre = con.prepareStatement(deleteSQL);
         pre.setString(1, goodsId);
         pre.setString(2, loginBean.getLogname());
         pre.executeUpdate();
         con.close();// ӷŻӳء
         response.sendRedirect("lookShoppingCar.jsp");// 鿴ﳵ
      } catch (SQLException e) {
         response.getWriter().print("删除失败：" + e.getMessage());
      } catch (NamingException exp) {
         response.getWriter().print("" + exp);
      } finally {
         try {
            con.close();
         } catch (Exception ee) {
         }
      }
   }
}
