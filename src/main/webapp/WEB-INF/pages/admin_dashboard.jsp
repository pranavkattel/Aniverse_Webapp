<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
     <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adminDashboard.css">
          <style>
        /* Reset and Base Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', sans-serif;
            background-color: #111827;
            color: #f3f4f6;
            padding: 16px;
        }
        
        /* Layout */
        .container {
            width: 100%;
            max-width: 1280px;
            margin: 0 auto;
        }
        
        /* Section Styles */
        .admin-section {
            display: none;
            opacity: 0;
            transition: opacity 0.5s ease-in-out;
            padding: 2rem;
            background-color: #1f2937;
            border-radius: 0.5rem;
            margin-top: 1rem;
        }
        
        .admin-section.active {
            display: block;
            opacity: 1;
        }
        
        .section-header {
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #374151;
        }
        
        .section-title {
            font-size: 1.75rem;
            font-weight: 600;
            color: #f3f4f6;
        }
        
        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        /* Stat Cards */
        .stat-card {
            background-color: #374151;
            padding: 1.5rem;
            border-radius: 0.75rem;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -1px rgba(0,0,0,0.06);
            color: #e5e7eb;
            transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1), 0 4px 6px -2px rgba(0,0,0,0.05);
        }
        
        .stat-card-title {
            color: #9ca3af;
            font-size: 0.875rem;
            font-weight: 600;
            text-transform: uppercase;
            margin-bottom: 0.5rem;
        }
        
        .stat-card-value {
            color: #ffffff;
            font-size: 2.25rem;
            font-weight: 700;
            margin-bottom: 0.75rem;
        }
        
        .stat-card-trend {
            display: flex;
            align-items: center;
            font-size: 0.875rem;
        }
        
        .stat-card-trend.trend-up {
            color: #34d399;
        }
        
        .stat-card-trend.trend-down {
            color: #f87171;
        }
        
        .stat-card-trend.trend-neutral {
            color: #60a5fa;
        }
        
        .stat-card-trend .icon {
            width: 1rem;
            height: 1rem;
            margin-right: 0.375rem;
            stroke-width: 2.5;
        }
        
        /* Chart Containers */
        .charts-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 1.5rem;
            margin-top: 2rem;
        }
        
        .chart-container {
            background-color: #374151;
            padding: 1.5rem;
            border-radius: 0.75rem;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -1px rgba(0,0,0,0.06);
            margin-bottom: 2rem;
            height: 600px;
            position: relative;
        }
        .message {
    padding: 16px 20px;
    margin: 20px auto;
    width: 80%;
    max-width: 600px;
    border-radius: 8px;
    font-size: 16px;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    position: relative;
    animation: fadeIn 0.5s ease-in-out;
}

.message-success {
    background-color: #e6ffed;
    border-left: 6px solid #2ecc71;
    color: #2e7d32;
}

.message-error {
    background-color: #ffeaea;
    border-left: 6px solid #e74c3c;
    color: #c0392b;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(-10px); }
    to   { opacity: 1; transform: translateY(0); }
}
        
        
        .chart-container h3 {
            color: #e5e7eb;
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 1rem;
            text-align: center;
        }
        
        /* Responsive Design */
        @media (min-width: 768px) {
            body {
                padding: 32px;
            }
            
            .charts-grid {
                grid-template-columns: 2fr 1fr;
            }
        }
        
        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .stat-card-value {
                font-size: 1.75rem;
            }
            
            .chart-container {
                margin-top: 1.5rem;
            }
        }
    </style>
</head>
<body class="antialiased">

    <div class="dashboard-layout">
         <aside class="sidebar">
            <div class="sidebar-header">
                <div class="sidebar-logo">
                    <span class="sidebar-logo-text" style="font-size: 1.5rem; color: #facc15;">★</span>
                </div>
                <h1 class="sidebar-title" style="font-size: 1.25rem; font-weight: 600; color: #e5e7eb;">Admin Panel</h1>
            </div>
            <nav class="sidebar-nav">
                 <ul>
                     <li>
                         <a href="#" onclick="showSection('dashboard-overview', this)" class="sidebar-link active">
                             <svg style="width: 1.25rem; height: 1.25rem; margin-right: 0.75rem;" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M3.75 3v11.25A2.25 2.25 0 006 16.5h12A2.25 2.25 0 0020.25 14.25V3m-16.5 0h16.5M3.75 3H2.25m1.5 0H6m12 0h1.5m-1.5 0H18m-6 18l-2.25-2.25m0 0l-2.25 2.25M12 21V12m0 0l2.25-2.25M12 12l-2.25 2.25" /></svg>
                             Dashboard
                         </a>
                     </li>
                     <li>
                         <a href="#" onclick="showSection('user-management', this)" class="sidebar-link">
                             <svg style="width: 1.25rem; height: 1.25rem; margin-right: 0.75rem;" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.501 20.118a7.5 7.5 0 0114.998 0A17.933 17.933 0 0112 21.75c-2.676 0-5.216-.584-7.499-1.632z" /></svg>
                             User Management
                         </a>
                     </li>
                     <li>
                         <a href="#" onclick="showSection('anime-management', this)" class="sidebar-link">
                             <svg style="width: 1.25rem; height: 1.25rem; margin-right: 0.75rem;" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M4.26 10.147a60.436 60.436 0 00-.491 6.347A48.627 48.627 0 0112 20.904a48.627 48.627 0 018.232-4.41 60.46 60.46 0 00-.491-6.347m-15.482 0a50.57 50.57 0 00-2.658-.813A59.905 59.905 0 0112 3.493a59.902 59.902 0 0110.399 5.84c-.896.248-1.783.52-2.658.814m-15.482 0A50.697 50.697 0 0112 13.489a50.702 50.702 0 017.74-3.342M6.75 15a.75.75 0 100-1.5.75.75 0 000 1.5zm0 0v-3.675A55.378 55.378 0 0112 8.443m-7.007 11.55A5.981 5.981 0 006.75 15.75v-1.5" /></svg>
                             Anime Management
                         </a>
                     </li>
                   
                 </ul>
            </nav>
        </aside>

         <div class="main-content-area">
            <header class="header">
                <div class="header-content">
                    <div>
                        <h1 class="header-title" style="font-size: 1.875rem; font-weight: 700; color: #f3f4f6;">Admin Dashboard</h1>
                    </div>
                    <div style="display: flex; align-items: center; column-gap: 1rem;"> 
                        <div style="position: relative;">
                            <button class="header-profile-button">
                                <span class="sr-only">Admin profile</span>
                                <div class="header-profile-avatar" style="background-color: #4f46e5; color: white; width: 2.5rem; height: 2.5rem; border-radius: 9999px; display:flex; align-items:center; justify-content:center; font-weight:500;">A</div>
                                <span class="header-profile-name" style="color: #e5e7eb; margin-left:0.5rem;"><a href="/Aniverse/logout" class="dropdown-item logout">
                    Logout
                </a></span>
                            </button>
                        </div>
                    </div>
                </div>
            </header>

            <main class="main-content">
            	<c:if test="${not empty param.success}">
				        <div class="message message-success">
				            <c:choose>
				                <c:when test="${param.success == 'UserDeleted'}">User deleted successfully.</c:when>
				                <c:when test="${param.success == 'UserUpdated'}">User updated successfully.</c:when>
				                <c:when test="${param.success == 'AnimeDeleted'}">Anime Deleted successfully.</c:when>
				                <c:otherwise>Operation successful.</c:otherwise> <%-- Generic success --%>
				            </c:choose>
				        </div>
				    </c:if>
				    <c:if test="${not empty param.error}">
				         <div class="message message-error">
				             <c:choose>
				                 <c:when test="${param.error == 'UserNotFound'}">User not found for editing.</c:when>
				                 <c:when test="${param.error == 'InvalidUserId'}">Invalid user ID provided.</c:when>
				                 <c:when test="${param.error == 'DeleteFailed'}">Failed to delete user.</c:when>
				                 <c:when test="${param.error == 'UpdateFailed'}">Failed to update user.</c:when>
				                 <c:when test="${param.error == 'UpdateFailedUserNotFound'}">Update failed: User not found.</c:when>
				                 <c:when test="${param.error == 'ServerError'}">An internal server error occurred.</c:when>
				                 <c:otherwise>An error occurred.</c:otherwise> <%-- Generic error --%>
				             </c:choose>
				         </div>
				    </c:if>
            
            	<%-- ============== STATS GRID SECTION ============== --%>
            	<div id="dashboard-overview"  class="admin-section active">
                <section >
                    <div class="section-header" style="margin-bottom: 1.5rem;">
                        <h2 class="section-title" style="font-size: 1.5rem; font-weight: 600; color: #f3f4f6;">Dashboard Overview</h2>
                    </div>
                    <div class="stats-grid">
                        <%-- Total Users Card --%>
                        <div class="stat-card">
                            <h3 class="stat-card-title">TOTAL USERS</h3>
                            <%-- Use fmt:formatNumber for better number display --%>
                            <%-- Make sure 'totalUsers' and 'userTrendText' are set as request attributes in your servlet --%>
                            <p class="stat-card-value">${totalUsers}</p>
                          
                        </div>

                        <%-- Total Anime Card --%>
                        <div class="stat-card">
                            <h3 class="stat-card-title">TOTAL ANIME</h3>
                            <%-- Make sure 'totalAnime' and 'animeTrendText' are set as request attributes in your servlet --%>
                            <p class="stat-card-value">${totalAnime}</p>
                             <div class="stat-card-trend trend-up"> <%-- Adjust class dynamically --%>
                                <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="18 15 12 9 6 15"></polyline></svg>
                                <span><c:out value="${not empty animeTrendText ? animeTrendText : '+0% this month'}"/></span>
                            </div>
                        </div>
                        
                        <%-- Placeholder for more stat cards if needed --%>
                        <div class="stat-card">
                            <h3 class="stat-card-title">TOP GENRE</h3>
                            <p class="stat-card-value">${topGenre}</p>
                             <div class="stat-card-trend trend-up">
                                <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="18 15 12 9 6 15"></polyline></svg>
                                <span><c:out value="${not empty signupTrendText ? signupTrendText : 'Trending up'}"/></span>
                            </div>
                        </div>
                        
                        <div class="stat-card">
                            <h3 class="stat-card-title">HIGHEST RATED ANIME</h3>
                            <p class="stat-card-value">${highestRatedAnime}</p>
                             <div class="stat-card-trend trend-up">
                                <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="18 15 12 9 6 15"></polyline></svg>
                                <span><c:out value="${not empty signupTrendText ? signupTrendText : 'Trending up'}"/></span>
                            </div>
                        </div>
                        <div class="stat-card">
                            <h3 class="stat-card-title">TOP SEASON</h3>
                            <p class="stat-card-value">${topSeason}</p>
                             <div class="stat-card-trend trend-up">
                                <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="18 15 12 9 6 15"></polyline></svg>
                                <span><c:out value="${not empty signupTrendText ? signupTrendText : 'Trending up'}"/></span>
                            </div>
                        </div>
                         </section>
                         <div class="stats-containerr">
                        <div class="charts-grid">
			                <div class="chart-container">
			                    <h3>Anime Ratings Distribution</h3>
			                    <canvas id="animeRatingsChart" style="height: 100%; width: 100%;"></canvas>
			                </div>
			                <div class="chart-container">
			                    <h3>Genre Popularity</h3>
			                    <canvas id="genrePopularityChart" style="height: 100%; width: 100%;"></canvas>
			                </div>
			            </div>
			            </div>
            
               </div>	
              

                <section id="user-management" class="admin-section active">
                    <div class="section-header">
                        <h2 class="section-title">User Management</h2>
                        
                                            
                    </div>
                    
                    
                    
                    

                    <div class="section-content-container">
                        <div class="table-container">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Username</th>
                                        <th>Email</th>
                                        <th>Joined</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                 <c:choose>
					                <c:when test="${empty customers}">
					                    <tr>
					                        <td colspan="5" style="text-align: center; padding: 20px;" class="text-gray-400">No customers found.</td>
					                    </tr>
					                </c:when>
					                <c:otherwise>
					                    <c:forEach var="customer" items="${customers}">
		                                    <tr>
		                                        <td class="text-white">${customer.username}</td>
		                                        <td class="text-gray-300">${customer.email}</td>
		                                        <td class="text-gray-400">
		                                        	<c:if test="${not empty customer.createdAt}">
					                                    ${customer.createdAt.toString().substring(0, 10)}
					                                </c:if>
		                                        </td>
		                                        <td>
		                                            <span class="status-badge status-badge-green">Active</span>
		                                        </td>
		                                        <td class="action-button-group">
		                                           <!--  <button onclick="alert('Edit user: AnimeFan42')" class="button-link-indigo" title="Edit User">
		                                                <svg class="button-link-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg>
		                                            </button>
		                                            <button onclick="confirm('Are you sure you want to delete user: AnimeFan42?')" class="button-link-red" title="Delete User">
		                                                <svg class="button-link-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
		                                            </button> -->
		                                           
		                                            <a href="${pageContext.request.contextPath}/customers?action=edit&userId=${customer.userId}" class="button-link-indigo" title="View UserDetails ${customer.username}">
					                                    <svg class="button-link-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
					                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path>
					                                    </svg>
					                                </a>
					
					                                <%-- Delete Form: Submits via POST to the servlet to perform deletion --%>
					                                <form action="${pageContext.request.contextPath}/admin" method="POST" onsubmit="return confirm('Are you sure you want to delete user: ${customer.username}?');">
					                                    <%-- Hidden fields to send data --%>
					                                    <input type="hidden" name="action" value="delete">
					                                    <input type="hidden" name="userId" value="${customer.userId}">
					
					                                    <%-- Submit button styled like a link --%>
					                                    <button type="submit" class="button-link-red" title="Delete User ${customer.username}">
					                                        <svg class="button-link-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
					                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
					                                        </svg>
					                                    </button>
					                                </form>
		                                        </td>
		                                        
		                                    </tr>
		                                    	</c:forEach>
							                 </c:otherwise>
							             </c:choose>
                                    </tbody>
                            </table>
                        </div>
                        
                    </div>
                </section>

                <section id="anime-management" class="admin-section">
                    <div class="section-header">
                        <h2 class="section-title">Anime Management</h2>
                        <button onclick="window.location.href='<%= request.getContextPath() %>/admin/addAnime'" class="button button-primary">
                             <svg class="button-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" /></svg>
                            Add New Anime
                        </button>
                    </div>
                    
                    
                    <div class="section-content-container">
                        <div class="table-container">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Title</th>
                                        <th>Type</th>
                                        <th>Episodes</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty animeList}">
                                            <tr>
                                                <td colspan="6" class="text-center">No anime found</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="anime" items="${animeList}">
                                                <tr>
                                                    <td>${anime.animeId}</td>
                                                    <td>${anime.title}</td>
                                                    <td>${anime.type}</td>
                                                    <td>${anime.episodes}</td>
                                                    <td>
                                                        <span class="status-badge status-badge-${anime.status == 'Airing' ? 'blue' : 'green'}">
                                                            ${anime.status}
                                                        </span>
                                                    </td>
                                                    <td class="action-button-group">
                                                       <a href="${pageContext.request.contextPath}/anime/details?id=${anime.animeId}" 
                                                           class="button-link-indigo">
                                                            <svg class="button-link-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path>
                                                            </svg>
                                                        </a> 
                                                        <form action="${pageContext.request.contextPath}/admin?action=deleteAnime&animeId=${anime.animeId}" method="POST" 
                                                              style="display: inline;"
                                                              onsubmit="return confirm('Are you sure you want to delete this anime?');">
                                                            <!-- <input type="hidden" name="action" value="delete"> -->
                                                            <input type="hidden" name="animeId" value="${anime.animeId}">
                                                            <button type="submit" class="button-link-red">
                                                                <svg class="button-link-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                                                                </svg>
                                                            </button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </section>

            

            </main>
        </div>
    </div>


    <script>
        /**
         * Shows the specified section and hides others.
         * Also updates the active state of the sidebar links.
         * @param {string} sectionId - The ID of the section to show.
         * @param {HTMLElement} [clickedLink=null] - The sidebar link element that was clicked.
         * @param {boolean} [isButton=false] - True if called from a button not a sidebar link.
         */
        function showSection(sectionId, clickedLink = null, isButton = false) {
            // Hide all sections first
            document.querySelectorAll('.admin-section').forEach(section => {
                section.classList.remove('active');
            });

            // Remove active class from all sidebar links
            document.querySelectorAll('.sidebar-link').forEach(link => {
                link.classList.remove('active');
            });

            // Show the target section
            const targetSection = document.getElementById(sectionId);
            if (targetSection) {
                 setTimeout(() => { // Ensure display:block happens before transition starts
                    targetSection.classList.add('active');
                 }, 10); 
            }

            // Add active class to the clicked sidebar link or corresponding link
            let targetLink = clickedLink;
            if (isButton || !clickedLink) { 
                 // If called from a button (like "Add New Anime" in anime-management) or programmatically,
                 // find the corresponding sidebar link to activate it.
                 const links = document.querySelectorAll('.sidebar-link');
                 for (let link of links) {
                     const onclickAttr = link.getAttribute('onclick');
                     if (onclickAttr && onclickAttr.includes(`showSection('${sectionId}'`)) {
                         targetLink = link;
                         break;
                     }
                 }
            }
            
            if (targetLink) {
                 targetLink.classList.add('active');
            }

            // Prevent default anchor behavior if triggered by a link click and event is available
            if (clickedLink && clickedLink.tagName === 'A' && typeof event !== 'undefined' && event) {
                event.preventDefault();
            }
        }

        /**
         * Handles the submission of the "Add New Anime" form.
         * Prevents default submission and logs data to console.
         * @param {Event} event - The form submission event.
         */
        function handleAddAnimeSubmit(event) {
            event.preventDefault(); // Prevent default form submission
            const formData = new FormData(event.target);
            const animeData = Object.fromEntries(formData.entries());
            console.log('Anime data to save:', animeData);
            alert('Anime "saved"! (Check console for data). Implement actual save logic.');
            // Optionally, clear the form or switch back to the anime list
            // event.target.reset();
            // Find the "Anime Management" link to pass to showSection
            const animeManagementLink = document.querySelector('a[onclick*="anime-management"]');
            showSection('anime-management', animeManagementLink); 
        }

        // Add event listener for the form after the DOM is loaded
        document.addEventListener('DOMContentLoaded', () => {
            const addAnimeForm = document.getElementById('add-anime-form');
            if (addAnimeForm) {
                addAnimeForm.addEventListener('submit', handleAddAnimeSubmit);
            }

            // Set the initial active section and link
            // The "Dashboard Overview" section and its link should be active by default.
            const initialActiveLink = document.querySelector('.sidebar-link[onclick*="dashboard-overview"]');
            if (initialActiveLink) {
                 showSection('dashboard-overview', initialActiveLink);
            } else {
                // Fallback if dashboard link not found, activate the first link
                const firstLink = document.querySelector('.sidebar-link');
                if(firstLink){
                    const firstSectionId = firstLink.getAttribute('onclick').match(/showSection\('([^']+)'/)[1];
                    showSection(firstSectionId, firstLink);
                }
            }
        });
                    
        document.addEventListener('DOMContentLoaded', function () {
            // Common Chart.js options for styling
            const commonChartOptions = {
                responsive: true,
                maintainAspectRatio: false, // Allows height to be controlled by CSS or container
                plugins: {
                    legend: {
                        labels: {
                            color: '#e5e7eb', // Legend text color
                            font: {
                                size: 14,
                                family: 'Inter, sans-serif'
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            color: '#9ca3af', // Y-axis labels color
                            stepSize: 10, // Adjust stepSize as needed
                            font: {
                                family: 'Inter, sans-serif'
                            }
                        },
                        grid: {
                            color: '#4b5563' // Y-axis grid lines color
                        }
                    },
                    x: {
                        ticks: {
                            color: '#9ca3af', // X-axis labels color
                            font: {
                                family: 'Inter, sans-serif'
                            }
                        },
                        grid: {
                            color: '#4b5563' // X-axis grid lines color
                        }
                    }
                }
            };

            // --- Anime Ratings Chart (Bar Chart) ---
            const ratingsCtx = document.getElementById('animeRatingsChart')?.getContext('2d');
            if (ratingsCtx) {
                // Placeholder data - replace with dynamic data from your backend
                const ratingLabels = ['0-1', '1-2', '2-3', '3-4', '4-5', '5-6', '6-7', '7-8', '8-9', '9-10'] // JSP: ${ratingLabelsJson}
                const ratingData = [${rating0to1Animes}, 
                    ${rating1to2Animes}, 
                    ${rating2to3Animes}, 
                    ${rating3to4Animes}, 
                    ${rating4to5Animes}, 
                    ${rating5to6Animes}, 
                    ${rating6to7Animes}, 
                    ${rating7to8Animes}, 
                    ${rating8to9Animes}, 
                    ${rating9to10Animes}]; // JSP: ${ratingDataJson}

                new Chart(ratingsCtx, {
                    type: 'bar',
                    data: {
                        labels: ratingLabels,
                        datasets: [{
                            label: ' Ratings',
                            data: ratingData,
                            backgroundColor: [
                                'rgba(239, 68, 68, 0.7)',  // Red (1 star)
                                'rgba(245, 158, 11, 0.7)', // Amber (2 stars)
                                'rgba(250, 204, 21, 0.7)', // Yellow (3 stars)
                                'rgba(16, 185, 129, 0.7)', // Green (4 stars) 
                                'rgba(59, 130, 246, 0.7)'  // Blue (5 stars)
                            ],
                            borderColor: [
                                'rgba(239, 68, 68, 1)',
                                'rgba(245, 158, 11, 1)',
                                'rgba(250, 204, 21, 1)',
                                'rgba(16, 185, 129, 1)',
                                'rgba(59, 130, 246, 1)'
                            ],
                            borderWidth: 1,
                            borderRadius: 5, // Rounded bars
                            hoverBackgroundColor: [
                                'rgba(220, 38, 38, 0.9)',
                                'rgba(217, 119, 6, 0.9)',
                                'rgba(202, 138, 4, 0.9)',
                                'rgba(5, 150, 105, 0.9)',
                                'rgba(37, 99, 235, 0.9)'
                            ]
                        }]
                    },
                    options: {
                        ...commonChartOptions,
                        maintainAspectRatio: true,
                        plugins: {
                            ...commonChartOptions.plugins,
                            title: {
                                display: false,
                                text: 'Anime Ratings Distribution',
                                color: '#e5e7eb',
                                font: {
                                    size: 16,
                                    weight: 'bold',
                                    family: 'Inter, sans-serif'
                                }
                            },
                            tooltip: {
                                callbacks: {
                                    label: function(context) {
                                        return `${context.raw} anime rated ${context.label}`;
                                    }
                                }
                            }
                        }
                    }
                });
            } else {
                console.error('Could not find canvas with ID animeRatingsChart');
            }

            // --- Genre Popularity Chart (Example Doughnut Chart) ---
            const genreCtx = document.getElementById('genrePopularityChart')?.getContext('2d');
            if (genreCtx) {
                // Placeholder data - replace with dynamic data
                // Example: Genre names and their counts or percentages
                // JSP: ${genreNamesJson}, ${genreDataJson}
                const genreNames = ['Action', 'Adventure', 'Comedy', 'Drama', 'Fantasy', 'Historical', 'Horror', 'Magic', 'Mecha', 'Music', 'Mystery', 'Romance', 'School', 'Sci-Fi', 'Shoujo', 'Shounen', 'Slice of Life', 'Sports', 'Supernatural', 'Thriller'];
				const genreData = [${actionAnimes}, ${adventureAnimes}, ${comedyAnimes}, ${dramaAnimes}, ${fantasyAnimes}, ${historicalAnimes}, ${horrorAnimes}, ${magicAnimes}, ${mechaAnimes}, ${musicAnimes}, ${mysteryAnimes}, ${romanceAnimes}, ${schoolAnimes}, ${sciFiAnimes}, ${shoujoAnimes}, ${shounenAnimes}, ${sliceOfLifeAnimes}, ${sportsAnimes}, ${supernaturalAnimes}, ${thrillerAnimes}];

                const backgroundColors = [ // More varied colors
                    'rgba(239, 68, 68, 0.7)',  // Red
                    'rgba(245, 158, 11, 0.7)', // Amber
                    'rgba(16, 185, 129, 0.7)', // Emerald
                    'rgba(59, 130, 246, 0.7)', // Blue
                    'rgba(139, 92, 246, 0.7)', // Violet
                    'rgba(236, 72, 153, 0.7)'  // Pink
                ];
                const borderColors = backgroundColors.map(color => color.replace('0.7', '1'));

                new Chart(genreCtx, {
                    type: 'doughnut', 
                    data: {
                        labels: genreNames,
                        datasets: [{
                            label: 'Genre Popularity',
                            data: genreData,
                            backgroundColor: backgroundColors,
                            borderColor: borderColors,
                            borderWidth: 1,
                            hoverOffset: 8 // Makes segment pop out a bit on hover
                        }]
                    },
                    options: { // Doughnut charts have slightly different preferred options
                        responsive: true,
                        maintainAspectRatio: true,
                        plugins: {
                            legend: {
                                position: 'right', // Changed to right for better space utilization
                                labels: {
                                    color: '#e5e7eb',
                                    font: {
                                        size: 12, // Slightly smaller for doughnut legend
                                        family: 'Inter, sans-serif'
                                    },
                                    padding: 20 // More padding for legend items
                                }
                            },
                            tooltip: { // Customize tooltips
                                titleFont: {
                                    family: 'Inter, sans-serif',
                                    size: 14,
                                    weight: 'bold'
                                },
                                bodyFont: {
                                    family: 'Inter, sans-serif',
                                    size: 12
                                },
                                callbacks: {
                                    label: function(context) {
                                        let label = context.label || '';
                                        if (label) {
                                            label += ': ';
                                        }
                                        if (context.parsed !== null) {
                                            // Format the value with the total count
                                            label += context.parsed + ' anime';
                                        }
                                        return label;
                                    }
                                }
                            }
                        }
                    }
                });
            } else {
                console.error('Could not find canvas with ID genrePopularityChart');
            }

            // --- Activate the section (if you have JS to switch sections) ---
            const overviewSection = document.getElementById('dashboard-overview');
            if (overviewSection) {
                overviewSection.classList.add('active');
            }
        });

    </script>

</body>
</html>
