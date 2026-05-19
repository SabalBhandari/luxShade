<%--
  Created by IntelliJ IDEA.
  User: sabal
  Date: 5/19/26
  Time: 2:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>500 - Server Error</title>
    <link rel="stylesheet" href="/luxShade_war_exploded/pages/css/error.css">
</head>
<body>
<div class="error-container">
    <div class="error-content">
        <h1 class="error-code">500</h1>
        <h2 class="error-title">Internal Server Error</h2>
        <p class="error-message">Something went wrong on our end. Please try again later.</p>
        <div class="error-actions">
            <a href="/luxShade_war_exploded/home" class="btn-home">
                Go to Home
            </a>
            <a href="javascript:history.back()" class="btn-back">
                Go Back
            </a>
        </div>
    </div>
</div>
</body>
</html>