<%--
  Created by IntelliJ IDEA.
  User: sabal
  Date: 4/11/26
  Time: 6:54 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/login_registration.css">
</head>
<body>
<div class="container">
    <div class="left">
        <div class="left-image"></div>
        <div class="left-content">
            <h1><span class="yellowFont">Lux</span>Shade</h1>
            <p>Discover premium glasses that blends style and comfort. Elevate your look with our curated collection of modern glasses.</p>
        </div>
    </div>

    <div class="right">
        <div class="form-box">
            <h2>Login</h2>
            <form action="${pageContext.request.contextPath}/login" method="post">

                <div class="input-group">
                    <label>Email</label>
                    <input type="email" name="email" placeholder="Enter your email" required>
                </div>
                <div class="input-group">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="Enter your password" required>
                </div>

                <div class="forgot-link">
                    <a href="#">Forgot Password?</a>
                </div>

                <button type="submit" class="register-btn">Login</button>

            </form>

            <!-- Error message -->
            <% if (request.getAttribute("error") != null) { %>
            <p style="color: red;"><%= request.getAttribute("error") %></p>
            <% } %>

            <div class="signup-link">
                Don't have an account? <a href="${pageContext.request.contextPath}/register.jsp">Sign Up</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
