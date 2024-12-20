<%@ page contentType="text/html" %>
   <%@ page pageEncoding="utf-8" %>
      <%@ page import="javax.sql.DataSource" %>
         <%@ page import="javax.naming.Context" %>
            <%@ page import="javax.naming.InitialContext" %>
               <%@ page import="java.sql.*" %>
                  <jsp:useBean id="loginBean" class="save.data.Login" scope="session" />

                  <HEAD>
                     <%@ include file="head.txt" %>
                  </HEAD>
                  <title>订单查看</title>

                  <style>
                     .order-container {
                        min-height: 100vh;
                        background-color: #f8f9fa;
                        padding: 40px 20px;
                     }

                     .order-card {
                        max-width: 1000px;
                        margin: 0 auto;
                        background: #fff;
                        border-radius: 20px;
                        box-shadow: 0 0 30px rgba(0, 0, 0, 0.1);
                        padding: 40px;
                     }

                     .order-title {
                        font-size: 28px;
                        font-weight: 600;
                        color: #333;
                        text-align: center;
                        margin-bottom: 30px;
                     }

                     .order-table {
                        width: 100%;
                        border-collapse: separate;
                        border-spacing: 0;
                        margin-top: 20px;
                     }

                     .order-table th {
                        background: linear-gradient(45deg, #0062ff, #00a3ff);
                        color: white;
                        padding: 15px;
                        font-weight: 500;
                        text-align: left;
                        font-size: 16px;
                     }

                     .order-table th:first-child {
                        border-top-left-radius: 10px;
                     }

                     .order-table th:last-child {
                        border-top-right-radius: 10px;
                     }

                     .order-table td {
                        padding: 15px;
                        border-bottom: 1px solid #eee;
                        color: #444;
                        font-size: 15px;
                     }

                     .order-table tr:last-child td {
                        border-bottom: none;
                     }

                     .order-table tr:hover {
                        background-color: #f8f9fa;
                        transition: background-color 0.3s ease;
                     }

                     .order-empty {
                        text-align: center;
                        padding: 40px;
                        color: #666;
                        font-size: 16px;
                     }

                     .order-number {
                        font-weight: 600;
                        color: #0062ff;
                     }

                     .order-info {
                        max-width: 400px;
                        line-height: 1.6;
                     }

                     @media (max-width: 768px) {
                        .order-card {
                           padding: 20px;
                        }

                        .order-table {
                           display: block;
                           overflow-x: auto;
                        }

                        .order-table th,
                        .order-table td {
                           padding: 10px;
                           font-size: 14px;
                        }
                     }
                  </style>

                  <body>
                     <div class="order-container">
                        <div class="order-card">
                           <h2 class="order-title">我的订单</h2>

                           <% if(loginBean==null || loginBean.getLogname()==null || loginBean.getLogname().length()==0){
                              response.sendRedirect("login.jsp"); return; } Context context=new InitialContext();
                              Context contextNeeded=(Context)context.lookup("java:comp/env"); DataSource
                              ds=(DataSource)contextNeeded.lookup("mobileConn"); Connection con=null; Statement sql;
                              ResultSet rs; try { con=ds.getConnection(); sql=con.createStatement(); String
                              SQL="SELECT * FROM orderForm where logname='" + loginBean.getLogname() + "'" ;
                              rs=sql.executeQuery(SQL); boolean hasOrders=false; %>

                              <table class="order-table">
                                 <tr>
                                    <th width="120">订单编号</th>
                                    <th width="150">用户名称</th>
                                    <th>订单详情</th>
                                 </tr>

                                 <% while(rs.next()) { hasOrders=true; %>
                                    <tr>
                                       <td class="order-number">#<%=rs.getString(1)%>
                                       </td>
                                       <td>
                                          <%=rs.getString(2)%>
                                       </td>
                                       <td class="order-info">
                                          <%=rs.getString(3)%>
                                       </td>
                                    </tr>
                                    <% } %>
                              </table>

                              <% if(!hasOrders) { %>
                                 <div class="order-empty">
                                    暂无订单记录
                                 </div>
                                 <% } } catch(SQLException e) { %>
                                    <div class="order-empty">
                                       查询订单时发生错误
                                    </div>
                                    <% } finally { try { if(con !=null) con.close(); } catch(Exception ee){} } %>
                        </div>
                     </div>
                  </body>

                  </HTML>