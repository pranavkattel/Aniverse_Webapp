<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Import the JSTL core tag library --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%-- For number formatting --%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Anime Management System</title>
    <%-- Link to Google Fonts --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        /* Your existing CSS styles remain largely the same */
        :root {
            --primary: #6366f1;
            --primary-dark: #4f46e5;
            --secondary: #8b5cf6;
            --success: #10b981; /* Green for up trend */
            --danger: #ef4444;  /* Red for down trend */
            --warning: #f59e0b;
            --dark: #1f2937;
            --darker: #111827;
            --light-text: #f3f4f6;
            --muted-text: #9ca3af;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Arial, sans-serif;
            background-color: #0f172a; /* Dark slate background */
            color: var(--light-text);
            margin: 0;
            padding: 0;
            line-height: 1.5;
        }

        .dashboard-container {
            padding: 1.5rem;
            max-width: 1400px;
            margin: 0 auto;
        }

        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #334155; /* Add a subtle separator */
        }

        .dashboard-title {
            font-size: 1.75rem; /* Slightly larger title */
            font-weight: 700;
            color: white;
            margin: 0;
        }

        .stats-grid {
            display: grid;
            /* Responsive grid: 1 col on small, 2 on medium, 4 on large screens */
            grid-template-columns: repeat(1, 1fr);
            gap: 1.25rem; /* Slightly increased gap */
            margin-bottom: 2rem;
        }

        /* Medium screens and up */
        @media (min-width: 640px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        /* Large screens and up */
        @media (min-width: 1024px) {
            .stats-grid {
                grid-template-columns: repeat(4, 1fr);
            }
        }


        .stat-card {
            background-color: #1e293b; /* Slightly lighter card background */
            border-radius: 0.5rem;
            padding: 1.25rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06); /* Softer shadow */
            border: 1px solid #334155; /* Subtle border */
            transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
        }
         .stat-card:hover {
            transform: translateY(-3px); /* Slight lift on hover */
             box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }


        .stat-card-title {
            font-size: 0.875rem; /* 14px */
            font-weight: 500; /* Medium weight */
            color: var(--muted-text);
            margin-top: 0;
            margin-bottom: 0.5rem;
            text-transform: uppercase; /* Uppercase titles */
            letter-spacing: 0.05em; /* Slight letter spacing */
        }

        .stat-card-value {
            font-size: 1.875rem; /* 30px - Larger value */
            font-weight: 700; /* Bold */
            color: white;
            margin: 0;
            line-height: 1.2; /* Adjust line height for larger font */
        }

        .stat-card-trend {
            display: flex;
            align-items: center;
            font-size: 0.8rem; /* Slightly larger trend text */
            margin-top: 0.75rem; /* More space above trend */
            color: var(--muted-text); /* Default trend text color */
        }

        .stat-card-trend svg {
             margin-right: 0.25rem; /* Space between icon and text */
             flex-shrink: 0; /* Prevent icon from shrinking */
        }


        /* Trend specific colors */
        .trend-up {
            color: var(--success);
        }
        .trend-up svg {
             stroke: var(--success); /* Color the SVG stroke */
        }

        .trend-down {
            color: var(--danger);
        }
         .trend-down svg {
             stroke: var(--danger); /* Color the SVG stroke */
        }

        /* No icon/color for neutral trends */
        .trend-info {
             color: var(--muted-text);
        }
         .trend-info svg {
            display: none; /* Hide icon for neutral info */
        }


        .button-primary {
            background-color: var(--primary);
            color: white;
            padding: 0.6rem 1.2rem; /* Slightly larger padding */
            border: none;
            border-radius: 0.375rem; /* Slightly more rounded */
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.2s ease-in-out, transform 0.1s ease;
            display: inline-flex; /* Align icon and text */
            align-items: center;
            gap: 0.5rem; /* Space between icon and text */
        }

        .button-primary:hover {
            background-color: var(--primary-dark);
            transform: translateY(-1px); /* Subtle lift on hover */
        }
         .button-primary:active {
            transform: translateY(0px); /* Press down effect */
        }

        /* Icon Styling (using inline SVG for simplicity) */
         .icon {
            width: 1em; /* Relative to font size */
            height: 1em;
            display: inline-block;
            vertical-align: middle; /* Align icon better with text */
         }

    </style>
</head>
<body>
    <div class="dashboard-container">
        <div class="dashboard-header">
            <h1 class="dashboard-title">Admin Dashboard</h1>
            <div>
                <%-- Example Button (can link to a settings servlet/page) --%>
                <button class="button-primary">
                     <svg class="icon" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="3"></circle><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"></path></svg>
                    <span>System Settings</span>
                </button>
            </div>
        </div>

        <%-- Stats Grid - Data populated using Expression Language (EL) --%>
        <div class="stats-grid">

            <%-- Total Users Card --%>
            <div class="stat-card">
                <h3 class="stat-card-title">TOTAL USERS</h3>
                <%-- Use fmt:formatNumber for better number display --%>
                <p class="stat-card-value"><fmt:formatNumber value="${totalUsers}" type="number" groupingUsed="true"/></p>
                <div class="stat-card-trend trend-up"> <%-- Assume trend-up, adjust class dynamically if needed --%>
                   
                    <span><c:out value="${userTrendText}"/></span>
                </div>
            </div>

            <%-- Total Anime Card --%>
            <div class="stat-card">
                <h3 class="stat-card-title">TOTAL ANIME</h3>
                <p class="stat-card-value"><fmt:formatNumber value="${totalAnime}" type="number" groupingUsed="true"/></p>
                 <div class="stat-card-trend trend-up">
                    <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="18 15 12 9 6 15"></polyline></svg>
                    <span><c:out value="${animeTrendText}"/></span>
                </div>
            </div>

            <%-- New Users Today Card --%>
            <div class="stat-card">
                <h3 class="stat-card-title">NEW USERS TODAY</h3>
                <p class="stat-card-value"><fmt:formatNumber value="${newUsersToday}" type="number" groupingUsed="true"/></p>
                 <div class="stat-card-trend trend-up">
                    <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="18 15 12 9 6 15"></polyline></svg>
                    <span><c:out value="${newUsersTrendText}"/></span>
                </div>
            </div>

            <%-- Reviews Today Card --%>
            <div class="stat-card">
                <h3 class="stat-card-title">REVIEWS TODAY</h3>
                <p class="stat-card-value"><fmt:formatNumber value="${reviewsToday}" type="number" groupingUsed="true"/></p>
                 <%-- Dynamically set trend class based on servlet attribute --%>
                <div class="stat-card-trend trend-${reviewsTrendDirection}">
                    <c:if test="${reviewsTrendDirection == 'up'}">
                         <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="18 15 12 9 6 15"></polyline></svg>
                    </c:if>
                     <c:if test="${reviewsTrendDirection == 'down'}">
                          <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                     </c:if>
                    <span><c:out value="${reviewsTrendText}"/></span>
                </div>
            </div>


            <%-- Total Watchlists Card --%>
            <div class="stat-card">
                <h3 class="stat-card-title">TOTAL WATCHLISTS</h3>
                <p class="stat-card-value"><fmt:formatNumber value="${totalWatchlists}" type="number" groupingUsed="true"/></p>
                <div class="stat-card-trend trend-up">
                     <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="18 15 12 9 6 15"></polyline></svg>
                    <span><c:out value="${watchlistTrendText}"/></span>
                </div>
            </div>

            <%-- Anime Added This Month Card --%>
            <div class="stat-card">
                <h3 class="stat-card-title">ANIME ADDED THIS MONTH</h3>
                <p class="stat-card-value"><fmt:formatNumber value="${animeAddedThisMonth}" type="number" groupingUsed="true"/></p>
                 <div class="stat-card-trend trend-up">
                     <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="18 15 12 9 6 15"></polyline></svg>
                    <span><c:out value="${animeAddedTrendText}"/></span>
                </div>
            </div>

            <%-- Top Genre Card --%>
            <div class="stat-card">
                <h3 class="stat-card-title">TOP GENRE</h3>
                <p class="stat-card-value"><c:out value="${topGenre}"/></p>
                <div class="stat-card-trend trend-info"> <%-- Use trend-info for non-directional info --%>
                     <%-- No icon needed here --%>
                    <span><c:out value="${genreTrendText}"/></span>
                </div>
            </div>

            <%-- Total Comments Card --%>
            <div class="stat-card">
                <h3 class="stat-card-title">TOTAL COMMENTS</h3>
                <p class="stat-card-value"><fmt:formatNumber value="${totalComments}" type="number" groupingUsed="true"/></p>
                <div class="stat-card-trend trend-up">
                    <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="18 15 12 9 6 15"></polyline></svg>
                    <span><c:out value="${commentsTrendText}"/></span>
                </div>
            </div>

            <%-- Comments Today Card --%>
            <div class="stat-card">
                <h3 class="stat-card-title">COMMENTS TODAY</h3>
                <p class="stat-card-value"><fmt:formatNumber value="${commentsToday}" type="number" groupingUsed="true"/></p>
                 <div class="stat-card-trend trend-up">
                     <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="18 15 12 9 6 15"></polyline></svg>
                    <span><c:out value="${commentsTodayTrendText}"/></span>
                </div>
            </div>

            <%-- Highest Rated Anime Card --%>
            <div class="stat-card">
                <h3 class="stat-card-title">HIGHEST RATED ANIME</h3>
                <p class="stat-card-value"><c:out value="${highestRatedAnime}"/></p>
                <div class="stat-card-trend trend-info">
                    <span><c:out value="${ratingTrendText}"/></span>
                </div>
            </div>

            <%-- Moderation Queue Card --%>
            <div class="stat-card">
                <h3 class="stat-card-title">ITEMS IN MODERATION QUEUE</h3>
                <p class="stat-card-value"><fmt:formatNumber value="${moderationQueue}" type="number" groupingUsed="true"/></p>
                <div class="stat-card-trend trend-${moderationTrendDirection}">
                     <c:if test="${moderationTrendDirection == 'up'}">
                         <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="18 15 12 9 6 15"></polyline></svg>
                    </c:if>
                     <c:if test="${moderationTrendDirection == 'down'}">
                          <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                     </c:if>
                    <span><c:out value="${moderationTrendText}"/></span>
                </div>
            </div>

             <%-- Reported Content Card --%>
            <div class="stat-card">
                <h3 class="stat-card-title">REPORTED CONTENT</h3>
                <p class="stat-card-value"><fmt:formatNumber value="${reportedContent}" type="number" groupingUsed="true"/></p>
                <div class="stat-card-trend trend-up"> <%-- Assuming more reports is an "up" trend indicator here --%>
                     <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="18 15 12 9 6 15"></polyline></svg>
                    <span><c:out value="${reportedTrendText}"/></span>
                </div>
            </div>

            <%-- Most Discussed Anime Card --%>
            <div class="stat-card">
                <h3 class="stat-card-title">MOST DISCUSSED ANIME</h3>
                <p class="stat-card-value"><c:out value="${mostDiscussedAnime}"/></p>
                 <div class="stat-card-trend trend-info">
                    <span><c:out value="${discussedTrendText}"/></span>
                </div>
            </div>

             <%-- Top Season Card --%>
            <div class="stat-card">
                <h3 class="stat-card-title">TOP SEASON</h3>
                <p class="stat-card-value"><c:out value="${topSeason}"/></p>
                 <div class="stat-card-trend trend-info">
                    <span><c:out value="${seasonTrendText}"/></span>
                </div>
            </div>

             <%-- Server Load Card --%>
            <div class="stat-card">
                <h3 class="stat-card-title">SERVER LOAD</h3>
                <p class="stat-card-value">${serverLoad}%</p> <%-- Add percentage sign --%>
                 <div class="stat-card-trend trend-${loadTrendDirection}">
                     <c:if test="${loadTrendDirection == 'up'}">
                         <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="18 15 12 9 6 15"></polyline></svg>
                    </c:if>
                     <c:if test="${loadTrendDirection == 'down'}">
                          <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                     </c:if>
                    <span><c:out value="${loadTrendText}"/></span>
                </div>
            </div>

        </div> <%-- End stats-grid --%>

        <%-- You could add other sections here, like recent activity, charts, etc. --%>

    </div> <%-- End dashboard-container --%>
</body>
</html>
