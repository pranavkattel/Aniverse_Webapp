<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Aniverse</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/about.css">
</head>
<body>
    <jsp:include page="/WEB-INF/components/header.jsp" />

    <main class="main-content">
        <div class="about-container">
            <h1 class="page-title">
                <i class="fas fa-info-circle icon"></i>
                About Aniverse
            </h1>

            <section class="section">
                <h2 class="section-title">
                    <i class="fas fa-bullseye icon"></i>
                    Our Mission
                </h2>
                <p>Welcome to Aniverse, your ultimate destination for discovering, tracking, and discussing everything anime and manga! We are passionate fans just like you, and we built this platform to create the best possible experience for managing your anime journey.</p>
                <p>Our goal is to provide a comprehensive database, powerful tracking tools, and a vibrant community where fans can connect and share their love for anime and manga.</p>
            </section>

            <section class="section">
                <h2 class="section-title">
                    <i class="fas fa-star icon"></i>
                    What We Offer
                </h2>
                <ul class="feature-list">
                    <li><i class="fas fa-database"></i>Extensive Database: Explore vast info on anime series, movies, OVAs, manga, and characters.</li>
                    <li><i class="fas fa-list-check"></i>Personalized Lists: Easily track your watching, reading, completed, planned, and dropped lists.</li>
                    <li><i class="fas fa-comments"></i>Community Interaction: Rate/review series, join forums, and connect with other fans.</li>
                    <li><i class="fas fa-lightbulb"></i>Recommendations: Discover new titles based on your tastes and history.</li>
                    <li><i class="fas fa-calendar-alt"></i>Seasonal Charts: Stay updated with the latest anime releases each season.</li>
                </ul>
            </section>

            <section class="section">
                <h2 class="section-title">
                    <i class="fas fa-users icon"></i>
                    Our Team
                </h2>
                <p>We are a small, dedicated guild of developers and anime lovers united by our quest to build the ultimate platform for the community. We're constantly leveling up Aniverse, adding new features, and ensuring our data is accurate and up-to-date.</p>
            </section>
        </div>
    </main>

    <jsp:include page="/WEB-INF/components/footer.jsp" />
</body>
</html>
