package com.aniverse.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.aniverse.model.User;
import com.aniverse.model.UserAnimeEntry;
import com.aniverse.service.Service;

/**
 * Servlet implementation class dashboard
 */
@WebServlet("/dashboard")
public class dashboard extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String currentUsernameFromSession;
	private Service service;
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public dashboard() {
        super();
        this.service = new Service();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
