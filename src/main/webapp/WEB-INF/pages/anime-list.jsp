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
        .modal {
    display: none; 
    position: fixed; 
    z-index: 1000; 
    left: 0;
    top: 0;
    width: 100%; 
    height: 100%; 
    overflow: auto; 
    background-color: rgba(0,0,0,0.6); /* Darker overlay */
    padding-top: 50px; /* Reduced padding */
    backdrop-filter: blur(5px); /* Frosted glass effect for overlay */
    -webkit-backdrop-filter: blur(5px);
}

.modal-content {
    background: linear-gradient(145deg, #2c3e50, #1a2937); /* Dark gradient */
    margin: 2% auto; /* Further reduced top margin */
    padding: 25px 30px;
    border: 1px solid #4a5568; /* Subtle border */
    width: 90%; 
    max-width: 550px; 
    border-radius: 12px; /* More rounded corners */
    position: relative;
    box-shadow: 0 10px 25px rgba(0,0,0,0.5); /* Enhanced shadow */
    color: #e0e0e0; /* Light text color for dark background */
}

.close-button {
    color: #a0aec0; /* Lighter close button */
    float: right;
    font-size: 32px;
    font-weight: bold;
    transition: color 0.3s ease;
}

.close-button:hover,
.close-button:focus {
    color: #f0f0f0; /* Brighter on hover */
    text-decoration: none;
    cursor: pointer;
}

.modal-content h3 {
    text-align: center;
    margin-bottom: 25px;
    font-size: 1.8em;
    color: #82aaff; /* Anime-ish accent color for title */
    font-weight: 600;
    letter-spacing: 1px;
}

.modal-form-group {
    margin-bottom: 20px;
}

.modal-form-group label {
    display: block;
    margin-bottom: 8px;
    font-weight: 500;
    color: #a0aec0; /* Slightly muted label color */
}

.modal-form-group input[type="number"],
.modal-form-group select,
.modal-form-group textarea {
    width: 100%;
    padding: 12px 15px;
    border: 1px solid #4a5568; /* Border matching modal content */
    border-radius: 6px;
    box-sizing: border-box; 
    background-color: #1a2937; /* Dark input background */
    color: #e0e0e0; /* Light input text */
    font-size: 1em;
    transition: border-color 0.3s ease, box-shadow 0.3s ease;
}

.modal-form-group input[type="number"]:focus,
.modal-form-group select:focus,
.modal-form-group textarea:focus {
    border-color: #82aaff; /* Accent color on focus */
    box-shadow: 0 0 0 3px rgba(130, 170, 255, 0.3); /* Focus ring */
    outline: none;
}

.modal-form-group textarea {
    resize: vertical;
    min-height: 90px;
}

.modal-form-group small { /* For progress helper */
    display: block;
    margin-top: 5px;
    color: #718096; /* Muted helper text */
    font-size: 0.85em;
}


.modal-form-actions {
    text-align: right;
    margin-top: 30px;
}

/* Anime-style buttons */
.modal-form-actions .action-btn {
    padding: 10px 20px;
    border: none;
    border-radius: 6px;
    font-size: 1em;
    font-weight: 500;
    cursor: pointer;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
    margin-left: 10px;
}

.modal-form-actions .action-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 10px rgba(0,0,0,0.3);
}

.modal-form-actions .action-btn.add-btn { /* Save/Submit button */
    background: linear-gradient(135deg, #5e72e4, #82aaff); /* Primary action gradient */
    color: white;
}
.modal-form-actions .action-btn.add-btn:hover {
    background: linear-gradient(135deg, #4e62d4, #729aff);
}

.modal-form-actions .action-btn { /* Cancel button (default/secondary) */
    background-color: #4a5568; /* Darker, less prominent */
    color: #e0e0e0;
}
.modal-form-actions .action-btn:hover {
     background-color: #5a6578;
}

/* Existing .anime-card-actions button styling if you want them to differ */
.anime-card-actions .action-btn {
    /* Your existing styles for card buttons */
    /* Example: */
    /* background-color: #f0ad4e; */
    /* color: #fff; */
    /* padding: 8px 12px; */
}
.anime-card-actions .add-btn { /* "Add/Edit List" button on the card */
    /* background: linear-gradient(45deg, #6a11cb 0%, #2575fc 100%);
    color: white;
    padding: 8px 15px;
    border-radius: 5px;
    border: none;
    cursor: pointer;
    font-size: 0.9em; */
}
.anime-card-actions .add-btn:hover {
    /* background: linear-gradient(45deg, #5e0fb0 0%, #1e65e0 100%); */
}

/* Style for select dropdown arrow (browser dependent, basic example) */
.watch-status-select {
    appearance: none;
    -webkit-appearance: none;
    -moz-appearance: none;
    background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22292.4%22%20height%3D%22292.4%22%3E%3Cpath%20fill%3D%22%23a0aec0%22%20d%3D%22M287%2069.4a17.6%2017.6%200%200%200-13-5.4H18.4c-5%200-9.3%201.8-12.9%205.4A17.6%2017.6%200%200%200%200%2082.2c0%205%201.8%209.3%205.4%2012.9l128%20127.9c3.6%203.6%207.8%205.4%2012.8%205.4s9.2-1.8%2012.8-5.4L287%2095c3.5-3.5%205.4-7.8%205.4-12.8%200-5-1.9-9.2-5.4-12.8z%22%2F%3E%3C%2Fsvg%3E');
    background-repeat: no-repeat;
    background-position: right 15px center;
    background-size: .8em;
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
                                    <span class="score">⭐ <fmt:formatNumber value="${anime.score}" pattern="#.0#"/></span>
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
                            <a href="<c:url value='/anime-details?id=${anime.animeId}'/>" class="action-btn details-btn">View Details</a>
                            
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
                <input type="number" name="userScore" id="modalUserScore" step="0.1" min="0" max="10" placeholder="e.g., 7.5">
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
