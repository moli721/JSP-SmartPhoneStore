package handle.data;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import save.data.Record_Bean;

public class ChangePage extends HttpServlet {
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        Record_Bean dataBean = (Record_Bean) session.getAttribute("dataBean");

        if (dataBean != null) {
            String pageStr = request.getParameter("page");
            if (pageStr != null) {
                int page = Integer.parseInt(pageStr);
                dataBean.setCurrentPage(page);
            }
        }

        response.sendRedirect("byPageShow.jsp");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}