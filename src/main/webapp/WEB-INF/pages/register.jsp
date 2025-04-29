<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/register.css">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<div class="container">
    <div class="left-panel">
      <div class="logo">
        <svg width="40" height="40" viewBox="0 0 100 100">
          <circle cx="50" cy="50" r="45" fill="none" stroke="#fff" stroke-width="2"/>
          <circle cx="30" cy="40" r="8" fill="#fff"/>
          <circle cx="70" cy="40" r="8" fill="#fff"/>
          <path d="M30 65 Q50 80 70 65" stroke="#fff" stroke-width="3" fill="none"/>
          <path d="M20 20 L35 35 M80 20 L65 35" stroke="#fff" stroke-width="2"/>
        </svg>
        <h2>AniVerse</h2>
      </div>
      
      <h1>Join Your Anime Universe</h1>
      <p>Create your profile, select your favorite genres, and begin your journey through the world of anime. Connect with fellow fans and discover new series.</p>
      
      <div class="stats">
        <div class="stat">100k+ Users</div>
        <div class="stat">500k+ Anime</div>
      </div>
    </div>
    
    <div class="right-panel">
      <div class="form-title">Create Your Account</div>
      <c:if test="${not empty message}">
    		<p  style="color: white;">${message}</p>
	   </c:if>
      <form action="register"  method="POST">
        <div class="form-group">
          <label for="username">Username</label>
          <input type="text" name="username" id="username" placeholder="Choose a unique username">
        </div>
        
        <div class="form-group">
          <label for="email">Email</label>
          <input name="email" id="email" placeholder="Your email address">
        </div>
        
        <div class="form-group">
              <label for="password">Password</label>
              <div style="position:relative;" class="password-container">
                 <span><input name="password" type="password" id="password" placeholder="Create a strong password"></span>
                  <span class="eye"><i class="fas fa-eye toggle-password" id="togglePassword" style="
    position: absolute;
    top: 35%;
    right: 2%;"></i></span>
              </div>
          </div>
        
        <div class="form-group">
          <label>Favorite Genres</label>
          <div class="genre-selection">
            <div class="genre-chip selected">Shonen</div>
            <div class="genre-chip">Shojo</div>
            <div class="genre-chip">Seinen</div>
            <div class="genre-chip">Isekai</div>
            <div class="genre-chip">Mecha</div>
            <div class="genre-chip">Fantasy</div>
          </div>
        </div>
        
        <button type="submit">Register</button>
        
        <div class="login-link">
          Already have an account? <a href="login">Log In</a>
        </div>
      </form>
    </div>
  </div>

<script>
    // Genre selection
    document.querySelectorAll('.genre-chip').forEach(chip => {
        chip.addEventListener('click', () => {
            chip.classList.toggle('selected');
        });
    });

    // Password toggle
    const togglePassword = document.getElementById('togglePassword');
    const password = document.getElementById('password');

    togglePassword.addEventListener('click', function() {
        // Toggle password visibility
        const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
        password.setAttribute('type', type);
        
        // Toggle the eye icon
        this.classList.toggle('fa-eye');
        this.classList.toggle('fa-eye-slash');
    });
</script>

</body>
</html>