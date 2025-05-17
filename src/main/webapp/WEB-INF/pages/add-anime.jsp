<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Anime - Admin Panel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <!-- Include any additional CSS or JS libraries you need -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/addanime.css">

</head>
<body>
   
<div class="container">
    <div class="admin-form">
    
        <h1>Add New Anime</h1>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/admin/addAnime" method="post" enctype="multipart/form-data">
            <!-- Basic Information -->
            <div class="form-group">
                <label for="title">Title*</label>
                <input type="text" id="title" name="title" class="form-control" required>
            </div>
            
            <div class="form-group">
                <label for="synopsis">Synopsis</label>
                <textarea id="synopsis" name="synopsis" class="form-control"></textarea>
            </div>
            
            <div class="form-row">
                <div class="form-col">
                    <div class="form-group">
                        <label for="type">Type</label>
                        <select id="type" name="type" class="form-control" required>
                            <option value="">Select Type</option>
                            <option value="TV">TV</option>
                            <option value="Movie">Movie</option>
                            <option value="OVA">OVA</option>
                            <option value="ONA">ONA</option>
                            <option value="Special">Special</option>
                            <option value="Music">Music</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-col">
                    <div class="form-group">
                        <label for="episodes">Episodes</label>
                        <input type="number" id="episodes" name="episodes" class="form-control" min="0" required>
                    </div>
                </div>
                
                <div class="form-col">
                    <div class="form-group">
                        <label for="episodesAired">Episodes Aired</label>
                        <input type="number" id="episodesAired" name="episodesAired" class="form-control" min="0" required>
                    </div>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-col">
                    <div class="form-group">
                        <label for="status">Status</label>
                        <select id="status" name="status" class="form-control" required>
                            <option value="">Select Status</option>
                            <option value="airing">Currently Airing</option>
                            <option value="finished">Finished Airing</option>
                            <option value="upcoming">Not Yet Aired</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-col">
                    <div class="form-group">
                        <label for="season">Season</label>
                        <select id="season" name="season" class="form-control" required>
                            <option value="">Select Season</option>
                            <option value="Winter">Winter</option>
                            <option value="Spring">Spring</option>
                            <option value="Summer">Summer</option>
                            <option value="Fall">Fall</option>
                        </select>
                    </div>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-col">
                    <div class="form-group">
                        <label for="startDate">Start Date</label>
                        <input type="date" id="startDate" name="startDate" class="form-control" required>
                    </div>
                </div>
                
                <div class="form-col">
                    <div class="form-group">
                        <label for="endDate">End Date</label>
                        <input type="date" id="endDate" name="endDate" class="form-control" required>
                    </div>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-col">
                    <div class="form-group">
                        <label for="studioId">Studio</label>
                        <select id="studioId" name="studioId" class="form-control" required>
                            <option value="">Select Studio</option>
                            <c:forEach items="${studios}" var="studio">
                                <option value="${studio.studioId}">${studio.studioName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                
                <div class="form-col">
                    <div class="form-group">
                        <label for="ratingId">Age Rating</label>
                        <select id="ratingId" name="ratingId" class="form-control" required>
                            <option value="">Select Rating</option>
                            <c:forEach items="${ratings}" var="rating">
                                <option value="${rating.ratingId}">${rating.ratingName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-col">
                    <div class="form-group">
                        <label for="score">Score</label>
                        <input type="number" id="score" name="score" class="form-control" min="0" max="9.9" step="0.01" required>
                    </div>
                </div>
                
                <div class="form-col">
                    <div class="form-group">
                        <label for="duration">Duration</label>
                        <input type="text" id="duration" name="duration" class="form-control" placeholder="e.g., 24 min per ep" required>
                    </div>
                </div>
                
                <div class="form-col">
                    <div class="form-group">
                        <label for="source">Source</label>
                        <select id="source" name="source" class="form-control" required>
                            <option value="">Select Source</option>
                            <option value="Manga">Manga</option>
                            <option value="Light Novel">Light Novel</option>
                            <option value="Original">Original</option>
                            <option value="Visual Novel">Visual Novel</option>
                            <option value="Game">Game</option>
                            <option value="Novel">Novel</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <label>Genres</label>
                <div class="checkbox-group">
                    <c:forEach items="${genres}" var="genre">
                        <div class="checkbox-item">
                            <input type="checkbox" id="genre${genre.genreId}" name="genres" value="${genre.genreId}" required>
                            <label for="genre${genre.genreId}">${genre.name}</label>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="form-group">
       			 <label for="coverImage">Anime Cover (.jpg only)</label>
        		<input type="file" id="coverImage" name="coverImage" accept=".jpg" required />
    		</div>
            <div class="form-group">
                <button type="submit" class="btn-primary">Add Anime</button>
            </div>
        </form>
    </div>
     <button onclick="window.location.href='<%= request.getContextPath() %>/admin'"  class="btn-primary">Return</button>
</div>



<script>
    // Client-side validation
    document.querySelector('form').addEventListener('submit', function(e) {
        const title = document.getElementById('title').value.trim();
        const form = e.target;
        const formData = new FormData(form);

        const file = document.getElementById("coverImage").files[0];

        if (!title) {
            e.preventDefault();
            alert('Title is required!');
        }
        
        const startDate = document.getElementById('startDate').value;
        const endDate = document.getElementById('endDate').value;
        if (startDate && endDate && new Date(startDate) > new Date(endDate)) {
            e.preventDefault();
            alert('End date must be after start date!');
        }
        if (!file || !file.name.toLowerCase().endsWith(".jpg")) {
            alert("Only .jpg files are allowed.");
            return;
        }

        fetch("/admin/addAnime", {
            method: "POST",
            body: formData
        })
        .then(response => {
            if (response.redirected) {
                window.location.href = response.url;
            } else {
                return response.text();
            }
        })
        .then(result => {
            console.log("Upload complete", result);
        })
        .catch(error => {
            console.error("Error:", error);
        });
        
    });
</script>
</body>
</html>