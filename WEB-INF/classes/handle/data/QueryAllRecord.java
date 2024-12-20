package handle.data;

import save.data.Record_Bean;
import java.sql.*;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;

public class QueryAllRecord extends HttpServlet {
   public void init(ServletConfig config) throws ServletException {
      super.init(config);
   }

   public void service(HttpServletRequest request,
         HttpServletResponse response)
         throws ServletException, IOException {
      request.setCharacterEncoding("utf-8");

      HttpSession session = request.getSession(true);
      Connection con = null;
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

         String query = "SELECT mobile_version, mobile_name, mobile_made, " +
               "mobile_price, mobile_mess, mobile_pic " +
               "FROM mobileForm";

         PreparedStatement pstmt = con.prepareStatement(query,
               ResultSet.TYPE_SCROLL_SENSITIVE,
               ResultSet.CONCUR_READ_ONLY);

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

         rs.close();
         pstmt.close();

         response.sendRedirect("byPageShow.jsp");
      } catch (Exception e) {
         e.printStackTrace();
         response.getWriter().println("查询失败：" + e.getMessage());
      } finally {
         try {
            if (con != null)
               con.close();
         } catch (Exception e) {
         }
      }
   }
}
