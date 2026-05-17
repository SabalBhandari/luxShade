<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register - LuxShade</title>
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

            <p class="msg error-msg" style="display:${not empty error ? 'block' : 'none'}">${error}</p>

            <form action="${pageContext.request.contextPath}/register"
                  method="post"
                  enctype="multipart/form-data">

                <!-- Profile Picture -->
                <div class="input-group" style="text-align: center;">
                    <div class="profile-pic-container">
                        <img id="preview"
                             src="${pageContext.request.contextPath}/pages/images/default-profile-avatar.webp"
                             alt="Profile Picture"
                             style="width: 90px; height: 90px; border-radius: 50%;
                                    object-fit: cover; border: 2px solid #ccc;">
                        <br>
                        <label for="profile_pic" style="cursor: pointer; color: black; font-size: 13px;">Upload Photo</label>
                        <input type="file" id="profile_pic" name="profile_pic" accept="image/*"
                               style="display: none;" onchange="previewImage(event)">
                    </div>
                </div>

                <!-- Full Name -->
                <div class="input-group">
                    <label>Full Name</label>
                    <input type="text" name="name" placeholder="Enter your full name"
                           value="${name}" required>
                </div>

                <!-- Email + Phone (same row) -->
                <div class="input-row">
                    <div class="input-group">
                        <label>Email</label>
                        <input type="email" name="email" placeholder="Enter your email"
                               value="${email}" required>
                    </div>
                    <div class="input-group">
                        <label>Phone Number</label>
                        <input type="tel" name="phone" placeholder="Enter phone number"
                               value="${phone}" required>
                    </div>
                </div>

                <!-- DOB + Address (same row) -->
                <div class="input-row">
                    <div class="input-group">
                        <label>Date of Birth</label>
                        <input type="date" name="dob" value="${dob}">
                    </div>
                    <div class="input-group">
                        <label>Address</label>
                        <input type="text" name="address" placeholder="Enter your address"
                               value="${address}">
                    </div>
                </div>

                <!-- Password -->
                <div class="input-group">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="Create a password" required>
                </div>

                <!-- Confirm Password -->
                <div class="input-group">
                    <label>Confirm Password</label>
                    <input type="password" name="confirmPassword" placeholder="Confirm your password" required>
                </div>

                <button type="submit" class="register-btn">Sign Up</button>
            </form>

            <div class="login-link">
                Already have an account?
                <a href="${pageContext.request.contextPath}/pages/user/login.jsp">Login</a>
            </div>
        </div>
    </div>
</div>
<script>
    function previewImage(event) {
        const reader = new FileReader();
        reader.onload = function() {
            document.getElementById('preview').src = reader.result;
        };
        reader.readAsDataURL(event.target.files[0]);
    }
</script>
</body>
</html>