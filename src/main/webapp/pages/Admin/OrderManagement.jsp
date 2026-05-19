<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 5/4/2026
  Time: 3:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Orders - LuxShade Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/admindashboard.css">
</head>
<body>

<div class="container">

    <!-- Sidebar -->
    <aside class="sidebar">
        <div>
            <div class="logo"><span class="yellow">Lux</span>Shade</div>
            <nav class="menu">
                <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
                <a href="${pageContext.request.contextPath}/admin/orders" class="active">Orders</a>
                <a href="${pageContext.request.contextPath}/admin/inventory">Inventory</a>
                <a href="${pageContext.request.contextPath}/admin/reports">Reports</a>
                <a href="${pageContext.request.contextPath}/admin/users">Users</a>
            </nav>
        </div>
        <div class="bottom-section">
            <div class="admin">
                <div class="icon-placeholder">
                    <img src="${pageContext.request.contextPath}/pages/images/default-profile-avatar.webp"
                         alt="Admin"/>
                </div>
                <span>${sessionScope.userName}</span>
            </div>
            <a href="${pageContext.request.contextPath}/logout" class="logout">
                <span>Log out</span>
            </a>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="main-content">

        <!-- Header -->
        <section class="header">
            <h1>Order Management</h1>
            <p>View and manage all customer orders.</p>
        </section>

        <!-- Stat Cards -->
        <section class="cards">
            <div class="card">
                <h3>Total Orders</h3>
                <h2>${totalOrders}</h2>
                <p>All time</p>
            </div>
            <div class="card">
                <h3>Pending</h3>
                <h2>${pendingOrders}</h2>
                <p>Awaiting confirmation</p>
            </div>
            <div class="card">
                <h3>Shipped</h3>
                <h2>${shippedOrders}</h2>
                <p>On the way</p>
            </div>
            <div class="card">
                <h3>Delivered</h3>
                <h2>${deliveredOrders}</h2>
                <p>Completed</p>
            </div>
        </section>

        <!-- Messages -->
        <p class="msg success-msg"
           style="display:${not empty sessionScope.success ? 'block' : 'none'};
                   margin-bottom:16px;">
            ${sessionScope.success}
        </p>
        <p class="msg error-msg"
           style="display:${not empty sessionScope.error ? 'block' : 'none'};
                   margin-bottom:16px;">
            ${sessionScope.error}
        </p>

        <!-- Filter Tabs -->
        <div class="filter-tabs">
            <a href="${pageContext.request.contextPath}/admin/orders"
               class="tab ${empty param.status ? 'tab-active' : ''}">All</a>
            <a href="${pageContext.request.contextPath}/admin/orders?status=pending"
               class="tab ${param.status == 'pending' ? 'tab-active' : ''}">Pending</a>
            <a href="${pageContext.request.contextPath}/admin/orders?status=confirmed"
               class="tab ${param.status == 'confirmed' ? 'tab-active' : ''}">Confirmed</a>
            <a href="${pageContext.request.contextPath}/admin/orders?status=shipped"
               class="tab ${param.status == 'shipped' ? 'tab-active' : ''}">Shipped</a>
            <a href="${pageContext.request.contextPath}/admin/orders?status=delivered"
               class="tab ${param.status == 'delivered' ? 'tab-active' : ''}">Delivered</a>
            <a href="${pageContext.request.contextPath}/admin/orders?status=cancelled"
               class="tab ${param.status == 'cancelled' ? 'tab-active' : ''}">Cancelled</a>
        </div>

        <!-- Orders List -->
        <section class="orders-section">
            <h3>Orders</h3>
            <c:choose>
                <c:when test="${empty orders}">
                    <p class="empty-row" style="text-align:center; padding:30px;
                       color:#aaa;">No orders found.</p>
                </c:when>
                <c:otherwise>
                    <c:forEach var="order" items="${orders}">
                        <div class="admin-order-card">

                            <!-- Order Header -->
                            <div class="admin-order-header">
                                <div>
                                    <span class="admin-order-id">
                                        Order #${order.orderId}
                                    </span>
                                    <span class="admin-order-date">
                                            ${order.orderDate}
                                    </span>
                                </div>
                                <div class="admin-order-header-right">
                                    <span class="admin-order-user">
                                        ${order.userName} (${order.userEmail})
                                    </span>
                                    <span class="order-status status-${order.status}">
                                            ${order.status}
                                    </span>
                                    <span class="admin-order-total">
                                        Rs ${order.totalPrice}
                                    </span>
                                </div>
                            </div>

                            <!-- Order Items -->
                            <div class="admin-order-items">
                                <c:forEach var="item"
                                           items="${orderItemsMap[order.orderId]}">
                                    <div class="admin-order-item">
                                        <img src="${pageContext.request.contextPath}/${item.productImage}"
                                             alt="${item.productName}"
                                             onerror="this.src='${pageContext.request.contextPath}/pages/images/default-product.png'"/>
                                        <div>
                                            <span class="item-name">
                                                    ${item.productName}
                                            </span>
                                            <span class="item-qty">
                                                Qty: ${item.quantity} ×
                                                Rs ${item.unitPrice}
                                            </span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- Order Actions -->
                            <div class="admin-order-footer">
                                <c:if test="${order.status != 'cancelled' &&
                                             order.status != 'delivered'}">
                                    <form action="${pageContext.request.contextPath}/admin/orders"
                                          method="post" style="display:inline-flex; gap:8px;">
                                        <input type="hidden" name="action"
                                               value="updateStatus"/>
                                        <input type="hidden" name="orderId"
                                               value="${order.orderId}"/>
                                        <select name="status" class="status-select">
                                            <option value="pending"
                                                ${order.status == 'pending' ? 'selected' : ''}>
                                                Pending
                                            </option>
                                            <option value="confirmed"
                                                ${order.status == 'confirmed' ? 'selected' : ''}>
                                                Confirmed
                                            </option>
                                            <option value="shipped"
                                                ${order.status == 'shipped' ? 'selected' : ''}>
                                                Shipped
                                            </option>
                                            <option value="delivered"
                                                ${order.status == 'delivered' ? 'selected' : ''}>
                                                Delivered
                                            </option>
                                        </select>
                                        <button type="submit"
                                                class="btn-approve">Update</button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/admin/orders"
                                          method="post" style="display:inline;">
                                        <input type="hidden" name="action"
                                               value="cancel"/>
                                        <input type="hidden" name="orderId"
                                               value="${order.orderId}"/>
                                        <button type="submit" class="btn-reject"
                                                onclick="return confirm('Cancel this order?')">
                                            Cancel
                                        </button>
                                    </form>
                                </c:if>
                                <c:if test="${order.status == 'cancelled' ||
                                             order.status == 'delivered'}">
                                    <span style="font-size:13px; color:#aaa;">
                                        No actions available
                                    </span>
                                </c:if>
                            </div>

                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </section>

    </main>
</div>

</body>
</html>