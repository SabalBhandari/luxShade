<%--
  Created by IntelliJ IDEA.
  User: sabal
  Date: 5/19/26
  Time: 2:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Wishlist - LuxShade</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/wishlist.css">
</head>
<body>

<header>
    <%@ include file="navbar.jsp" %>
</header>

<main class="wishlist-main">

    <h1 class="wishlist-title">My Wishlist</h1>

    <!-- Messages -->
    <p class="msg success-msg"
       style="display:${not empty wishlistSuccess ? 'block' : 'none'}">
        ${wishlistSuccess}
    </p>
    <p class="msg error-msg"
       style="display:${not empty wishlistError ? 'block' : 'none'}">
        ${wishlistError}
    </p>

    <c:choose>
        <c:when test="${empty wishlistProducts}">
            <div class="empty-wishlist">
                <h2>Your wishlist is empty</h2>
                <p>Save items you love to your wishlist.</p>
                <a href="${pageContext.request.contextPath}/collections"
                   class="btn-shop">Browse Collections</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="wishlist-layout">

                <!-- Wishlist Table -->
                <div class="wishlist-table-wrapper">
                    <table class="wishlist-table">
                        <thead>
                        <tr>
                            <th>Product</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="product" items="${wishlistProducts}">
                            <tr>
                                <!-- Product Info -->
                                <td>
                                    <div class="wishlist-product">
                                        <img src="${pageContext.request.contextPath}/${product.image}"
                                             alt="${product.name}"
                                             onerror="this.src='${pageContext.request.contextPath}/pages/images/default-product.png'"/>
                                        <div class="wishlist-product-info">
                                                <span class="wishlist-brand">
                                                        ${product.brandName}
                                                </span>
                                            <span class="wishlist-name">
                                                    ${product.name}
                                            </span>
                                            <span class="wishlist-category">
                                                    ${product.categoryName}
                                            </span>
                                        </div>
                                    </div>
                                </td>

                                <!-- Price -->
                                <td class="wishlist-price">
                                    Rs ${product.price}
                                </td>

                                <!-- Stock -->
                                <td>
                                        <span class="stock-badge
                                            ${product.stock > 0 ? 'in-stock' : 'out-stock'}">
                                                ${product.stock > 0 ? 'In Stock' : 'Out of Stock'}
                                        </span>
                                </td>

                                <!-- Actions -->
                                <td>
                                    <div class="wishlist-actions">
                                        <!-- Move to Cart -->
                                        <c:if test="${product.stock > 0}">
                                            <a href="${pageContext.request.contextPath}/wishlist?action=moveToCart&productId=${product.productId}"
                                               class="btn-move-cart">
                                                Move to Cart
                                            </a>
                                        </c:if>
                                        <!-- Remove -->
                                        <a href="${pageContext.request.contextPath}/wishlist?action=remove&productId=${product.productId}"
                                           class="btn-remove"
                                           onclick="return confirm('Remove from wishlist?')">
                                            ✕
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <div class="wishlist-footer-actions">
                        <a href="${pageContext.request.contextPath}/collections"
                           class="btn-continue">← Continue Shopping</a>
                    </div>
                </div>

                <!-- Summary -->
                <div class="wishlist-summary">
                    <h3>Summary</h3>
                    <div class="summary-row">
                        <span>Total Items</span>
                        <span>${wishlistProducts.size()}</span>
                    </div>
                    <div class="summary-divider"></div>
                    <a href="${pageContext.request.contextPath}/cart"
                       class="btn-view-cart">View Cart</a>
                    <a href="${pageContext.request.contextPath}/collections"
                       class="btn-back-shop">Continue Shopping</a>
                </div>

            </div>
        </c:otherwise>
    </c:choose>

</main>

<footer>
    <%@ include file="footer.jsp" %>
</footer>

</body>
</html>