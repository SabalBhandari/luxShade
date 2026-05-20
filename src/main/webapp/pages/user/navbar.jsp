<%--
  Created by IntelliJ IDEA.
  User: sabal
  Date: 5/3/26
  Time: 12:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<nav>
    <div class="container">
        <h1 class="logo">
            <a href="${pageContext.request.contextPath}/home">LuxShade</a>
        </h1>
        <div class="hamburger" id="hamburger">
            <span></span>
            <span></span>
            <span></span>
        </div>
        <ul class="nav-links" id="nav-links">
            <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/collections">Collection</a></li>
            <li><a href="${pageContext.request.contextPath}/aboutus">About</a></li>
            <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
        </ul>
        <div class="nav-right">
            <div class="icons">
                <!-- Search -->
                <div class="search-wrapper">
                    <img src="${pageContext.request.contextPath}/pages/images/icons/search.png"
                         alt="search" id="searchIcon" onclick="toggleSearch()">
                    <form action="${pageContext.request.contextPath}/search"
                          method="get" class="search-bar" id="searchBar">
                        <input type="text" name="q" placeholder="Search products..."
                               id="searchInput"/>
                    </form>
                </div>
                <!-- Profile -->
                <a href="${pageContext.request.contextPath}/profile">
                    <img src="${pageContext.request.contextPath}/pages/images/icons/user.png" alt="profile">
                </a>
                <!-- Wishlist -->
                <a href="${pageContext.request.contextPath}/wishlist">
                    <img src="${pageContext.request.contextPath}/pages/images/icons/wishlist.png" alt="wishlist">
                </a>
                <!-- Cart -->
                <a href="${pageContext.request.contextPath}/cart">
                    <img src="${pageContext.request.contextPath}/pages/images/icons/cart.png" alt="cart">
                </a>
                <!-- Username + Logout -->
                <span class="nav-username">${sessionScope.userName}</span>
                <a href="${pageContext.request.contextPath}/logout" class="nav-logout">Logout</a>
            </div>
        </div>
    </div>
</nav>
<script>
    const hamburger = document.getElementById('hamburger');
    const navLinks  = document.getElementById('nav-links');

    hamburger.addEventListener('click', () => {
        navLinks.classList.toggle('active');
    });

    function toggleSearch() {
        const searchBar   = document.getElementById('searchBar');
        const searchInput = document.getElementById('searchInput');
        searchBar.classList.toggle('active');
        if (searchBar.classList.contains('active')) {
            searchInput.focus();
        }
    }

    document.addEventListener('click', function(e) {
        const wrapper = document.querySelector('.search-wrapper');
        if (wrapper && !wrapper.contains(e.target)) {
            document.getElementById('searchBar').classList.remove('active');
        }
    });
</script>