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
.update-form {
  display: none;
  position: absolute;
  top: 3%;
  right: 0%;
  background: linear-gradient(135deg, #2b3054, #1e2238); /* darker bluish gradient */
  padding: 20px 30px;
  border-radius: 10px;
  box-shadow: 0 8px 16px rgba(0,0,0,0.3);
  width: 700px;
  height: 90%;
  z-index: 1000;
  font-family: Arial, sans-serif;
  color: white;
}

/* Style inputs */
.update-form input[type="text"],
.update-form input[type="number"] {
  width: calc(100% - 20px);
  margin: 8px 0;
  padding: 8px 10px;
  border: 1px solid rgba(255, 255, 255, 0.4);z
  border-radius: 5px;
  font-size: 14px;
  box-sizing: border-box;
  background-color: rgba(255, 255, 255, 0.1);
  color: white;
}

.update-form input::placeholder {
  color: rgba(255, 255, 255, 0.6);
}

/* Style buttons */
.update-form button {
  background-color: #4a90e2;
  color: white;
  border: none;
  padding: 10px 16px;
  margin-top: 12px;
  border-radius: 5px;
  cursor: pointer;
  font-size: 15px;
  transition: background-color 0.3s ease;
}

.update-form button:hover {
  background-color: #357ab8;
}

.update-form .cancel-btn {
  background-color: #dc3545;
  margin-left: 10px;
}

.update-form .cancel-btn:hover {
  background-color: #a71d2a;
}

.update-form form {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.update-form .form-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 10px;
}

.update-form label {
  flex: 0 0 80px;
  font-weight: bold;
  font-size: 14px;
  color: white;
}

.update-form .form-grid {
  height: 50px;
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 12px;
  align-items: center;
}

.update-form .form-grid label {
  font-weight: bold;
  font-size: 14px;
  color: white;
}

.update-form .form-grid input[type="text"],
.update-form .form-grid input[type="number"] {
  width: 100%;
  padding: 8px 10px;
  border: 1px solid rgba(255, 255, 255, 0.4);
  border-radius: 5px;
  font-size: 14px;
  box-sizing: border-box;
  background-color: rgba(255, 255, 255, 0.1);
  color: white;
}

.update-form .grid-buttons {
  display: flex;
  gap: 10px;
  justify-content: flex-start;
}
.edit-btn {
  background: transparent;
  border: none;
  color: inherit;       /* keep icon/text color from parent */
  cursor: pointer;
  padding: 0;           /* remove extra space if you want */
  font-size: 1.2em;     /* adjust icon size if needed */
  display: inline-flex; /* optional: for better control of icon alignment */
  align-items: center;  /* center vertically */
  gap: 4px;             /* space between icons/text */
}
  
  .delete-btn{
  background: transparent;
  border: none;
  color: inherit;       /* keep icon/text color from parent */
  cursor: pointer;
  padding: 0;           /* remove extra space if you want */
  font-size: 1.2em;     /* adjust icon size if needed */
  display: inline-flex; /* optional: for better control of icon alignment */
  align-items: center;  /* center vertically */
  gap: 4px;             /* space between icons/text */
} 
    </style>
</head>
<body>
    <div class="background-characters"></div>
    <img src="${pageContext.request.contextPath}/resources/system/anime_girl_1.jpg" alt="Floating anime character 1" class="floating-images floating-1" onerror="this.style.display='none'">
    <img src="${pageContext.request.contextPath}/resources/system/anime_girl_2.jpg" alt="Floating anime character 2" class="floating-images floating-2" onerror="this.style.display='none'">
    <img src="${pageContext.request.contextPath}/resources/system/anime_girl_1.jpg" alt="Floating anime character 3" class="floating-images floating-3" onerror="this.style.display='none'">
    <img src="${pageContext.request.contextPath}/resources/system/anime_girl_2.jpg" alt="Floating anime character 4" class="floating-images floating-4" onerror="this.style.display='none'">

      <jsp:include page="/WEB-INF/components/header.jsp" />

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
                <div class="stat-number">${totalAnime}</div>
                <div class="stat-label">Total Anime</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">${watching}</div>
                <div class="stat-label">Watching</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">${completed}</div>
                <div class="stat-label">Completed</div>
            </div>
             <div class="stat-card">
                <div class="stat-number">${planToWatch}</div>
                <div class="stat-label">Plan to Watch</div>
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
                                 <th> </th>
                             </tr>
                         </thead>
                        	<tbody id="my-anime-list-body">
    <c:forEach var="anime" items="${animeList}">
        <tr style="height:150px">
            <td class="anime-poster-cell">
                <img src="${pageContext.request.contextPath}/resources/animecover/${anime.title}.jpg" 
                     onerror="this.src='${pageContext.request.contextPath}/resources/animes/default.jpg'" 
                     alt="${anime.title} Poster">
            </td>
            <td class="title-cell">
                <span class="main-title">${anime.title}</span>
                <span class="alt-title">${anime.type} - ${anime.season}</span>
            </td>
            <td class="score-cell">
                <c:choose>
                    <c:when test="${anime.userScore != null}">${anime.userScore}</c:when>
                    <c:otherwise>-</c:otherwise>
                </c:choose>
            </td>
            <td>
                ${anime.progress} / 
                <c:choose>
                    <c:when test="${anime.episodes != null}">${anime.episodes}</c:when>
                    <c:otherwise>-</c:otherwise>
                </c:choose>
            </td>
            <td>
                <span class="status-badge status-${anime.watchStatus.toLowerCase()}">${anime.watchStatus}</span>
            </td>
            <td style="position: relative;">
            <form action="${pageContext.request.contextPath}/dashboard" method="post">
							      <input type="hidden" name="action" value="deleteAnimeEntry">
							      <input type="hidden" name="entryId" value="${anime.entryId}">
							      <button type="submit" class="delete-btn">🗑️</button>
							    </form>
							    <br>
			 <button class="edit-btn">✏️</button>
					<div class="update-form" style="display: none;">
					  <form action="${pageContext.request.contextPath}/dashboard" method="post">
					    <input type="hidden" name="action" value="updateAnimeEntry">
					    <input type="hidden" name="entryId" value="${anime.entryId}">
					
					    <div class="form-grid">
					      <!-- Row 1: Labels -->
					      <label>Status</label>
					      <label>Score</label>
					      <label>Progress</label>
					      <div></div> <!-- empty cell for alignment -->
					
					      <!-- Row 2: Inputs -->
					      <input type="text" name="watchStatus" value="${anime.watchStatus}" placeholder="Status">
					      <input 
							  type="number" 
							  name="userScore" 
							  value="${anime.userScore}" 
							  placeholder="Score" 
							  step="0.1" 
							  min="0"
							  max="9.99"
							/>
							
							<input 
							  type="number" 
							  name="progress" 
							  value="${anime.progress}" 
							  placeholder="Progress" 
							  min="0" 
							  max="${anime.episodes != null ? anime.episodes : ''}" 
							/>
					      
					      <!-- Buttons -->
					      <div class="grid-buttons">
					        <button type="submit">Update</button>
					        <button type="button" class="cancel-btn">Cancel</button>
					      </div>
					    </div>
					  </form>
					</div>


            <td>
                
                	         
                
             </td>
           
                <!-- Delete Form -->
            
        </tr>
    </c:forEach>
</tbody>
                     </table>
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

    </div>
     <jsp:include page="/WEB-INF/components/footer.jsp" />

    <!-- Modal for editing anime -->


    <script>
    document.addEventListener('click', function(event) {
        if (event.target.classList.contains('edit-btn')) {
            const updateForm = event.target.nextElementSibling;
            updateForm.style.display = 'block';
        }
        
    });
    document.addEventListener("DOMContentLoaded", function () {
        const cancelBtns = document.querySelectorAll(".cancel-btn");

        cancelBtns.forEach(btn => {
          btn.addEventListener("click", () => {
            btn.closest(".update-form").style.display = "none";
          });
        });
      });
    document.addEventListener("DOMContentLoaded", function () {
        const cancelBtns = document.querySelectorAll(".edit-btn");

        cancelBtns.forEach(btn => {
          btn.addEventListener("click", () => {
            btn.closest(".update-form").style.display = "block";
          });
        });
      });
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
                   
                }

                // Handle Delete Button Click
                if (button.classList.contains('delete-btn')) {
                    console.log(`Delete button clicked for anime ID: ${animeId} (${animeTitle})`);
                    // Confirm deletion
                    if (confirm(`Are you sure you want to remove the anime from your list?`)) {
                        // Remove the row from the table visually
                        row.style.opacity = '0'; // Start fade out effect
                        row.style.transition = 'opacity 0.4s ease-out, transform 0.4s ease-out';
                        row.style.transform = 'translateX(50px)'; // Optional: slide out effect

                        setTimeout(() => {
                            row.remove();
                            // In a real app, you would also send a DELETE request to your Java backend API here
                            // using fetch() or similar, passing the animeId.
                            console.log(`Anime ID: ${animeId} removed from view.`);
                            
                            // Optional: Update stats cards if needed
                        }, 400); // Wait for fade/slide out animation
                    }
                }
            });
        } else {
            console.error("Element with ID 'my-anime-list-body' not found.");
        }

        let selectedAnimeId = null;




   
    </script>

</body>
</html>
