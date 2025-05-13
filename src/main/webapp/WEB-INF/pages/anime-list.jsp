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
    <style>
        /* Basic Reset and Font (Same as dashboard) */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Body Styling (Same as dashboard) */
        body {
            background: linear-gradient(135deg, #1c203b 0%, #2b2f54 50%, #1c203b 100%);
            color: #ffffff;
            background-attachment: fixed;
        }

        /* Navbar Styling (Same as dashboard) */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 40px;
            background: linear-gradient(90deg, #252a4a 0%, #383f71 50%, #252a4a 100%);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .logo img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
        }

        .nav-links {
            display: flex;
            gap: 30px;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            position: relative;
            padding-bottom: 5px;
            transition: color 0.3s ease;
        }

        .nav-links a:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background: linear-gradient(90deg, #5d5fef, #8a5fed);
            transition: width 0.3s ease;
        }
        /* Use JSTL to set active class if needed, e.g., based on page context */
        /* Example: <a href="#" class="${pageContext.request.requestURI.endsWith('/browse.jsp') ? 'active' : ''}">Anime</a> */
        .nav-links a.active,
        .nav-links a:hover {
            color: #c0c0ff;
        }
        .nav-links a.active:after,
        .nav-links a:hover:after {
            width: 100%;
        }


        .profile-btn {
            background: linear-gradient(90deg, #5d5fef 0%, #8a5fed 100%);
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s ease;
        }

        .profile-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(93, 95, 239, 0.4);
        }

        /* Main Container (Same as dashboard) */
        .container {
            max-width: 1300px; /* Slightly wider for browse page */
            margin: 30px auto;
            padding: 0 20px;
            position: relative;
        }
        /* Background Character Image (Subtle - Same as dashboard) */
        .background-characters {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            opacity: 0.05;
            z-index: -1;
            background-image: url('https://placehold.co/1920x1080/1c203b/333333?text=Subtle+BG'); /* Consider making this dynamic or removing if not needed */
            background-size: cover;
            background-repeat: no-repeat;
        }

        /* Page Header */
        .page-header {
        margin-top:60px;
            text-align: center;
            margin-bottom: 30px;
        }
        .page-header h1 {
            font-size: 32px;
            font-weight: bold;
            background: linear-gradient(90deg, #ffffff, #a0a0ff);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 2px 10px rgba(255, 255, 255, 0.1);
            margin-bottom: 10px;
        }
        .page-header p {
            font-size: 16px;
            color: #a0a0e0;
        }

        /* Filters and Sort Section */
        .filters-sort-section {
            background: linear-gradient(135deg, rgba(37, 42, 74, 0.7) 0%, rgba(50, 56, 101, 0.7) 100%);
            backdrop-filter: blur(5px);
            padding: 20px 25px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            align-items: center;
            justify-content: space-between;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
            min-width: 150px; /* Minimum width for filter groups */
            flex-grow: 1; /* Allow groups to grow */
        }

        .filter-group label {
            font-size: 13px;
            font-weight: 500;
            color: #a0a0ff;
        }

        .filter-group select, .filter-group input[type="text"] {
            background-color: rgba(28, 32, 59, 0.8);
            border: 1px solid rgba(93, 95, 239, 0.3);
            border-radius: 5px;
            padding: 8px 10px;
            color: #ffffff;
            font-size: 14px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
            width: 100%; /* Make select full width of its group */
        }
        .filter-group select:focus, .filter-group input[type="text"]:focus {
            outline: none;
            border-color: #8a5fed;
            box-shadow: 0 0 0 2px rgba(138, 95, 237, 0.3);
        }
        .filter-group option {
            background-color: #2b2f54;
            color: #ffffff;
        }
        .filter-actions button {
            background: linear-gradient(90deg, #5d5fef 0%, #8a5fed 100%);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s ease;
            font-size: 14px;
            height: 38px; /* Match select height */
            align-self: flex-end; /* Align button to bottom of flex container if wrapping */
        }
        .filter-actions button:hover {
            transform: translateY(-2px);
            box-shadow: 0 3px 10px rgba(93, 95, 239, 0.4);
        }


        /* Anime Grid */
        .anime-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 25px; /* Gap between cards */
            margin-bottom: 30px;
        }

        /* Anime Card Styling */
        .anime-card {
            background: linear-gradient(135deg, #252a4a 0%, #323865 100%);
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            flex-direction: column;
            border: 1px solid rgba(93, 95, 239, 0.1);
        }

        .anime-card:hover {
            transform: translateY(-5px) scale(1.02);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
            border-color: rgba(93, 95, 239, 0.4);
        }

        .anime-card-poster {
            width: 100%;
            height: 280px; /* Fixed height for posters */
            object-fit: cover;
            transition: transform 0.3s ease;
            background-color: #323865; /* Placeholder background */
        }
        .anime-card:hover .anime-card-poster {
            transform: scale(1.05);
        }

        .anime-card-content {
            padding: 15px;
            display: flex;
            flex-direction: column;
            flex-grow: 1; /* Allow content to grow and push actions to bottom */
        }

        .anime-card-title {
            font-size: 16px;
            font-weight: bold;
            color: #ffffff;
            margin-bottom: 5px;
            line-height: 1.3;
            /* Clamp title to 2 lines with ellipsis */
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
            min-height: calc(1.3em * 2); /* Ensure space for 2 lines */
        }

        .anime-card-info {
            font-size: 12px;
            color: #a0a0e0;
            margin-bottom: 10px;
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 5px; /* Add gap for wrapping info */
        }
        .anime-card-info .score {
            color: #facc15; /* Yellow for score */
            font-weight: bold;
        }
         .anime-card-info .score.no-score { /* Style for when score is null/0 */
             color: #a0a0e0;
             font-style: italic;
         }
        .anime-card-info .type {
            background-color: rgba(93, 95, 239, 0.2);
            padding: 2px 6px;
            border-radius: 4px;
            color: #c0c0ff;
            text-transform: uppercase; /* Make type uppercase */
        }


        .anime-card-actions {
            margin-top: auto; /* Push actions to the bottom */
            display: flex;
            gap: 10px;
        }

        .anime-card-actions .action-btn {
            flex-grow: 1;
            padding: 8px 10px;
            border-radius: 5px;
            text-align: center;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            text-decoration: none; /* Remove underline from links styled as buttons */
        }
        .action-btn.details-btn {
            background-color: rgba(93, 95, 239, 0.3);
            color: #c0c0ff;
            border: 1px solid rgba(93, 95, 239, 0.5);
        }
        .action-btn.details-btn:hover {
            background-color: rgba(93, 95, 239, 0.5);
            color: white;
        }
        .action-btn.add-btn {
            background: linear-gradient(90deg, #5d5fef 0%, #8a5fed 100%);
            color: white;
        }
        .action-btn.add-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 3px 10px rgba(93, 95, 239, 0.3);
        }

        /* Pagination Styling */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            margin-top: 30px;
            flex-wrap: wrap; /* Allow wrapping on small screens */
        }
        .pagination a, .pagination span { /* Style links and spans similarly */
            background: linear-gradient(135deg, #373d5c 0%, #4a5180 100%);
            border: 1px solid rgba(93, 95, 239, 0.3);
            color: #e0e0ff;
            padding: 8px 14px;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease, border-color 0.3s ease;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
        }
        .pagination a:hover, .pagination span.active {
            background: linear-gradient(90deg, #5d5fef 0%, #8a5fed 100%);
            border-color: #8a5fed;
            color: white;
        }
        .pagination span.disabled { /* Style for disabled Prev/Next */
            opacity: 0.5;
            cursor: not-allowed;
             background: linear-gradient(135deg, #373d5c 0%, #4a5180 100%);
             border: 1px solid rgba(93, 95, 239, 0.3);
             color: #e0e0ff;
        }
         .pagination span.disabled:hover { /* Ensure disabled stays disabled */
             background: linear-gradient(135deg, #373d5c 0%, #4a5180 100%);
             border: 1px solid rgba(93, 95, 239, 0.3);
             color: #e0e0ff;
         }

        .pagination span.dots {
            background: none;
            border: none;
            cursor: default;
            padding: 8px 5px;
        }


        /* Footer Styling (Same as dashboard) */
        .footer {
            background: linear-gradient(90deg, #252a4a 0%, #383f71 50%, #252a4a 100%);
            padding: 30px 0;
            margin-top: 50px;
            text-align: center;
            box-shadow: 0 -4px 15px rgba(0, 0, 0, 0.3);
        }
        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        .footer-links {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 25px;
            margin-bottom: 20px;
        }
        .footer-links a {
            color: #a0a0ff;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s ease;
        }
        .footer-links a:hover {
            color: #ffffff;
        }
        .footer-copyright {
            color: #a0a0a0;
            font-size: 14px;
        }

         /* Responsive Adjustments */
         @media (max-width: 992px) {
            .filters-sort-section {
                flex-direction: column;
                align-items: stretch; /* Make filter groups full width */
            }
            .filter-group {
                min-width: 100%; /* Full width for filter groups on smaller screens */
            }
            .filter-actions button {
                width: 100%; /* Full width button */
            }
            .anime-grid {
                grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
                gap: 20px;
            }
            .anime-card-poster {
                height: 250px;
            }
         }

         @media (max-width: 768px) {
             .navbar {
                 padding: 15px 20px;
                 flex-direction: column;
                 gap: 15px;
             }
             .nav-links {
                 gap: 20px;
                 justify-content: center;
                 width: 100%;
             }
             .page-header h1 {
                 font-size: 28px;
             }
             .anime-grid {
                grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
                gap: 15px;
            }
            .anime-card-poster {
                height: 220px;
            }
            .anime-card-title {
                font-size: 15px;
            }
            .anime-card-actions .action-btn {
                font-size: 12px;
                padding: 6px 8px;
            }
         }

          @media (max-width: 480px) {
             .profile-btn {
                 width: 100%;
                 text-align: center;
             }
              .page-header h1 {
                 font-size: 24px;
             }
             .page-header p {
                 font-size: 14px;
             }
             .filters-sort-section {
                 padding: 15px;
             }
             .anime-grid {
                /* Switch to 2 columns for very small screens */
                grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
                gap: 15px;
            }
            .anime-card-poster {
                height: 200px;
            }
            .anime-card-title {
                font-size: 14px;
            }
             .pagination a, .pagination span {
                 padding: 6px 10px;
                 font-size: 13px;
             }
          }

    </style>
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
        <form action="<c:url value='/browse'/>" method="get">
            <section class="filters-sort-section">
                <div class="filter-group">
                    <label for="search-term">Search Title</label>
                    <%-- Use param.searchTerm to retain value after submit --%>
                    <input type="text" id="search-term" name="searchTerm" placeholder="e.g., Attack on Titan" value="${param.searchTerm}">
                </div>
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
                        <option value="finished" ${param.status == 'finished' ? 'selected' : ''}>Finished Airing</option>
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
                         </c:if>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="sort-by">Sort By</label>
                    <select id="sort-by" name="sortBy">
                        <%-- Use param.sortBy to retain value after submit --%>
                        <option value="popularity" ${param.sortBy == 'popularity' ? 'selected' : ''}>Popularity</option>
                        <option value="score" ${param.sortBy == 'score' ? 'selected' : ''}>Score</option>
                        <option value="release_date" ${param.sortBy == 'release_date' ? 'selected' : ''}>Release Date</option>
                        <option value="title" ${param.sortBy == 'title' ? 'selected' : ''}>Title (A-Z)</option>
                    </select>
                </div>
                <div class="filter-actions">
                    <button type="submit">Apply Filters</button>
                </div>
            </section>
        </form> <%-- End of filters form --%>

        <section class="anime-grid" id="anime-grid-results">

            <%-- Check if the animeList exists and is not empty --%>
            <c:choose>
                <c:when test="${not empty animes}">
                    <%-- Loop through each anime object in the list --%>
                    <c:forEach var="anime" items="${animes}">
                        <div class="anime-card">
                            <%-- Construct image URL (adjust path as needed) --%>
                            <%-- Option 1: Using MAL ID if available and you have images named that way --%>
                            <c:set var="imageUrl">
                                <c:choose>
                                    <c:when test="${not empty anime.malId}">
                                        <c:url value='/images/anime_posters/${anime.malId}.jpg'/> <%-- Example path --%>
                                    </c:when>
                                    <c:otherwise>
                                        https://placehold.co/250x350/323865/ffffff?text=No+Image
                                    </c:otherwise>
                                </c:choose>
                            </c:set>

                            <img src="${pageContext.request.contextPath}/resources/animecover/${anime.title}.jpg"
                                 alt="Poster for ${anime.title}"
                                 class="anime-card-poster"
                                 onerror="this.onerror=null; this.src='https://placehold.co/250x350/cccccc/ffffff?text=Load+Error';"> <%-- Fallback image --%>

                            <div class="anime-card-content">
                                <h3 class="anime-card-title" title="${anime.title}">
                                    <c:out value="${anime.title}"/>
                                </h3>
                                <div class="anime-card-info">
                                    <%-- Display Score - Use fmt:formatNumber for consistency --%>
                                    <c:choose>
                                        <c:when test="${not empty anime.score and anime.score > 0}">
                                            <span class="score">⭐ <fmt:formatNumber value="${anime.score}" pattern="#.0#"/></span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="score no-score">N/A</span>
                                        </c:otherwise>
                                    </c:choose>

                                    <%-- Display Type (TV, Movie, etc.) --%>
                                    <c:if test="${not empty anime.type}">
                                        <span class="type"><c:out value="${anime.type}"/></span>
                                    </c:if>

                                    <%-- Display Episodes --%>
                                    <c:choose>
                                        <c:when test="${not empty anime.episodes and anime.episodes > 0}">
                                            <span><c:out value="${anime.episodes}"/> Eps</span>
                                        </c:when>
                                        <c:when test="${not empty anime.type and anime.type == 'Movie'}">
                                            <%-- Don't show eps for movies unless specifically needed --%>
                                        </c:when>
                                        <c:otherwise>
                                            <span>? Eps</span> <%-- Placeholder if null/0 --%>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="anime-card-actions">
                                    <%-- Link to a details servlet/page, passing animeId --%>
                                    <a href="<c:url value='/anime-details?id=${anime.animeId}'/>" class="action-btn details-btn">View Details</a>
                                    <%-- Form/Link to add to user's list (requires user session handling) --%>
                                    <%-- Example: Could be a form submitting to an 'add-to-list' servlet --%>
                                    <form action="<c:url value='/user/add-list'/>" method="post" style="display: contents;">
                                        <input type="hidden" name="animeId" value="${anime.animeId}">
                                        <button type="submit" class="action-btn add-btn">Add to List</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <%-- Message to display if no anime match the filters --%>
                    <p style="text-align: center; color: #a0a0e0; grid-column: 1 / -1; padding: 40px;">
                        No anime found matching your criteria. Try adjusting the filters!
                    </p>
                </c:otherwise>
            </c:choose>

        </section>

        <%-- Assumes 'currentPage', 'totalPages', and filter parameters are available --%>
        <c:if test="${totalPages > 1}">
            <nav class="pagination" aria-label="Anime list navigation">
                <%-- Previous Button --%>
                <c:choose>
                    <c:when test="${currentPage > 1}">
                        <a href="<c:url value='/browse?page=${currentPage - 1}&searchTerm=${param.searchTerm}&genre=${param.genre}&status=${param.status}&year=${param.year}&sortBy=${param.sortBy}'/>">&laquo; Prev</a>
                    </c:when>
                    <c:otherwise>
                        <span class="disabled">&laquo; Prev</span>
                    </c:otherwise>
                </c:choose>

                <%-- Page Numbers (simplified example, could be more complex) --%>
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <%-- Basic pagination - show all pages (can get long) --%>
                    <%-- A more advanced version would show first, last, current, and nearby pages with dots --%>
                     <a href="<c:url value='/browse?page=${i}&searchTerm=${param.searchTerm}&genre=${param.genre}&status=${param.status}&year=${param.year}&sortBy=${param.sortBy}'/>"
                        class="${currentPage == i ? 'active' : ''}">
                         <c:out value="${i}"/>
                     </a>
                </c:forEach>

                <%-- Next Button --%>
                 <c:choose>
                    <c:when test="${currentPage < totalPages}">
                        <a href="<c:url value='/browse?page=${currentPage + 1}&searchTerm=${param.searchTerm}&genre=${param.genre}&status=${param.status}&year=${param.year}&sortBy=${param.sortBy}'/>">Next &raquo;</a>
                    </c:when>
                    <c:otherwise>
                        <span class="disabled">Next &raquo;</span>
                    </c:otherwise>
                </c:choose>
            </nav>
        </c:if>


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
                &copy; 2025 AnimeTracker. All Rights Reserved. Built with ❤️ for Anime Fans.
            </div>
        </div>
    </footer>

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

    </script>

</body>
</html>
