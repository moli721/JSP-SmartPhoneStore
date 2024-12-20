<%@ page contentType="text/html" %>
   <%@ page pageEncoding="utf-8" %>

      <HEAD>
         <%@ include file="head.txt" %>
      </HEAD>
      <title>商品详情</title>
      <style>
         #tom {
            font-family: 宋体;
            font-size: 26;
            color: black
         }
      </style>
      <HTML>

      <body background=image/back.jpg>
         <center>
            <% String mobileID=request.getParameter("mobileID"); if(mobileID==null) { out.print("没有产品号，无法查看详情"); return;
               } Connection con=null; try { Context context=new InitialContext(); Context
               contextNeeded=(Context)context.lookup("java:comp/env"); DataSource
               ds=(DataSource)contextNeeded.lookup("mobileConn"); con=ds.getConnection(); String
               query="SELECT * FROM mobileForm WHERE mobile_version=?" ; PreparedStatement
               pstmt=con.prepareStatement(query); pstmt.setString(1, mobileID); ResultSet rs=pstmt.executeQuery();
               if(rs.next()) { out.print("<table id=tom border=2>");
               out.print("<tr>");
                  out.print("<th>产品号</th>");
                  out.print("<th>名称</th>");
                  out.print("<th>制造商</th>");
                  out.print("<th>价格</th>");
                  out.print("<th>操作</th>");
                  out.print("</tr>");

               out.print("<tr>");
                  out.print("<td>" + rs.getString("mobile_version") + "</td>");
                  out.print("<td>" + rs.getString("mobile_name") + "</td>");
                  out.print("<td>" + rs.getString("mobile_made") + "</td>");
                  out.print("<td>" + rs.getString("mobile_price") + "</td>");
                  out.print("<td><a href='putGoodsServlet?mobileID=" + mobileID + "'>加入购物车</a></td>");
                  out.print("</tr>");
               out.print("</table>");

               out.print("<h3>商品详情：</h3>");
               out.print("<p>" + rs.getString("mobile_mess") + "</p>");

               String picPath = "image/" + rs.getString("mobile_pic");
               out.print("<img src='" + picPath + "' width=260 height=200>");
               } else {
               out.print("未找到该商品");
               }

               rs.close();
               pstmt.close();

               } catch(Exception e) {
               out.print("查询失败：" + e.getMessage());
               } finally {
               try {
               if(con != null) con.close();
               } catch(Exception e) { }
               }
               %>
         </center>
      </body>

      </HTML>