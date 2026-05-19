<%--
  Created by IntelliJ IDEA.
  User: sabal
  Date: 5/19/26
  Time: 1:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>My Orders - LuxShade</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/orders.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/footer.css">
</head>
<body>

<header>
    <%@ include file="navbar.jsp" %>
</header>

<main class="orders-main">

    <h1 class="orders-title">My Orders</h1>

    <!-- Messages -->
    <p class="msg success-msg"
       style="display:${not empty orderSuccess ? 'block' : 'none'}">
        ${orderSuccess}
    </p>
    <p class="msg error-msg"
       style="display:${not empty orderError ? 'block' : 'none'}">
        ${orderError}
    </p>

    <c:choose>
        <c:when test="${empty orders}">
            <div class="empty-orders">
                <h2>No orders yet</h2>
                <p>You haven't placed any orders yet.</p>
                <a href="${pageContext.request.contextPath}/collections"
                   class="btn-shop">Start Shopping</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="orders-list">
                <c:forEach var="order" items="${orders}">
                    <div class="order-card">

                        <!-- Order Header -->
                        <div class="order-header">
                            <div class="order-header-left">
                                <span class="order-id">Order #${order.orderId}</span>
                                <span class="order-date">${order.orderDate}</span>
                            </div>
                            <div class="order-header-right">
                                <span class="order-status status-${order.status}">
                                        ${order.status}
                                </span>
                                <span class="order-total">
                                    Rs ${order.totalPrice}
                                </span>
                            </div>
                        </div>

                        <!-- Order Items -->
                        <div class="order-items">
                            <c:forEach var="item"
                                       items="${orderItemsMap[order.orderId]}">
                                <div class="order-item">
                                    <img src="${pageContext.request.contextPath}/${item.productImage}"
                                         alt="${item.productName}"
                                         onerror="this.src='${pageContext.request.contextPath}/pages/images/default-product.png'"/>
                                    <div class="order-item-info">
                                        <span class="item-brand">${item.brandName}</span>
                                        <span class="item-name">${item.productName}</span>
                                        <span class="item-qty">Qty: ${item.quantity}</span>
                                    </div>
                                    <span class="item-price">
                                        Rs ${item.unitPrice.doubleValue() * item.quantity}
                                    </span>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Order Footer -->
                        <div class="order-footer">
                            <c:if test="${order.status == 'pending'}">
                                <form action="${pageContext.request.contextPath}/orders"
                                      method="post">
                                    <input type="hidden" name="action" value="cancel"/>
                                    <input type="hidden" name="orderId"
                                           value="${order.orderId}"/>
                                    <button type="submit" class="btn-cancel"
                                            onclick="return confirm('Cancel this order?')">
                                        Cancel Order
                                    </button>
                                </form>
                            </c:if>
                            <span class="order-items-count">
                                ${orderItemsMap[order.orderId].size()} item(s)
                            </span>
                        </div>

                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

</main>

<footer>
    <%@ include file="footer.jsp" %>
</footer>

</body>
</html>