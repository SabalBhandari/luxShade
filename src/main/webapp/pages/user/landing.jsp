<%--
  Created by IntelliJ IDEA.
  User: sabal
  Date: 4/11/26
  Time: 7:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="../css/navbar.css">
    <link rel="stylesheet" href="../css/landing.css">
</head>
<body>
<!-- logo + nav -->
<header>
    <%@ include file="navbar.jsp" %>
</header>
<!-- Main content -->
<main>
    <!-- Hero section -->
    <section class="hero">
        <div class="container">
            <div class="left-side">
                <div class="left-content">
                    <h1>DESIGNED TO STAND OUT</h1>
                    <p>Experience the perfect blend of fashion and function with sunglasses built to <br>deliver
                        lasting comfort, sharp clarity, and timeless appeal.</p>
                </div>
            </div>
            <img src="#" alt="">
        </div>
    </section>


    <!-- panel 2 -->
    <section class="panel-2">
        <div class="pnl2-left">
            <h2>
                Lorem ipsum dolor <br>
                sit amet <br>
                consectetur
                adipiscing elit.
            </h2>
        </div>
        <div class="pnl2-right">
            <p>Consectetur adipiscing elit quisque faucibus ex sapien vitae. Ex sapien vitae pellentesque sem
                placerat in id.</p>
            <div class="learn-more btn">
                <a href="#">
                    <span>Learn More </span>
                    <img src="../images/icons/btn-1.png" alt="" srcset="">
                </a>
            </div>
        </div>
    </section>


    <!-- new arrival section -->
    <section class="new-arrivals">
        <div class="top">
            <h2>New Arrivals</h2>
            <div class="see-more btn">
                <a href="#">
                    <span>See More </span>
                    <img src="../images/icons/btn-2.png" alt="" srcset="">
                </a>
            </div>
        </div>
        <div class="product-cards">
            <ul>
                <li class="card-1">
                    <a href="#">
                        <img src="../images/Glasses/image%201.png" alt="" class="image">
                        <div class="description">
                            Name | color <br>
                            Price <br>
                            Rating <br>

                        </div>
                    </a>
                </li>
                <li class="card-2">
                    <a href="#">
                        <img src="../images/Glasses/image%202.png" alt="" class="image">
                        <div class="description">
                            Name | color <br>
                            Price <br>
                            Rating <br>
                        </div>
                    </a>
                </li>
                <li class="card-3">
                    <a href="#">
                        <img src="../images/Glasses/image%203.png" alt="" class="image">
                        <div class="description">
                            Name | color <br>
                            Price <br>
                            Rating <br>
                        </div>
                    </a>
                </li>
                <li class="card-4">
                    <a href="#">
                        <img src="../images/Glasses/image%204.png" alt="" class="image">
                        <div class="description">
                            Name | color <br>
                            Price <br>
                            Rating <br>
                        </div>
                    </a>
                </li>
            </ul>
        </div>
    </section>

    <!-- Ad section -->

    <section class="ad">
        <div class="ad-left">
            <img src="../images/ad-image.png" alt="">
        </div>
        <div class="ad-right">
            <div class="ad-right-container">

                <h2>YOUR EYES <br> <span>DESERVE</span> <br> THE BEST</h2>
                <p>Consectetur adipiscing elit quisque faucibus ex sapien vitae. Ex sapien vitae pellentesque sem
                    placerat in id.</p>
                <div class="explore-btn btn">
                    <a href="#">Explore <img src="../images/icons/btn-2.png" alt="" srcset=""></a>
                </div>
            </div>
        </div>
    </section>
    <!-- Collection section -->
    <section class="collection">
        <div class="collection-left">
            <h1>Collections</h1>
            <div class="card">
                <img src="../images/Collections/image%201.png" alt="">
                <div class="description">
                    Name | color <br>
                    Price <br>
                    Rating
                </div>
                </p>
            </div>
        </div>
        <div class="collection-right">
            <div class="grid-container">
                <div class="card-1 cards">
                    <img src="../images/Collections/image%202.png" alt="" srcset="">
                    <div class="description">
                        Name | color <br>
                        Price <br>
                        Rating
                    </div>
                </div>
                <div class="card-2 cards">
                    <img src="../images/Collections/image%203.png" alt="" srcset="">
                    <div class="description">
                        Name | color <br>
                        Price <br>
                        Rating
                    </div>
                </div>
                <div class="card-3 cards">
                    <img src="../images/Collections/image%204.png" alt="" srcset="">
                    <div class="description">
                        Name | color <br>
                        Price <br>
                        Rating
                    </div>
                </div>
                <div class="card-4 cards">
                    <img src="../images/Collections/image%205.png" alt="" srcset="">
                    <div class="description">
                        Name | color <br>
                        Price <br>
                        Rating
                    </div>
                </div>
                <div class="card-5 cards">
                    <img src="../images/Collections/image%206.png" alt="" srcset="">
                    <div class="description">
                        Name | color <br>
                        Price <br>
                        Rating
                    </div>
                </div>
                <div class="card-6 cards">
                    <img src="../images/Collections/image%207.png" alt="" srcset="">
                    <div class="description">
                        Name | color <br>
                        Price <br>
                        Rating
                    </div>
                </div>
            </div>
        </div>

    </section>

    <!-- Experience section -->

    <section class="experience-section">

        <!-- Top: Unrivalled Experience -->
        <h2 class="section-title">Unrivalled Experience</h2>

        <!-- Top Cards Row -->
        <div class="experience-cards">

            <!-- Left Card -->
            <div class="exp-card exp-card-left">
                <div class="exp-card-text">
                    <h3>Need an Eye Exam?</h3>
                    <p>Schedule your in-person eye exam at LuxShade with advanced technology for better experience
                    </p>
                    <a href="#" class="schedule-btn">Schedule now</a>
                </div>
                <div class="exp-card-img">
                    <img src="../images/experience/image%201.png" alt="Eye Exam">
                </div>
            </div>

            <!-- Right Card -->
            <div class="exp-card exp-card-right">
                <img src="../images/experience/image%202.png" alt="Shop">
                <div class="exp-card-overlay">
                    <h3>Shop Online, <br> Thrive In-store!</h3>
                </div>
            </div>

        </div>

        <!-- Bottom: Product Section -->
        <div class="product-section">

            <!-- Tabs -->
            <hr class="tab-line">
            <div class="product-tabs">
                <span>P o l a r i z e d</span>
                <span>|</span>
                <span>U V &nbsp; P r o t e c t i o n</span>
                <span>|</span>
                <span>M i r r o r e d</span>
                <span>|</span>
                <span>P h o t o c h r o m i c</span>
            </div>
            <hr class="tab-line">

            <!-- Product Grid -->
            <div class="product-grid">

                <div class="product-card">
                    <img src="../images/experience/image%203.png" alt="Product 1">
                    <p class="product-name">Name | Color</p>
                    <p class="product-price">Price</p>
                    <p class="product-rating">Rating</p>
                </div>

                <div class="product-card">
                    <img src="../images/experience/image%204.png" alt="Product 2">
                    <p class="product-name">Name | Color</p>
                    <p class="product-price">Price</p>
                    <p class="product-rating">Rating</p>
                </div>

                <div class="product-card">
                    <img src="../images/experience/image%205.png" alt="Product 3">
                    <p class="product-name">Name | Color</p>
                    <p class="product-price">Price</p>
                    <p class="product-rating">Rating</p>
                </div>

                <div class="product-card">
                    <img src="../images/experience/image%206.png" alt="Product 4">
                    <p class="product-name">Name | Color</p>
                    <p class="product-price">Price</p>
                    <p class="product-rating">Rating</p>
                </div>

            </div>
        </div>

    </section>


    <!-- discount section -->
    <section class="discount-section">

        <!-- Special Discount Banner -->
        <div class="discount-banner">
            <h2 class="discount-title">Special Discount</h2>
            <img src="../images/Discount/clock.png" alt="" srcset="">
        </div>

        <!-- Shades Approved Heading -->
        <h2 class="shades-title">Shades Approved by <br> Thousands</h2>

        <!-- Cards Row -->
        <div class="shades-cards">
            <div class="shade-text-card">
                <p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
                    pariatur.</p>
            </div>
            <div class="shade-img-card">
                <img src="../images/Discount/image%201.png" alt="Model 1">
            </div>
            <div class="shade-text-card">
                <p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
                    pariatur.</p>
            </div>
            <div class="shade-img-card">
                <img src="../images/Discount/image%202.png" alt="Model 2">
            </div>
        </div>

        <!-- Shop by Brands -->
        <h3 class="brands-title">Shop by Brands</h3>
        <div class="brands-grid">
            <div class="brand-card">
                <img src="../images/brands/chanel.png" alt="Chanel">
                <span>Chanel</span>
            </div>
            <div class="brand-card">
                <img src="../images/brands/celine.png" alt="Celine">
                <span>Celine</span>
            </div>
            <div class="brand-card">
                <img src="../images/brands/gentle_monster.png" alt="Gentle Monster">
                <span>Gentle Monster</span>
            </div>
            <div class="brand-card">
                <img src="../images/brands/versace.png" alt="Versace">
                <span>Versace</span>
            </div>
        </div>

    </section>

</main>
<%@ include file="footer.jsp" %>
</body>
</html>
