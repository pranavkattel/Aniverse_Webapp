<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>aniverse Dashboard</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/userDashboard.css">
    <style>
        
    </style>
</head>
<body>
    <div class="background-characters"></div>
    <img src="${pageContext.request.contextPath}/resources/system/anime_girl_1.jpg" alt="Floating anime character 1" class="floating-images floating-1" onerror="this.style.display='none'">
    <img src="${pageContext.request.contextPath}/resources/system/anime_girl_2.jpg" alt="Floating anime character 2" class="floating-images floating-2" onerror="this.style.display='none'">
    <img src="${pageContext.request.contextPath}/resources/system/anime_girl_1.jpg" alt="Floating anime character 3" class="floating-images floating-3" onerror="this.style.display='none'">
    <img src="${pageContext.request.contextPath}/resources/system/anime_girl_2.jpg" alt="Floating anime character 4" class="floating-images floating-4" onerror="this.style.display='none'">

    <nav class="navbar">
        <div class="logo">
            <img src="https://placehold.co/40x40/5d5fef/ffffff?text=AT" alt="aniverse Logo" onerror="this.src='https://placehold.co/40x40/cccccc/ffffff?text=Logo'">
        </div>
        <div class="nav-links">
            <a href="#">Home</a>
            <a href="#">Anime</a>
            <a href="#">Manga</a>
            <a href="#">Community</a>
            <a href="#">News</a>
        </div>
        <div class="right-nav">
            <button class="login-btn">MY PROFILE</button>
            <a href="/Aniverse/accountsettings" class="settings-btn" >
                <img src="${pageContext.request.contextPath}/resources/system/settings.png" alt="Settings" width="24" height="24">
            </a>
        </div>
    </nav>

    <div class="container">
        <div class="dashboard-header">  
            <c:if test="${not empty userFromDb}">
			 <div class="welcome-user">Welcome back, ${userFromDb}</div>
		</c:if>
            
        </div>

        <div class="featured-banner">
            <img src="${pageContext.request.contextPath}/resources/animes/comdey.avif" alt="Featured anime: Demon Slayer" onerror="this.src='https://placehold.co/1200x300/cccccc/ffffff?text=Error'">
            <div class="featured-overlay">
                <div>
                    <div class="featured-title">Demon Slayer: Entertainment District Arc</div>
                    <div class="featured-info">New Episode Every Sunday • ⭐ 8.9/10 Rating</div>
                </div>
            </div>
        </div>

        <div class="dashboard-stats">
            <div class="stat-card">
                <div class="stat-number">42</div>
                <div class="stat-label">Watching</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">189</div>
                <div class="stat-label">Completed</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">67</div>
                <div class="stat-label">Plan to Watch</div>
            </div>
             <div class="stat-card">
                <div class="stat-number">15</div>
                <div class="stat-label">Dropped / On Hold</div>
            </div>
        </div>

        <div class="section-title" style="border: none; padding-bottom: 0; margin-bottom: 15px;">
             <span>Explore Genres</span>
         </div>
        <div class="banner-grid">
            <a href="#" class="anime-banner">
                <img src="${pageContext.request.contextPath}/resources/animes/action.jpg" alt="Action Genre Banner">
                <div class="anime-banner-overlay"><p style="color:white">Action</p></div>
            </a>
            <a href="#" class="anime-banner">
                <img src="${pageContext.request.contextPath}/resources/animes/fantasy.avif" alt="Fantasy Genre Banner">
                <div class="anime-banner-overlay"><p style="color:white">Fantasy</p></div>
            </a>
            <a href="#" class="anime-banner">
                <img src="${pageContext.request.contextPath}/resources/animes/romance.jpg" alt="Romance Genre Banner">
                <div class="anime-banner-overlay"><p style="color:white">Romance</p></div>
            </a>
            <a href="#" class="anime-banner">
                <img src="${pageContext.request.contextPath}/resources/animes/sifi.jpg" alt="Sci-Fi Genre Banner">
                <div class="anime-banner-overlay"><p style="color:white">Sci-Fi</p></div>
            </a>
        </div>

        <div class="trending-anime">
             <div class="section-title">
                 <span>Trending Now</span>
                 <a href="#" class="view-all">View More</a>
             </div>
             <div class="trending-scroll">
                 <div class="trending-card">
                     <div class="trending-rank">1</div>
                     <img src="${pageContext.request.contextPath}/resources/animes/angelbeats.webp" alt="Trending Anime 1 Poster" class="trending-poster" onerror="this.src='https://placehold.co/160x220/cccccc/ffffff?text=Err'">
                     <div class="trending-overlay">
                         <div class="trending-title">Jujutsu Kaisen S2</div>
                         <div class="trending-info">Action, Fantasy</div>
                     </div>
                 </div>
                 <div class="trending-card">
                     <div class="trending-rank">2</div>
                     <img src="${pageContext.request.contextPath}/resources/animes/rezero.jpg" alt="Trending Anime 2 Poster" class="trending-poster" onerror="this.src='https://placehold.co/160x220/cccccc/ffffff?text=Err'">
                     <div class="trending-overlay">
                         <div class="trending-title">Frieren: Beyond Journey's End</div>
                         <div class="trending-info">Adventure, Fantasy</div>
                     </div>
                 </div>
                 <div class="trending-card">
                     <div class="trending-rank">3</div>
                     <img src="${pageContext.request.contextPath}/resources/animes/onepiece.jpg" alt="Trending Anime 3 Poster" class="trending-poster" onerror="this.src='https://placehold.co/160x220/cccccc/ffffff?text=Err'">
                     <div class="trending-overlay">
                         <div class="trending-title">One Piece</div>
                         <div class="trending-info">Action, Adventure</div>
                     </div>
                 </div>
                 </div>
        </div>

        <div class="dashboard-content">
            <div class="my-anime-list-container">
                 <div class="section-title section-title-padding">
                     <span>My Anime List</span>
                     </div>
                 <div style="overflow-x: auto;"> <table class="my-anime-table">
                         <thead>
                             <tr>
                                 <th>Image</th>
                                 <th>Title</th>
                                 <th>Score</th>
                                 <th>Progress</th>
                                 <th>Status</th>
                                 <th>Actions</th>
                             </tr>
                         </thead>
                         <tbody id="my-anime-list-body">
    <tr data-anime-id="101">
        <td class="anime-poster-cell">
            <img src="${pageContext.request.contextPath}/resources/animes/aot.webp" alt="Attack on Titan Poster">
        </td>
        <td class="title-cell">
            <span class="main-title">Attack on Titan: Final Season</span>
            <span class="alt-title">Shingeki no Kyojin</span>
        </td>
        <td class="score-cell">9.2</td>
        <td>8 / 12</td>
        <td><span class="status-badge status-watching">Watching</span></td>
        <td class="action-buttons">
            <button class="edit-btn" title="Edit Entry">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 3a2.85 2.83 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5Z"/><path d="m15 5 4 4"/></svg>
            </button>
            <button class="delete-btn" title="Delete Entry">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 6h18"/><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/><line x1="10" x2="10" y1="11" y2="17"/><line x1="14" x2="14" y1="11" y2="17"/></svg>
            </button>
        </td>
    </tr>
    <tr data-anime-id="102">
        <td class="anime-poster-cell">
            <img src="${pageContext.request.contextPath}/resources/animes/dandadan.jpg" alt="Dandadan Poster">
        </td>
        <td class="title-cell">
            <span class="main-title">Dandadan</span>
            <span class="alt-title">ダンダダン</span>
        </td>
        <td class="score-cell">9.1</td>
        <td>64 / 64</td>
        <td><span class="status-badge status-completed">Completed</span></td>
        <td class="action-buttons">
            <button class="edit-btn" title="Edit Entry">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 3a2.85 2.83 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5Z"/><path d="m15 5 4 4"/></svg>
            </button>
            <button class="delete-btn" title="Delete Entry">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 6h18"/><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/><line x1="10" x2="10" y1="11" y2="17"/><line x1="14" x2="14" y1="11" y2="17"/></svg>
            </button>
        </td>
    </tr>
    <tr data-anime-id="103">
        <td class="anime-poster-cell">
            <img src="${pageContext.request.contextPath}/resources/animes/bluelock.jpg" alt="Blue Lock Poster">
        </td>
        <td class="title-cell">
            <span class="main-title">Blue Lock</span>
            <span class="alt-title">ブルーロック</span>
        </td>
        <td class="score-cell">8.7</td>
        <td>24 / 24</td>
        <td><span class="status-badge status-completed">Completed</span></td>
        <td class="action-buttons">
            <button class="edit-btn" title="Edit Entry">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 3a2.85 2.83 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5Z"/><path d="m15 5 4 4"/></svg>
            </button>
            <button class="delete-btn" title="Delete Entry">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 6h18"/><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/><line x1="10" x2="10" y1="11" y2="17"/><line x1="14" x2="14" y1="11" y2="17"/></svg>
            </button>
        </td>
    </tr>
    <tr data-anime-id="104">
        <td class="anime-poster-cell">
            <img src="${pageContext.request.contextPath}/resources/animes/onepiece.jpg" alt="One Piece Poster">
        </td>
        <td class="title-cell">
            <span class="main-title">One Piece</span>
            <span class="alt-title">ワンピース</span>
        </td>
        <td class="score-cell">9.5</td>
        <td>1080 / -</td>
        <td><span class="status-badge status-watching">Watching</span></td>
        <td class="action-buttons">
            <button class="edit-btn" title="Edit Entry">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 3a2.85 2.83 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5Z"/><path d="m15 5 4 4"/></svg>
            </button>
            <button class="delete-btn" title="Delete Entry">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 6h18"/><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/><line x1="10" x2="10" y1="11" y2="17"/><line x1="14" x2="14" y1="11" y2="17"/></svg>
            </button>
        </td>
    </tr>
    <tr data-anime-id="105">
        <td class="anime-poster-cell">
            <img src="${pageContext.request.contextPath}/resources/animes/angelbeats.webp" alt="Angel Beats Poster">
        </td>
        <td class="title-cell">
            <span class="main-title">Angel Beats!</span>
            <span class="alt-title">エンジェルビーツ</span>
        </td>
        <td class="score-cell">8.3</td>
        <td>13 / 13</td>
        <td><span class="status-badge status-completed">Completed</span></td>
        <td class="action-buttons">
            <button class="edit-btn" title="Edit Entry">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 3a2.85 2.83 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5Z"/><path d="m15 5 4 4"/></svg>
            </button>
            <button class="delete-btn" title="Delete Entry">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 6h18"/><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/><line x1="10" x2="10" y1="11" y2="17"/><line x1="14" x2="14" y1="11" y2="17"/></svg>
            </button>
        </td>
    </tr>
</tbody>
                     </table>
                 </div>
                 <div class="table-pagination">
                     <div>Showing 1-5 of 313 entries</div>
                     <div class="pagination-buttons">
                         <button disabled>&lt; Prev</button>
                         <button>Next &gt;</button>
                     </div>
                 </div>
            </div>

            <div class="side-content">
                <div class="recommendations">
                    <div class="section-title">
                        <span>Recommendations For You</span>
                    </div>
                    <div class="recommendation-items">
                        <a href="#" class="recommendation-item">
                            <img src="${pageContext.request.contextPath}/resources/animes/rezero.jpg" alt="Re:Zero" class="recommendation-poster">
                            <div class="recommendation-details">
                                <div class="recommendation-title">Re:Zero</div>
                                <div class="recommendation-info">Fantasy, Thriller</div>
                            </div>
                        </a>
                        <a href="#" class="recommendation-item">
                            <img src="${pageContext.request.contextPath}/resources/animes/comdey.avif" alt="Grand Blue" class="recommendation-poster">
                            <div class="recommendation-details">
                                <div class="recommendation-title">Grand Blue</div>
                                <div class="recommendation-info">Comedy, Slice of Life</div>
                            </div>
                        </a>
                        <a href="#" class="recommendation-item">
                            <img src="${pageContext.request.contextPath}/resources/animes/action.jpg" alt="Jujutsu Kaisen" class="recommendation-poster">
                            <div class="recommendation-details">
                                <div class="recommendation-title">Jujutsu Kaisen</div>
                                <div class="recommendation-info">Action, Supernatural</div>
                            </div>
                        </a>
                    </div>
                </div>

                <div class="seasonal-anime">
                    <div class="seasonal-header">
                         <div class="section-title" style="border: none; padding-bottom: 0; margin-bottom: 0;">
                             <span>Seasonal Charts</span>
                         </div>
                         <div class="season-tabs">
                            <button class="season-tab active">Winter 2025</button>
                            <button class="season-tab">Fall 2024</button>
                        </div>
                    </div>
                    <div class="seasonal-grid">
                        <a href="#" class="seasonal-card">
                            <img src="${pageContext.request.contextPath}/resources/animes/action.jpg" alt="Action Anime" class="seasonal-img">
                            <div class="seasonal-overlay">Jujutsu Kaisen S2</div>
                        </a>
                        <a href="#" class="seasonal-card">
                            <img src="${pageContext.request.contextPath}/resources/animes/fantasy.avif" alt="Fantasy Anime" class="seasonal-img">
                            <div class="seasonal-overlay">Frieren</div>
                        </a>
                        <a href="#" class="seasonal-card">
                            <img src="${pageContext.request.contextPath}/resources/animes/romance.jpg" alt="Romance Anime" class="seasonal-img">
                            <div class="seasonal-overlay">Horimiya: Piece</div>
                        </a>
                        <a href="#" class="seasonal-card">
                            <img src="${pageContext.request.contextPath}/resources/animes/sifi.jpg" alt="Sci-Fi Anime" class="seasonal-img">
                            <div class="seasonal-overlay">Dr. Stone S3</div>
                        </a>
                    </div>
                     <a href="#" class="view-all" style="display: block; text-align: right; margin-top: 15px;">View Full Chart</a>
                </div>
            </div> </div> <div class="recently-completed">
             <div class="section-title">
                 <span>Recently Completed</span>
                 <a href="#" class="view-all">View History</a>
             </div>
             <div class="recently-grid">
                 <a href="#" class="recently-card">
                     <img src="${pageContext.request.contextPath}/resources/animes/darling.avif" alt="Recently Completed 1 Poster" class="recently-poster" onerror="this.src='https://placehold.co/200x180/cccccc/ffffff?text=Err'">
                     <div class="recently-details">
                         <div class="recently-title">Fullmetal Alchemist: Brotherhood</div>
                         <div class="recently-info">Finished 2 days ago</div>
                         <span class="recently-score">⭐ 9.1</span>
                     </div>
                 </a>
                 <a href="#" class="recently-card">
                     <img src="${pageContext.request.contextPath}/resources/animes/drama.jpg" alt="Recently Completed 2 Poster" class="recently-poster" onerror="this.src='https://placehold.co/200x180/cccccc/ffffff?text=Err'">
                     <div class="recently-details">
                         <div class="recently-title">Steins;Gate</div>
                         <div class="recently-info">Finished last week</div>
                          <span class="recently-score">⭐ 9.0</span>
                     </div>
                 </a>
                 </div>
        </div>

    </div> <footer class="footer">
        <div class="footer-content">
            <div class="footer-links">
                <a href="#">About Us</a>
                <a href="#">Contact</a>
                <a href="#">Terms of Service</a>
                <a href="#">Privacy Policy</a>
                <a href="#">FAQ</a>
                <a href="#">API</a>
            </div>
            <div class="footer-copyright">
                &copy; 2025 aniverse. All Rights Reserved. Built with ❤️ for Anime Fans.
            </div>
        </div>
    </footer>

    <script>
        // Get the table body for the main anime list
        const myAnimeListBody = document.getElementById('my-anime-list-body');

        // Add event listener to the table body (event delegation)
        if (myAnimeListBody) {
            myAnimeListBody.addEventListener('click', function(event) {
                // Find the closest button that was clicked
                const button = event.target.closest('button');
                if (!button) return; // Exit if the click wasn't on a button

                // Find the table row associated with the button
                const row = button.closest('tr');
                if (!row) return; // Exit if couldn't find the row

                const animeId = row.dataset.animeId; // Get the anime ID from data attribute
                const animeTitle = row.querySelector('.main-title')?.textContent || 'this anime'; // Get title for messages

                // Handle Edit Button Click
                if (button.classList.contains('edit-btn')) {
                    console.log(`Edit button clicked for anime ID: ${animeId} (${animeTitle})`);
                    // In a real app, you would open an edit modal or form here,
                    // pre-filled with data for this animeId.
                    alert(`Simulating EDIT action for: ${animeTitle} (ID: ${animeId})\n\n(In a real app, this would open an edit form)`);
                }

                // Handle Delete Button Click
                if (button.classList.contains('delete-btn')) {
                    console.log(`Delete button clicked for anime ID: ${animeId} (${animeTitle})`);
                    // Confirm deletion
                    if (confirm(`Are you sure you want to remove "${animeTitle}" (ID: ${animeId}) from your list?`)) {
                        // Remove the row from the table visually
                        row.style.opacity = '0'; // Start fade out effect
                        row.style.transition = 'opacity 0.4s ease-out, transform 0.4s ease-out';
                        row.style.transform = 'translateX(50px)'; // Optional: slide out effect

                        setTimeout(() => {
                            row.remove();
                            // In a real app, you would also send a DELETE request to your Java backend API here
                            // using fetch() or similar, passing the animeId.
                            console.log(`Anime ID: ${animeId} removed from view.`);
                            alert(`"${animeTitle}" (ID: ${animeId}) has been removed from the list.\n\n(In a real app, this action would be saved to the database)`);
                            // Optional: Update stats cards if needed
                        }, 400); // Wait for fade/slide out animation
                    }
                }
            });
        } else {
            console.error("Element with ID 'my-anime-list-body' not found.");
        }
    </script>

</body>
</html>
