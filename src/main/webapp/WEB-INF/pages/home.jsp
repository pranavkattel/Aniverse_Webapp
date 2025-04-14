<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aniverse - Anime Tracking Platform</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f5f5;
        }

        /* Header Styles */
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 50px;
            background-color: rgba(45, 52, 95, 0.95);
            position: fixed;
            width: 100%;
            z-index: 1000;
        }

        .logo img {
            height: 40px;
        }

        .logo {
            display: flex;
            align-items: center;
        }

        .nav-links {
            display: flex;
            gap: 25px;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-size: 16px;
            transition: color 0.3s;
        }

        .nav-links a:hover {
            color: #ddd;
        }

        .dropdown-icon {
            margin-left: 5px;
            font-size: 12px;
        }

        .right-nav {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .search-icon, .theme-icon {
            color: white;
            font-size: 18px;
            cursor: pointer;
        }

        .login-btn {
            background-color: #6452e3;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
            transition: background-color 0.3s;
        }

        .login-btn:hover {
            background-color: #5243c2;
        }

        /* Hero Section */
        .hero {
            position: relative;
            height: 100vh;
            overflow: hidden;
        }

        .carousel {
            width: 100%;
            height: 100%;
            position: absolute;
        }

        .carousel-slide {
            width: 100%;
            height: 100%;
            position: absolute;
            top: 0;
            left: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(rgba(45, 52, 95, 0.7), rgba(45, 52, 95, 0.7));
        }

        .carousel-slide img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            position: absolute;
            z-index: -1;
        }

        .hero-content {
            text-align: center;
            color: white;
            z-index: 2;
            position: relative;
            max-width: 800px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .hero-content h1 {
            font-size: 50px;
            margin-bottom: 30px;
            text-transform: uppercase;
            letter-spacing: 3px;
        }

        .search-container {
            display: flex;
            max-width: 600px;
            margin: 0 auto;
        }

        .search-input {
            flex: 1;
            padding: 15px;
            border: none;
            border-radius: 5px 0 0 5px;
            font-size: 16px;
        }

        .search-button {
            background-color: #6452e3;
            color: white;
            border: none;
            padding: 0 20px;
            border-radius: 0 5px 5px 0;
            cursor: pointer;
            font-size: 20px;
        }

        /* Stats Section */
        .stats-section {
            background: linear-gradient(to right, #4e54c8, #8f94fb);
            color: white;
            padding: 30px 0;
            text-align: center;
        }

        .stats-container {
            display: flex;
            justify-content: center;
            gap: 100px;
        }

        .stat-item {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .stat-number {
            font-size: 36px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 18px;
        }

        /* Pagination Dots */
        .pagination {
            position: absolute;
            bottom: 30px;
            right: 30px;
            display: flex;
            gap: 10px;
        }

        .dot {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background-color: rgba(255, 255, 255, 0.5);
            cursor: pointer;
        }

        .dot.active {
            background-color: #6452e3;
        }

        /* Seasonal Anime Section */
        .seasonal-anime {
            padding: 50px;
            background-color: white;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .section-header h2 {
            font-size: 28px;
            color: #333;
        }

        .view-all {
            background-color: #6452e3;
            color: white;
            padding: 8px 15px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 14px;
            display: flex;
            align-items: center;
        }

        .view-all::after {
            content: ">";
            margin-left: 5px;
        }

        .anime-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
        }

        .anime-card {
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
            cursor: pointer;
            position: relative;
        }

        .anime-card:hover {
            transform: translateY(-5px);
        }

        .anime-card img {
            width: 100%;
            height: 300px;
            object-fit: cover;
        }

        .anime-info {
            padding: 15px;
            background-color: white;
        }

        .anime-title {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
        }

        .anime-meta {
            display: flex;
            justify-content: space-between;
            color: #666;
            font-size: 14px;
        }

        .anime-rating {
            display: flex;
            align-items: center;
        }

        .star-icon {
            color: #ffc107;
            margin-right: 3px;
        }

        .anime-genre {
            font-size: 12px;
            background-color: #f0f2ff;
            color: #6452e3;
            padding: 3px 8px;
            border-radius: 3px;
            position: absolute;
            top: 10px;
            left: 10px;
        }

        .anime-episodes {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: rgba(0,0,0,0.7);
            color: white;
            padding: 3px 8px;
            border-radius: 3px;
            font-size: 12px;
        }

        /* Top Rated Anime Section */
        .top-rated {
            padding: 50px;
            background-color: #f8f9fa;
        }

        .top-anime-list {
            display: flex;
            gap: 20px;
            overflow-x: auto;
            padding: 10px 0;
        }

        .top-anime-item {
            min-width: 180px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .top-anime-rank {
            position: absolute;
            top: 0;
            left: 0;
            background-color: #6452e3;
            color: white;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }

        /* Genres Section */
        .genres-section {
            padding: 50px;
            background-color: #414957;
            color: white;
        }

        .genres-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            gap: 20px;
        }

        .genre-card {
            border-radius: 8px;
            overflow: hidden;
            height: 100px;
            position: relative;
            cursor: pointer;
            transition: transform 0.3s;
        }

        .genre-card:hover {
            transform: translateY(-5px);
        }

        .genre-card img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .genre-name {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            background: linear-gradient(transparent, rgba(0,0,0,0.8));
            padding: 20px 10px 10px;
            font-weight: bold;
            text-align: center;
        }

        /* Latest News Section */
        .news-section {
            padding: 60px 50px;
            background-color: #f8f9fa;
            text-align: center;
        }

        .news-section h2 {
            font-size: 32px;
            color: #333;
            margin-bottom: 15px;
        }

        .news-description {
            max-width: 600px;
            margin: 0 auto 40px;
            color: #6c757d;
            line-height: 1.6;
        }

        .news-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .news-card {
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
        }

        .news-card:hover {
            transform: translateY(-5px);
        }

        .news-image {
            height: 200px;
            overflow: hidden;
        }

        .news-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s;
        }

        .news-card:hover .news-image img {
            transform: scale(1.05);
        }

        .news-content {
            padding: 20px;
            text-align: left;
        }

        .author-info {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .author-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .news-title {
            font-size: 18px;
            margin-bottom: 10px;
            color: #333;
            font-weight: bold;
        }

        .news-date {
            color: #6c757d;
            font-size: 14px;
            margin-bottom: 15px;
            display: block;
        }

        .news-excerpt {
            color: #6c757d;
            line-height: 1.6;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .read-more-btn {
            background-color: #6452e3;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s;
            text-transform: uppercase;
            display: inline-block;
        }

        .read-more-btn:hover {
            background-color: #5243c2;
        }

        /* Season Preview Section */
        .season-preview {
            padding: 50px;
            background-color: #414957;
            color: white;
        }

        .season-preview-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
            gap: 20px;
        }

        .season-preview-item {
            border-radius: 8px;
            overflow: hidden;
            position: relative;
        }

        .season-preview-item img {
            width: 100%;
            height: 220px;
            object-fit: cover;
        }

        .season-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            background: linear-gradient(transparent, rgba(0,0,0,0.8));
            padding: 50px 20px 20px;
        }

        .season-title {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .season-info {
            font-size: 14px;
            opacity: 0.8;
        }

        /* User Features Section */
        .features-section {
            padding: 60px 50px;
            background-color: white;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
        }

        .feature-card {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 30px;
            text-align: center;
            transition: transform 0.3s;
        }

        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        .feature-icon {
            font-size: 40px;
            color: #6452e3;
            margin-bottom: 20px;
        }

        .feature-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 15px;
            color: #333;
        }

        .feature-desc {
            color: #666;
            line-height: 1.6;
        }

        /* Join Now Section */
        .join-section {
            padding: 80px 50px;
            background-color: #f8f9fa;
            text-align: center;
        }

        .join-section h2 {
            font-size: 32px;
            color: #444;
            margin-bottom: 15px;
        }

        .join-description {
            max-width: 600px;
            margin: 0 auto 40px;
            color: #6c757d;
            line-height: 1.6;
        }

        .subscribe-form {
            display: flex;
            max-width: 500px;
            margin: 0 auto;
        }

        .email-input {
            flex: 1;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 5px 0 0 5px;
            font-size: 16px;
        }

        .subscribe-button {
            background-color: #6452e3;
            color: white;
            border: none;
            padding: 0 25px;
            border-radius: 0 5px 5px 0;
            cursor: pointer;
            font-size: 16px;
            text-transform: uppercase;
            font-weight: 600;
        }

        /* Footer */
        .footer {
            background-color: #2d345f;
            color: #adb5bd;
            padding: 50px;
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 40px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .footer-about img {
            height: 35px;
            margin-bottom: 20px;
        }

        .footer-about p {
            line-height: 1.6;
            font-size: 14px;
            margin-bottom: 20px;
        }

        .footer-column h3 {
            color: white;
            margin-bottom: 20px;
            font-size: 18px;
        }

        .footer-links {
            list-style: none;
        }

        .footer-links li {
            margin-bottom: 10px;
        }

        .footer-links a {
            color: #adb5bd;
            text-decoration: none;
            transition: color 0.3s;
            font-size: 14px;
        }

        .footer-links a:hover {
            color: white;
        }

        .blog-post {
            margin-bottom: 15px;
        }

        .blog-title {
            font-size: 14px;
            margin-bottom: 5px;
        }

        .blog-date {
            font-size: 12px;
            color: #6c757d;
        }

        .social-icons {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        .social-icon {
            color: white;
            width: 30px;
            height: 30px;
            background-color: #495057;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background-color 0.3s;
        }

        .social-icon:hover {
            background-color: #6452e3;
        }

        .footer-bottom {
            border-top: 1px solid #495057;
            margin-top: 20px;
            padding-top: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 20px auto 0;
        }

        .footer-links-bottom {
            display: flex;
            gap: 20px;
        }

        .footer-links-bottom a {
            color: #adb5bd;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s;
        }

        .footer-links-bottom a:hover {
            color: white;
        }

        .footer-copyright {
            font-size: 14px;
        }

        /* Scroll to top button */
        .scroll-top {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 50px;
            height: 50px;
            background-color: #6452e3;
            color: white;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 24px;
            cursor: pointer;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }

        /* User Tracking Section */
        .tracking-section {
            padding: 50px;
            background-color: white;
        }

        .tracking-tabs {
            display: flex;
            border-bottom: 1px solid #ddd;
            margin-bottom: 20px;
        }

        .tracking-tab {
            padding: 10px 20px;
            cursor: pointer;
            border-bottom: 3px solid transparent;
            font-weight: 600;
        }

        .tracking-tab.active {
            border-bottom-color: #6452e3;
            color: #6452e3;
        }

        .tracking-content {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        .tracking-card {
            width: calc(20% - 16px);
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .tracking-card img {
            width: 100%;
            height: 240px;
            object-fit: cover;
        }

        .tracking-info {
            padding: 10px;
        }

        .tracking-title {
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 5px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .tracking-progress {
            height: 4px;
            background-color: #ddd;
            border-radius: 2px;
            overflow: hidden;
            margin-bottom: 5px;
        }

        .progress-bar {
            height: 100%;
            background-color: #6452e3;
            width: 70%;
        }

        .tracking-episodes {
            font-size: 12px;
            color: #666;
        }

        /* Media Queries for Responsive Design */
        @media (max-width: 1024px) {
            .nav-links {
                display: none;
            }
            
            .tracking-card {
                width: calc(25% - 15px);
            }
        }

        @media (max-width: 768px) {
            header {
                padding: 15px 20px;
            }
            
            .stats-container {
                gap: 50px;
            }
            
            .tracking-card {
                width: calc(33.33% - 14px);
            }
            
            .anime-grid {
                grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
            }
        }

        @media (max-width: 576px) {
            .stats-container {
                flex-direction: column;
                gap: 20px;
            }
            
            .tracking-card {
                width: calc(50% - 10px);
            }
            
            .footer-content {
                grid-template-columns: 1fr;
            }
            
            .footer-bottom {
                flex-direction: column;
                gap: 10px;
            }
            
            .hero-content h1 {
                font-size: 36px;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <div class="logo">
            <a href="#">
                <img src="${pageContext.request.contextPath}/resources/system/logo.png" alt="Aniverse Logo">
            </a>
        </div>

        <div class="nav-links">
            <a href="#">Home </a>
            <a href="#">Anime </a>
            <a href="#">Contacts </a>
            <a href="#">Abouts</a>
        </div>

        <div class="right-nav">
            <a href="login"><button class="login-btn">LOGIN</button></a>
        </div>
    </header>

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

    <!-- Current Season Section -->
    <section class="seasonal-anime">
        <div class="section-header">
            <h2>Spring 2025 Anime</h2>
            <a href="#" class="view-all">VIEW ALL</a>
        </div>
        <div class="anime-grid">
            <div class="anime-card">
                <div class="anime-genre">Action</div>
                <div class="anime-episodes">13 eps</div>
                <img src="${pageContext.request.contextPath}/resources/animes/dandadan.jpg" alt="Anime Title 1">
                <div class="anime-info">
                    <div class="anime-title">Demon Chronicles</div>
                    <div class="anime-meta">
                        <div class="anime-rating">
                            <span class="star-icon">★</span> 4.8
                        </div>
                        <div>TV</div>
                    </div>
                </div>
            </div>
            <div class="anime-card">
                <div class="anime-genre">Romance</div>
                <div class="anime-episodes">24 eps</div>
                <img src="${pageContext.request.contextPath}/resources/animes/bluelock.jpg" alt="Anime Title 2">
                <div class="anime-info">
                    <div class="anime-title">Cherry Blossom Tales</div>
                    <div class="anime-meta">
                        <div class="anime-rating">
                            <span class="star-icon">★</span> 4.5
                        </div>
                        <div>TV</div>
                    </div>
                </div>
            </div>
            <div class="anime-card">
                <div class="anime-genre">Fantasy</div>
                <div class="anime-episodes">12 eps</div>
                <img src="${pageContext.request.contextPath}/resources/animes/dandadan.jpg" alt="Anime Title 3">
                <div class="anime-info">
                    <div class="anime-title">Dragon & Sword</div>
                    <div class="anime-meta">
                        <div class="anime-rating">
                            <span class="star-icon">★</span> 4.9
                        </div>
                        <div>TV</div>
                    </div>
                </div>
            </div>
            <div class="anime-card">
                <div class="anime-genre">Sci-Fi</div>
                <div class="anime-episodes">10 eps</div>
                <img src="${pageContext.request.contextPath}/resources/animes/onepiece.jpg" alt="Anime Title 4">
                <div class="anime-info">
                    <div class="anime-title">Cybernetic Horizon</div>
                    <div class="anime-meta">
                        <div class="anime-rating">
                            <span class="star-icon">★</span> 4.6
                        </div>
                        <div>TV</div>
                    </div>
                </div>
            </div>
            <div class="anime-card">
                <div class="anime-genre">Sci-Fi</div>
                <div class="anime-episodes">10 eps</div>
                <img src="${pageContext.request.contextPath}/resources/animes/onepiece.jpg" alt="Anime Title 4">
                <div class="anime-info">
                    <div class="anime-title">Cybernetic Horizon</div>
                    <div class="anime-meta">
                        <div class="anime-rating">
                            <span class="star-icon">★</span> 4.6
                        </div>
                        <div>TV</div>
                    </div>
                </div>
            </div>
            <div class="anime-card">
                <div class="anime-genre">Sci-Fi</div>
                <div class="anime-episodes">10 eps</div>
                <img src="${pageContext.request.contextPath}/resources/animes/onepiece.jpg" alt="Anime Title 4">
                <div class="anime-info">
                    <div class="anime-title">Cybernetic Horizon</div>
                    <div class="anime-meta">
                        <div class="anime-rating">
                            <span class="star-icon">★</span> 4.6
                        </div>
                        <div>TV</div>
                    </div>
                </div>
            </div>
            <div class="anime-card">
                <div class="anime-genre">Sci-Fi</div>
                <div class="anime-episodes">10 eps</div>
                <img src="${pageContext.request.contextPath}/resources/animes/onepiece.jpg" alt="Anime Title 4">
                <div class="anime-info">
                    <div class="anime-title">Cybernetic Horizon</div>
                    <div class="anime-meta">
                        <div class="anime-rating">
                            <span class="star-icon">★</span> 4.6
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
                <img src="${pageContext.request.contextPath}/resources/animes/onepiece.jpg" alt="Top Anime 1">
                <div class="anime-info">
                    <div class="anime-title">Cosmic Journey</div>
                    <div class="anime-meta">
                        <div class="anime-rating">
                            <span class="star-icon">★</span> 9.8
                        </div>
                    </div>
                </div>
            </div>
            <div class="anime-card top-anime-item">
                <div class="top-anime-rank">2</div>
                <img src="${pageContext.request.contextPath}/resources/animes/onepiece.jpg" alt="Top Anime 2">
                <div class="anime-info">
                    <div class="anime-title">Ninja Academy</div>
                    <div class="anime-meta">
                        <div class="anime-rating">
                            <span class="star-icon">★</span> 9.7
                        </div>
                    </div>
                </div>
            </div>
            <div class="anime-card top-anime-item">
                <div class="top-anime-rank">3</div>
                <img src="${pageContext.request.contextPath}/resources/animes/onepiece.jpg" alt="Top Anime 3">
                <div class="anime-info">
                    <div class="anime-title">Titan Slayer</div>
                    <div class="anime-meta">
                        <div class="anime-rating">
                            <span class="star-icon">★</span> 9.6
                        </div>
                    </div>
                </div>
            </div>
            <div class="anime-card top-anime-item">
                <div class="top-anime-rank">4</div>
                <img src="${pageContext.request.contextPath}/resources/animes/onepiece.jpg" alt="Top Anime 4">
                <div class="anime-info">
                    <div class="anime-title">Death Book</div>
                    <div class="anime-meta">
                        <div class="anime-rating">
                            <span class="star-icon">★</span> 9.5
                        </div>
                    </div>
                </div>
            </div>
            <div class="anime-card top-anime-item">
                <div class="top-anime-rank">5</div>
                <img src="${pageContext.request.contextPath}/resources/animes/onepiece.jpg" alt="Top Anime 5">
                <div class="anime-info">
                    <div class="anime-title">Alchemist Brothers</div>
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
                    <div class="anime-title">One Sword</div>
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
                <img src="/api/placeholder/200/100" alt="Action Genre">
                <div class="genre-name">Action</div>
            </div>
            <div class="genre-card">
                <img src="/api/placeholder/200/100" alt="Romance Genre">
                <div class="genre-name">Romance</div>
            </div>
            <div class="genre-card">
                <img src="/api/placeholder/200/100" alt="Comedy Genre">
                <div class="genre-name">Comedy</div>
            </div>
            <div class="genre-card">
                <img src="/api/placeholder/200/100" alt="Drama Genre">
                <div class="genre-name">Drama</div>
            </div>
            <div class="genre-card">
                <img src="/api/placeholder/200/100" alt="Fantasy Genre">
                <div class="genre-name">Fantasy</div>
            </div>
            <div class="genre-card">
                <img src="/api/placeholder/200/100" alt="Sci-Fi Genre">
                <div class="genre-name">Sci-Fi</div>
            </div>
            <div class="genre-card">
                <img src="/api/placeholder/200/100" alt="Horror Genre">
                <div class="genre-name">Horror</div>
            </div>
            <div class="genre-card">
                <img src="/api/placeholder/200/100" alt="Mystery Genre">
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
                <img src="/api/placeholder/600/400" alt="Summer Anime 1">
                <div class="season-overlay">
                    <h3 class="season-title">Mystic Academy: New Semester</h3>
                    <div class="season-info">Fantasy, Action • July 2025</div>
                </div>
            </div>
            <div class="season-preview-item">
                <img src="/api/placeholder/600/400" alt="Summer Anime 2">
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
                    <img src="/api/placeholder/400/300" alt="News Image 1">
                </div>
                <div class="news-content">
                    <div class="author-info">
                        <img src="/api/placeholder/40/40" alt="Author" class="author-avatar">
                    </div>
                    <h3 class="news-title">Top 10 Most Anticipated Spring 2025 Anime</h3>
                    <span class="news-date">April 02, 2025</span>
                    <p class="news-excerpt">Our editors have compiled a list of the most anticipated anime coming this Spring season. From returning favorites to exciting new adaptations...</p>
                    <button class="read-more-btn">Read More</button>
                </div>
            </div>

            <div class="news-card">
                <div class="news-image">
                    <img src="/api/placeholder/400/300" alt="News Image 2">
                </div>
                <div class="news-content">
                    <div class="author-info">
                        <img src="/api/placeholder/40/40" alt="Author" class="author-avatar">
                    </div>
                    <h3 class="news-title">Anime Awards 2025 Winners Announced</h3>
                    <span class="news-date">March 28, 2025</span>
                    <p class="news-excerpt">The results are in! The annual Anime Awards ceremony revealed this year's winners across multiple categories including Best Animation, Best Story...</p>
                    <button class="read-more-btn">Read More</button>
                </div>
            </div>

            <div class="news-card">
                <div class="news-image">
                    <img src="/api/placeholder/400/300" alt="News Image 3">
                </div>
                <div class="news-content">
                    <div class="author-info">
                        <img src="/api/placeholder/40/40" alt="Author" class="author-avatar">
                    </div>
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
        
        <form class="subscribe-form">
            <input type="email" class="email-input" placeholder="Your Email">
            <button type="submit" class="subscribe-button">Sign Up</button>
        </form>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-content">
            <div class="footer-about">
                <img src="/api/placeholder/120/40" alt="Aniverse Logo">
                <p>Aniverse is the premier platform for anime and manga enthusiasts to discover, track, and discuss their favorite series. Join our community of passionate fans!</p>
                <div class="social-icons">
                    <a href="#" class="social-icon">f</a>
                    <a href="#" class="social-icon">t</a>
                    <a href="#" class="social-icon">ig</a>
                    <a href="#" class="social-icon">d</a>
                </div>
            </div>
            
            <div class="footer-column">
                <h3>Navigation</h3>
                <ul class="footer-links">
                    <li><a href="#">Home</a></li>
                    <li><a href="#">Anime Database</a></li>
                    <li><a href="#">Manga Database</a></li>
                    <li><a href="#">Seasonal Chart</a></li>
                    <li><a href="#">Top Anime</a></li>
                    <li><a href="#">Reviews</a></li>
                </ul>
            </div>
            
            <div class="footer-column">
                <h3>Community</h3>
                <ul class="footer-links">
                    <li><a href="#">Forums</a></li>
                    <li><a href="#">User Reviews</a></li>
                    <li><a href="#">Clubs</a></li>
                    <li><a href="#">Blogs</a></li>
                    <li><a href="#">Discord Server</a></li>
                </ul>
            </div>
            
            <div class="footer-column">
                <h3>Account</h3>
                <ul class="footer-links">
                    <li><a href="#">My Profile</a></li>
                    <li><a href="#">Anime List</a></li>
                    <li><a href="#">Manga List</a></li>
                    <li><a href="#">My Reviews</a></li>
                    <li><a href="#">Settings</a></li>
                </ul>
            </div>
        </div>
        
        <div class="footer-bottom">
            <div class="footer-links-bottom">
                <a href="#">Privacy Policy</a>
                <a href="#">Terms of Service</a>
                <a href="#">Content Guidelines</a>
                <a href="#">About Us</a>
                <a href="#">Contact</a>
            </div>
            <div class="footer-copyright">© 2025 Aniverse. All Rights Reserved.</div>
        </div>
    </footer>

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