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
    <link rel="stylesheet" href="./css/navbar.css">
    <link rel="stylesheet" href="./css/landing.css">
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
            <div class="left-content"></div>
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
                    <img src="./images/btn-1.png" alt="" srcset="">
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
                    <img src="./images/btn-2.png" alt="" srcset="">
                </a>
            </div>
        </div>
        <div class="product-cards">
            <ul>
                <li class="card-1">
                    <a href="#">
                        <img src="./images/Glasses/image 1.png" alt="" class="image">
                        <div class="description">
                            Name | color <br>
                            Price <br>
                            Rating <br>

                        </div>
                    </a>
                </li>
                <li class="card-2">
                    <a href="#">
                        <img src="./images/Glasses/image 2.png" alt="" class="image">
                        <div class="description">
                            Name | color <br>
                            Price <br>
                            Rating <br>
                        </div>
                    </a>
                </li>
                <li class="card-3">
                    <a href="#">
                        <img src="./images/Glasses/image 3.png" alt="" class="image">
                        <div class="description">
                            Name | color <br>
                            Price <br>
                            Rating <br>
                        </div>
                    </a>
                </li>
                <li class="card-4">
                    <a href="#">
                        <img src="./images/Glasses/image 4.png" alt="" class="image">
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
            <img src="./images/ad-image.png" alt="">
        </div>
        <div class="ad-right">
            <h2>Message</h2>
            <p>desc</p>
            <div class="explore-btn btn">
                <a href="#">Explore <span><!-- shape--></span></a>
            </div>
        </div>
    </section>
    <!-- Collection section -->
    <section class="collection">
        <h1>Collections</h1>
        <div class="collection-left">
            <div class="card">
                <img src="" alt="">
                <p>Desc</p>
            </div>
        </div>
        <div class="collection-right">

        </div>
    </section>

</main>
</body>
</html>
