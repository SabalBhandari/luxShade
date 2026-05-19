<%--
  Created by IntelliJ IDEA.
  User: sabal
  Date: 5/17/26
  Time: 2:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Edit Product - LuxShade Admin</title>
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
                <a href="${pageContext.request.contextPath}/admin/inventory" class="active">Inventory</a>
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
            <div class="header-row">
                <div>
                    <h1>Edit Product</h1>
                    <p>Update the details for ${product.name}.</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/inventory"
                   class="btn-back">← Back to Inventory</a>
            </div>
        </section>

        <!-- Error Message -->
        <p class="msg error-msg"
           style="display:${not empty error ? 'block' : 'none'}; margin-bottom:20px;">
            ${error}
        </p>

        <!-- Form -->
        <section class="orders-section">
            <form action="${pageContext.request.contextPath}/admin/inventory"
                  method="post" enctype="multipart/form-data">

                <input type="hidden" name="action" value="edit"/>
                <input type="hidden" name="productId" value="${product.productId}"/>

                <div class="form-grid">

                    <!-- Product Name -->
                    <div class="form-group">
                        <label>Product Name</label>
                        <input type="text" name="name" placeholder="Enter product name"
                               value="${product.name}" required/>
                    </div>

                    <!-- SKU -->
                    <div class="form-group">
                        <label>SKU</label>
                        <input type="text" name="sku" placeholder="e.g. SKU-001"
                               value="${product.sku}" required/>
                    </div>

                    <!-- Price -->
                    <div class="form-group">
                        <label>Price (Rs)</label>
                        <input type="number" name="price" placeholder="e.g. 1999"
                               value="${product.price}" step="0.01" min="0" required/>
                    </div>

                    <!-- Stock -->
                    <div class="form-group">
                        <label>Stock</label>
                        <input type="number" name="stock" placeholder="e.g. 50"
                               value="${product.stock}" min="0" required/>
                    </div>

                    <!-- Brand -->
                    <div class="form-group">
                        <label>Brand</label>
                        <select name="brandId" required>
                            <option value="">-- Select Brand --</option>
                            <c:forEach var="brand" items="${brands}">
                                <option value="${brand.brandId}"
                                    ${product.brandId == brand.brandId ? 'selected' : ''}>
                                        ${brand.brandName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Category -->
                    <div class="form-group">
                        <label>Category</label>
                        <select name="categoryId" required>
                            <option value="">-- Select Category --</option>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.categoryId}"
                                    ${product.categoryId == category.categoryId ? 'selected' : ''}>
                                        ${category.categoryName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Description -->
                    <div class="form-group form-group-full">
                        <label>Description</label>
                        <textarea name="description" placeholder="Enter product description"
                                  rows="4">${product.description}</textarea>
                    </div>

                    <!-- Image Upload -->
                    <div class="form-group form-group-full">
                        <label>Product Image</label>
                        <div class="image-upload-container">
                            <img id="imagePreview"
                                 src="${pageContext.request.contextPath}/${product.image}"
                                 alt="Current Image"
                                 onerror="this.src='${pageContext.request.contextPath}/pages/images/default-product.png'"/>
                            <div class="image-upload-right">
                                <label for="image" class="btn-upload">Change Image</label>
                                <input type="file" id="image" name="image" accept="image/*"
                                       style="display:none;" onchange="previewImage(event)"/>
                                <p class="upload-hint">Leave empty to keep current image.</p>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/admin/inventory"
                       class="btn-cancel">Cancel</a>
                    <button type="submit" class="btn-submit">Save Changes</button>
                </div>

            </form>
        </section>

    </main>
</div>

<script>
    function previewImage(event) {
        const reader = new FileReader();
        reader.onload = function () {
            document.getElementById('imagePreview').src = reader.result;
        };
        reader.readAsDataURL(event.target.files[0]);
    }
</script>

</body>
</html>
