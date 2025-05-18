<%-- Import JSTL Core and Formatting libraries --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> <%-- Optional: for functions like length --%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Anime - AnimeTracker</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/animelist.css">
</head>
<body>
    <%-- Assumes you have set request attributes in your Servlet like:
         request.setAttribute("animeList", listOfAnimeObjects);
         request.setAttribute("genres", listOfGenreStrings); // For filter dropdown
         request.setAttribute("years", listOfYearIntegers); // For filter dropdown
         request.setAttribute("selectedGenre", currentlySelectedGenre); // To keep filter selection
         request.setAttribute("selectedStatus", currentlySelectedStatus);
         request.setAttribute("selectedYear", currentlySelectedYear);
         request.setAttribute("selectedSort", currentlySelectedSort);
         request.setAttribute("searchTerm", currentSearchTerm);
         request.setAttribute("currentPage", currentPageNumber);
         request.setAttribute("totalPages", totalNumberOfPages);
    --%>

    <div class="background-characters"></div>

    <nav class="navbar">
        <div class="logo">
            <%-- Assuming logo source is static or handled elsewhere --%>
            <img id="nav-logo-preview" src="https://placehold.co/40x40/5d5fef/ffffff?text=AT" alt="AnimeTracker Logo" onerror="this.src='https://placehold.co/40x40/cccccc/ffffff?text=Logo'">
        </div>
        <div class="nav-links">
            <%-- Construct URLs using JSTL's c:url for context path handling --%>
            <a href="<c:url value='/dashboard'/>">Home</a> <%-- Example link to a dashboard servlet --%>
            <a href="<c:url value='/browse'/>" class="active">Anime</a> <%-- Assuming this page is mapped to /browse --%>
            <a href="#">Manga</a>
            <a href="#">Community</a>
            <a href="#">News</a>
        </div>
        <%-- Button to open profile modal (modal HTML/JS needs to be included) --%>
        <button id="open-profile-modal-btn" class="profile-btn">MY PROFILE</button>
    </nav>

    <div class="container">
        
        <jsp:include page="/WEB-INF/components/header.jsp" />
        
        <%-- Filters form - submits back to the browse servlet/JSP --%>
        <form action="<c:url value='/animelist'/>" method="get">
            <section class="filters-sort-section">
                <div class="filter-group">
                    <label for="search-term">Search Title</label>
                    <%-- Use param.searchTerm to retain value after submit --%>
                    <input type="text" id="search-term" name="searchTitle" placeholder="e.g., Attack on Titan" value="${param.searchTitle}">
                </div>
                <%-- Include message display component at the top of your page --%>

                <div class="filter-group">
                    <label for="genre-filter">Genre</label>
                    <select id="genre-filter" name="genre">
                        <option value="">All Genres</option>
                        <%-- Example of dynamic genre options (assumes 'genresList' attribute exists) --%>
                        <c:forEach var="genre" items="${genresList}">
                            <option value="${genre}" ${param.genre == genre ? 'selected' : ''}>
                                <c:out value="${genre}"/>
                            </option>
                        </c:forEach>
                        <%-- Fallback static options if dynamic list is not provided --%>
                        <c:if test="${empty genresList}">
                            <option value="action" ${param.genre == 'action' ? 'selected' : ''}>Action</option>
                            <option value="adventure" ${param.genre == 'adventure' ? 'selected' : ''}>Adventure</option>
                            <option value="comedy" ${param.genre == 'comedy' ? 'selected' : ''}>Comedy</option>
                            <option value="drama" ${param.genre == 'drama' ? 'selected' : ''}>Drama</option>
                            <option value="fantasy" ${param.genre == 'fantasy' ? 'selected' : ''}>Fantasy</option>
                            <option value="sci-fi" ${param.genre == 'sci-fi' ? 'selected' : ''}>Sci-Fi</option>
                             <option value="romance" ${param.genre == 'romance' ? 'selected' : ''}>Romance</option>
                        </c:if>
                    </select>
                </div>
                 <div class="filter-group">
                    <label for="status-filter">Status</label>
                    <select id="status-filter" name="status">
                        <option value="">All Statuses</option>
                        <%-- Use param.status to retain value after submit --%>
                        <option value="airing" ${param.status == 'airing' ? 'selected' : ''}>Currently Airing</option>
                        <option value="completed" ${param.status == 'completed' ? 'selected' : ''}>Finished Airing</option>
                        <option value="upcoming" ${param.status == 'upcoming' ? 'selected' : ''}>Not Yet Aired</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="year-filter">Year</label>
                     <select id="year-filter" name="year">
                        <option value="">All Years</option>
                         <%-- Example of dynamic year options (assumes 'yearsList' attribute exists) --%>
                        <c:forEach var="year" items="${yearsList}">
                            <option value="${year}" ${param.year == year ? 'selected' : ''}>
                                <c:out value="${year}"/>
                            </option>
                        </c:forEach>
                         <%-- Fallback static options --%>
                         <c:if test="${empty yearsList}">
						    <option value="2025" ${param.year == '2025' ? 'selected' : ''}>2025</option>
						    <option value="2024" ${param.year == '2024' ? 'selected' : ''}>2024</option>
						    <option value="2023" ${param.year == '2023' ? 'selected' : ''}>2023</option>
						    <option value="2022" ${param.year == '2022' ? 'selected' : ''}>2022</option>
						    <option value="2021" ${param.year == '2021' ? 'selected' : ''}>2021</option>
						    <option value="2020" ${param.year == '2020' ? 'selected' : ''}>2020</option>
						    <option value="2019" ${param.year == '2019' ? 'selected' : ''}>2019</option>
						    <option value="2018" ${param.year == '2018' ? 'selected' : ''}>2018</option>
						    <option value="2017" ${param.year == '2017' ? 'selected' : ''}>2017</option>
						    <option value="2016" ${param.year == '2016' ? 'selected' : ''}>2016</option>
						    <option value="2015" ${param.year == '2015' ? 'selected' : ''}>2015</option>
						    <option value="2014" ${param.year == '2014' ? 'selected' : ''}>2014</option>
						    <option value="2013" ${param.year == '2013' ? 'selected' : ''}>2013</option>
						    <option value="2012" ${param.year == '2012' ? 'selected' : ''}>2012</option>
						    <option value="2011" ${param.year == '2011' ? 'selected' : ''}>2011</option>
						    <option value="2010" ${param.year == '2010' ? 'selected' : ''}>2010</option>
						    <option value="2009" ${param.year == '2009' ? 'selected' : ''}>2009</option>
						    <option value="2008" ${param.year == '2008' ? 'selected' : ''}>2008</option>
						    <option value="2007" ${param.year == '2007' ? 'selected' : ''}>2007</option>
						    <option value="2006" ${param.year == '2006' ? 'selected' : ''}>2006</option>
						    <option value="2005" ${param.year == '2005' ? 'selected' : ''}>2005</option>
						    <option value="2004" ${param.year == '2004' ? 'selected' : ''}>2004</option>
						    <option value="2003" ${param.year == '2003' ? 'selected' : ''}>2003</option>
						    <option value="2002" ${param.year == '2002' ? 'selected' : ''}>2002</option>
						    <option value="2001" ${param.year == '2001' ? 'selected' : ''}>2001</option>
						    <option value="2000" ${param.year == '2000' ? 'selected' : ''}>2000</option>
						    <option value="1999" ${param.year == '1999' ? 'selected' : ''}>1999</option>
						    <option value="1998" ${param.year == '1998' ? 'selected' : ''}>1998</option>
							<option value="1997" ${param.year == '1997' ? 'selected' : ''}>1997</option>
							<option value="1996" ${param.year == '1996' ? 'selected' : ''}>1996</option>
							<option value="1995" ${param.year == '1995' ? 'selected' : ''}>1995</option>
							<option value="1994" ${param.year == '1994' ? 'selected' : ''}>1994</option>
							<option value="1993" ${param.year == '1993' ? 'selected' : ''}>1993</option>
							<option value="1992" ${param.year == '1992' ? 'selected' : ''}>1992</option>
							<option value="1991" ${param.year == '1991' ? 'selected' : ''}>1991</option>
							<option value="1990" ${param.year == '1990' ? 'selected' : ''}>1990</option>
						</c:if>
                    </select>
                </div>
               
                <div class="filter-actions">
                    <button style="margin-top: 20px" type="submit">Apply Filters</button>
                </div>
            </section>
        </form> <%-- End of filters form --%>
<section class="anime-grid" id="anime-grid-results">
    <c:choose>
        <c:when test="${not empty animes}">
            <c:forEach var="anime" items="${animes}">
                <div class="anime-card">
                    <img src="${pageContext.request.contextPath}/resources/animecover/${anime.title}.jpg"
                         alt="Poster for ${anime.title}"
                         class="anime-card-poster"
                         onerror="this.onerror=null; this.src='https://placehold.co/250x350/cccccc/ffffff?text=Load+Error';">

                    <div class="anime-card-content">
                        <h3 class="anime-card-title" title="${anime.title}">
                            <c:out value="${anime.title}"/>
                        </h3>
                        <div class="anime-card-info">
                            <c:choose>
                                <c:when test="${not empty anime.score and anime.score > 0}">
                                    <span class="score">${anime.score}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="score no-score">N/A</span>
                                </c:otherwise>
                            </c:choose>
                            <c:if test="${not empty anime.type}">
                                <span class="type"><c:out value="${anime.type}"/></span>
                            </c:if>
                            <c:choose>
                                <c:when test="${not empty anime.episodes and anime.episodes > 0}">
                                    <span><c:out value="${anime.episodes}"/> Eps</span>
                                </c:when>
                                <c:when test="${not empty anime.type and anime.type == 'Movie'}">
                                </c:when>
                                <c:otherwise>
                                    <span>? Eps</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="anime-card-actions">
                            <a href="<c:url value='/anime/details?id=${anime.animeId}'/>" class="action-btn details-btn">View Details</a>
                            
                            <%-- Button to trigger the modal --%>
                            <c:if test="${not empty sessionScope.user}">
                                <button type="button" class="action-btn add-btn" 
                                        onclick="openAddToListModal('${anime.animeId}', '${anime.title}', '${anime.episodes}')">
                                    Add/Edit List
                                </button>
                            </c:if>
                            <c:if test="${empty sessionScope.user}">
                                 <a href="<c:url value='/login'/>" class="action-btn add-btn">Login to Add</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p class="no-results-message">
                No anime found matching your criteria. Try adjusting the filters!
            </p>
        </c:otherwise>
    </c:choose>
</section>
<div id="addToListModal" class="modal">
    <div class="modal-content">
        <span class="close-button" onclick="closeAddToListModal()">&times;</span>
        <h3 id="modalTitle">Add/Edit Anime</h3>
        <form id="modalForm" action="<c:url value='/user/add-list'/>" method="post">
            <input type="hidden" name="animeId" id="modalAnimeId">
            
            <div class="modal-form-group">
                <label for="modalWatchStatus">Status:</label>
                <select name="watchStatus" id="modalWatchStatus" class="watch-status-select">
                    <option value="Plan to Watch">Plan to Watch</option>
                    <option value="Watching">Watching</option>
                    <option value="Completed">Completed</option>
                    <option value="On Hold">On Hold</option>
                    <option value="Dropped">Dropped</option>
                </select>
            </div>

            <div class="modal-form-group">
                <label for="modalUserScore">Your Score (0-10):</label>
                <input type="number" name="userScore" id="modalUserScore" step="0.1" min="0" max="9.99" placeholder="e.g., 7.5">
            </div>

            <div class="modal-form-group">
                <label for="modalProgress">Progress (Episodes Watched):</label>
                <input type="number" name="progress" id="modalProgress" min="0" placeholder="e.g., 5">
                <small id="modalProgressHelper"></small>
            </div>
            
            <div class="modal-form-group">
                <label for="modalNotes">Notes:</label>
                <textarea name="notes" id="modalNotes" rows="3" placeholder="Any personal notes..."></textarea>
            </div>
            
            <div class="modal-form-actions">
                <button type="button" class="action-btn" onclick="closeAddToListModal()">Cancel</button>
                <button type="submit" class="action-btn add-btn" id="modalSubmitButton">Save to List</button>
            </div>
        </form>
    </div>
</div>

        <%-- Assumes 'currentPage', 'totalPages', and filter parameters are available --%>
  


    </div> 
     <jsp:include page="/WEB-INF/components/footer.jsp" />

    <%-- Include Profile Modal HTML here if needed --%>
    <%-- <jsp:include page="/WEB-INF/views/partials/profileModal.jsp" /> --%>

    <script>
        // Remove static JS simulations for filters and pagination as they are now handled by form submission/links
        // Keep JS for Add to List / View Details button clicks if needed for client-side feedback (optional)

        const animeGridResults = document.getElementById('anime-grid-results');
        if (animeGridResults) {
            animeGridResults.addEventListener('click', (event) => {
                // Handle clicks on dynamically generated buttons if needed
                // Example: Provide immediate feedback for "Add to List" before page reload/AJAX response
                const targetButton = event.target.closest('.action-btn.add-btn');
                if (targetButton && targetButton.tagName === 'BUTTON') { // Ensure it's the button inside the form
                     const card = targetButton.closest('.anime-card');
                     const title = card ? card.querySelector('.anime-card-title').textContent : 'Selected Anime';
                     console.log(`Add to list clicked for: ${title}`);
                     // Optionally disable button briefly or show a spinner
                     // The actual addition happens via the form submission
                }

                 const detailsButton = event.target.closest('.action-btn.details-btn');
                 if(detailsButton && detailsButton.tagName === 'A') {
                     console.log('View details clicked, navigating via link.');
                     // Navigation handled by the href in the <a> tag
                 }
            });
        }

        // --- Profile Modal JS (Keep if Profile Modal HTML is included) ---
        const openModalBtn = document.getElementById('open-profile-modal-btn');
        // Add the rest of the profile modal JS here if the modal HTML is part of this page.
        // Example:
        if (openModalBtn) {
            openModalBtn.addEventListener('click', () => {
                // Code to find and display the profile modal
                alert("Profile button clicked! (Profile modal JS needs to be present)");
            });
        }
        var modal = document.getElementById('addToListModal');
        var modalForm = document.getElementById('modalForm');
        var modalAnimeIdInput = document.getElementById('modalAnimeId');
        var modalTitleElement = document.getElementById('modalTitle');
        var modalWatchStatusInput = document.getElementById('modalWatchStatus');
        var modalUserScoreInput = document.getElementById('modalUserScore');
        var modalProgressInput = document.getElementById('modalProgress');
        var modalProgressHelper = document.getElementById('modalProgressHelper');
        var modalNotesInput = document.getElementById('modalNotes');
        var modalSubmitButton = document.getElementById('modalSubmitButton'); // Get the submit button

        async function openAddToListModal(animeId, animeTitle, totalEpisodes) {
            modalAnimeIdInput.value = animeId;
            modalTitleElement.textContent = 'Manage: ' + animeTitle; // Changed title slightly
            
            // Reset form to default values first
            modalForm.reset(); 
            modalSubmitButton.textContent = 'Save to List'; // Default button text
            modalUserScoreInput.value = ''; // Explicitly clear potentially problematic fields
            modalProgressInput.value = '';
            modalNotesInput.value = '';


            if (totalEpisodes && totalEpisodes !== '0' && totalEpisodes !== '?' && !isNaN(parseInt(totalEpisodes))) {
                modalProgressInput.max = totalEpisodes;
                modalProgressHelper.textContent = 'Total episodes: ' + totalEpisodes;
            } else {
                modalProgressInput.removeAttribute('max');
                modalProgressHelper.textContent = totalEpisodes === '?' ? 'Total episodes: Unknown' : '';
            }

            // Fetch existing data
            try {
                // Note: Ensure your context path is handled correctly if this JSP is not at the root.
                // Using a root-relative path for the API call.
                const response = await fetch(`${pageContext.request.contextPath}/user/api/entry-details?animeId=${animeId}`);
                
                if (response.ok) {
                    const data = await response.json();
                    if (data && Object.keys(data).length > 0 && !data.error) { // Check if data is not empty and not an error object
                    	 alert("Anime added successfully!");
                        modalWatchStatusInput.value = data.watchStatus || 'Plan to Watch';
                        modalUserScoreInput.value = data.userScore !== null ? data.userScore : '';
                        modalProgressInput.value = data.progress !== null ? data.progress : '';
                        modalNotesInput.value = data.notes || '';
                        modalSubmitButton.textContent = 'Update List'; // Change button text if editing
                       
                    } else if (data.error) {
                         console.warn('Error fetching entry details:', data.error);
                         // Keep form blank, default button text
                    }
                    // If response is OK but data is empty (e.g. {}), it means no entry exists, so form remains blank.
                } else {
                    console.error('Failed to fetch user anime data, status:', response.status);
                    // Optionally show a user-facing error message here
                    // For now, just let the form be blank.
                }
            } catch (error) {
                console.error('Error fetching user anime data:', error);
                // Optionally show a user-facing error message here
            }

            modal.style.display = "block";

            // Add alert when the modal is opened
            alert(`You are adding anime to your list.`);
        }

        function closeAddToListModal() {
            modal.style.display = "none";
        }

        window.onclick = function(event) {
            if (event.target == modal) {
                closeAddToListModal();
            }
        }

        // Optional: If you want to clear the form explicitly when the modal is closed
        // (though reset on open is generally good enough)
        // modal.addEventListener('transitionend', () => {
        //    if (modal.style.display === 'none') {
        //        modalForm.reset();
        //    }
        // });

    </script>

</body>
</html>
