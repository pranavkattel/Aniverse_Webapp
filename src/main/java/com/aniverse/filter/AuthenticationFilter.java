package com.aniverse.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(asyncSupported = true, urlPatterns = "/*")
public class AuthenticationFilter implements Filter {
    // Public pages accessible to all users
    private static final String[] PUBLIC_PAGES = {
        "/login", "/logout", "/register", "/home", 
        "/", "/aboutus", "/contact", "/animelist", "/anime/details", "/test"
    };
    
    // Admin-only pages
    private static final String[] ADMIN_PAGES = {
        "/admin", "/adminAddAnime" 
    };

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization logic, if required
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        
        // Get the request URI and servlet path
        String uri = req.getRequestURI();
        String servletPath = req.getServletPath();
        String contextPath = req.getContextPath();
        
//        // System.out.println("DEBUG - URI: " + uri);
//        // System.out.println("DEBUG - ServletPath: " + servletPath);
//        // System.out.println("DEBUG - ContextPath: " + contextPath);
//        
        // Allow access to static resources without authentication
        if (uri.endsWith(".png") || uri.endsWith(".jpg") || uri.endsWith(".css") || 
            uri.endsWith(".js") || uri.endsWith(".ico") || uri.endsWith(".webp") || uri.endsWith(".avif")) {
            chain.doFilter(request, response);
            return;
        }
        
        // Get session and check user authentication
        HttpSession session = req.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        String role = isLoggedIn ? (String) session.getAttribute("role") : null;
        
         System.out.println("DEBUG - IsLoggedIn: " + isLoggedIn);
         System.out.println("DEBUG - Role: " + role);
        
        // Check if the requested page is public
        boolean isPublicPage = isPathInArray(servletPath, PUBLIC_PAGES);
        boolean isAdminPage = isPathInArray(servletPath, ADMIN_PAGES);

        System.out.println("DEBUG - Page " + servletPath);
         System.out.println("DEBUG - IsPublicPage: " + isPublicPage);
         System.out.println("DEBUG - IsAdminPage: " + isAdminPage);
        
        // Always allow access to public pages
        if (isPublicPage) {
            // Redirect logged-in users away from login/register if needed
        	if ("admin".equals(role) && 
        		    !servletPath.equals("/logout") && 
        		    !servletPath.equals("/anime/details")) {
                // If admin tries to access public pages, redirect to admin dashboard
                res.sendRedirect(contextPath + "/admin");
                return;
            }
            if ((servletPath.equals("/login") || servletPath.equals("/register")) && isLoggedIn) {
                if ("admin".equals(role)) {
                    res.sendRedirect(contextPath + "/admin");
                } else {
                    res.sendRedirect(contextPath + "/home");
                }
            } else {
                chain.doFilter(request, response);
            }
            return;
        }
        
        // Handle authentication for non-public pages
        if (!isLoggedIn) {
            // User is not logged in, redirect to login
            res.sendRedirect(contextPath + "/login");
            return;
        }
        
        // Check role-based access
        if (isAdminPage && !"admin".equals(role)) {
            // Non-admin trying to access admin page
            res.sendRedirect(contextPath + "/home");
            return;
        }
        
        // Allow access for authenticated users
        chain.doFilter(request, response);
    }
    
    private boolean isPathInArray(String path, String[] pathArray) {
        for (String p : pathArray) {
            if (path.equals(p)) {
                return true;
            }
        }
        return false;
    }

    @Override
    public void destroy() {
        // Cleanup logic, if required
    }
}