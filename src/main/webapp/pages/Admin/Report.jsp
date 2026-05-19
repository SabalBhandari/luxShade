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
    <title>Reports - LuxShade Admin</title>
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
                <a href="${pageContext.request.contextPath}/admin/orders">Orders</a>
                <a href="${pageContext.request.contextPath}/admin/inventory">Inventory</a>
                <a href="${pageContext.request.contextPath}/admin/reports" class="active">Reports</a>
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
            <h1>Reports & Analytics</h1>
            <p>Overview of your store's performance.</p>
        </section>

        <!-- Stat Cards -->
        <section class="cards">
            <div class="card">
                <h3>Total Revenue</h3>
                <h2>Rs ${totalRevenue}</h2>
                <p>All time</p>
            </div>
            <div class="card">
                <h3>Total Orders</h3>
                <h2>${totalOrders}</h2>
                <p>All time</p>
            </div>
            <div class="card">
                <h3>Deliveries</h3>
                <h2>${totalDeliveries}</h2>
                <p>Completed</p>
            </div>
            <div class="card">
                <h3>Avg Daily Sales</h3>
                <h2>Rs ${avgDailySales}</h2>
                <p>Last 7 days</p>
            </div>
            <div class="card">
                <h3>Total Users</h3>
                <h2>${totalUsers}</h2>
                <p>Registered</p>
            </div>
        </section>

        <!-- Middle Section -->
        <section class="middle-section">

            <!-- Daily Sales Chart -->
            <div class="chart-container">
                <h3>Daily Sales - Last 7 Days</h3>
                <canvas id="salesChart"></canvas>
            </div>

            <!-- Top Selling Products -->
            <div class="top-selling">
                <h3>Top Selling Items</h3>
                <div class="items">
                    <c:choose>
                        <c:when test="${empty topProducts}">
                            <p style="color:#aaa; font-size:13px;">
                                No sales data yet.
                            </p>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="product" items="${topProducts}">
                                <div class="item-row">
                                    <div class="item-image">
                                        <img src="${pageContext.request.contextPath}/${product.image}"
                                             alt="${product.name}"
                                             onerror="this.src='${pageContext.request.contextPath}/pages/images/default-product.png'"/>
                                    </div>
                                    <div class="item-info">
                                        <span>${product.name}</span>
                                        <small>${product.brandName} |
                                                ${product.totalSold} sold</small>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="see-more">
                    <a href="${pageContext.request.contextPath}/admin/inventory">
                        See Inventory
                    </a>
                </div>
            </div>

        </section>

        <!-- Daily Sales Table -->
        <section class="orders-section">
            <h3>Daily Sales Breakdown</h3>
            <table>
                <thead>
                <tr>
                    <th>Date</th>
                    <th>Revenue</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty dailySales}">
                        <tr class="empty-row">
                            <td colspan="2">No sales data yet.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="entry" items="${dailySales}">
                            <tr>
                                <td>${entry.key}</td>
                                <td>Rs ${entry.value}</td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </section>

    </main>
</div>

<!-- Chart.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.min.js"></script>
<script>
    // Build chart data from dailySales map
    const labels = [];
    const data   = [];

    <c:forEach var="entry" items="${dailySales}">
    labels.push('${entry.key}');
    data.push(${entry.value});
    </c:forEach>

    const ctx = document.getElementById('salesChart').getContext('2d');
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Daily Revenue (Rs)',
                data: data,
                backgroundColor: 'rgba(240, 196, 25, 0.7)',
                borderColor: '#f0c419',
                borderWidth: 2,
                borderRadius: 6
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { display: false }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: { color: '#f0ebe8' }
                },
                x: {
                    grid: { display: false }
                }
            }
        }
    });
</script>

</body>
</html>