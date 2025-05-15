<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
<style>
    .profile-container {
        position: relative;
    }

    .profile-dropdown {
        position: relative;
        display: inline-block;
    }

    .profile-icon {
        border-radius: 50%;
        cursor: pointer;
        transition: transform 0.2s;
    }

    .profile-icon:hover {
        transform: scale(1.1);
    }

    .dropdown-menu {
        display: none;
        position: absolute;
        right: 0;
        top: 100%;
        margin-top: 10px;
        width: 200px;
        background-color: white;
        border: 1px solid #e0e0e0;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        z-index: 1000;
        opacity: 0;
        transform: translateY(-10px);
        transition: opacity 0.3s ease, transform 0.3s ease;
    }
    .dropdown-menu {
    visibility: hidden;
    opacity: 0;
    pointer-events: none;
    transform: translateY(-10px);
    transition: opacity 0.3s ease, transform 0.3s ease, visibility 0.3s;
}


.dropdown-menu-visible {
    visibility: visible;
    opacity: 1;
    pointer-events: auto;
    transform: translateY(0);
}
    

    .dropdown-menu-visible {
        display: block;
        opacity: 1;
        transform: translateY(0);
    }

    .dropdown-item {
        display: block;
        padding: 10px 15px;
        color: #333;
        text-decoration: none;
        transition: background-color 0.2s ease;
    }

    .dropdown-item:hover {
        background-color: #f5f5f5;
    }

    .dropdown-item.logout {
        color: #ff4d4d;
    }

    .dropdown-item.logout:hover {
        background-color: #fff0f0;
    }
</style>
<header>
    <div class="logo">
        <a href="${pageContext.request.contextPath}/home">
            <img src="${pageContext.request.contextPath}/resources/system/logo.png" alt="Aniverse Logo">
        </a>
    </div>

    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home" class="${pageContext.request.servletPath eq '/WEB-INF/pages/home.jsp' ? 'active' : ''}">Home</a>
        <a href="${pageContext.request.contextPath}/animelist" class="${pageContext.request.servletPath eq '/WEB-INF/pages/anime-list.jsp' ? 'active' : ''}">Anime</a>
        <a href="${pageContext.request.contextPath}/contact" class="${pageContext.request.servletPath eq '/WEB-INF/pages/Contact.jsp' ? 'active' : ''}">Contacts</a>
        <a href="${pageContext.request.contextPath}/aboutus" class="${pageContext.request.servletPath eq '/WEB-INF/pages/AboutUs.jsp' ? 'active' : ''}">About</a>
    </div>

<%--     <c:if test="${empty sessionScope.user}">
    <div class="right-nav">
        <a href="${pageContext.request.contextPath}/login" class="login-btn">LOGIN</a>
    </div>
</c:if>

<!-- If user IS in session, show Logout and Account Settings -->
<c:if test="${not empty sessionScope.user}">
    <div class="right-nav">
        <a href="${pageContext.request.contextPath}/logout" class="login-btn" style="text-decoration: none;">Logout</a>
        <a href="${pageContext.request.contextPath}/accountsettings" class="settings-btn">
            <img src="${pageContext.request.contextPath}/resources/system/settings.png" alt="Settings" width="24" height="24">
        </a>
    </div>
</c:if> --%>
<!-- If user is NOT logged in -->
<!-- If user is NOT in session, show Login -->
<!-- If user is NOT logged in -->
<c:if test="${empty sessionScope.user}">
    <div class="right-nav">
        <a href="${pageContext.request.contextPath}/login" class="login-btn">LOGIN</a>
    </div>
</c:if>

<!-- If user IS in session, show Profile Dropdown -->
<c:if test="${not empty sessionScope.user}">
    <div class="right-nav profile-container">
        <div class="profile-dropdown">
            <img src="${pageContext.request.contextPath}/resources/animes/dandan.jpg"
                 alt="Profile"
                 class="profile-icon"
                 width="36" 
                 height="36"/>
            
            <div class="dropdown-menu">
                <a href="/Aniverse/dashboard" class="dropdown-item">
                    Dashboard
                </a>
                <a href="/Aniverse/accountsettings" class="dropdown-item">
                    Settings
                </a>
                <a href="/Aniverse/logout" class="dropdown-item logout">
                    Logout
                </a>
            </div>
        </div>
    </div>
</c:if>
</header>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const profileDropdown = document.querySelector('.profile-dropdown');
        const profileIcon = profileDropdown.querySelector('.profile-icon');
        const dropdownMenu = profileDropdown.querySelector('.dropdown-menu');

        // Toggle dropdown on profile icon click
        profileIcon.addEventListener('click', function(event) {
            event.stopPropagation(); // Prevent event from bubbling
            dropdownMenu.classList.toggle('dropdown-menu-visible');
        });

        // Close dropdown when clicking outside
        document.addEventListener('click', function(event) {
            if (!profileDropdown.contains(event.target)) {
                dropdownMenu.classList.remove('dropdown-menu-visible');
            }
        });

        // Prevent dropdown from closing when clicking inside
        dropdownMenu.addEventListener('click', function(event) {
            event.stopPropagation();
        });
    });
</script>