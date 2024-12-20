package handle.data;

import save.data.Record_Bean;
import java.sql.*;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;

public class SearchByCondition extends HttpServlet {
   public void init(ServletConfig config) throws ServletException {
      super.init(config);
   }

   public void service(HttpServletRequest request,
         HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("utf-8");
      response.setContentType("text/html;charset=utf-8");
      response.setCharacterEncoding("utf-8");

      HttpSession session = request.getSession(true);
      String searchMess = request.getParameter("searchMess");
      String radioMess = request.getParameter("radio");

      if (searchMess == null || searchMess.length() == 0) {
         response.getWriter().print("没有查询信息，无法查询");
         return;
      }

      Connection con = null;
      String queryCondition = "";
      float max = 0, min = 0;

      if (radioMess.contains("mobile_version")) {
         queryCondition = "SELECT mobile_version,mobile_name,mobile_made,mobile_price " +
               "FROM mobileForm where mobile_version=?";
      } else if (radioMess.contains("mobile_name")) {
         queryCondition = "SELECT mobile_version,mobile_name,mobile_made,mobile_price " +
               "FROM mobileForm where mobile_name like ?";
      } else if (radioMess.contains("mobile_price")) {
         try {
            String[] priceMess = searchMess.split("-");
            if (priceMess.length != 2) {
               response.getWriter().print("价格区间格式错误，请使用类似'1000-2000'的格式");
               return;
            }
            min = Float.parseFloat(priceMess[0].trim());
            max = Float.parseFloat(priceMess[1].trim());

            queryCondition = "SELECT mobile_version,mobile_name,mobile_made,mobile_price " +
                  "FROM mobileForm where mobile_price >= ? and mobile_price <= ?";

            // 如果最小值大于最大值，交换它们
            if (min > max) {
               float temp = min;
               min = max;
               max = temp;
            }
         } catch (Exception exp) {
            response.getWriter().print("价格格式错误，请输入正确的数字范围，例如：1000-2000");
            return;
         }
      }

      Record_Bean dataBean = null;
      try {
         dataBean = (Record_Bean) session.getAttribute("dataBean");
         if (dataBean == null) {
            dataBean = new Record_Bean();
            session.setAttribute("dataBean", dataBean);
         }

         Context context = new InitialContext();
         Context contextNeeded = (Context) context.lookup("java:comp/env");
         DataSource ds = (DataSource) contextNeeded.lookup("mobileConn");
         con = ds.getConnection();

         PreparedStatement pstmt = con.prepareStatement(queryCondition,
               ResultSet.TYPE_SCROLL_SENSITIVE,
               ResultSet.CONCUR_READ_ONLY);

         // 设置参数
         if (radioMess.contains("mobile_version")) {
            pstmt.setString(1, searchMess);
         } else if (radioMess.contains("mobile_name")) {
            pstmt.setString(1, "%" + searchMess + "%");
         } else if (radioMess.contains("mobile_price")) {
            pstmt.setFloat(1, min);
            pstmt.setFloat(2, max);
         }

         ResultSet rs = pstmt.executeQuery();
         ResultSetMetaData metaData = rs.getMetaData();
         int columnCount = metaData.getColumnCount();

         rs.last();
         int rows = rs.getRow();

         String[][] tableRecord = new String[rows][columnCount];
         rs.beforeFirst();
         int i = 0;
         while (rs.next()) {
            for (int k = 0; k < columnCount; k++) {
               tableRecord[i][k] = rs.getString(k + 1);
            }
            i++;
         }

         dataBean.setTableRecord(tableRecord);
         dataBean.setCurrentPage(1); // 重置到第一页
         dataBean.setTotalPages((int) Math.ceil(rows / 5.0)); // 设置总页数

         rs.close();
         pstmt.close();
         con.close();

         response.sendRedirect("byPageShow.jsp");
      } catch (Exception e) {
         response.getWriter().print("查询失败：" + e.getMessage());
      } finally {
         try {
            if (con != null)
               con.close();
         } catch (Exception e) {
         }
      }
   }
}
