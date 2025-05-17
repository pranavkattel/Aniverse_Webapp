package com.aniverse.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import com.aniverse.model.Anime;
import com.aniverse.model.User;
import com.aniverse.model.UserAnimeEntry;
import com.aniverse.service.AnimeService;
import com.aniverse.service.Service;
import com.aniverse.service.UserAnimeListService;

/**
 * Servlet implementation class dashboard
 */
@WebServlet("/dashboard")
public class UserDashboardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String currentUsernameFromSession;
	private Service service;
	private AnimeService animeservice;
	private UserAnimeListService useranimelistservice;
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserDashboardController() {
        super();
        this.service = new Service();
        this.animeservice = new AnimeService();
        this.useranimelistservice = new UserAnimeListService(); // Initialize the service
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
	    if ("getAnimeById".equals(action)) {
	        int animeId = Integer.parseInt(request.getParameter("animeId"));
	        try {
	            Anime anime = animeservice.getAnimeById(animeId);
	            response.setContentType("application/json");
	            if (anime != null) {
	                StringBuilder json = new StringBuilder();
	                json.append("{");
	                json.append("\"animeId\":").append(anime.getAnimeId()).append(",");
	                json.append("\"title\":\"").append(anime.getTitle()).append("\",");
	                json.append("\"synopsis\":\"").append(anime.getSynopsis()).append("\",");
	                json.append("\"type\":\"").append(anime.getType()).append("\",");
	                json.append("\"episodes\":").append(anime.getEpisodes()).append(",");
	                json.append("\"status\":\"").append(anime.getStatus()).append("\",");
	                json.append("\"startDate\":\"").append(anime.getStartDate()).append("\",");
	                json.append("\"endDate\":\"").append(anime.getEndDate()).append("\",");
	                json.append("\"season\":\"").append(anime.getSeason()).append("\",");
	                json.append("\"studioName\":\"").append(anime.getStudioName()).append("\",");
	                json.append("\"ratingName\":\"").append(anime.getRatingName()).append("\",");
	                json.append("\"score\":").append(anime.getScore()).append(",");
	                json.append("\"duration\":\"").append(anime.getDuration()).append("\",");
	                json.append("\"source\":\"").append(anime.getSource()).append("\",");
	                json.append("\"genres\":").append(anime.getGenres().toString());
	                json.append("}");
	                response.getWriter().write(json.toString());
	            } else {
	                response.getWriter().write("{}");
	            }
	        } catch (Exception e) {
	            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	            response.getWriter().write("{\"error\":\"Failed to fetch anime details.\"}");
	        }
	        return;
	    }
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false); // Don't create a new session if it doesn't exist
	    
	    if (session == null || session.getAttribute("user") == null || !"customer".equals(session.getAttribute("role"))) {
	        // User is not logged in or does not have the role "user", redirect to login page
	        response.sendRedirect(request.getContextPath() + "/login");
	        return; // Stop further processing
	    }
		 currentUsernameFromSession = (String) session.getAttribute("user");
	     User currentUser = service.getUserByUsername(currentUsernameFromSession);
	     int userId= currentUser.getUserId();
	    request.setAttribute("userFromDb", currentUsernameFromSession);
	    List<UserAnimeEntry> animeList = service.getUserAnimeList(userId);
	    request.setAttribute("userFromDb", currentUsernameFromSession);
	    request.setAttribute("animeList", animeList);

	    // Calculate statistics
	    int totalAnime = animeList.size();
	    int watching = 0;
	    int completed = 0;
	    int planToWatch = 0;
	    int onHold = 0;
	    int dropped = 0;

	    // Count entries by status
	    for (UserAnimeEntry entry : animeList) {
	        String status = entry.getWatchStatus();
	        if (status.equalsIgnoreCase("watching")) {
	            watching++;
	        } else if (status.equalsIgnoreCase("completed")) {
	            completed++;
	        } else if (status.equalsIgnoreCase("plan_to_watch") || status.equalsIgnoreCase("plan to watch")) {
	            planToWatch++;
	        } else if (status.equalsIgnoreCase("on_hold") || status.equalsIgnoreCase("on hold")) {
	            onHold++;
	        } else if (status.equalsIgnoreCase("dropped")) {
	            dropped++;
	        }
	    }

	    // Print stats
	    System.out.println("User: " + currentUsernameFromSession);
	    System.out.println("Total Anime: " + totalAnime);
	    System.out.println("Currently Watching: " + watching);
	    System.out.println("Completed: " + completed);
	    System.out.println("Plan to Watch: " + planToWatch);
	    System.out.println("On Hold: " + onHold);
	    System.out.println("Dropped: " + dropped);
	    
	    request.setAttribute("userFromDb", currentUsernameFromSession);
	    request.setAttribute("animeList", animeList);
	    request.setAttribute("totalAnime", totalAnime);
	    request.setAttribute("watching", watching);
	    request.setAttribute("completed", completed);
	    request.setAttribute("planToWatch", planToWatch);
	    request.setAttribute("onHold", onHold);
	    request.setAttribute("dropped", dropped);

	    // Print details of each anime
	    System.out.println("\n--- ANIME DETAILS ---");
	    for (UserAnimeEntry entry : animeList) {
	        System.out.println("\nTitle: " + entry.getTitle());
	        System.out.println("Status: " + entry.getWatchStatus());
	        System.out.println("Progress: " + entry.getProgress() + "/" + entry.getEpisodes());
	        System.out.println("User Score: " + entry.getUserScore());
	        System.out.println("Type: " + entry.getType());
	        System.out.println("Genres: " + String.join(", ", entry.getGenres()));
	    }

		request.getRequestDispatcher("WEB-INF/pages/dashboard.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
	    if ("updateAnime".equals(action)) {
	        try {
	            int animeId = Integer.parseInt(request.getParameter("animeId"));
	            String title = request.getParameter("title");
	            String synopsis = request.getParameter("synopsis");
	            String type = request.getParameter("type");
	            int episodes = Integer.parseInt(request.getParameter("episodes"));
	            String status = request.getParameter("status");

	            Anime anime = new Anime();
	            anime.setAnimeId(animeId);
	            anime.setTitle(title);
	            anime.setSynopsis(synopsis);
	            anime.setType(type);
	            anime.setEpisodes(episodes);
	            anime.setStatus(status);

	            animeservice.updateAnime(anime);
	            response.setStatus(HttpServletResponse.SC_OK);
	        } catch (Exception e) {
	            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        }
	        return;
	    } else if ("deleteAnime".equals(action)) {
	        try {
	            int animeId = Integer.parseInt(request.getParameter("animeId"));
	            animeservice.deleteAnime(animeId);
	            response.setStatus(HttpServletResponse.SC_OK);
	        } catch (Exception e) {
	            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        }
	        return;
	    } else if ("updateAnimeEntry".equals(action)) {
	        try {
	            // Validate and parse parameters
	            int entryId = Integer.parseInt(request.getParameter("entryId"));
	            String watchStatus = request.getParameter("watchStatus");
	            BigDecimal userScore = request.getParameter("userScore") != null && !request.getParameter("userScore").isEmpty()
	                    ? new BigDecimal(request.getParameter("userScore"))
	                    : null;
	            Integer progress = request.getParameter("progress") != null && !request.getParameter("progress").isEmpty()
	                    ? Integer.parseInt(request.getParameter("progress"))
	                    : null;

	            // Ensure required fields are not null or empty
	            if (watchStatus == null || watchStatus.trim().isEmpty()) {
	                throw new IllegalArgumentException("Watch status is required.");
	            }

	            // Call service to update the entry
	            boolean success = useranimelistservice.updateUserAnimeEntry(entryId, watchStatus, userScore, progress);
	            if (success) {
	                response.sendRedirect(request.getContextPath() + "/dashboard");
	            } else {
	                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update anime entry.");
	            }
	        } catch (NumberFormatException e) {
	            System.err.println("Invalid number format: " + e.getMessage());
	            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format.");
	        } catch (IllegalArgumentException e) {
	            System.err.println("Validation error: " + e.getMessage());
	            response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
	        } catch (Exception e) {
	            System.err.println("Error processing update request: " + e.getMessage());
	            e.printStackTrace();
	            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing update request.");
	        }
	        return;
	    } else if ("deleteAnimeEntry".equals(action)) {
	        try {
	            // Validate and parse the entryId parameter
	            String entryIdParam = request.getParameter("entryId");
	            if (entryIdParam == null || entryIdParam.trim().isEmpty()) {
	                throw new IllegalArgumentException("Entry ID is required.");
	            }
	            int entryId = Integer.parseInt(entryIdParam);

	            // Call service to delete the entry
	            boolean success = useranimelistservice.deleteUserAnimeEntry(entryId);
	            if (success) {
	                response.sendRedirect(request.getContextPath() + "/dashboard");
	            } else {
	                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete anime entry.");
	            }
	        } catch (NumberFormatException e) {
	            System.err.println("Invalid number format for entryId: " + e.getMessage());
	            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid entry ID format.");
	        } catch (IllegalArgumentException e) {
	            System.err.println("Validation error: " + e.getMessage());
	            response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
	        } catch (Exception e) {
	            System.err.println("Error processing delete request: " + e.getMessage());
	            e.printStackTrace();
	            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing delete request.");
	        }
	        return;
	    }
		doGet(request, response);
	}

}
