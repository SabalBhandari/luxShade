<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Cart - LuxShade</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/cart.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/footer.css">
</head>
<body>

<header>
    <%@ include file="navbar.jsp" %>
</header>

<main class="cart-main">

    <h1 class="cart-title">Your Cart</h1>

    <!-- Messages -->
    <p class="msg success-msg"
       style="display:${not empty cartSuccess ? 'block' : 'none'}">
        ${cartSuccess}
    </p>
    <p class="msg error-msg"
       style="display:${not empty cartError ? 'block' : 'none'}">
        ${cartError}
    </p>

    <c:choose>
        <c:when test="${empty cartProducts}">
            <div class="empty-cart">
                <h2>Your cart is empty</h2>
                <p>Looks like you haven't added anything yet.</p>
                <a href="${pageContext.request.contextPath}/collections"
                   class="btn-shop">Start Shopping</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="cart-layout">

                <!-- Cart Table -->
                <div class="cart-table-wrapper">
                    <table class="cart-table">
                        <thead>
                        <tr>
                            <th>Product</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Subtotal</th>
                            <th>Remove</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="product" items="${cartProducts}">
                            <tr>
                                <!-- Product Info -->
                                <td>
                                    <div class="cart-product">
                                        <img src="${pageContext.request.contextPath}/${product.image}"
                                             alt="${product.name}"
                                             onerror="this.src='${pageContext.request.contextPath}/pages/images/default-product.png'"/>
                                        <div class="cart-product-info">
                                            <span class="cart-brand">${product.brandName}</span>
                                            <span class="cart-name">${product.name}</span>
                                            <span class="cart-sku">SKU: ${product.sku}</span>
                                        </div>
                                    </div>
                                </td>

                                <!-- Price -->
                                <td>Rs ${product.price}</td>

                                <!-- Quantity -->
                                <td>
                                    <form action="${pageContext.request.contextPath}/cart"
                                          method="post" class="qty-form">
                                        <input type="hidden" name="action" value="update"/>
                                        <input type="hidden" name="productId"
                                               value="${product.productId}"/>
                                        <div class="qty-control">
                                            <button type="button"
                                                    onclick="changeQty(this, -1)">−</button>
                                            <input type="number" name="quantity"
                                                   value="${cartItems[product.productId]}"
                                                   min="1" max="${product.stock}"
                                                   class="qty-input"
                                                   onchange="this.form.submit()"/>
                                            <button type="button"
                                                    onclick="changeQty(this, 1)">+</button>
                                        </div>
                                    </form>
                                </td>

                                <!-- Subtotal -->
                                <td class="subtotal">
                                    Rs ${product.price.doubleValue() *
                                        cartItems[product.productId]}
                                </td>

                                <!-- Remove -->
                                <td>
                                    <a href="${pageContext.request.contextPath}/cart?action=remove&productId=${product.productId}"
                                       class="btn-remove"
                                       onclick="return confirm('Remove this item?')">✕</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <!-- Cart Actions -->
                    <div class="cart-actions">
                        <a href="${pageContext.request.contextPath}/collections"
                           class="btn-continue">← Continue Shopping</a>
                        <a href="${pageContext.request.contextPath}/cart?action=clear"
                           class="btn-clear"
                           onclick="return confirm('Clear entire cart?')">Clear Cart</a>
                    </div>
                </div>

                <!-- Order Summary -->
                <div class="order-summary">
                    <h3>Order Summary</h3>
                    <div class="summary-row">
                        <span>Subtotal</span>
                        <span>Rs ${cartTotal}</span>
                    </div>
                    <div class="summary-row">
                        <span>Shipping</span>
                        <span>Free</span>
                    </div>
                    <div class="summary-divider"></div>
                    <div class="summary-row summary-total">
                        <span>Total</span>
                        <span>Rs ${cartTotal}</span>
                    </div>
                    <form action="${pageContext.request.contextPath}/cart"
                          method="post">
                        <input type="hidden" name="action" value="checkout"/>
                        <button type="submit" class="btn-checkout">
                            Place Order
                        </button>
                    </form>
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

<script>
    function changeQty(btn, delta) {
        const form  = btn.closest('.qty-form');
        const input = form.querySelector('.qty-input');
        const max   = parseInt(input.getAttribute('max'));
        let val     = parseInt(input.value) + delta;
        if (val < 1) val = 1;
        if (val > max) val = max;
        input.value = val;
        form.submit();
    }
</script>

</body>
</html>