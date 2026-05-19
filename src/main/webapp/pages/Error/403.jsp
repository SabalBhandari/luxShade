<%--
  Created by IntelliJ IDEA.
  User: sabal
  Date: 5/19/26
  Time: 2:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>403 - Access Denied</title>
    <link rel="stylesheet" href="/luxShade_war_exploded/pages/css/error.css">
</head>
<body>
<div class="error-container">
    <div class="error-content">
        <h1 class="error-code">403</h1>
        <h2 class="error-title">Access Denied</h2>
        <p class="error-message">You don't have permission to view this page.</p>
        <div class="error-actions">
            <a href="/luxShade_war_exploded/home" class="btn-home">
                Go to Home
            </a>
            <a href="/luxShade_war_exploded/login" class="btn-back">
                Go to Login
            </a>
        </div>
    </div>
</div>
</body>
</html>
