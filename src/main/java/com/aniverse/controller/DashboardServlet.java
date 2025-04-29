package com.aniverse.controller; // Or your appropriate package

import com.aniverse.service.Service; // Import your service

import jakarta.servlet.ServletException; // Or javax.servlet if using older Java EE
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/dashboard1") // Define the URL pattern for this servlet
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Service dataService; // Use your Service class

    @Override
    public void init() throws ServletException {
        // Initialize the service once when the servlet is loaded
        dataService = new Service();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Fetch all the data needed for the dashboard using the service
        int totalUsers = dataService.getTotalUserCount();
        int totalAnime = dataService.getTotalAnimeCount();
        int newUsersToday = dataService.getNewUsersTodayCount();
        int reviewsToday = dataService.getReviewsTodayCount();
        int totalWatchlists = dataService.getTotalWatchlistCount();
        int animeAddedThisMonth = dataService.getAnimeAddedThisMonthCount();
        String topGenre = dataService.getTopGenre();
        int totalComments = dataService.getTotalCommentCount();
        int commentsToday = dataService.getCommentsTodayCount();
        String highestRatedAnime = dataService.getHighestRatedAnime();
        int moderationQueue = dataService.getModerationQueueCount();
        int reportedContent = dataService.getReportedContentCount();
        String mostDiscussedAnime = dataService.getMostDiscussedAnime();
        String topSeason = dataService.getTopSeason();
        int serverLoad = dataService.getServerLoad();

        // Set the fetched data as request attributes
        // The names here ("totalUsers", "totalAnime", etc.) are what you'll use in the JSP
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalAnime", totalAnime);
        request.setAttribute("newUsersToday", newUsersToday);
        request.setAttribute("reviewsToday", reviewsToday);
        request.setAttribute("totalWatchlists", totalWatchlists);
        request.setAttribute("animeAddedThisMonth", animeAddedThisMonth);
        request.setAttribute("topGenre", topGenre);
        request.setAttribute("totalComments", totalComments);
        request.setAttribute("commentsToday", commentsToday);
        request.setAttribute("highestRatedAnime", highestRatedAnime);
        request.setAttribute("moderationQueue", moderationQueue);
        request.setAttribute("reportedContent", reportedContent);
        request.setAttribute("mostDiscussedAnime", mostDiscussedAnime);
        request.setAttribute("topSeason", topSeason);
        request.setAttribute("serverLoad", serverLoad);

        // --- Placeholder Trend Data (You might calculate this in the service or servlet) ---
        // For simplicity, I'm adding static trend text. You'd fetch previous data
        // and calculate percentages in a real application.
        request.setAttribute("userTrendText", "12% from last month");
        request.setAttribute("animeTrendText", "8% from last month");
        request.setAttribute("newUsersTrendText", "15% from yesterday");
        request.setAttribute("reviewsTrendText", "3% from yesterday"); // Down trend
        request.setAttribute("activeUsersTrendText", "5% from this time yesterday");
        request.setAttribute("watchlistTrendText", "7% from last month");
        request.setAttribute("animeAddedTrendText", "18% from last month");
        request.setAttribute("genreTrendText", "32% of all anime"); // Info text
        request.setAttribute("commentsTrendText", "9% from last month");
        request.setAttribute("commentsTodayTrendText", "6% from yesterday");
        request.setAttribute("ratingTrendText", "4.8/5 (9,327 ratings)"); // Info text
        request.setAttribute("moderationTrendText", "25% from yesterday"); // Down trend
        request.setAttribute("reportedTrendText", "2 from yesterday");
        request.setAttribute("discussedTrendText", "845 comments this week"); // Info text
        request.setAttribute("seasonTrendText", "42 new anime series"); // Info text
        request.setAttribute("loadTrendText", "5% from peak hours"); // Down trend

        // Determine trend direction (up/down) based on comparison (example for reviews)
        // You would compare today's value with yesterday's/last month's
        request.setAttribute("reviewsTrendDirection", "down"); // Example
        request.setAttribute("moderationTrendDirection", "down"); // Example
        request.setAttribute("loadTrendDirection", "down"); // Example
        // Add similar logic for other trends that can go up or down


        // Forward the request to your JSP page
        // Ensure the path to your JSP is correct within your webapp structure
        request.getRequestDispatcher("/WEB-INF/pages/dashboard1.jsp").forward(request, response);
        // Or if your JSP is directly under webapp:
        // request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }

    @Override
    public void destroy() {
        // Clean up resources like the database connection when the servlet is unloaded
        if (dataService != null) {
            dataService.closeConnection();
        }
    }
}
