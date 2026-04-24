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
    <link rel="stylesheet" href="css/login_registration.css">
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
            <form>
                <!-- <div class="input-group">
                    <label>Full Name</label>
                    <input type="text" placeholder="Enter your full name" required>
                </div> -->

                <div class="input-group">
                    <label>Email</label>
                    <input type="email" placeholder="Enter your email" required>
                </div>

                <div class="input-group">
                    <label>Password</label>
                    <input type="password" placeholder="Create a password" required>
                </div>

                <!-- <div class="input-group">
                    <label>Confirm Password</label>
                    <input type="password" placeholder="Confirm your password" required>
                </div> -->
                <div class="forgot-link">
                    <a href="#">Forgot Password?</a>
                </div>

                <button type="submit" class="register-btn">Login</button>
            </form>
            <div class="signup-link">
                Don't have an account?<a href="#">Sign Up</a>
            </div>

        </div>
    </div>
</div>
</body>
</html>
