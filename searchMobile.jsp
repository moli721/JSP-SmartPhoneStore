<%@ page contentType="text/html" %>
   <%@ page pageEncoding="utf-8" %>

      <HEAD>
         <%@ include file="head.txt" %>
      </HEAD>
      <title>查询页面</title>

      <style>
         .search-container {
            min-height: 100vh;
            background-color: #f8f9fa;
            padding: 40px 20px;
         }

         .search-card {
            max-width: 800px;
            margin: 0 auto;
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.1);
            padding: 40px;
         }

         .search-title {
            font-size: 28px;
            font-weight: 600;
            color: #333;
            text-align: center;
            margin-bottom: 30px;
         }

         .search-tips {
            background: linear-gradient(45deg, #0062ff, #00a3ff);
            color: white;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 30px;
            line-height: 1.6;
         }

         .search-form {
            margin-top: 30px;
         }

         .search-input {
            width: 100%;
            padding: 15px 20px;
            font-size: 16px;
            border: 2px solid #eee;
            border-radius: 12px;
            margin-bottom: 25px;
            transition: all 0.3s;
         }

         .search-input:focus {
            outline: none;
            border-color: #0062ff;
            box-shadow: 0 0 0 3px rgba(0, 98, 255, 0.1);
         }

         .radio-group {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-bottom: 30px;
            flex-wrap: wrap;
         }

         .radio-item {
            position: relative;
            padding-left: 30px;
            cursor: pointer;
            font-size: 16px;
            user-select: none;
            display: flex;
            align-items: center;
         }

         .radio-item input {
            position: absolute;
            opacity: 0;
            cursor: pointer;
         }

         .radio-checkmark {
            position: absolute;
            left: 0;
            height: 20px;
            width: 20px;
            background-color: #eee;
            border-radius: 50%;
            transition: all 0.2s;
         }

         .radio-item:hover input~.radio-checkmark {
            background-color: #ccc;
         }

         .radio-item input:checked~.radio-checkmark {
            background-color: #0062ff;
         }

         .radio-checkmark:after {
            content: "";
            position: absolute;
            display: none;
            top: 6px;
            left: 6px;
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: white;
         }

         .radio-item input:checked~.radio-checkmark:after {
            display: block;
         }

         .submit-btn {
            background: #0062ff;
            color: white;
            border: none;
            padding: 15px 40px;
            border-radius: 30px;
            font-size: 16px;
            cursor: pointer;
            transition: transform 0.3s, box-shadow 0.3s;
            display: block;
            margin: 0 auto;
         }

         .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 98, 255, 0.3);
         }

         @media (max-width: 768px) {
            .search-card {
               padding: 20px;
            }

            .radio-group {
               flex-direction: column;
               gap: 15px;
            }
         }
      </style>

      <body>
         <div class="search-container">
            <div class="search-card">
               <h2 class="search-title">智能搜索</h2>

               <div class="search-tips">
                  <p>✦ 支持手机版本号精确查询</p>
                  <p>✦ 支持手机名称模糊查询</p>
                  <p>✦ 价格区间查询格式：最低价-最高价（如：899-2999）</p>
               </div>

               <form action="searchByConditionServlet" method="post" class="search-form">
                  <input type="text" name="searchMess" class="search-input" placeholder="请输入搜索关键词..." required>

                  <div class="radio-group">
                     <label class="radio-item">
                        <input type="radio" name="radio" value="mobile_version">
                        <span class="radio-checkmark"></span>
                        手机版本号
                     </label>

                     <label class="radio-item">
                        <input type="radio" name="radio" value="mobile_name">
                        <span class="radio-checkmark"></span>
                        手机名称
                     </label>

                     <label class="radio-item">
                        <input type="radio" name="radio" value="mobile_price" checked>
                        <span class="radio-checkmark"></span>
                        手机价格
                     </label>
                  </div>

                  <button type="submit" class="submit-btn">开始搜索</button>
               </form>
            </div>
         </div>
      </body>

      </HTML>