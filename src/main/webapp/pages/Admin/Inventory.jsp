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
    <title>Inventory - LuxShade Admin</title>
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
                <a href="${pageContext.request.contextPath}/admin/users">Users</a>
                <a href="${pageContext.request.contextPath}/admin/inventory" class="active">Inventory</a>
                <a href="${pageContext.request.contextPath}/admin/orders">Orders</a>
                <a href="${pageContext.request.contextPath}/admin/reports">Reports</a>
            </nav>
        </div>
        <div class="bottom-section">
            <div class="admin">
                <div class="icon-placeholder">
                    <img src="${pageContext.request.contextPath}/pages/images/default-profile-avatar.webp" alt="Admin"/>
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
            <div class="header-row">
                <div>
                    <h1>Inventory Management</h1>
                    <p>Manage your products, brands and categories.</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/inventory?action=addForm"
                   class="btn-add">+ Add Product</a>
            </div>
        </section>

        <!-- Messages -->
        <p class="msg success-msg"
           style="display:${not empty sessionScope.success ? 'block' : 'none'}; margin-bottom:16px;">
            ${sessionScope.success}
        </p>
        <p class="msg error-msg"
           style="display:${not empty sessionScope.error ? 'block' : 'none'}; margin-bottom:16px;">
            ${sessionScope.error}
        </p>

        <!-- Brand Filter Tabs -->
        <div class="filter-tabs">
            <a href="${pageContext.request.contextPath}/admin/inventory"
               class="tab ${empty param.brand ? 'tab-active' : ''}">All Items</a>
            <c:forEach var="brand" items="${brands}">
                <a href="${pageContext.request.contextPath}/admin/inventory?brand=${brand.brandId}"
                   class="tab ${param.brand == brand.brandId ? 'tab-active' : ''}">
                        ${brand.brandName}
                </a>
            </c:forEach>
        </div>

        <!-- Product Grid -->
        <section class="product-grid-section">
            <c:choose>
                <c:when test="${empty products}">
                    <div class="empty-state">
                        <p>No products found. Click "Add Product" to get started.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="product-grid">
                        <c:forEach var="product" items="${products}">
                            <div class="product-card" onclick="openPanel(
                                    '${product.productId}',
                                    '${product.name}',
                                    '${product.sku}',
                                    '${product.brandName}',
                                    '${product.categoryName}',
                                    '${product.price}',
                                    '${product.stock}',
                                    '${product.description}',
                                    '${pageContext.request.contextPath}/${product.image}'
                                    )">
                                <div class="card-image">
                                    <img src="${pageContext.request.contextPath}/${product.image}"
                                         alt="${product.name}"
                                         onerror="this.src='${pageContext.request.contextPath}/pages/images/default-product.png'"/>
                                </div>
                                <div class="card-body">
                                    <span class="card-brand">${product.brandName}</span>
                                    <h3 class="card-name">${product.name}</h3>
                                    <p class="card-price">Rs ${product.price}</p>
                                    <p class="card-stock ${product.stock < 5 ? 'low-stock' : ''}">
                                        Stock: ${product.stock}
                                    </p>
                                </div>
                                <div class="card-actions" onclick="event.stopPropagation()">
                                    <a href="${pageContext.request.contextPath}/admin/inventory?action=editForm&id=${product.productId}"
                                       class="btn-edit">Edit</a>
                                    <form action="${pageContext.request.contextPath}/admin/inventory"
                                          method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="delete"/>
                                        <input type="hidden" name="productId" value="${product.productId}"/>
                                        <button type="submit" class="btn-delete"
                                                onclick="return confirm('Delete this product?')">Delete</button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </section>

    </main>
</div>

<!-- Side Panel Overlay -->
<div class="overlay" id="overlay" onclick="closePanel()"></div>

<!-- Product Detail Side Panel -->
<div class="side-panel" id="sidePanel">
    <button class="close-btn" onclick="closePanel()">✕</button>
    <div class="panel-image-container">
        <img id="panelImage" src="" alt="Product Image"/>
    </div>
    <div class="panel-details">
        <span class="panel-brand" id="panelBrand"></span>
        <h2 class="panel-name" id="panelName"></h2>
        <div class="panel-info-grid">
            <div class="panel-info-item">
                <span class="info-label">Product ID</span>
                <span class="info-value" id="panelId"></span>
            </div>
            <div class="panel-info-item">
                <span class="info-label">SKU</span>
                <span class="info-value" id="panelSku"></span>
            </div>
            <div class="panel-info-item">
                <span class="info-label">Category</span>
                <span class="info-value" id="panelCategory"></span>
            </div>
            <div class="panel-info-item">
                <span class="info-label">Brand</span>
                <span class="info-value" id="panelBrandDetail"></span>
            </div>
            <div class="panel-info-item">
                <span class="info-label">Price</span>
                <span class="info-value" id="panelPrice"></span>
            </div>
            <div class="panel-info-item">
                <span class="info-label">Stock</span>
                <span class="info-value" id="panelStock"></span>
            </div>
        </div>
        <div class="panel-description">
            <span class="info-label">Description</span>
            <p id="panelDescription"></p>
        </div>
    </div>
</div>

<script>
    function openPanel(id, name, sku, brand, category, price, stock, description, image) {
        document.getElementById('panelId').textContent          = id;
        document.getElementById('panelName').textContent        = name;
        document.getElementById('panelSku').textContent         = sku;
        document.getElementById('panelBrand').textContent       = brand;
        document.getElementById('panelBrandDetail').textContent = brand;
        document.getElementById('panelCategory').textContent    = category;
        document.getElementById('panelPrice').textContent       = 'Rs ' + price;
        document.getElementById('panelStock').textContent       = stock;
        document.getElementById('panelDescription').textContent = description;
        document.getElementById('panelImage').src               = image;

        document.getElementById('sidePanel').classList.add('open');
        document.getElementById('overlay').classList.add('active');
    }

    function closePanel() {
        document.getElementById('sidePanel').classList.remove('open');
        document.getElementById('overlay').classList.remove('active');
    }
</script>

</body>
</html>
