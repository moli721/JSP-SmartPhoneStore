<%@ page contentType="text/html" %>
    <%@ page pageEncoding="utf-8" %>
        <jsp:useBean id="userBean" class="save.data.Register" scope="request" />

        <HEAD>
            <%@ include file="head.txt" %>
        </HEAD>
        <title>注册页面</title>

        <style>
            .page-container {
                min-height: 100vh;
                background-color: #f8f9fa;
                padding: 40px 20px;
            }

            .register-card {
                max-width: 800px;
                margin: 0 auto;
                background: #fff;
                border-radius: 20px;
                box-shadow: 0 0 30px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                display: flex;
            }

            .register-left {
                flex: 1;
                padding: 40px;
            }

            .register-right {
                flex: 1;
                background: linear-gradient(45deg, #0062ff, #00a3ff);
                padding: 40px;
                color: white;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .form-title {
                font-size: 28px;
                font-weight: 600;
                color: #333;
                margin-bottom: 30px;
            }

            .input-group {
                margin-bottom: 25px;
                position: relative;
            }

            .input-group input {
                width: 100%;
                padding: 12px 20px;
                font-size: 16px;
                border: none;
                border-bottom: 2px solid #eee;
                background: transparent;
                transition: all 0.3s;
            }

            .input-group input:focus {
                outline: none;
                border-bottom-color: #0062ff;
            }

            .input-group label {
                position: absolute;
                top: 12px;
                left: 20px;
                font-size: 16px;
                color: #999;
                transition: all 0.3s;
                pointer-events: none;
            }

            .input-group input:focus+label,
            .input-group input:valid+label {
                top: -10px;
                left: 0;
                font-size: 12px;
                color: #0062ff;
            }

            .required-field label::after {
                content: '*';
                color: #ff4757;
                margin-left: 4px;
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
            }

            .submit-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0, 98, 255, 0.3);
            }

            .welcome-text {
                font-size: 32px;
                margin-bottom: 20px;
            }

            .feature-list {
                list-style: none;
                padding: 0;
            }

            .feature-list li {
                margin-bottom: 15px;
                display: flex;
                align-items: center;
            }

            .feature-list li::before {
                content: '✓';
                margin-right: 10px;
                font-size: 20px;
            }

            .feedback-panel {
                margin-top: 30px;
                padding: 20px;
                background: #f8f9fa;
                border-radius: 10px;
            }

            @media (max-width: 768px) {
                .register-card {
                    flex-direction: column;
                }

                .register-right {
                    display: none;
                }
            }
        </style>

        <body>
            <div class="page-container">
                <div class="register-card">
                    <div class="register-left">
                        <h2 class="form-title">创建账户</h2>
                        <form action="registerServlet" method="post">
                            <div class="input-group required-field">
                                <input type="text" name="logname" required>
                                <label>用户名称</label>
                            </div>

                            <div class="input-group required-field">
                                <input type="password" name="password" required>
                                <label>密码</label>
                            </div>

                            <div class="input-group required-field">
                                <input type="password" name="again_password" required>
                                <label>确认密码</label>
                            </div>

                            <div class="input-group">
                                <input type="tel" name="phone">
                                <label>联系电话</label>
                            </div>

                            <div class="input-group">
                                <input type="text" name="address">
                                <label>邮寄地址</label>
                            </div>

                            <div class="input-group">
                                <input type="text" name="realname">
                                <label>真实姓名</label>
                            </div>

                            <button type="submit" class="submit-btn">立即注册</button>

                            <div class="feedback-panel">
                                <p>注册反馈：
                                    <jsp:getProperty name="userBean" property="backNews" />
                                </p>
                            </div>
                        </form>
                    </div>

                    <div class="register-right">
                        <h3 class="welcome-text">欢迎加入智机优选</h3>
                        <ul class="feature-list">
                            <li>正品保障，品质承诺</li>
                            <li>会员专享优惠</li>
                            <li>快速配送服务</li>
                            <li>7天无理由退换</li>
                            <li>专业售后支持</li>
                        </ul>
                    </div>
                </div>
            </div>
        </body>

        </HTML>