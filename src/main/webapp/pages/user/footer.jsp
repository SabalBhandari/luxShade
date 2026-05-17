<%--
  Footer Component
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Footer</title>
  <link rel="stylesheet" href="../css/footer.css">
</head>
<body>

<footer class="footer">

  <!-- Left Section -->
  <div class="footer-left">
    <h2 class="footer-logo">LuxShade</h2>
    <p class="footer-desc">Discover premium eyewear that blends style, comfort, and quality. Elevate your look with LuxShade.</p>
    <div class="footer-socials">
      <a href="#"><img src="${pageContext.request.contextPath}/pages/images/socials/insta.png" alt="Instagram"></a>
      <a href="#"><img src="${pageContext.request.contextPath}/pages/images/socials/fb.png" alt="Facebook"></a>
    </div>
    <a href="#" class="back-to-top">
      <img src="${pageContext.request.contextPath}/pages/images/icons/uparrow.png" alt=""> Back to top
    </a>
  </div>

  <!-- Middle Section -->
  <div class="footer-middle">
    <h3>Contact us</h3>
    <ul class="contact-list">
      <li>
        <img src="${pageContext.request.contextPath}/pages/images/icons/phone.png" alt="phone">
        <span>9876540979</span>
      </li>
      <li>
        <img src="${pageContext.request.contextPath}/pages/images/icons/mail.png" alt="email">
        <span>luxshade@gmail.com</span>
      </li>
      <li>
        <img src="${pageContext.request.contextPath}/pages/images/icons/location.png" alt="location">
        <span>kathmandu, ktm</span>
      </li>
      <li>
        <img src="${pageContext.request.contextPath}/pages/images/icons/time.png" alt="clock">
        <span>10 AM – 7 PM</span>
      </li>
    </ul>
  </div>

  <!-- Right Section -->
  <div class="footer-right">
    <h3>Subscribe</h3>
    <p>Join our community for updates</p>
    <div class="subscribe-form">
      <input type="email" placeholder="Enter your email">
      <button type="button">submit</button>
    </div>
  </div>

</footer>

</body>
</html>