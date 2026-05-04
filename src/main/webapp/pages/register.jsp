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
            <p>Create your account and explore stylish, high-quality eyewear tailored just for you.</p>
        </div>
    </div>

    <div class="right">
        <div class="form-box">
            <h2>Create Account</h2>
            <form action="${pageContext.request.contextPath}/register"
                  method="post"
                  enctype="multipart/form-data">

                <div class="input-group" style="text-align: center;">
                    <div class="profile-pic-container">
                        <img id="preview" src="./images/default-profile-avatar.webp" alt="Profile Picture"
                             style="width: 100px;
                     height: 100px;
                     border-radius: 50%;
                     object-fit: cover;
                     border: 2px solid #ccc;">
                        <br>
                        <label for="profile_pic" style="cursor: pointer; color: black;">Upload Photo</label>
                        <input type="file" id="profile_pic" name="profile_pic" accept="image/*"
                               style="display: none;" onchange="previewImage(event)">
                    </div>
                </div>

                <div class="input-group">
                    <label>Full Name</label>
                    <input type="text" name="name" placeholder="Enter your full name" required>
                </div>
                <div class="input-group">
                    <label>Email</label>
                    <input type="email" name="email" placeholder="Enter your email" required>
                </div>
                <div class="input-group">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="Create a password" required>
                </div>
                <div class="input-group">
                    <label>Confirm Password</label>
                    <input type="password" name="confirmPassword" placeholder="Confirm your password" required>
                </div>

                <button type="submit" class="register-btn">Sign Up</button>

            </form>

            <!-- Error message -->
            <% if (request.getAttribute("error") != null) { %>
            <p style="color: red;"><%= request.getAttribute("error") %></p>
            <% } %>

            <div class="login-link">
                Already have an account? <a href="${pageContext.request.contextPath}/pages/login.jsp">Login</a>

            </div>
        </div>
    </div>
</div>
<script>
    function previewImage(event) {
        const reader = new FileReader();
        reader.onload = function() {
            const preview = document.getElementById('preview');
            preview.src = reader.result;
        };
        reader.readAsDataURL(event.target.files[0]);
    }
</script>
</body>
</html>
