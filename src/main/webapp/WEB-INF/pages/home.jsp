<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aniverse - Anime Tracking Platform</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/home.css">
</head>
<body>
    <!-- Header -->
     <jsp:include page="/WEB-INF/components/header.jsp" />

    <!-- Hero Section with Carousel -->
    <section class="hero">
        <div class="carousel">
            <div class="carousel-slide">
                <img src="${pageContext.request.contextPath}/resources/system/background.jpg" alt="Anime collage">
                <div class="hero-content">
                    <h1>TRACK YOUR ANIME JOURNEY</h1>
                    <div class="search-container">
                        <input type="text" class="search-input" placeholder="Search anime, manga, characters...">
                        <button class="search-button">🔍</button>
                    </div>
                </div>
            </div>
        </div>
        
    </section>

    <!-- Stats Section -->
    <section class="stats-section">
        <div class="stats-container">
            <div class="stat-item">
                <div class="stat-number">17,648</div>
                <div class="stat-label">Anime</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">284,732</div>
                <div class="stat-label">Users</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">5.2M</div>
                <div class="stat-label">Reviews</div>
            </div>
        </div>
    </section>
	<div class="main-below">
    <!-- Current Season Section -->
    <section class="seasonal-anime">
        <div class="section-header">
            <h2>Spring 2025 Anime</h2>
            <a href="#" class="view-all">VIEW ALL</a>
        </div>
        <div class="anime-grid">
            <div class="anime-card">
                <div class="anime-genre">Action</div>
                <div class="anime-episodes">12 eps</div>
                <img src="${pageContext.request.contextPath}/resources/animes/dandadan.jpg" alt="Dandadan">
                <div class="anime-info">
                    <div class="anime-title">Dandadan</div>
                    <div class="anime-meta">
                        <div class="anime-rating">
                            <span class="star-icon">★</span> 4.8
                        </div>
                        <div>TV</div>
                    </div>
                </div>
            </div>
            <div class="anime-card">
                <div class="anime-genre">Sports</div>
                <div class="anime-episodes">24 eps</div>
                <img src="${pageContext.request.contextPath}/resources/animes/bluelock.jpg" alt="Blue Lock">
                <div class="anime-info">
                    <div class="anime-title">Blue Lock</div>
                    <div class="anime-meta">
                        <div class="anime-rating">
                            <span class="star-icon">★</span> 4.5
                        </div>
                        <div>TV</div>
                    </div>
                </div>
            </div>
            <div class="anime-card">
                <div class="anime-genre">Drama</div>
                <div class="anime-episodes">13 eps</div>
                <img src="${pageContext.request.contextPath}/resources/animes/angelbeats.webp" alt="Angel Beats">
                <div class="anime-info">
                    <div class="anime-title">Angel Beats!</div>
                    <div class="anime-meta">
                        <div class="anime-rating">
                            <span class="star-icon">★</span> 4.9
                        </div>
                        <div>TV</div>
                    </div>
                </div>
            </div>
            <div class="anime-card">
                <div class="anime-genre">Adventure</div>
                <div class="anime-episodes">1080+ eps</div>
                <img src="${pageContext.request.contextPath}/resources/animes/onepiece.jpg" alt="One Piece">
                <div class="anime-info">
                    <div class="anime-title">One Piece</div>
                    <div class="anime-meta">
                        <div class="anime-rating">
                            <span class="star-icon">★</span> 4.9
                        </div>
                        <div>TV</div>
                    </div>
                </div>
            </div>
            <div class="anime-card">
                <div class="anime-genre">Fantasy</div>
                <div class="anime-episodes">25 eps</div>
                <img src="${pageContext.request.contextPath}/resources/animes/rezero.jpg" alt="Re:Zero">
                <div class="anime-info">
                    <div class="anime-title">Re:Zero</div>
                    <div class="anime-meta">
                        <div class="anime-rating">
                            <span class="star-icon">★</span> 4.7
                        </div>
                        <div>TV</div>
                    </div>
                </div>
            </div>
            <div class="anime-card">
                <div class="anime-genre">Sci-Fi</div>
                <div class="anime-episodes">24 eps</div>
                <img src="${pageContext.request.contextPath}/resources/animes/steinsgate.jpg" alt="Steins;Gate">
                <div class="anime-info">
                    <div class="anime-title">Steins;Gate</div>
                    <div class="anime-meta">
                        <div class="anime-rating">
                            <span class="star-icon">★</span> 4.9
                        </div>
                        <div>TV</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- User Tracking Section -->
   

    <!-- Top Rated Section -->
    <section class="top-rated">
        <div class="section-header">
            <h2>Top Rated Anime</h2>
            <a href="#" class="view-all">VIEW ALL</a>
        </div>
        <div class="top-anime-list">
            <div class="anime-card top-anime-item">
                <div class="top-anime-rank">1</div>
                <img src="${pageContext.request.contextPath}/resources/animes/dandadan.jpg" alt="Fullmetal Alchemist">
                <div class="anime-info">
                    <div class="anime-title">DanDaDan</div>
                    <div class="anime-meta">
                        <div class="anime-rating">
                            <span class="star-icon">★</span> 9.8
                        </div>
                    </div>
                </div>
            </div>
            <div class="anime-card top-anime-item">
                <div class="top-anime-rank">2</div>
                <img src="${pageContext.request.contextPath}/resources/animes/bluelock.jpg" alt="Attack on Titan">
                <div class="anime-info">
                    <div class="anime-title">Blue Lock</div>
                    <div class="anime-meta">
                        <div class="anime-rating">
                            <span class="star-icon">★</span> 9.7
                        </div>
                    </div>
                </div>
            </div>
            <div class="anime-card top-anime-item">
                <div class="top-anime-rank">3</div>
                <img src="${pageContext.request.contextPath}/resources/animes/angelbeats.webp" alt="Steins;Gate">
                <div class="anime-info">
                    <div class="anime-title">Angel Beats</div>
                    <div class="anime-meta">
                        <div class="anime-rating">
                            <span class="star-icon">★</span> 9.6
                        </div>
                    </div>
                </div>
            </div>
            <div class="anime-card top-anime-item">
                <div class="top-anime-rank">4</div>
                <img src="${pageContext.request.contextPath}/resources/animes/rezero.jpg" alt="Top Anime 4">
                <div class="anime-info">
                    <div class="anime-title">Re:Zero</div>
                    <div class="anime-meta">
                        <div class="anime-rating">
                            <span class="star-icon">★</span> 9.5
                        </div>
                    </div>
                </div>
            </div>
            <div class="anime-card top-anime-item">
                <div class="top-anime-rank">5</div>
                <img src="${pageContext.request.contextPath}/resources/animes/steinsgate.jpg" alt="Top Anime 5">
                <div class="anime-info">
                    <div class="anime-title">Steins;Gate</div>
                    <div class="anime-meta">
                        <div class="anime-rating">
                            <span class="star-icon">★</span> 9.4
                        </div>
                    </div>
                </div>
            </div>
            <div class="anime-card top-anime-item">
                <div class="top-anime-rank">6</div>
                <img src="${pageContext.request.contextPath}/resources/animes/onepiece.jpg" alt="Top Anime 6">
                <div class="anime-info">
                    <div class="anime-title">One Piece</div>
                    <div class="anime-meta">
                        <div class="anime-rating">
                            <span class="star-icon">★</span> 9.3
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Genres Section -->
    <section class="genres-section">
        <div class="section-header">
            <h2>Browse by Genre</h2>
            <a href="#" class="view-all" style="color: white;">VIEW ALL</a>
        </div>
        <div class="genres-grid">
            <div class="genre-card">
                <img src="${pageContext.request.contextPath}/resources/animes/action.jpg" alt="Action Genre">
                <div class="genre-name">Action</div>
            </div>
            <div class="genre-card">
                <img src="${pageContext.request.contextPath}/resources/animes/romance.jpg" alt="Romance Genre">
                <div class="genre-name">Romance</div>
            </div>
            <div class="genre-card">
                <img src="${pageContext.request.contextPath}/resources/animes/comdey.avif" alt="Comedy Genre">
                <div class="genre-name">Comedy</div>
            </div>
            <div class="genre-card">
                <img src="${pageContext.request.contextPath}/resources/animes/drama.jpg" alt="Drama Genre">
                <div class="genre-name">Drama</div>
            </div>
            <div class="genre-card">
                <img src="${pageContext.request.contextPath}/resources/animes/fantasy.avif" alt="Fantasy Genre">
                <div class="genre-name">Fantasy</div>
            </div>
            <div class="genre-card">
                <img src="${pageContext.request.contextPath}/resources/animes/sifi.jpg" alt="Sci-Fi Genre">
                <div class="genre-name">Sci-Fi</div>
            </div>
            <div class="genre-card">
                <img src="${pageContext.request.contextPath}/resources/animes/horror.avif" alt="Horror Genre">
                <div class="genre-name">Horror</div>
            </div>
            <div class="genre-card">
                <img src="${pageContext.request.contextPath}/resources/animes/mystery.avif" alt="Mystery Genre">
                <div class="genre-name">Mystery</div>
            </div>
        </div>
    </section>

    <!-- Season Preview Section -->
    <section class="season-preview">
        <div class="section-header">
            <h2>Summer 2025 Preview</h2>
            <a href="#" class="view-all" style="color: white;">VIEW ALL</a>
        </div>
        <div class="season-preview-grid">
            <div class="season-preview-item">
                <img src="${pageContext.request.contextPath}/resources/animes/darling.avif" alt="Summer Anime 1">
                <div class="season-overlay">
                    <h3 class="season-title">Mystic Academy: New Semester</h3>
                    <div class="season-info">Fantasy, Action • July 2025</div>
                </div>
            </div>
            <div class="season-preview-item">
                <img src="${pageContext.request.contextPath}/resources/animes/dandan.jpg" alt="Summer Anime 2">
                <div class="season-overlay">
                    <h3 class="season-title">Beach Volleyball Champions</h3>
                    <div class="season-info">Sports, Comedy • August 2025</div>
                </div>
            </div>
        </div>
    </section>

    <!-- User Features Section -->
    <section class="features-section">
        <div class="section-header">
            <h2>Track Your Anime Experience</h2>
        </div>
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">📊</div>
                <h3 class="feature-title">Track Progress</h3>
                <p class="feature-desc">Keep track of episodes you've watched and manga chapters you've read with our easy-to-use tracking system.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">⭐</div>
                <h3 class="feature-title">Rate & Review</h3>
                <p class="feature-desc">Share your thoughts and rate anime and manga to help others discover great content.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">👥</div>
                <h3 class="feature-title">Join Communities</h3>
                <p class="feature-desc">Connect with fellow fans, join discussions, and find recommendations from like-minded anime enthusiasts.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🔔</div>
                <h3 class="feature-title">Stay Updated</h3>
                <p class="feature-desc">Get notifications for new episodes of your favorite shows and never miss an update.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">📱</div>
                <h3 class="feature-title">Mobile Access</h3>
                <p class="feature-desc">Access your anime and manga lists anytime, anywhere with our mobile-friendly platform.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">📈</div>
                <h3 class="feature-title">Personalized Stats</h3>
                <p class="feature-desc">View detailed statistics about your watching habits, favorite genres, and more.</p>
            </div>
        </div>
    </section>

    <!-- Latest News Section -->
    <section class="news-section">
        <h2>Anime News & Updates</h2>
        <p class="news-description">Stay up-to-date with the latest anime announcements, releases, and industry news.</p>
        
        <div class="news-grid">
            <div class="news-card">
                <div class="news-image">
                    <img src="${pageContext.request.contextPath}/resources/animes/news1.jpg" alt="News Image 1">
                </div>
                <div class="news-content">
                
                    <h3 class="news-title">Top 10 Most Anticipated Spring 2025 Anime</h3>
                    <span class="news-date">April 02, 2025</span>
                    <p class="news-excerpt">Our editors have compiled a list of the most anticipated anime coming this Spring season. From returning favorites to exciting new adaptations...</p>
                    <button class="read-more-btn">Read More</button>
                </div>
            </div>

            <div class="news-card">
                <div class="news-image">
                    <img src="${pageContext.request.contextPath}/resources/animes/news2.webp" alt="News Image 2">
                </div>
                <div class="news-content">
                    <h3 class="news-title">Anime Awards 2025 Winners Announced</h3>
                    <span class="news-date">March 28, 2025</span>
                    <p class="news-excerpt">The results are in! The annual Anime Awards ceremony revealed this year's winners across multiple categories including Best Animation, Best Story...</p>
                    <button class="read-more-btn">Read More</button>
                </div>
            </div>

            <div class="news-card">
                <div class="news-image">
                    <img src="${pageContext.request.contextPath}/resources/animes/news3.avif" alt="News Image 3">
                </div>
                <div class="news-content">
                    <h3 class="news-title">Major Studio Announces Five New Anime Adaptations</h3>
                    <span class="news-date">March 25, 2025</span>
                    <p class="news-excerpt">In a surprise announcement, one of Japan's biggest animation studios revealed plans to adapt five popular manga series into anime. Fans are particularly excited about...</p>
                    <button class="read-more-btn">Read More</button>
                </div>
            </div>
        </div>
    </section>

    <!-- Join Now Section -->
    <section class="join-section">
        <h2>Join Aniverse Community!</h2>
        <p class="join-description">Create your account to track your anime, join discussions, write reviews, and connect with fellow anime fans around the world.</p>
        
        <form class="subscribe-form" action="register">
            <input type="email" class="email-input" placeholder="Your Email">
            <button type="submit" class="subscribe-button"> Sign Up</button>
        </form>
    </section>
    </div>

    <!-- Footer -->
   <jsp:include page="/WEB-INF/components/footer.jsp" />

    <!-- Scroll to top button -->
    <div class="scroll-top">↑</div>

    <script>
        // JavaScript for interactivity
        document.addEventListener('DOMContentLoaded', function() {
            // Tab functionality for tracking section
            const tabs = document.querySelectorAll('.tracking-tab');
            tabs.forEach(tab => {
                tab.addEventListener('click', function() {
                    tabs.forEach(t => t.classList.remove('active'));
                    this.classList.add('active');
                    // In a real implementation, this would load different content
                });
            });
            
            // Scroll to top functionality
            const scrollTopBtn = document.querySelector('.scroll-top');
            scrollTopBtn.addEventListener('click', function() {
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });
            });
            
            // Show/hide scroll to top button based on scroll position
            window.addEventListener('scroll', function() {
                if (window.pageYOffset > 300) {
                    scrollTopBtn.style.opacity = '1';
                } else {
                    scrollTopBtn.style.opacity = '0';
                }
            });
            
            // Theme toggle (light/dark mode) - simplified implementation
            const themeToggle = document.querySelector('.theme-icon');
            themeToggle.addEventListener('click', function() {
                document.body.classList.toggle('dark-mode');
                // In a real implementation, this would toggle styles throughout the site
            });
            
            // Carousel functionality - simplified implementation
            const dots = document.querySelectorAll('.dot');
            dots.forEach((dot, index) => {
                dot.addEventListener('click', function() {
                    dots.forEach(d => d.classList.remove('active'));
                    this.classList.add('active');
                    // In a real implementation, this would switch carousel slides
                });
            });
        });
    </script>
</body>
</html>