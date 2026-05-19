<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Dashboard - LuxShade Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/admindashboard.css">
</head>
<body>

<div class="container">

    <!-- Sidebar -->
    <aside class="sidebar">
        <div>
            <div class="logo"><span class="yellow">Lux</span>Shade</div>
            <nav class="menu">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="active">Dashboard</a>
                <a href="${pageContext.request.contextPath}/admin/orders">Orders</a>
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
            <h1>Welcome Back, ${sessionScope.userName}</h1>
            <p>Here's what's happening with your store today.</p>
        </section>

        <!-- Cards -->
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
        </section>

        <!-- Middle Section -->
        <section class="middle-section">
            <div class="chart-container">
                <h3>Average Daily Sales</h3>
                <canvas id="salesChart"></canvas>
            </div>
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
                    <a href="${pageContext.request.contextPath}/admin/reports">
                        See More
                    </a>
                </div>
            </div>
        </section>

        <!-- Registration Requests -->
        <section class="orders-section">
            <h3>Registration Requests</h3>
            <table>
                <thead>
                <tr>
                    <th>User ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Date of Birth</th>
                    <th>Address</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty pendingUsers}">
                        <tr class="empty-row">
                            <td colspan="7">No pending registration requests.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="user" items="${pendingUsers}">
                            <tr>
                                <td>${user.userId}</td>
                                <td>${user.name}</td>
                                <td>${user.email}</td>
                                <td>${user.phone}</td>
                                <td>${user.dob}</td>
                                <td>${user.address}</td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/admin/dashboard"
                                          method="post" style="display:inline;">
                                        <input type="hidden" name="userId" value="${user.userId}"/>
                                        <input type="hidden" name="action" value="approve"/>
                                        <button type="submit" class="btn-approve">Approve</button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/admin/dashboard"
                                          method="post" style="display:inline;">
                                        <input type="hidden" name="userId" value="${user.userId}"/>
                                        <input type="hidden" name="action" value="reject"/>
                                        <button type="submit" class="btn-reject">Reject</button>
                                    </form>
                                </td>
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
            plugins: { legend: { display: false } },
            scales: {
                y: { beginAtZero: true, grid: { color: '#f0ebe8' } },
                x: { grid: { display: false } }
            }
        }
    });
</script>

</body>
</html>