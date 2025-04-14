<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>AniVerse - Your Anime Universe</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
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
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
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
</body>
</html>