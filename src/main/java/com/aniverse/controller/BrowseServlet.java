package com.aniverse.controller;

import com.aniverse.model.Anime;
import com.aniverse.service.AnimeService;
// Import your DAO implementation if needed for service instantiation
// import com.aniverse.dao.impl.AnimeDAOImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * BrowseServlet
 * Handles requests for the /browse URL, fetches anime data using AnimeService,
 * and forwards to the browse.jsp page.
 */
@WebServlet("/browse") // Map servlet to the /browse URL pattern
public class BrowseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(BrowseServlet.class.getName());
    private static final int DEFAULT_PAGE_SIZE = 20; // Number of anime per page

    private AnimeService animeService;

    @Override
    public void init() throws ServletException {
        super.init();
        // Initialize the service (replace with proper dependency injection if available)
        // AnimeDAO dao = new AnimeDAOImpl(); // Example DAO instantiation
        // this.animeService = new AnimeService(dao);
         this.animeService = new AnimeService(); // Using default constructor (ensure DAO is initialized within)
         LOGGER.info("BrowseServlet initialized.");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        LOGGER.info("Received GET request for /browse");

        // 1. Get Filter and Pagination Parameters from Request
        String searchTerm = request.getParameter("searchTerm");
        String genre = request.getParameter("genre");
        String status = request.getParameter("status");
        String year = request.getParameter("year");
        String sortBy = request.getParameter("sortBy");
        String pageParam = request.getParameter("page");

        // Default values
        int currentPage = 1;
        int pageSize = DEFAULT_PAGE_SIZE;
        if (sortBy == null || sortBy.isEmpty()) {
            sortBy = "popularity"; // Default sort
        }

        // Parse page number
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);
                if (currentPage < 1) {
                    currentPage = 1; // Ensure page is at least 1
                }
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid page parameter received: " + pageParam + ". Defaulting to 1.", e);
                currentPage = 1;
            }
        }

        // 2. Prepare Filters Map for Service Layer
        Map<String, String> filters = new HashMap<>();
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            filters.put("searchTerm", searchTerm.trim());
        }
        if (genre != null && !genre.isEmpty()) {
            filters.put("genre", genre);
        }
        if (status != null && !status.isEmpty()) {
            filters.put("status", status);
        }
        if (year != null && !year.isEmpty()) {
            filters.put("year", year);
        }
        // Note: sortBy is passed separately to the service method

        try {
            // 3. Call Service Layer to get Data
            List<Anime> animeList = animeService.getAllAnimes();
            int totalAnimeCount = animeService.getTotalAnimeCount(genre, status, status);
            List<String> genresList = animeService.getAllGenres();
          

            // 4. Calculate Pagination Details
            int totalPages = (int) Math.ceil((double) totalAnimeCount / pageSize);
            if (totalPages == 0 && totalAnimeCount > 0) {
                 totalPages = 1; // Ensure at least one page if there are results
            }
             if (currentPage > totalPages && totalPages > 0) {
                 // Handle case where requested page is beyond available pages (e.g., after deleting items)
                 // Optionally redirect to the last page or show an empty page
                 currentPage = totalPages;
                 // Re-fetch data for the last page if necessary (or handle in service/DAO)
                 // animeList = animeService.getFilteredAnime(filters, sortBy, currentPage, pageSize);
                 LOGGER.log(Level.WARNING, "Requested page " + pageParam + " exceeds total pages (" + totalPages + "). Showing page " + currentPage);
             }


            // 5. Set Attributes for JSP
            request.setAttribute("animes", animeList);
            request.setAttribute("genresList", genresList); // For filter dropdown  // For filter dropdown
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);

            // Also set selected filter values back to the request so JSP can repopulate the form
            // (param.* works for this in JSP, but setting explicitly can be clearer)
            request.setAttribute("selectedSearchTerm", searchTerm);
            request.setAttribute("selectedGenre", genre);
            request.setAttribute("selectedStatus", status);
            request.setAttribute("selectedYear", year);
            request.setAttribute("selectedSort", sortBy);

            LOGGER.info("Forwarding to browse.jsp with " + animeList.size() + " anime records. Page: " + currentPage + "/" + totalPages);

        } catch (Exception e) {
            // Log unexpected errors during service calls
            LOGGER.log(Level.SEVERE, "Error processing browse request", e);
            // Set an error message for the JSP
            request.setAttribute("errorMessage", "An error occurred while retrieving anime data. Please try again later.");
            // Optionally forward to an error page or display message on browse.jsp
        }

        // 6. Forward Request to JSP
        // Ensure the path to your JSP is correct
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/anime-list.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Typically, filters are applied via GET, but handle POST if needed
        doGet(request, response);
    }

    @Override
    public void destroy() {
        // Clean up resources if necessary (e.g., close DB connections if managed here)
        LOGGER.info("BrowseServlet destroyed.");
        super.destroy();
    }
}
