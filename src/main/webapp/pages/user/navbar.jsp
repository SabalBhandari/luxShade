<%--
  Created by IntelliJ IDEA.
  User: sabal
  Date: 5/3/26
  Time: 12:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="../css/navbar.css">
</head>
<body>
<nav>
    <div class="container">
        <h1 class="logo"><a href="#">LuxShade</a></h1>

        <div class="hamburger" id="hamburger">
            <span></span>
            <span></span>
            <span></span>
        </div>

        <ul class="nav-links" id="nav-links">
            <li><a href="${pageContext.request.contextPath}/pages/user/landing.jsp">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/pages/user/aboutUs.jsp">Collection</a></li>
            <li><a href="${pageContext.request.contextPath}/pages/user/collections.jsp">About</a></li>
            <li><a href="${pageContext.request.contextPath}/pages/user/contact.jsp">Contact</a></li>
        </ul>

        <div class="nav-right">
            <div class="icons">
                <img src="../images/icons/search.png" alt="search">
                <img src="../images/icons/user.png" alt="profile">
                <img src="../images/icons/cart.png" alt="cart">
            </div>
        </div>
    </div>
</nav>

<script>
    const hamburger = document.getElementById('hamburger');
    const navLinks = document.getElementById('nav-links');
    hamburger.addEventListener('click', () => {
        navLinks.classList.toggle('active');
    });
</script>
</body>
</html>