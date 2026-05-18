<%--
  Created by IntelliJ IDEA.
  User: sabal
  Date: 4/11/26
  Time: 7:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Collections - LuxShade</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/collections.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/footer.css">
</head>
<body>

<header>
    <%@ include file="navbar.jsp" %>
</header>

<main class="collections-main">

    <!-- Page Header -->
    <section class="collections-header">
        <h1>Our Collections</h1>
        <p>Explore our premium range of eyewear from the world's finest brands.</p>
    </section>

    <!-- Filter + Sort Bar -->
    <section class="filter-bar">
        <form action="${pageContext.request.contextPath}/collections"
              method="get" id="filterForm">

            <div class="filter-group">
                <label>Brand</label>
                <select name="brand" onchange="document.getElementById('filterForm').submit()">
                    <option value="">All Brands</option>
                    <c:forEach var="brand" items="${brands}">
                        <option value="${brand.brandId}"
                            ${param.brand == brand.brandId ? 'selected' : ''}>
                                ${brand.brandName}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="filter-group">
                <label>Category</label>
                <select name="category" onchange="document.getElementById('filterForm').submit()">
                    <option value="">All Categories</option>
                    <c:forEach var="category" items="${categories}">
                        <option value="${category.categoryId}"
                            ${param.category == category.categoryId ? 'selected' : ''}>
                                ${category.categoryName}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="filter-group">
                <label>Sort By</label>
                <select name="sort" onchange="document.getElementById('filterForm').submit()">
                    <option value="">Default</option>
                    <option value="price_asc"
                    ${'price_asc' == param.sort ? 'selected' : ''}>
                        Price: Low to High
                    </option>
                    <option value="price_desc"
                    ${'price_desc' == param.sort ? 'selected' : ''}>
                        Price: High to Low
                    </option>
                    <option value="name_asc"
                    ${'name_asc' == param.sort ? 'selected' : ''}>
                        Name: A to Z
                    </option>
                </select>
            </div>

            <div class="filter-group filter-count">
                <span>${totalCount} product(s) found</span>
                <a href="${pageContext.request.contextPath}/collections"
                   class="btn-clear">Clear Filters</a>
            </div>

        </form>
    </section>

    <!-- Products Grid -->
    <section class="collections-grid-section">
        <c:choose>
            <c:when test="${empty products}">
                <div class="empty-state">
                    <p>No products found. Try a different filter.</p>
                    <a href="${pageContext.request.contextPath}/collections">
                        View All Products
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="collections-grid">
                    <c:forEach var="product" items="${products}">
                        <div class="collection-card">
                            <div class="card-image">
                                <img src="${pageContext.request.contextPath}/${product.image}"
                                     alt="${product.name}"
                                     onerror="this.src='${pageContext.request.contextPath}/pages/images/default-product.png'"/>
                                <div class="card-overlay">
                                    <a href="${pageContext.request.contextPath}/wishlist?action=add&productId=${product.productId}"
                                       class="overlay-btn wishlist-btn">♡ Wishlist</a>
                                </div>
                            </div>
                            <div class="card-body">
                                <span class="card-brand">${product.brandName}</span>
                                <h3 class="card-name">${product.name}</h3>
                                <p class="card-category">${product.categoryName}</p>
                                <div class="card-footer">
                                    <span class="card-price">Rs ${product.price}</span>
                                    <span class="card-stock ${product.stock < 5 ? 'low-stock' : ''}">
                                            ${product.stock > 0 ? 'In Stock' : 'Out of Stock'}
                                    </span>
                                </div>
                                <a href="${pageContext.request.contextPath}/cart?action=add&productId=${product.productId}"
                                   class="btn-add-cart
                                   ${product.stock == 0 ? 'btn-disabled' : ''}">
                                        ${product.stock > 0 ? 'Add to Cart' : 'Out of Stock'}
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </section>

</main>

<footer>
    <%@ include file="footer.jsp" %>
</footer>

</body>
</html>
