
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>About Us</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/About_us.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/footer.css">
</head>
<body>
<header>
    <%@ include file="navbar.jsp"%>
</header>
<section class="hero-section">
    <div class="hero-grid">
        <div>
            <h1 class="hero-title">ABOUT<br/>US</h1>
        </div>

        <div>
            <img
                    src="${pageContext.request.contextPath}/pages/images/Glasses/glasses1.jpg"
                    alt="Sunglasses on beach"
                    class="hero-main-img"
            />
        </div>
        
        <div class="hero-side">
            <div class="philosophy-card">
                <img
                        src="https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=500&q=80"
                        alt="Gold-frame sunglasses"
                />
                <div class="philosophy-card-body">
                    <h3>Our Philosophy</h3>
                    <p>
                        We believe that premium eyewear is more than a fashion accessory —
                        it is a statement of identity, crafted with precision and worn with confidence.
                    </p>
                </div>
            </div>
        </div>

    </div>
</section>

<!-- ========== VISION & MISSION (Scroll Section) ========== -->
<section class="vm-section">
    <div class="vm-container">

        <div class="vm-image">
            <img
                    src="${pageContext.request.contextPath}/pages/images/Glasses/model1.jpg"
                    alt="Model wearing LuxShade sunglasses"
            />
        </div>

        <div class="vm-content">
            <div class="scroll-line-wrapper">
                <div class="scroll-track">
                    <div class="scroll-thumb"></div>
                </div>
            </div>

            <div class="vm-items">

                <div class="vm-item">
                    <h3>Vision</h3>
                    <p>
                        To become the world's most recognised luxury eyewear brand — a name synonymous
                        with artisanal quality, timeless style, and the courage to be seen.
                    </p>
                </div>

                <div class="vm-item">
                    <h3>Mission</h3>
                    <p>
                        To craft sunglasses that merge cutting-edge lens technology with bespoke frame
                        design, delivering an unmatched experience for the discerning wearer.
                    </p>
                </div>

                <div class="vm-item">
                    <h3>Values</h3>
                    <p>
                        Integrity in craftsmanship, sustainability in sourcing, and innovation in every
                        collection. Every pair carries our commitment to excellence.
                    </p>
                </div>

            </div>
        </div>

    </div>
</section>

<!-- ========== MEET THE TEAM ========== -->
<section class="team-section">
    <h2 class="section-title">Meet The Amazing Team</h2>

    <div class="team-grid">
        <div class="flip-card">
            <div class="flip-card-inner">
                <div class="flip-front">
                    <img
                            src="https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400&q=80"
                            alt="Sophia Lin"
                    />
                </div>
                <div class="flip-back">
                    <img
                            class="member-avatar"
                            src="https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100&q=80"
                            alt="Sophia Lin"
                    />
                    <h4>Telisha Khadgi</h4>
                    <div class="member-role">Creative Director</div>
                    <p>
                        With 12 years in luxury fashion, Sophia drives the aesthetic vision
                        behind every LuxShade collection.
                    </p>
                    <div class="socials">
                        <a href="#"><i class="fa-brands fa-instagram"></i></a>
                        <a href="#"><i class="fa-brands fa-linkedin-in"></i></a>
                        <a href="#"><i class="fa-solid fa-envelope"></i></a>
                    </div>
                </div>
            </div>
        </div>

        <div class="flip-card">
            <div class="flip-card-inner">
                <div class="flip-front">
                    <img
                            src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&q=80"
                            alt="Marcus Reid"
                    />
                </div>
                <div class="flip-back">
                    <img
                            class="member-avatar"
                            src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&q=80"
                            alt="Marcus Reid"
                    />
                    <h4>Sabal Bhandari</h4>
                    <div class="member-role">Head of Operations</div>
                    <p>
                        Marcus oversees global supply chains and ensures every frame reaches
                        customers in pristine condition, on time.
                    </p>
                    <div class="socials">
                        <a href="#"><i class="fa-brands fa-instagram"></i></a>
                        <a href="#"><i class="fa-brands fa-linkedin-in"></i></a>
                        <a href="#"><i class="fa-solid fa-envelope"></i></a>
                    </div>
                </div>
            </div>
        </div>

        <div class="flip-card">
            <div class="flip-card-inner">
                <div class="flip-front">
                    <img
                            src="https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=400&q=80"
                            alt="Elena Voss"
                    />
                </div>
                <div class="flip-back">
                    <img
                            class="member-avatar"
                            src="https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=100&q=80"
                            alt="Elena Voss"
                    />
                    <h4>Nirjara Shrestha</h4>
                    <div class="member-role">Lead Designer</div>
                    <p>
                        Elena translates trend forecasting into wearable art, balancing bold
                        geometry with timeless silhouette.
                    </p>
                    <div class="socials">
                        <a href="#"><i class="fa-brands fa-instagram"></i></a>
                        <a href="#"><i class="fa-brands fa-linkedin-in"></i></a>
                        <a href="#"><i class="fa-solid fa-envelope"></i></a>
                    </div>
                </div>
            </div>
        </div>

    </div>
</section>

<!-- ========== FAQ SECTION ========== -->
<section class="faq-section">
    <div class="faq-container">

        <div class="faq-left">
            <p class="faq-label">FAQ</p>
            <h2>
                Frequently <span class="highlight">Asked</span> Questions
            </h2>
            <img
                    class="faq-img"
                    src="${pageContext.request.contextPath}/pages/images/faq.png"
                    alt="FAQ illustration"
            />
        </div>

        <div class="faq-list">

            <div class="faq-item">
                <div class="faq-question">
                    Are your sunglasses suitable for daily use?
                    <span class="faq-icon"><i class="fa-solid fa-plus"></i></span>
                </div>
                <div class="faq-answer">
                    Absolutely. All LuxShade frames are crafted from lightweight, durable acetate
                    and titanium alloys. Our lenses provide 100% UV-A and UV-B protection, making
                    them ideal for everyday wear — from morning commutes to weekend getaways.
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question">
                    How long does delivery take?
                    <span class="faq-icon"><i class="fa-solid fa-plus"></i></span>
                </div>
                <div class="faq-answer">
                    Standard delivery takes 5–7 business days within Nepal. Express shipping
                    (2–3 business days) is available at checkout. International orders typically
                    arrive within 10–14 business days depending on destination.
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question">
                    What is your return policy?
                    <span class="faq-icon"><i class="fa-solid fa-plus"></i></span>
                </div>
                <div class="faq-answer">
                    We offer a 30-day hassle-free return policy on all unworn, undamaged items in
                    original packaging. Simply contact our team at asdns@gmail.com and we will
                    arrange a free collection from your address.
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question">
                    What payment methods do you accept?
                    <span class="faq-icon"><i class="fa-solid fa-plus"></i></span>
                </div>
                <div class="faq-answer">
                    We accept all major credit/debit cards (Visa, MasterCard), eSewa, Khalti,
                    bank transfers, and cash on delivery for orders within Kathmandu Valley.
                    All online transactions are secured with 256-bit SSL encryption.
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question">
                    Are your sunglasses suitable for daily use?
                    <span class="faq-icon"><i class="fa-solid fa-plus"></i></span>
                </div>
                <div class="faq-answer">
                    Absolutely. All LuxShade frames are crafted from lightweight, durable acetate
                    and titanium alloys. Our lenses provide 100% UV-A and UV-B protection, making
                    them ideal for everyday wear — from morning commutes to weekend getaways.
                </div>
            </div>

        </div>
    </div>
</section>

<!-- ========== STATS SECTION ========== -->
<section class="stats-section">
    <div class="stats-card">
        <h3>Track Backed by Numbers</h3>
        <div class="stats-grid">
            <div class="stat-item">
                <div class="stat-number">2026</div>
                <div class="stat-label">Founded</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">+2456</div>
                <div class="stat-label">Clients</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">+343</div>
                <div class="stat-label">Reviews</div>
            </div>
        </div>
    </div>
</section>

<!-- ========== FOOTER ========== -->
<%@ include file="footer.jsp"%>

</body>
</html>
