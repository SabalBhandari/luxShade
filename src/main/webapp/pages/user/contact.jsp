<%@ page import="java.util.UUID" %><%--
  Created by IntelliJ IDEA.
  User: sabal
  Date: 4/11/26
  Time: 7:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Contact Us</title>
    <link rel="stylesheet" href="../css/contact.css" />
</head>
<body>
<!-- ========== NAVBAR ========== -->
<%@ include file="navbar.jsp"%>

<section class="lux-hero">
    <div class="lux-hero-bg"></div>
    <div class="lux-hero-content">
        <h1 class="lux-hero-title">Get In Touch</h1>
        <p class="lux-hero-subtitle">We'd love to hear from you!</p>
        <img src="../images/Shades%20Picture.png">
    </div>
</section>

<%-- ============================================
     MAIN CONTENT
     ============================================ --%>
<main class="lux-page-wrap">

    <%-- Two-column row: promo card | form box --%>
    <div class="lux-columns">

        <%-- LEFT: Promo image — Sunglasses_Image.png --%>
        <div class="lux-promo">
            <img
                    src="../images/Sunglasses Image.png"
                    class="lux-promo-img"
            />
        </div>

        <%-- RIGHT: White box with form --%>
        <div class="lux-form-box">
            <h2 class="lux-form-heading">Let&apos;s Chat<br/>Reach out to us</h2>

            <%
                String successMsg = (String) request.getAttribute("successMsg");
                String errorMsg   = (String) request.getAttribute("errorMsg");
            %>
            <% if (successMsg != null) { %>
            <div class="lux-banner lux-banner--success"><%= successMsg %></div>
            <% } %>
            <% if (errorMsg != null) { %>
            <div class="lux-banner lux-banner--error"><%= errorMsg %></div>
            <% } %>

            <form action="${pageContext.request.contextPath}/pages/user/contact.jsp"
                  method="post" id="contactForm" novalidate>

                <%
                    String csrfToken = UUID.randomUUID().toString();
                    session.setAttribute("csrfToken", csrfToken);
                %>
                <input type="hidden" name="csrfToken" value="<%= csrfToken %>"/>

                <%-- Name row --%>
                <div class="lux-field-row">
                    <div class="lux-field">
                        <label for="firstName">First Name</label>
                        <input type="text" id="firstName" name="firstName" placeholder="John"
                               value="<%= request.getParameter("firstName") != null ? request.getParameter("firstName") : "" %>"
                               required/>
                    </div>
                    <div class="lux-field">
                        <label for="lastName">Last Name</label>
                        <input type="text" id="lastName" name="lastName" placeholder="Doe"
                               value="<%= request.getParameter("lastName") != null ? request.getParameter("lastName") : "" %>"
                               required/>
                    </div>
                </div>

                <%-- Email --%>
                <div class="lux-field">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" placeholder="john@example.com"
                           value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>"
                           required/>
                </div>

                <%-- Message --%>
                <div class="lux-field">
                    <label for="message">Message</label>
                    <textarea id="message" name="message"
                              placeholder="Write your message here..."
                              required
                    ><%= request.getParameter("message") != null ? request.getParameter("message") : "" %></textarea>
                </div>

                <button type="submit" class="lux-btn-submit">Send Message</button>

                <div class="lux-banner lux-banner--success" id="jsSuccess" style="display:none;">
                    Thank you! Your message has been sent.
                </div>

            </form>
        </div><%-- end .lux-form-box --%>

    </div><%-- end .lux-columns --%>

    <%-- MAP: full width below both columns --%>
    <div class="lux-map">
        <iframe
                title="LuxShade Location – Kalopul, Kathmandu"
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d56516.316265!2d85.2910!3d27.7172!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39eb1908b4bd1963%3A0x1007e1028e0a2b01!2sKathmandu!5e0!3m2!1sen!2snp!4v1680000000000"
                allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade">
        </iframe>
    </div>

</main>

<%-- ============================================
     SHARED FOOTER
     Change path to match your footer file
     ============================================ --%>

<script>
    document.getElementById('contactForm').addEventListener('submit', function(e) {
        const firstName = document.getElementById('firstName').value.trim();
        const lastName  = document.getElementById('lastName').value.trim();
        const email     = document.getElementById('email').value.trim();
        const message   = document.getElementById('message').value.trim();
        const emailRe   = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!firstName || !lastName || !email || !message) {
            e.preventDefault();
            alert('Please fill in all fields before submitting.');
            return;
        }
        if (!emailRe.test(email)) {
            e.preventDefault();
            alert('Please enter a valid email address.');
        }
    });
</script>


    </section>
</main>

<!-- ========== FOOTER ========== -->
<%@ include file="footer.jsp"%>
</body>
</html>
