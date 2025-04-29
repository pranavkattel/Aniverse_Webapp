<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>AniVerse - Your Anime Universe</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
       
    </style>
</head>
<body>
    <div class="background"></div>
    <div class="login-container">
        <div class="info-section">
            <div class="logo">
                <img src="${pageContext.request.contextPath}/resources/system/logo.png" alt="AniVerse Logo">
                <span class="logo-text">AniVerse</span>
            </div>
            <h2>Welcome to Your Anime Universe</h2>
            <p>Dive into a world of endless anime possibilities. Track your favorites, discover new series, and connect with fellow anime enthusiasts in one immersive platform.</p>
            <div class="user-stats">
                <div>100k Users</div>
                <div>500k+ Anime</div>
            </div>
        </div>
        <div class="login-section">
            <div class="form-title">
            	
                <h2>Sign in to continue</h2>
                <p>Enter your username and password to access AniVerse</p>
                
            </div>
            <form action="login"  method="POST" class="login-form">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input style="width:90%;" type="text" id="username" name="username" required>
                     <c:if test="${not empty message}">
    					<p  style="color: white;" border>${message}</p>
					</c:if>
                    
                </div>
                <div class="form-group">
    <label for="password">Password</label>
    <div style="position:relative;" class="password-container">
        <span><input style="width:90%" type="password" id="password" name="password" required></span>
        <span class="eye"><i class="fas fa-eye toggle-password" id="togglePassword" style="
            position: absolute;
            top: 35%;
            right: 5%;
            cursor: pointer;
            color: rgba(255, 255, 255, 0.8);
            transition: color 0.3s ease;"></i></span>
    </div>
    <c:if test="${not empty message1}">
        <p style="color: white;" border>${message1}</p>
    </c:if>
</div>
                <button type="submit" class="login-btn">Log In</button>
                <div class="extra-links">
                    <a href="#">Forgot password?</a>
                </div>
                <div class="signup-text">
                    Don't have an account? 
                    <a href="register">Register</a>
                </div>
            </form>
        </div>
    </div>
    <script>
    const togglePassword = document.querySelector('#togglePassword');
    const password = document.querySelector('#password');

    togglePassword.addEventListener('click', function() {
        // Toggle password visibility
        const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
        password.setAttribute('type', type);
        
        // Toggle the eye icon (fixed order)
        this.classList.toggle('fa-eye');
        this.classList.toggle('fa-eye-slash');
        
        // Optional: Add hover effect
        this.style.color = type === 'text' ? 'rgba(255, 255, 255, 1)' : 'rgba(255, 255, 255, 0.8)';
    });
</script>
</body>
</html>