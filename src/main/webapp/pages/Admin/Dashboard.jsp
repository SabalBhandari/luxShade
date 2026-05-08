<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>DashBoard</title>
  <link rel="stylesheet" href="../css/admindashboard.css" />
</head>
<body>
<!-- ========== SIDEBAR ========== -->
<nav class="sidebar">
    <div class="sidebar-logo">LuxShade</div>
    <div class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item ${param.page == 'dashboard' ? 'active' : ''}">Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/orders" class="nav-item ${param.page == 'orders' ? 'active' : ''}">Orders</a>
        <a href="${pageContext.request.contextPath}/admin/inventory" class="nav-item ${param.page == 'inventory' ? 'active' : ''}">Inventory</a>
        <a href="${pageContext.request.contextPath}/admin/report" class="nav-item ${param.page == 'report' ? 'active' : ''}">Report</a>
    </div>
    <div class="sidebar-footer">
        <div class="user-info">
            <div class="user-avatar">A</div>
            <span>Admin</span>
        </div>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
            Log out
        </a>
    </div>
</nav>

</body>
</html>
