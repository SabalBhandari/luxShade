<%--
  Created by IntelliJ IDEA.
  User: sabal
  Date: 5/17/26
  Time: 3:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>My Profile - LuxShade</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/profile.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/footer.css">
</head>
<body>

<header>
    <%@ include file="navbar.jsp" %>
</header>

<main class="profile-main">
    <div class="profile-container">

        <!-- Left Panel — Avatar + Info -->
        <div class="profile-left">
            <div class="avatar-section">
                <div class="avatar-wrapper">
                    <img id="avatarPreview"
                         src="${not empty profileUser.profilePic ?
                             pageContext.request.contextPath.concat('/').concat(profileUser.profilePic) :
                             pageContext.request.contextPath.concat('/pages/images/default-profile-avatar.webp')}"
                         alt="Profile Picture"/>
                </div>
                <h2>${profileUser.name}</h2>
                <p class="profile-email">${profileUser.email}</p>
                <span class="profile-status status-${profileUser.status}">
                    ${profileUser.status}
                </span>
            </div>

            <div class="profile-meta">
                <div class="meta-item">
                    <span class="meta-label">Phone</span>
                    <span class="meta-value">${profileUser.phone}</span>
                </div>
                <div class="meta-item">
                    <span class="meta-label">Date of Birth</span>
                    <span class="meta-value">${profileUser.dob}</span>
                </div>
                <div class="meta-item">
                    <span class="meta-label">Address</span>
                    <span class="meta-value">${profileUser.address}</span>
                </div>
                <div class="meta-item">
                    <span class="meta-label">Member Since</span>
                    <span class="meta-value">${profileUser.createdAt}</span>
                </div>
            </div>
        </div>

        <!-- Right Panel — Forms -->
        <div class="profile-right">

            <!-- Update Profile Form -->
            <div class="profile-card">
                <h3>Edit Profile</h3>

                <p class="msg success-msg"
                   style="display:${not empty profileSuccess ? 'block' : 'none'}">
                    ${profileSuccess}
                </p>
                <p class="msg error-msg"
                   style="display:${not empty profileError ? 'block' : 'none'}">
                    ${profileError}
                </p>

                <form action="${pageContext.request.contextPath}/profile"
                      method="post" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="updateProfile"/>

                    <!-- Profile Picture -->
                    <div class="form-group" style="text-align:center;">
                        <label for="profile_pic" class="avatar-upload-label">
                            Change Photo
                        </label>
                        <input type="file" id="profile_pic" name="profile_pic"
                               accept="image/*" style="display:none;"
                               onchange="previewAvatar(event)"/>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>Full Name</label>
                            <input type="text" name="name"
                                   value="${profileUser.name}" required/>
                        </div>
                        <div class="form-group">
                            <label>Email (cannot be changed)</label>
                            <input type="email" value="${profileUser.email}"
                                   disabled class="input-disabled"/>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>Phone Number</label>
                            <input type="tel" name="phone"
                                   value="${profileUser.phone}" required/>
                        </div>
                        <div class="form-group">
                            <label>Date of Birth</label>
                            <input type="date" name="dob"
                                   value="${profileUser.dob}"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Address</label>
                        <input type="text" name="address"
                               value="${profileUser.address}"/>
                    </div>

                    <button type="submit" class="btn-save">Save Changes</button>
                </form>
            </div>

            <!-- Change Password Form -->
            <div class="profile-card">
                <h3>Change Password</h3>

                <p class="msg success-msg"
                   style="display:${not empty passwordSuccess ? 'block' : 'none'}">
                    ${passwordSuccess}
                </p>
                <p class="msg error-msg"
                   style="display:${not empty passwordError ? 'block' : 'none'}">
                    ${passwordError}
                </p>

                <form action="${pageContext.request.contextPath}/profile"
                      method="post">
                    <input type="hidden" name="action" value="changePassword"/>

                    <div class="form-group">
                        <label>Current Password</label>
                        <input type="password" name="currentPassword"
                               placeholder="Enter current password" required/>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>New Password</label>
                            <input type="password" name="newPassword"
                                   placeholder="Enter new password" required/>
                        </div>
                        <div class="form-group">
                            <label>Confirm New Password</label>
                            <input type="password" name="confirmPassword"
                                   placeholder="Confirm new password" required/>
                        </div>
                    </div>

                    <button type="submit" class="btn-save">Change Password</button>
                </form>
            </div>

        </div>
    </div>
</main>

<footer>
    <%@ include file="footer.jsp" %>
</footer>

<script>
    function previewAvatar(event) {
        const reader = new FileReader();
        reader.onload = function () {
            document.getElementById('avatarPreview').src = reader.result;
        };
        reader.readAsDataURL(event.target.files[0]);
    }
</script>

</body>
</html>
