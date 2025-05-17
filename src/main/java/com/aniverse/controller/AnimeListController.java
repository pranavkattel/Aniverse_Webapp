package com.aniverse.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.aniverse.model.Anime;
import com.aniverse.service.AnimeService;

/**
 * Servlet implementation class AnimeListServlet
 */
@WebServlet("/animelist")
public class AnimeListController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AnimeService animeService;
    
    public AnimeListController() {
        super();
        animeService = new AnimeService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
		
//    	String title = request.getParameter("searchTitle");
//    	String genre = request.getParameter("genre");
//    	
//
//    	try {
//    	List<Anime> resultList;
//    	List<String> genres = animeService.getAllGenres();
//    	request.setAttribute("genresList", genres);
//
//        if ((title != null && !title.trim().isEmpty()) &&
//            (genre != null && !genre.trim().isEmpty())) {
//
//            resultList = animeService.getAnimesByTitleAndGenre(title, genre);
//
//        } else if (title != null && !title.trim().isEmpty()) {
//
//            resultList = animeService.searchAnimeByTitle(title);
//
//        } else if (genre != null && !genre.trim().isEmpty()) {
//
//            resultList = animeService.getAnimesByGenre(genre);
//
//        } else {
//            resultList = animeService.getAllAnimes(); // optional: show all if no filter
//        }
//        request.setAttribute("animes", resultList);
//    	} catch (SQLException | ClassNotFoundException e) {
//    	    e.printStackTrace();
//    	    request.setAttribute("error", "Error retrieving anime.");
//    	    request.getRequestDispatcher("error.jsp").forward(request, response);
//    	}
    	String title = request.getParameter("searchTitle");
    	String genre = request.getParameter("genre");
    	String status = request.getParameter("status");
    	String yearParam = request.getParameter("year");
    	int year = 0; // default value representing "any year"

    	if (yearParam != null && !yearParam.trim().isEmpty()) {
    	    try {
    	        year = Integer.parseInt(yearParam);
    	    } catch (NumberFormatException e) {
    	        // Handle invalid year format
    	    }
    	}

    	try {
    	    List<Anime> resultList;
    	    List<String> genres = animeService.getAllGenres();
    	    request.setAttribute("genresList", genres);
    	    
    	    // Get list of statuses for dropdown
    	    List<String> statuses = animeService.getAllStatuses();
    	    request.setAttribute("statusList", statuses);

    	    if ((title != null && !title.trim().isEmpty()) ||
    	        (genre != null && !genre.trim().isEmpty()) ||
    	        (status != null && !status.trim().isEmpty()) ||
    	        year > 0) {
    	        
    	        // Use empty strings for null values
    	        resultList = animeService.getAnimesByTitleAndGenre(
    	            title != null ? title : "", 
    	            genre != null ? genre : "", 
    	            status != null ? status : "",
    	            year);
    	    } else {
    	        resultList = animeService.getAllAnimes(); // show all if no filter
    	    }
    	    request.setAttribute("animes", resultList);
    	} catch (SQLException | ClassNotFoundException e) {
    	    e.printStackTrace();
    	    request.setAttribute("error", "Error retrieving anime.");
    	    request.getRequestDispatcher("error.jsp").forward(request, response);
    	}
    	
    	
            request.getRequestDispatcher("/WEB-INF/pages/anime-list.jsp").forward(request, response);
         
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // For form submissions, just redirect to GET with parameters
		/*
		 * StringBuilder redirectUrl = new StringBuilder("anime-list?");
		 * 
		 * // Add filter parameters if present if (request.getParameter("genre") != null
		 * && !request.getParameter("genre").isEmpty()) {
		 * redirectUrl.append("genre=").append(request.getParameter("genre")).append("&"
		 * ); }
		 * 
		 * if (request.getParameter("studio") != null &&
		 * !request.getParameter("studio").isEmpty()) {
		 * redirectUrl.append("studio=").append(request.getParameter("studio")).append(
		 * "&"); }
		 * 
		 * if (request.getParameter("status") != null &&
		 * !request.getParameter("status").isEmpty()) {
		 * redirectUrl.append("status=").append(request.getParameter("status")).append(
		 * "&"); }
		 * 
		 * if (request.getParameter("sortBy") != null &&
		 * !request.getParameter("sortBy").isEmpty()) {
		 * redirectUrl.append("sortBy=").append(request.getParameter("sortBy")).append(
		 * "&"); }
		 * 
		 * if (request.getParameter("page") != null &&
		 * !request.getParameter("page").isEmpty()) {
		 * redirectUrl.append("page=").append(request.getParameter("page")).append("&");
		 * }
		 * 
		 * if (request.getParameter("pageSize") != null &&
		 * !request.getParameter("pageSize").isEmpty()) {
		 * redirectUrl.append("pageSize=").append(request.getParameter("pageSize")); }
		 * 
		 * response.sendRedirect(redirectUrl.toString());
		 */
    }
}
