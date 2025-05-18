package com.aniverse.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal; // Import BigDecimal
import java.sql.SQLException;

import com.aniverse.model.User;
import com.aniverse.service.Service; // Assuming this is your general service
import com.aniverse.service.UserAnimeListService;

@WebServlet("/user/add-list")
public class AddToListController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Service service; // General service for user retrieval etc.
    private UserAnimeListService userAnimeListService;

    public AddToListController() {
        super();
        this.service = new Service();
        this.userAnimeListService = new UserAnimeListService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String message;
        String redirectUrl = request.getHeader("Referer"); // Default redirect to previous page
        if (redirectUrl == null || redirectUrl.isEmpty()) {
            redirectUrl = request.getContextPath() + "/animelist"; // Fallback
        }

        String currentUsernameFromSession = (String) session.getAttribute("user");
        User currentUser = service.getUserByUsername(currentUsernameFromSession); // Ensure this method exists and works
        if (currentUser == null) {
            message = "User not found. Please log in again.";
             request.getSession().setAttribute("errorMessage", message);
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        int userId = currentUser.getUserId();

        String animeIdParam = request.getParameter("animeId");
        if (animeIdParam == null || animeIdParam.isEmpty()) {
            message = "No anime selected.";
            request.getSession().setAttribute("errorMessage", message);
            response.sendRedirect(redirectUrl);
            return;
        }

        try {
            int animeId = Integer.parseInt(animeIdParam);

            // Get new parameters
            String watchStatus = request.getParameter("watchStatus");
            String scoreParam = request.getParameter("userScore");
            String progressParam = request.getParameter("progress");
            String notes = request.getParameter("notes");

            if (watchStatus == null || watchStatus.isEmpty()) {
                watchStatus = "Plan to Watch"; // Default status if not provided
            }

            BigDecimal userScore = null;
            if (scoreParam != null && !scoreParam.isEmpty()) {
                try {
                    userScore = new BigDecimal(scoreParam);
                    if (userScore.compareTo(BigDecimal.ZERO) < 0 || userScore.compareTo(new BigDecimal("10")) > 0) {
                         request.getSession().setAttribute("errorMessage", "Score must be between 0 and 10.");
                         response.sendRedirect(redirectUrl);
                         return;
                    }
                } catch (NumberFormatException e) {
                    request.getSession().setAttribute("errorMessage", "Invalid score format. Please enter a number (e.g., 7.5).");
                    response.sendRedirect(redirectUrl);
                    return;
                }
            }

            Integer progress = null;
            if (progressParam != null && !progressParam.isEmpty()) {
                try {
                    progress = Integer.parseInt(progressParam);
                     if (progress < 0) {
                         request.getSession().setAttribute("errorMessage", "Progress cannot be negative.");
                         response.sendRedirect(redirectUrl);
                         return;
                    }
                } catch (NumberFormatException e) {
                    request.getSession().setAttribute("errorMessage", "Invalid progress format. Please enter a whole number.");
                    response.sendRedirect(redirectUrl);
                    return;
                }
            }
            
            // Check if anime was already in list to tailor the message
            boolean wasAlreadyInList = userAnimeListService.isAnimeInUserList(userId, animeId);

            // Use the combined addOrUpdate method
            boolean success = userAnimeListService.addOrUpdateAnimeInUserList(userId, animeId, watchStatus, userScore, progress, notes);

            if (success) {
                if (wasAlreadyInList) {
                    message = "Anime updated in your list successfully!";
                } else {
                    message = "Anime added to your list successfully!";
                }
                request.getSession().setAttribute("successMessage", message);
            } else {
                message = "Failed to update or add anime to your list. Please try again.";
                request.getSession().setAttribute("errorMessage", message);
            }

        } catch (NumberFormatException e) {
            message = "Invalid anime ID or numeric input format.";
            request.getSession().setAttribute("errorMessage", message);
        } catch (ClassNotFoundException | SQLException e) {
            message = "Database error: " + e.getMessage();
            request.getSession().setAttribute("errorMessage", message);
            e.printStackTrace(); // Log the full error for debugging
        }

        response.sendRedirect(redirectUrl);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/animelist");
    }
}