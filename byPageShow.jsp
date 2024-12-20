<%@ page contentType="text/html" %>
   <%@ page pageEncoding="utf-8" %>
      <%@ page import="java.sql.*" %>
         <jsp:useBean id="dataBean" class="save.data.Record_Bean" scope="session" />
         <!DOCTYPE html>
         <html>

         <head>
            <title>智机优选 - 商品列表</title>
            <style>
               body {
                  font-family: 'Microsoft YaHei', sans-serif;
                  background-color: #f5f7fa;
                  margin: 0;
                  padding: 20px;
               }

               .container {
                  max-width: 1200px;
                  margin: 0 auto;
                  padding: 20px;
                  background-color: white;
                  border-radius: 15px;
                  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
               }

               h2 {
                  color: #2c3e50;
                  text-align: center;
                  margin-bottom: 30px;
                  font-size: 28px;
               }

               .product-table {
                  width: 100%;
                  border-collapse: collapse;
                  margin-bottom: 20px;
                  background-color: white;
               }

               .product-table th {
                  background: linear-gradient(45deg, #1a73e8, #289cf5);
                  color: white;
                  padding: 15px;
                  text-align: left;
                  font-weight: 500;
               }

               .product-table td {
                  padding: 12px 15px;
                  border-bottom: 1px solid #eee;
               }

               .product-table tr:hover {
                  background-color: #f8f9ff;
                  transition: background-color 0.3s ease;
               }

               .status-bar {
                  background-color: #fff;
                  padding: 15px;
                  border-radius: 8px;
                  margin-top: 20px;
                  text-align: center;
                  color: #666;
                  font-size: 16px;
               }

               .query-link {
                  display: inline-block;
                  padding: 8px 20px;
                  background: linear-gradient(45deg, #1a73e8, #289cf5);
                  color: white;
                  text-decoration: none;
                  border-radius: 5px;
                  margin-left: 10px;
                  transition: transform 0.2s ease;
               }

               .query-link:hover {
                  transform: translateY(-2px);
                  box-shadow: 0 4px 12px rgba(26, 115, 232, 0.2);
               }

               @media (max-width: 768px) {
                  .container {
                     padding: 10px;
                  }

                  .product-table th,
                  .product-table td {
                     padding: 8px;
                     font-size: 14px;
                  }
               }
            </style>
         </head>

         <body>
            <div class="container">
               <h2>精选手机列表</h2>
               <table class="product-table">
                  <tr>
                     <th>手机型号</th>
                     <th>产品名称</th>
                     <th>制造商</th>
                     <th>价格</th>
                  </tr>
                  <% String[][] table=dataBean.getTableRecord(); if(table !=null) { for(int i=0; i < table.length; i++)
                     { out.print("<tr>");
                     for(int j = 0; j < 4; j++) { out.print("<td>");
                        out.print(table[i][j]);
                        out.print("</td>");
                        }
                        out.print("</tr>");
                        }
                        }
                        %>
               </table>
               <div class="status-bar">
                  <% if(table !=null) { out.print("当前共有 " + table.length + " 款精选机型"); } else { out.print("暂无商品数据 ");
                out.print(" <a class='query-link' href='queryServlet'>点击加载商品</a>");
                     }
                     %>
               </div>
            </div>
         </body>

         </html>