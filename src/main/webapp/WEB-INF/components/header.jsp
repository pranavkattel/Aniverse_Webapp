<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">

<header>
    <div class="logo">
        <a href="${pageContext.request.contextPath}/home">
            <img src="${pageContext.request.contextPath}/resources/system/logo.png" alt="Aniverse Logo">
        </a>
    </div>

    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home" class="${pageContext.request.servletPath eq '/WEB-INF/pages/home.jsp' ? 'active' : ''}">Home</a>
        <a href="${pageContext.request.contextPath}/anime" class="${pageContext.request.servletPath eq '/WEB-INF/pages/anime.jsp' ? 'active' : ''}">Anime</a>
        <a href="${pageContext.request.contextPath}/contact" class="${pageContext.request.servletPath eq '/WEB-INF/pages/Contact.jsp' ? 'active' : ''}">Contacts</a>
        <a href="${pageContext.request.contextPath}/aboutus" class="${pageContext.request.servletPath eq '/WEB-INF/pages/AboutUs.jsp' ? 'active' : ''}">About</a>
    </div>

    <div class="right-nav">
        <a href="${pageContext.request.contextPath}/login" class="login-btn">LOGIN</a>
    </div>
</header>