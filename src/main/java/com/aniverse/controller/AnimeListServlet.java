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
public class AnimeListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AnimeService animeService;
    
    public AnimeListServlet() {
        super();
        animeService = new AnimeService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
		
    		try {
				List <Anime> allanime = animeService.getAllAnimes();
				 request.setAttribute("animes", allanime);
			} catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("works");
			    
			    
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
