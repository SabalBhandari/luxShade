<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>DashBoard</title>
  <link rel="stylesheet" href="../css/admindashboard.css" />
</head>
<body>
<!-- ========== SIDEBAR ========== -->
<aside class="sidebar">
  <a class="sidebar-brand" href="#">Lux<span>Shade</span></a>

  <nav class="sidebar-nav">
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link active">
      <i class="fa-solid fa-gauge-high"></i>
      <span>Dashboard</span>
    </a>
    <a href="${pageContext.request.contextPath}/admin/orders" class="nav-link">
      <i class="fa-solid fa-bag-shopping"></i>
      <span>Orders</span>
    </a>
    <a href="${pageContext.request.contextPath}/admin/inventory" class="nav-link">
      <i class="fa-solid fa-boxes-stacked"></i>
      <span>Inventory</span>
    </a>
    <a href="${pageContext.request.contextPath}/admin/reports" class="nav-link">
      <i class="fa-solid fa-chart-bar"></i>
      <span>Report</span>
    </a>
  </nav>

  <div class="sidebar-footer">
    <div class="admin-info">
      <div class="admin-avatar"><i class="fa-solid fa-user"></i></div>
      <span>adminName </span>
    </div>
    <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
      <i class="fa-solid fa-right-from-bracket"></i>
      <span>Log out</span>
    </a>
  </div>
</aside>

</body>
</html>
