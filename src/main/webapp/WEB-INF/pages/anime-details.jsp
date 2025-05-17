<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${anime.title} - Details</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        /* Global Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Roboto', Arial, sans-serif;
        }
        
        body {
            background-color: #0b0e3f;
            color: #f0f0f0;
            background-image: linear-gradient(to bottom, #0b0e3f, #1a2258, #262f70);
            min-height: 100vh;
        }
        
        /* Header */
      
        
        /* Main Content */
        .anime-details-container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 30px;
            background-color: rgba(30, 35, 70, 0.8);
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }
        
        .anime-details-container h1 {
            font-size: 28px;
            margin-bottom: 20px;
            color: #ffd54f;
            border-bottom: 2px solid #5c6bc0;
            padding-bottom: 10px;
        }
        
        .anime-details {
            display: flex;
            gap: 30px;
        }
        
        .anime-details img {
            width: 225px;
            height: 320px;
            object-fit: cover;
            border: 3px solid #5c6bc0;
            border-radius: 4px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        }
        
        .anime-info {
            flex: 1;
        }
        
        .anime-info p {
            margin-bottom: 12px;
            line-height: 1.5;
        }
        
        .anime-info strong {
            color: #a5b4fc;
            font-weight: 600;
            display: inline-block;
            width: 120px;
        }
        
        /* Score styling */
        .score-badge {
            display: inline-block;
            background-color: #5c6bc0;
            color: white;
            padding: 2px 8px;
            border-radius: 4px;
            font-weight: bold;
        }
        
        /* Genres styling */
        .genre-tag {
            display: inline-block;
            background-color: #3f51b5;
            color: white;
            padding: 3px 8px;
            margin-right: 6px;
            margin-bottom: 6px;
            border-radius: 4px;
            font-size: 0.9em;
        }
        
        /* Synopsis styling */
        .synopsis {
            margin-top: 20px;
            padding: 15px;
            background-color: rgba(20, 25, 55, 0.7);
            border-radius: 6px;
            line-height: 1.6;
        }
        
        /* Button styling */
        .btn {
            background-color: #5c6bc0;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 600;
            margin-top: 20px;
            transition: background-color 0.3s;
        }
        
        .btn:hover {
            background-color: #3f51b5;
        }
        
        /* Additional information section */
        .additional-info {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .additional-info h2 {
            font-size: 20px;
            margin-bottom: 15px;
            color: #a5b4fc;
        }
        
        /* Responsive design */
        @media (max-width: 768px) {
            .anime-details {
                flex-direction: column;
            }
            
            .anime-details img {
                margin: 0 auto 20px;
                width: 180px;
                height: 260px;
            }
        }
        
    </style>
</head>
<body>
    <!-- Header Navigation -->
   <jsp:include page="/WEB-INF/components/header.jsp" />
	<br><br><br>
    <!-- Main Content -->
    <div class="anime-details-container">
        <h1>${anime.title}</h1>
        <div class="anime-details">
            <img src="${pageContext.request.contextPath}/resources/animecover/${anime.title}.jpg" alt="${anime.title}" onerror="this.src='${pageContext.request.contextPath}/resources/animes/default.jpg'">
            
            <div class="anime-info">
                <p><strong>Title:</strong> ${anime.title}</p>
                <p><strong>Type:</strong> <span class="badge">${anime.type}</span></p>
                <p><strong>Episodes:</strong>
                    <c:choose>
                        <c:when test="${not empty anime.episodes}">${anime.episodes}</c:when>
                        <c:otherwise>Unknown</c:otherwise>
                    </c:choose>
                </p>
                <p><strong>Aired:</strong>
                    <c:choose>
                        <c:when test="${not empty anime.episodesAired}">${anime.episodesAired}</c:when>
                        <c:otherwise>Unknown</c:otherwise>
                    </c:choose>
                </p>
                <p><strong>Status:</strong> ${anime.status}</p>
                <p><strong>Start Date:</strong>
                    <c:choose>
                        <c:when test="${not empty anime.startDate}">${anime.startDate}</c:when>
                        <c:otherwise>Unknown</c:otherwise>
                    </c:choose>
                </p>
                <p><strong>End Date:</strong>
                    <c:choose>
                        <c:when test="${not empty anime.endDate}">${anime.endDate}</c:when>
                        <c:otherwise>Ongoing / Unknown</c:otherwise>
                    </c:choose>
                </p>
                <p><strong>Season:</strong> ${anime.season}</p>
                <p><strong>Studio:</strong> ${anime.studioName}</p>
                <p><strong>Age Rating:</strong> ${anime.ratingName}</p>
                <p><strong>Score:</strong>
                    <c:choose>
                        <c:when test="${not empty anime.score}">
                            <span class="score-badge">${anime.score}</span>
                        </c:when>
                        <c:otherwise>N/A</c:otherwise>
                    </c:choose>
                </p>
                <p><strong>Duration:</strong> ${anime.duration}</p>
                <p><strong>Source:</strong> ${anime.source}</p>
                <p><strong>MAL ID:</strong>
                    <c:choose>
                        <c:when test="${not empty anime.malId}">${anime.malId}</c:when>
                        <c:otherwise>N/A</c:otherwise>
                    </c:choose>
                </p>
                
                <p><strong>Genres:</strong></p>
                <div>
                    <c:forEach var="genre" items="${anime.genres}">
                        <span class="genre-tag">${genre}</span>
                    </c:forEach>
                </div>
                
                <div class="synopsis">
                    <strong>Synopsis:</strong><br>
                    ${anime.synopsis}
                </div>
                
                <button class="btn" onclick="window.history.back()">Go Back</button>
            </div>
        </div>
        
        
    </div>
    <jsp:include page="/WEB-INF/components/footer.jsp" />
</body>
</html>