<%--
  Created by IntelliJ IDEA.
  User: sabal
  Date: 4/11/26
  Time: 7:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LuxShade - Premium Sunglasses</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/home.css">
</head>
<body>
<!-- Navigation Header -->
<header>
    <%@ include file="navbar.jsp" %>
</header>

<!-- Main Content -->
<main>
    <!-- Hero Section -->
    <section class="hero" aria-label="Hero section featuring main sunglasses collection">
        <div class="container">
            <div class="left-side">
                <div class="left-content">
                    <h1>Designed to Stand Out</h1>
                    <p>Experience the perfect blend of fashion and function with sunglasses built to deliver lasting comfort, sharp clarity, and timeless appeal.</p>
                </div>
            </div>
            <img src="${pageContext.request.contextPath}/pages/images/bannerCropped.png" alt="Featured sunglasses collection">

        </div>
    </section>
..
    <!-- Panel 2 - Key Message Section -->
    <section class="panel-2" aria-label="Premium quality promise">
        <div class="pnl2-left">
            <h2>Quality Craftsmanship Meets Modern Design</h2>
        </div>
        <div class="pnl2-right">
            <p>Our sunglasses are meticulously crafted with premium materials and cutting-edge technology to ensure you get the best protection and style.</p>
            <div class="learn-more btn">
                <a href="#collections" title="Learn more about our collections">
                    <span>Learn More</span>
                    <img src="${pageContext.request.contextPath}/pages/images/icons/btn-1.png" alt="">
                </a>
            </div>
        </div>
    </section>

    <!-- New Arrivals Section -->
    <section class="new-arrivals" aria-label="New arrivals collection">
        <div class="top">
            <h2>New Arrivals</h2>
            <div class="see-more btn">
                <a href="#all-products" title="View all new arrivals">
                    <span>See More</span>
                    <img src="${pageContext.request.contextPath}/pages/images/icons/btn-2.png" alt="">
                </a>
            </div>
        </div>
        <div class="product-cards">
            <ul>
                <c:choose>
                    <c:when test="${empty latestProducts}">
                        <li style="color:white; padding:20px;">
                            No products available yet.
                        </li>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="product" items="${latestProducts}">
                            <li>
                                <a href="${pageContext.request.contextPath}/product?id=${product.productId}"
                                   title="View product details">
                                    <img src="${pageContext.request.contextPath}/${product.image}"
                                         alt="${product.name}"
                                         class="image"
                                         onerror="this.src='${pageContext.request.contextPath}/pages/images/default-product.png'"/>
                                    <div class="description">
                                        <span class="product-name">${product.name}</span>
                                        <span class="product-price">Rs ${product.price}</span>
                                        <span class="product-rating">
                                        ${product.brandName} | ${product.categoryName}
                                    </span>
                                    </div>
                                </a>
                            </li>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </section>

    <!-- Advertisement Section -->
    <section class="ad" aria-label="Premium quality advertisement">
        <div class="ad-left">
            <img src="${pageContext.request.contextPath}/pages/images/ad-imageCropped.png" alt="Premium sunglasses lifestyle photography">
        </div>
        <div class="ad-right">
            <div class="ad-right-container">
                <h2>Your Eyes <br> <span>Deserve</span> <br> The Best</h2>
                <p>Protect your vision with our UV protection technology while maintaining timeless elegance. Every pair is engineered for comfort and durability.</p>
                <div class="explore-btn btn">
                    <a href="#" title="Explore full collection">Explore <img src="${pageContext.request.contextPath}/pages/images/icons/btn-2.png" alt=""></a>
                </div>
            </div>
        </div>
    </section>

    <!-- Collections Section -->
    <section class="collection" id="collections" aria-label="Featured collections">
        <div class="collection-left">
            <h1>Collections</h1>
            <div class="card">
                <img src="${pageContext.request.contextPath}/pages/images/Collections/image%201.png" alt="Classic Collection - Featured product">
                <div class="description">
                    <span class="product-name">Classic Collection</span>
                    <span class="product-price">From $149.99</span>
                    <span class="product-rating">★★★★★</span>
                </div>
            </div>
        </div>
        <div class="collection-right">
            <div class="grid-container">
                <div class="card-1 cards">
                    <img src="${pageContext.request.contextPath}/pages/images/Collections/image%202.png" alt="Summer Vibes Collection">
                    <div class="description">
                        <span class="product-name">Summer Vibes</span>
                        <span class="product-price">$159.99</span>
                        <span class="product-rating">★★★★☆</span>
                    </div>
                </div>
                <div class="card-2 cards">
                    <img src="${pageContext.request.contextPath}/pages/images/Collections/image%203.png" alt="Urban Edge Collection">
                    <div class="description">
                        <span class="product-name">Urban Edge</span>
                        <span class="product-price">$179.99</span>
                        <span class="product-rating">★★★★★</span>
                    </div>
                </div>
                <div class="card-3 cards">
                    <img src="${pageContext.request.contextPath}/pages/images/Collections/image%204.png" alt="Retro Vibes Collection">
                    <div class="description">
                        <span class="product-name">Retro Vibes</span>
                        <span class="product-price">$169.99</span>
                        <span class="product-rating">★★★★★</span>
                    </div>
                </div>
                <div class="card-4 cards">
                    <img src="${pageContext.request.contextPath}/pages/images/Collections/image%205.png" alt="Sport Edition Collection">
                    <div class="description">
                        <span class="product-name">Sport Edition</span>
                        <span class="product-price">$199.99</span>
                        <span class="product-rating">★★★★☆</span>
                    </div>
                </div>
                <div class="card-5 cards">
                    <img src="${pageContext.request.contextPath}/pages/images/Collections/image%206.png" alt="Luxury Premium Collection">
                    <div class="description">
                        <span class="product-name">Luxury Premium</span>
                        <span class="product-price">$249.99</span>
                        <span class="product-rating">★★★★★</span>
                    </div>
                </div>
                <div class="card-6 cards">
                    <img src="${pageContext.request.contextPath}/pages/images/Collections/image%207.png" alt="Designer Exclusive Collection">
                    <div class="description">
                        <span class="product-name">Designer Exclusive</span>
                        <span class="product-price">$299.99</span>
                        <span class="product-rating">★★★★★</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Experience Section -->
    <section class="experience-section" aria-label="Customer experience features">
        <h2 class="section-title">Unrivalled Experience</h2>

        <div class="experience-cards">
            <!-- Left Card: Eye Exam -->
            <div class="exp-card exp-card-left">
                <div class="exp-card-text">
                    <h3>Need an Eye Exam?</h3>
                    <p>Schedule your in-person eye exam at LuxShade with advanced technology for better experience</p>
                    <a href="#" class="schedule-btn" title="Schedule an eye exam appointment">Schedule now</a>
                </div>
                <div class="exp-card-img">
                    <img src="${pageContext.request.contextPath}/pages/images/experience/image%201.png" alt="Professional eye exam setup">
                </div>
            </div>

            <!-- Right Card: Shop Online -->
            <div class="exp-card exp-card-right">
                <img src="${pageContext.request.contextPath}/pages/images/experience/image%202.png" alt="In-store shopping experience">
                <div class="exp-card-overlay">
                    <h3>Shop Online, <br> Thrive In-store!</h3>
                </div>
            </div>
        </div>

        <!-- Product Section with Tabs -->
        <div class="product-section">
            <hr class="tab-line">
            <div class="product-tabs" role="tablist">
                <span role="tab" aria-selected="true" tabindex="0">Polarized</span>
                <span aria-hidden="true">|</span>
                <span role="tab" aria-selected="false" tabindex="0">UV Protection</span>
                <span aria-hidden="true">|</span>
                <span role="tab" aria-selected="false" tabindex="0">Mirrored</span>
                <span aria-hidden="true">|</span>
                <span role="tab" aria-selected="false" tabindex="0">Photochromic</span>
            </div>
            <hr class="tab-line">

            <div class="product-grid">
                <div class="product-card">
                    <img src="${pageContext.request.contextPath}/pages/images/experience/image%203.png" alt="Polarized Aviator - Black">
                    <p class="product-name">Polarized Aviator | Black</p>
                    <p class="product-price">$189.99</p>
                    <p class="product-rating">★★★★★ (145 reviews)</p>
                </div>

                <div class="product-card">
                    <img src="${pageContext.request.contextPath}/pages/images/experience/image%204.png" alt="UV Shield Classic - Brown">
                    <p class="product-name">UV Shield Classic | Brown</p>
                    <p class="product-price">$175.99</p>
                    <p class="product-rating">★★★★★ (98 reviews)</p>
                </div>

                <div class="product-card">
                    <img src="${pageContext.request.contextPath}/pages/images/experience/image%205.png" alt="Mirrored Lens Pro - Gold">
                    <p class="product-name">Mirrored Lens Pro | Gold</p>
                    <p class="product-price">$209.99</p>
                    <p class="product-rating">★★★★★ (167 reviews)</p>
                </div>

                <div class="product-card">
                    <img src="${pageContext.request.contextPath}/pages/images/experience/image%206.png" alt="Photochromic Smart - Gray">
                    <p class="product-name">Photochromic Smart | Gray</p>
                    <p class="product-price">$229.99</p>
                    <p class="product-rating">★★★★★ (203 reviews)</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Discount Section -->
    <section class="discount-section" aria-label="Special discount offers and testimonials">
        <div class="discount-banner">
            <h2 class="discount-title">Special Discount</h2>
            <img src="${pageContext.request.contextPath}/pages/images/Discount/clock.png" alt="Limited time offer clock">
        </div>

        <h2 class="shades-title">Shades Approved by <br> Thousands</h2>

        <div class="shades-cards">
            <div class="shade-text-card">
                <p>"The best sunglasses I've ever owned. Perfect comfort and style!" - Sarah M.</p>
            </div>
            <div class="shade-img-card">
                <img src="${pageContext.request.contextPath}/pages/images/Discount/image%201.png" alt="Customer testimonial - Sarah M.">
            </div>
            <div class="shade-text-card">
                <p>"Outstanding quality and protection. Highly recommend for anyone!" - James T.</p>
            </div>
            <div class="shade-img-card">
                <img src="${pageContext.request.contextPath}/pages/images/Discount/image%202.png" alt="Customer testimonial - James T.">
            </div>
        </div>

        <!-- Shop by Brands -->
        <h3 class="brands-title">Shop by Brands</h3>
        <div class="brands-grid">
            <div class="brand-card">
                <img src="${pageContext.request.contextPath}/pages/images/brands/chanel.png" alt="Chanel logo">
                <span>Chanel</span>
            </div>
            <div class="brand-card">
                <img src="${pageContext.request.contextPath}/pages/images/brands/celine.png" alt="Celine logo">
                <span>Celine</span>
            </div>
            <div class="brand-card">
                <img src="${pageContext.request.contextPath}/pages/images/brands/gentle_monster.png" alt="Gentle Monster logo">
                <span>Gentle Monster</span>
            </div>
            <div class="brand-card">
                <img src="${pageContext.request.contextPath}/pages/images/brands/versace.png" alt="Versace logo">
                <span>Versace</span>
            </div>
        </div>
    </section>
</main>

<!-- Footer -->
<%@ include file="footer.jsp" %>
</body>
</html>