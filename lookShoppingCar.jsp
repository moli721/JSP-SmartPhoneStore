<%@ page contentType="text/html" %>
   <%@ page pageEncoding="utf-8" %>
      <%@ page import="save.data.Login" %>
         <%@ page import="java.sql.*" %>
            <%@ page import="javax.sql.DataSource" %>
               <%@ page import="javax.naming.Context" %>
                  <%@ page import="javax.naming.InitialContext" %>
                     <jsp:useBean id="loginBean" class="save.data.Login" scope="session" />
                     <!DOCTYPE html>
                     <html>

                     <head>
                        <title>智机优选 - 购物车</title>
                        <%@ include file="head.txt" %>
                           <style>
                              body {
                                 font-family: 'Microsoft YaHei', sans-serif;
                                 background-color: #f5f7fa;
                                 margin: 0;
                                 padding: 20px;
                              }

                              .cart-container {
                                 max-width: 1200px;
                                 margin: 0 auto;
                                 padding: 30px;
                                 background-color: white;
                                 border-radius: 15px;
                                 box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
                              }

                              .cart-title {
                                 color: #2c3e50;
                                 text-align: center;
                                 margin-bottom: 30px;
                                 font-size: 28px;
                                 font-weight: 600;
                              }

                              .cart-table {
                                 width: 100%;
                                 border-collapse: collapse;
                                 margin-bottom: 30px;
                                 background: white;
                              }

                              .cart-table th {
                                 background: linear-gradient(45deg, #1a73e8, #289cf5);
                                 color: white;
                                 padding: 15px;
                                 text-align: left;
                                 font-weight: 500;
                              }

                              .cart-table td {
                                 padding: 15px;
                                 border-bottom: 1px solid #eee;
                                 vertical-align: middle;
                              }

                              .cart-table tr:hover {
                                 background-color: #f8f9fa;
                              }

                              .quantity-input {
                                 width: 60px;
                                 padding: 8px;
                                 border: 1px solid #ddd;
                                 border-radius: 4px;
                                 text-align: center;
                              }

                              .update-btn,
                              .delete-btn {
                                 padding: 8px 15px;
                                 border: none;
                                 border-radius: 5px;
                                 cursor: pointer;
                                 transition: all 0.3s ease;
                              }

                              .update-btn {
                                 background: linear-gradient(45deg, #1a73e8, #289cf5);
                                 color: white;
                              }

                              .delete-btn {
                                 background: linear-gradient(45deg, #ff4757, #ff6b81);
                                 color: white;
                              }

                              .update-btn:hover,
                              .delete-btn:hover {
                                 transform: translateY(-2px);
                                 box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                              }

                              .order-btn {
                                 display: block;
                                 width: 100%;
                                 max-width: 300px;
                                 margin: 20px auto;
                                 padding: 15px;
                                 background: linear-gradient(45deg, #2ecc71, #27ae60);
                                 color: white;
                                 border: none;
                                 border-radius: 8px;
                                 font-size: 16px;
                                 cursor: pointer;
                                 transition: all 0.3s ease;
                              }

                              .order-btn:hover {
                                 transform: translateY(-2px);
                                 box-shadow: 0 4px 12px rgba(46, 204, 113, 0.2);
                              }

                              .empty-cart {
                                 text-align: center;
                                 padding: 40px;
                                 color: #666;
                                 font-size: 18px;
                              }
                           </style>
                     </head>

                     <body>
                        <div class="cart-container">
                           <h2 class="cart-title">我的购物车</h2>
                           <% if(loginBean==null || loginBean.getLogname()==null || loginBean.getLogname().length()==0)
                              { response.sendRedirect("login.jsp"); return; } Context context=new InitialContext();
                              Context contextNeeded=(Context)context.lookup("java:comp/env"); DataSource
                              ds=(DataSource)contextNeeded.lookup("mobileConn"); Connection con=null; Statement sql;
                              ResultSet rs; try { con=ds.getConnection(); sql=con.createStatement(); String
                              SQL="SELECT goodsId, goodsName, goodsPrice, goodsAmount FROM shoppingForm WHERE logname=?"
                              ; PreparedStatement pstmt=con.prepareStatement(SQL); pstmt.setString(1,
                              loginBean.getLogname()); rs=pstmt.executeQuery(); boolean hasItems=false; %>
                              <table class="cart-table">
                                 <tr>
                                    <th>商品编号</th>
                                    <th>商品名称</th>
                                    <th>单价(元)</th>
                                    <th>数量</th>
                                    <th>操作</th>
                                 </tr>
                                 <% while(rs.next()) { hasItems=true; String goodsId=rs.getString(1); String
                                    name=rs.getString(2); float price=rs.getFloat(3); int amount=rs.getInt(4); %>
                                    <tr>
                                       <td>
                                          <%=goodsId%>
                                       </td>
                                       <td>
                                          <%=name%>
                                       </td>
                                       <td>￥<%=price%>
                                       </td>
                                       <td>
                                          <form action="updateServlet" method="post" style="display:inline;">
                                             <input type="number" class="quantity-input" name="update"
                                                value="<%=amount%>" min="1">
                                             <input type="hidden" name="goodsId" value="<%=goodsId%>">
                                             <input type="submit" class="update-btn" value="更新">
                                          </form>
                                       </td>
                                       <td>
                                          <form action="deleteServlet" method="post" style="display:inline;">
                                             <input type="hidden" name="goodsId" value="<%=goodsId%>">
                                             <input type="submit" class="delete-btn" value="删除">
                                          </form>
                                       </td>
                                    </tr>
                                    <% } if(!hasItems) { %>
                                       <tr>
                                          <td colspan="5" class="empty-cart">
                                             购物车还是空的，快去选购心仪的商品吧！
                                          </td>
                                       </tr>
                                       <% } else { %>
                              </table>
                              <form action="buyServlet" method="post">
                                 <input type="hidden" name="logname" value="<%=loginBean.getLogname()%>">
                                 <input type="submit" class="order-btn" value="生成订单">
                              </form>
                              <% } con.close(); } catch(SQLException e) { %>
                                 <div class="empty-cart">
                                    系统繁忙，请稍后再试
                                 </div>
                                 <% } finally { try { if(con !=null) { con.close(); } } catch(Exception ee) {} } %>
                        </div>
                     </body>

                     </html>