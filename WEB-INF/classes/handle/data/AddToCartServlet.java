package handle.data;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import javax.sql.DataSource;
import javax.naming.*;
import java.lang.reflect.Method;

public class AddToCartServlet extends HttpServlet {
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(true);
        Object loginBean = session.getAttribute("loginBean");
        String logname = null;

        if (loginBean != null) {
            try {
                Method getLogname = loginBean.getClass().getMethod("getLogname");
                Object result = getLogname.invoke(loginBean);
                if (result != null) {
                    logname = result.toString();
                }
            } catch (Exception e) {
                out.println("获取登录信息失败：" + e.getMessage());
                return;
            }
        }

        if (logname == null || logname.trim().length() == 0) {
            response.sendRedirect("login.jsp");
            return;
        }

        String goodsId = request.getParameter("goodsId");
        String goodsName = request.getParameter("goodsName");
        String priceStr = request.getParameter("goodsPrice");

        try {
            double price = Double.parseDouble(priceStr);

            Context context = new InitialContext();
            Context contextNeeded = (Context) context.lookup("java:comp/env");
            DataSource ds = (DataSource) contextNeeded.lookup("mobileConn");
            Connection con = ds.getConnection();

            out.println("当前登录用户名: " + logname + "<br>");

            String checkUserSQL = "SELECT logname FROM user WHERE logname=?";
            PreparedStatement checkUserStmt = con.prepareStatement(checkUserSQL);
            checkUserStmt.setString(1, logname);
            ResultSet userRs = checkUserStmt.executeQuery();

            if (!userRs.next()) {
                out.println("用户 " + logname + " 不存在于数据库中<br>");
                Statement stmt = con.createStatement();
                ResultSet allUsers = stmt.executeQuery("SELECT logname FROM user");
                out.println("数据库中的用户列表：<br>");
                while (allUsers.next()) {
                    out.println(allUsers.getString("logname") + "<br>");
                }
                con.close();
                return;
            }

            String insertSQL = "INSERT INTO shoppingForm(logname, goodsId, goodsName, goodsPrice, goodsAmount) VALUES(?,?,?,?,1)";
            PreparedStatement insertStmt = con.prepareStatement(insertSQL);
            insertStmt.setString(1, logname.trim());
            insertStmt.setString(2, goodsId);
            insertStmt.setString(3, goodsName);
            insertStmt.setDouble(4, price);

            try {
                insertStmt.executeUpdate();
                response.sendRedirect("lookShoppingCar.jsp");
            } catch (SQLException e) {
                out.println("插入购物车失败：" + e.getMessage() + "<br>");
                out.println("SQL State: " + e.getSQLState() + "<br>");
                out.println("Error Code: " + e.getErrorCode() + "<br>");
            }

            con.close();

        } catch (Exception e) {
            out.println("操作失败：" + e.getMessage());
            e.printStackTrace(new PrintWriter(out));
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}