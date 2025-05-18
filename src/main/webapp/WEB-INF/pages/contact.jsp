<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - AnimeTracker</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/contact.css">
</head>
<body>
    <jsp:include page="/WEB-INF/components/header.jsp" />

    <main class="main-content">
        <div class="grid-container">
            <div class="contact-form-container">
                <h1 class="page-title">
                    <i class="fas fa-envelope icon"></i>
                    Contact Us
                </h1>

                <p class="intro-text">
                    Have questions, feedback, or suggestions? We'd love to hear from you! Fill out the form below, and we'll get back to you faster than a speeding shonen protagonist! ✨
                </p>

                <form action="#" method="POST" class="contact-form">
                    <div class="form-group">
                        <label for="name" class="form-label">Your Name</label>
                        <input type="text" id="name" name="name" class="form-input" placeholder="e.g., Neko Chan" required>
                    </div>

                    <div class="form-group">
                        <label for="email" class="form-label">Your Email</label>
                        <input type="email" id="email" name="email" class="form-input" placeholder="e.g., user@domain.com" required>
                    </div>

                    <div class="form-group">
                        <label for="subject" class="form-label">Subject</label>
                        <input type="text" id="subject" name="subject" class="form-input" placeholder="What's on your mind?" required>
                    </div>

                    <div class="form-group">
                        <label for="message" class="form-label">Message</label>
                        <textarea id="message" name="message" rows="5" class="form-input" placeholder="Tell us everything..." required></textarea>
                    </div>

                    <div class="form-group">
                        <button type="submit" class="submit-btn">
                            <i class="fas fa-paper-plane"></i> Send Message
                        </button>
                    </div>
                </form>

                <div class="direct-contact">
                    <p>Or reach us directly at:</p>
                    <a href="mailto:support@animetracker.com" class="email-link">support@animetracker.com</a>
                </div>
            </div>

            <div class="support-container">
                <h2 class="support-title">Need Assistance?</h2>
                <div class="support-image-container">
                    <img src="${pageContext.request.contextPath}/resources/system/anime_girl_1.jpg" 
                         alt="Support Team Anime Character" 
                         class="support-image">
                </div>
                <p class="support-text">Our support team is ready to help!</p>
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/components/footer.jsp" />
</body>
</html>
