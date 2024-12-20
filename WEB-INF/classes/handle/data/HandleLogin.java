package handle.data;

import save.data.*;
import java.sql.*;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

public class HandleLogin extends HttpServlet {
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    public void service(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        Connection con = null;
        Statement sql;
        String logname = request.getParameter("logname").trim(),
                password = request.getParameter("password").trim();
        password = Encrypt.encrypt(password, "javajsp");
        boolean boo = (logname.length() > 0) && (password.length() > 0);
        try {
            Context context = new InitialContext();
            Context contextNeeded = (Context) context.lookup("java:comp/env");
            DataSource ds = (DataSource) contextNeeded.lookup("mobileConn");
            con = ds.getConnection();
            String condition = "SELECT * FROM user WHERE logname=? AND password=?";
            PreparedStatement pstmt = con.prepareStatement(condition);
            pstmt.setString(1, logname);
            pstmt.setString(2, password);
            if (boo) {
                ResultSet rs = pstmt.executeQuery();
                boolean m = rs.next();
                if (m == true) {
                    // õ¼ɹķ:
                    success(request, response, logname);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");// ת
                    dispatcher.forward(request, response);
                } else {
                    String backNews = "用户名或密码不正确";
                    // õ¼ʧܵķ:
                    fail(request, response, logname, backNews);
                }
                rs.close();
            } else {
                String backNews = "请输入用户名和密码";
                fail(request, response, logname, backNews);
            }
            con.close();// ӷӳء
        } catch (SQLException exp) {
            String backNews = "登录失败：" + exp.getMessage();
            fail(request, response, logname, backNews);
        } catch (NamingException exp) {
            String backNews = "没有设置连接池：" + exp.getMessage();
            fail(request, response, logname, backNews);
        } finally {
            try {
                con.close();
            } catch (Exception ee) {
            }
        }
    }

    private void success(HttpServletRequest request,
            HttpServletResponse response,
            String logname) {
        Login loginBean = null;
        HttpSession session = request.getSession(true);
        try {
            loginBean = (Login) session.getAttribute("loginBean");
            if (loginBean == null) {
                loginBean = new Login(); // µģ
                session.setAttribute("loginBean", loginBean);
            }
            String name = loginBean.getLogname();
            if (name.equals(logname)) {
                loginBean.setBackNews(logname + "已经登录");
            } else { // ģʹ洢µĵ¼û:
                loginBean.setBackNews(logname + "登录成功");
            }
            loginBean.setLogname(logname);
            loginBean.setLogged(true);
        } catch (Exception ee) {
            loginBean = new Login();
            session.setAttribute("loginBean", loginBean);
            loginBean.setBackNews(ee.toString());
            loginBean.setLogname(logname);
            loginBean.setLogged(false);
        }
    }

    private void fail(HttpServletRequest request,
            HttpServletResponse response,
            String logname, String backNews) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        out.println("<script>");
        out.println("alert('" + backNews + "');");
        out.println("window.location.href='login.jsp';");
        out.println("</script>");
    }
}
