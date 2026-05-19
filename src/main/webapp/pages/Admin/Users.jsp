<%--
  Created by IntelliJ IDEA.
  User: sabal
  Date: 5/15/26
  Time: 3:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Users - LuxShade Admin</title>
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
                <a href="${pageContext.request.contextPath}/admin/report">Reports</a>
                <a href="${pageContext.request.contextPath}/admin/users" class="active">Users</a>
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
            <h1>User Management</h1>
            <p>View and manage all registered users.</p>
        </section>

        <!-- Stats Cards -->
        <section class="cards">
            <div class="card">
                <h3>Total Users</h3>
                <h2>${totalUsers}</h2>
                <p>Registered</p>
            </div>
            <div class="card">
                <h3>Approved</h3>
                <h2>${approvedUsers}</h2>
                <p>Active accounts</p>
            </div>
            <div class="card">
                <h3>Pending</h3>
                <h2>${pendingUsers}</h2>
                <p>Awaiting approval</p>
            </div>
            <div class="card">
                <h3>Rejected</h3>
                <h2>${rejectedUsers}</h2>
                <p>Declined accounts</p>
            </div>
        </section>

        <!-- Success / Error Messages -->
        <p class="msg success-msg"
           style="display:${not empty sessionScope.success ? 'block' : 'none'}">
            ${sessionScope.success}
        </p>
        <p class="msg error-msg"
           style="display:${not empty sessionScope.error ? 'block' : 'none'}">
            ${sessionScope.error}
        </p>

        <!-- Filter Tabs -->
        <div class="filter-tabs">
            <a href="${pageContext.request.contextPath}/admin/users"
               class="tab ${empty param.status ? 'tab-active' : ''}">All</a>
            <a href="${pageContext.request.contextPath}/admin/users?status=approved"
               class="tab ${param.status == 'approved' ? 'tab-active' : ''}">Approved</a>
            <a href="${pageContext.request.contextPath}/admin/users?status=pending"
               class="tab ${param.status == 'pending' ? 'tab-active' : ''}">Pending</a>
            <a href="${pageContext.request.contextPath}/admin/users?status=rejected"
               class="tab ${param.status == 'rejected' ? 'tab-active' : ''}">Rejected</a>
        </div>

        <!-- Users Table -->
        <section class="orders-section">
            <h3>All Users</h3>
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Address</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty allUsers}">
                        <tr class="empty-row">
                            <td colspan="7">No users found.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="user" items="${allUsers}">
                            <tr>
                                <td>${user.userId}</td>
                                <td>${user.name}</td>
                                <td>${user.email}</td>
                                <td>${user.phone}</td>
                                <td>${user.address}</td>
                                <td>
                                        <span class="status-badge status-${user.status}">
                                                ${user.status}
                                        </span>
                                </td>
                                <td>
                                    <!-- Approve -->
                                    <form action="${pageContext.request.contextPath}/admin/users"
                                          method="post" style="display:inline;">
                                        <input type="hidden" name="userId" value="${user.userId}"/>
                                        <input type="hidden" name="action" value="approve"/>
                                        <button type="submit" class="btn-approve"
                                                style="display:${user.status != 'approved' ? 'inline-block' : 'none'}">
                                            Approve
                                        </button>
                                    </form>
                                    <!-- Reject -->
                                    <form action="${pageContext.request.contextPath}/admin/users"
                                          method="post" style="display:inline;">
                                        <input type="hidden" name="userId" value="${user.userId}"/>
                                        <input type="hidden" name="action" value="reject"/>
                                        <button type="submit" class="btn-reject"
                                                style="display:${user.status != 'rejected' ? 'inline-block' : 'none'}">
                                            Reject
                                        </button>
                                    </form>
                                    <!-- Delete -->
                                    <form action="${pageContext.request.contextPath}/admin/users"
                                          method="post" style="display:inline;">
                                        <input type="hidden" name="userId" value="${user.userId}"/>
                                        <input type="hidden" name="action" value="delete"/>
                                        <button type="submit" class="btn-delete"
                                                onclick="return confirm('Are you sure you want to delete this user?')">
                                            Delete
                                        </button>
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
