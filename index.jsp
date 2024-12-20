<%@ page contentType="text/html" %>
   <%@ page pageEncoding="utf-8" %>
      <title>智机优选</title>

      <HEAD>
         <%@ include file="head.txt" %>
      </HEAD>
      <style>
         .container {
            min-height: 100vh;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
         }

         .welcome-text {
            font-family: "Microsoft YaHei", sans-serif;
            font-size: 4rem;
            color: #2c3e50;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
            animation: fadeIn 1.5s ease-in;
         }

         .subtitle {
            font-family: "Microsoft YaHei", sans-serif;
            font-size: 1.5rem;
            color: #34495e;
            margin-bottom: 3rem;
            animation: slideUp 1.5s ease-out;
         }

         .feature-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 2rem;
            max-width: 1200px;
            padding: 0 2rem;
         }

         .feature-card {
            background: rgba(255, 255, 255, 0.9);
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s ease;
         }

         .feature-card:hover {
            transform: translateY(-5px);
         }

         @keyframes fadeIn {
            from {
               opacity: 0;
            }

            to {
               opacity: 1;
            }
         }

         @keyframes slideUp {
            from {
               transform: translateY(30px);
               opacity: 0;
            }

            to {
               transform: translateY(0);
               opacity: 1;
            }
         }

         @media (max-width: 768px) {
            .feature-grid {
               grid-template-columns: 1fr;
            }

            .welcome-text {
               font-size: 3rem;
            }
         }
      </style>

      <body>
         <div class="container">
            <h1 class="welcome-text">欢迎光临智机优选手机</h1>
            <p class="subtitle">您的智能手机专业导购</p>

            <div class="feature-grid">
               <div class="feature-card">
                  <h3>品质保证</h3>
                  <p>所有商品均为正品行货<br>享受原厂保修服务</p>
               </div>
               <div class="feature-card">
                  <h3>快速配送</h3>
                  <p>极速发货<br>让您享受快捷购物体验</p>
               </div>
               <div class="feature-card">
                  <h3>售后无忧</h3>
                  <p>7天无理由退换<br>专业客服团队</p>
               </div>
            </div>
         </div>
      </body>

      </HTML>