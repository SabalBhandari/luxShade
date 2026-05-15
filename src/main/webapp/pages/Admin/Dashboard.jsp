
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>DashBoard</title>
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
                <a href="${pageContext.request.contextPath}/pages/Admin/OrderManagement.jsp">Orders</a>
                <a href="${pageContext.request.contextPath}/pages/Admin/Inventory.jsp">Inventory</a>
                <a href="${pageContext.request.contextPath}/pages/Admin/Report.jsp">Reports</a>
                <a href="${pageContext.request.contextPath}/pages/Admin/Users.jsp">Users</a>
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
                <h3>Total Sales</h3>
                <h2>Rs 92,530</h2>
                <p>This month</p>
            </div>
            <div class="card">
                <h3>Orders</h3>
                <h2>2,530</h2>
                <p>This month</p>
            </div>
            <div class="card">
                <h3>Returning Customers</h3>
                <h2>1,240</h2>
                <p>This month</p>
            </div>
            <div class="card">
                <h3>Deliveries</h3>
                <h2>630</h2>
                <p>This month</p>
            </div>
        </section>

        <!-- Middle Section -->
        <section class="middle-section">
            <div class="chart-container">
                <h3>Average Daily Sales</h3>
                <div class="chart-placeholder"></div>
            </div>
            <div class="top-selling">
                <h3>Top Selling Items</h3>
                <div class="items">
                    <div class="item-image"></div>
                    <div class="item-image"></div>
                    <div class="item-image"></div>
                </div>
                <div class="see-more">
                    <span>See More</span>
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

</body>
</html>
