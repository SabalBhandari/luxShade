<%--
  Created by IntelliJ IDEA.
  User: sabal
  Date: 5/18/26
  Time: 11:40 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Search - LuxShade</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/search.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/footer.css">
</head>
<body>

<header>
    <%@ include file="navbar.jsp" %>
</header>

<main class="search-main">

    <!-- Search Header -->
    <section class="search-header">
        <h1>Search Results</h1>
        <p style="display:${not empty keyword ? 'block' : 'none'}">
            Showing results for "<strong>${keyword}</strong>"
        </p>
        <p style="display:${empty keyword ? 'block' : 'none'}">
            Enter a keyword to search for products.
        </p>

        <!-- Search Bar -->
        <form action="${pageContext.request.contextPath}/search" method="get"
              class="search-form">
            <input type="text" name="q" value="${keyword}"
                   placeholder="Search by name or SKU..." autofocus/>
            <button type="submit">Search</button>
        </form>
    </section>

    <!-- Results -->
    <section class="search-results">
        <c:choose>
            <c:when test="${empty keyword}">
                <!-- No search yet -->
            </c:when>
            <c:when test="${empty results}">
                <div class="no-results">
                    <p>No products found for "<strong>${keyword}</strong>".</p>
                    <a href="${pageContext.request.contextPath}/home">Back to Home</a>
                </div>
            </c:when>
            <c:otherwise>
                <p class="results-count">${results.size()} product(s) found</p>
                <div class="results-grid">
                    <c:forEach var="product" items="${results}">
                        <div class="result-card">
                            <div class="result-image">
                                <img src="${pageContext.request.contextPath}/${product.image}"
                                     alt="${product.name}"
                                     onerror="this.src='${pageContext.request.contextPath}/pages/images/default-product.png'"/>
                            </div>
                            <div class="result-body">
                                <span class="result-brand">${product.brandName}</span>
                                <h3 class="result-name">${product.name}</h3>
                                <p class="result-sku">SKU: ${product.sku}</p>
                                <p class="result-category">${product.categoryName}</p>
                                <p class="result-price">Rs ${product.price}</p>
                                <p class="result-stock ${product.stock < 5 ? 'low-stock' : ''}">
                                        ${product.stock > 0 ? 'In Stock' : 'Out of Stock'}
                                </p>
                                <div class="result-actions">
                                    <a href="${pageContext.request.contextPath}/cart?action=add&productId=${product.productId}"
                                       class="btn-cart">Add to Cart</a>
                                    <a href="${pageContext.request.contextPath}/wishlist?action=add&productId=${product.productId}"
                                       class="btn-wishlist">Wishlist</a>
                                </div>
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
