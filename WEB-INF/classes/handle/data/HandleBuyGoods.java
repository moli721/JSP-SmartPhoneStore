package handle.data;

import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.lang.reflect.Method;
import java.util.Date;

public class HandleBuyGoods extends HttpServlet {
   public void init(ServletConfig config) throws ServletException {
      super.init(config);
   }

   public void doPost(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
      request.setCharacterEncoding("utf-8");
      response.setContentType("text/html;charset=utf-8");
      PrintWriter out = response.getWriter();

      Connection con = null;
      PreparedStatement pre = null;
      ResultSet rs = null;

      HttpSession session = request.getSession(true);
      Object loginBean = session.getAttribute("loginBean");
      String logname = null;

      try {
         if (loginBean != null) {
            Method getLogname = loginBean.getClass().getMethod("getLogname");
            Object result = getLogname.invoke(loginBean);
            if (result != null) {
               logname = result.toString();
            }
         }

         if (logname == null || logname.trim().length() == 0) {
            response.sendRedirect("login.jsp");
            return;
         }

         Context context = new InitialContext();
         Context contextNeeded = (Context) context.lookup("java:comp/env");
         DataSource ds = (DataSource) contextNeeded.lookup("mobileConn");
         con = ds.getConnection();

         // 查询购物车
         String querySQL = "SELECT * FROM shoppingForm WHERE logname=?";
         pre = con.prepareStatement(querySQL);
         pre.setString(1, logname);
         rs = pre.executeQuery();

         // 生成订单信息
         StringBuilder orderMess = new StringBuilder();
         boolean hasItems = false;

         while (rs.next()) {
            hasItems = true;
            String goodsId = rs.getString("goodsId");
            String goodsName = rs.getString("goodsName");
            double price = rs.getDouble("goodsPrice");
            int amount = rs.getInt("goodsAmount");

            orderMess.append("商品ID: ").append(goodsId)
                  .append(", 商品名称: ").append(goodsName)
                  .append(", 单价: ").append(price)
                  .append(", 数量: ").append(amount)
                  .append("\n");
         }

         if (!hasItems) {
            out.println("<script>alert('购物车为空！');window.location.href='lookShoppingCar.jsp';</script>");
            return;
         }

         // 插入订单
         String insertSQL = "INSERT INTO orderForm(logname, mess) VALUES(?,?)";
         pre = con.prepareStatement(insertSQL);
         pre.setString(1, logname);
         pre.setString(2, orderMess.toString());
         pre.executeUpdate();

         // 清空购物车
         String deleteSQL = "DELETE FROM shoppingForm WHERE logname=?";
         pre = con.prepareStatement(deleteSQL);
         pre.setString(1, logname);
         pre.executeUpdate();

         response.sendRedirect("lookOrderForm.jsp");
      } catch (Exception e) {
         out.println("生成订单失败：" + e.getMessage());
      } finally {
         try {
            if (rs != null)
               rs.close();
            if (pre != null)
               pre.close();
            if (con != null)
               con.close();
         } catch (Exception e) {
         }
      }
   }

   public void doGet(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
      doPost(request, response);
   }
}
