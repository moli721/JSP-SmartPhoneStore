<%@ page contentType="text/html" %>
   <%@ page pageEncoding="utf-8" %>
      <%@ page import="java.sql.*" %>
         <%@ page import="javax.sql.DataSource" %>
            <%@ page import="javax.naming.Context" %>
               <%@ page import="javax.naming.InitialContext" %>
                  <jsp:useBean id="loginBean" class="save.data.Login" scope="session" />
                  <!DOCTYPE html>
                  <html>

                  <head>
                     <%@ include file="head.txt" %>
                        <style>
                           .product-grid {
                              display: grid;
                              grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                              gap: 20px;
                              padding: 20px;
                           }

                           .product-card {
                              background: white;
                              border-radius: 10px;
                              box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                              padding: 15px;
                              transition: transform 0.3s ease;
                           }

                           .product-card:hover {
                              transform: translateY(-5px);
                           }

                           .product-image {
                              width: 100%;
                              height: 200px;
                              object-fit: cover;
                              border-radius: 8px;
                           }

                           .product-info {
                              padding: 15px 0;
                           }

                           .product-title {
                              font-size: 18px;
                              font-weight: bold;
                              margin-bottom: 10px;
                           }

                           .product-price {
                              color: #e74c3c;
                              font-size: 20px;
                              font-weight: bold;
                           }

                           .add-to-cart {
                              background: linear-gradient(45deg, #1a73e8, #289cf5);
                              color: white;
                              border: none;
                              padding: 10px 20px;
                              border-radius: 5px;
                              cursor: pointer;
                              width: 100%;
                              margin-top: 10px;
                              transition: all 0.3s ease;
                           }

                           .add-to-cart:hover {
                              transform: translateY(-2px);
                              box-shadow: 0 5px 15px rgba(26, 115, 232, 0.3);
                           }

                           .category-filter {
                              margin-bottom: 20px;
                              text-align: center;
                           }

                           .filter-btn {
                              padding: 10px 20px;
                              margin: 0 10px;
                              border: none;
                              border-radius: 5px;
                              cursor: pointer;
                              background: #f8f9fa;
                              transition: all 0.3s ease;
                           }

                           .filter-btn.active {
                              background: linear-gradient(45deg, #1a73e8, #289cf5);
                              color: white;
                           }
                        </style>
                  </head>

                  <body>
                     <div class="page-container">
                        <div class="content-card">
                           <div class="category-filter">
                              <button class="filter-btn active" onclick="filterProducts('all')">全部手机</button>
                              <button class="filter-btn" onclick="filterProducts('ios')">iOS手机</button>
                              <button class="filter-btn" onclick="filterProducts('android')">Android手机</button>
                           </div>

                           <div class="product-grid">
                              <% try { Connection con=null; Statement sql=null; ResultSet rs=null; Context context=new
                                 InitialContext(); Context contextNeeded=(Context)context.lookup("java:comp/env");
                                 DataSource ds=(DataSource)contextNeeded.lookup("mobileConn"); con=ds.getConnection();
                                 sql=con.createStatement(); String query="SELECT * FROM mobileForm" ;
                                 rs=sql.executeQuery(query); while(rs.next()) { String
                                 id=rs.getString("mobile_version"); String name=rs.getString("mobile_name"); String
                                 manufacturer=rs.getString("mobile_made"); double price=rs.getDouble("mobile_price");
                                 String spec=rs.getString("mobile_mess"); String image=rs.getString("mobile_pic");
                                 String categoryClass=manufacturer.contains("苹果") ? "ios" : "android" ; %>
                                 <div class="product-card" data-category="<%=categoryClass%>">
                                    <img src="image/<%=image%>" alt="<%=name%>" class="product-image">
                                    <div class="product-info">
                                       <div class="product-title">
                                          <%=name%>
                                       </div>
                                       <div>
                                          <%=manufacturer%>
                                       </div>
                                       <div>
                                          <%=spec%>
                                       </div>
                                       <div class="product-price">￥<%=price%>
                                       </div>
                                       <% if(loginBean !=null && loginBean.getLogname() !=null) { %>
                                          <form action="addToCart" method="POST">
                                             <input type="hidden" name="goodsId" value="<%=id%>">
                                             <input type="hidden" name="goodsName" value="<%=name%>">
                                             <input type="hidden" name="goodsPrice" value="<%=price%>">
                                             <button type="submit" class="add-to-cart">加入购物车</button>
                                          </form>
                                          <% } %>
                                    </div>
                                 </div>
                                 <% } con.close(); } catch(Exception e) { out.print("查询数据库出错！" + e.getMessage()); } %>
                           </div>
                        </div>
                     </div>

                     <script>
                        function filterProducts(category) {
                           const products = document.querySelectorAll('.product-card');
                           const buttons = document.querySelectorAll('.filter-btn');

                           // 更新按钮状态
                           buttons.forEach(btn => {
                              btn.classList.remove('active');
                              if (btn.textContent.toLowerCase().includes(category)) {
                                 btn.classList.add('active');
                              }
                           });

                           // 过滤产品
                           products.forEach(product => {
                              if (category === 'all' || product.dataset.category === category) {
                                 product.style.display = 'block';
                              } else {
                                 product.style.display = 'none';
                              }
                           });
                        }
                     </script>
                  </body>

                  </html>