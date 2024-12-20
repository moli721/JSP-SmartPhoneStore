<%@ page contentType="text/html" %>
   <%@ page pageEncoding="utf-8" %>
      <jsp:useBean id="loginBean" class="save.data.Login" scope="session" />
      <!DOCTYPE html>
      <html>

      <head>
         <%@ include file="head.txt" %>
            <title>智机优选 - 登录</title>
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
            <style>
               * {
                  box-sizing: border-box;
               }

               body {
                  background: #f8f9fa;
                  margin: 0;
                  font-family: 'Microsoft YaHei', sans-serif;
                  min-height: 100vh;
               }

               .login-section {
                  display: flex;
                  justify-content: center;
                  align-items: center;
                  min-height: calc(100vh - 60px);
                  /* 减去导航栏高度 */
                  padding: 40px 20px;
               }

               .container {
                  background-color: #fff;
                  border-radius: 20px;
                  box-shadow: 0 14px 28px rgba(0, 0, 0, 0.1),
                     0 10px 10px rgba(0, 0, 0, 0.1);
                  position: relative;
                  overflow: hidden;
                  width: 900px;
                  max-width: 100%;
                  min-height: 550px;
               }

               .form-container {
                  position: absolute;
                  top: 0;
                  height: 100%;
                  transition: all 0.6s ease-in-out;
               }

               .sign-in-container {
                  left: 0;
                  width: 50%;
                  z-index: 2;
               }

               form {
                  background-color: #FFFFFF;
                  display: flex;
                  align-items: center;
                  justify-content: center;
                  flex-direction: column;
                  padding: 0 50px;
                  height: 100%;
                  text-align: center;
               }

               h1 {
                  font-weight: bold;
                  margin: 0;
                  color: #2c3e50;
               }

               .input-group {
                  position: relative;
                  width: 100%;
                  margin: 10px 0;
               }

               .input-group input {
                  background-color: #f8f9fa;
                  border: none;
                  border-bottom: 2px solid #eee;
                  padding: 12px 15px;
                  margin: 8px 0;
                  width: 100%;
                  font-size: 16px;
                  transition: all 0.3s ease;
               }

               .input-group input:focus {
                  outline: none;
                  border-bottom-color: #1a73e8;
               }

               .input-group label {
                  position: absolute;
                  top: 20px;
                  left: 15px;
                  color: #999;
                  transition: all 0.3s ease;
                  pointer-events: none;
               }

               .input-group input:focus+label,
               .input-group input:valid+label {
                  top: 0;
                  font-size: 12px;
                  color: #1a73e8;
               }

               .overlay-container {
                  position: absolute;
                  top: 0;
                  left: 50%;
                  width: 50%;
                  height: 100%;
                  overflow: hidden;
                  transition: transform 0.6s ease-in-out;
                  z-index: 100;
               }

               .overlay {
                  background: #1a73e8;
                  background: linear-gradient(45deg, #1a73e8, #289cf5);
                  background-repeat: no-repeat;
                  background-size: cover;
                  background-position: 0 0;
                  color: #FFFFFF;
                  position: relative;
                  left: -100%;
                  height: 100%;
                  width: 200%;
                  transform: translateX(0);
                  transition: transform 0.6s ease-in-out;
               }

               .overlay-panel {
                  position: absolute;
                  display: flex;
                  align-items: center;
                  justify-content: center;
                  flex-direction: column;
                  padding: 0 40px;
                  text-align: center;
                  top: 0;
                  height: 100%;
                  width: 50%;
                  transform: translateX(0);
                  transition: transform 0.6s ease-in-out;
               }

               .overlay-right {
                  right: 0;
                  transform: translateX(0);
               }

               .submit-btn {
                  background: linear-gradient(45deg, #1a73e8, #289cf5);
                  color: white;
                  border: none;
                  border-radius: 30px;
                  font-size: 16px;
                  padding: 12px 45px;
                  letter-spacing: 1px;
                  text-transform: uppercase;
                  cursor: pointer;
                  transition: transform 0.3s ease;
                  margin-top: 20px;
               }

               .submit-btn:hover {
                  transform: translateY(-2px);
                  box-shadow: 0 5px 15px rgba(26, 115, 232, 0.3);
               }

               .welcome-image {
                  width: 280px;
                  margin-bottom: 30px;
               }

               .feedback-message {
                  margin-top: 20px;
                  padding: 10px;
                  border-radius: 5px;
                  font-size: 14px;
                  color: #666;
               }

               .register-link {
                  margin-top: 15px;
                  font-size: 14px;
               }

               .register-link a {
                  color: #1a73e8;
                  text-decoration: none;
                  font-weight: 500;
               }

               .register-link a:hover {
                  text-decoration: underline;
               }
            </style>
      </head>

      <body>
         <div class="login-section">
            <div class="container">
               <div class="form-container sign-in-container">
                  <form action="loginServlet" method="post">
                     <h1>智机优选</h1>
                     <p>使用您的账号访问所有服务</p>

                     <div class="input-group">
                        <input type="text" name="logname" required>
                        <label>用户名</label>
                     </div>

                     <div class="input-group">
                        <input type="password" name="password" required>
                        <label>密码</label>
                     </div>

                     <button type="submit" class="submit-btn">登 录</button>

                     <div class="feedback-message">
                        <div>登录状态：
                           <jsp:getProperty name="loginBean" property="backNews" />
                        </div>
                        <div>当前用户：
                           <jsp:getProperty name="loginBean" property="logname" />
                        </div>
                     </div>

                     <div class="register-link">
                        还没有账号？<a href="inputRegisterMess.jsp">立即注册</a>
                     </div>
                  </form>
               </div>
               <div class="overlay-container">
                  <div class="overlay">
                     <div class="overlay-panel overlay-right">
                        <img src="image/welcome.png" alt="Welcome" class="welcome-image">
                        <h1>欢迎回来！</h1>
                        <p>智能手机优选平台，为您提供最优质的产品和服务</p>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </body>

      </html>