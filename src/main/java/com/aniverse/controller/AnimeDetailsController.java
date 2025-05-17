package com.aniverse.controller;

import com.aniverse.service.AnimeService;
import com.aniverse.model.Anime;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/anime/details")
public class AnimeDetailsController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private AnimeService animeService;

    public AnimeDetailsController() {
        super();
        this.animeService = new AnimeService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String animeIdParam = request.getParameter("id");

        if (animeIdParam != null) {
            try {
                int animeId = Integer.parseInt(animeIdParam);
                Anime anime = animeService.getAnimeById(animeId);

                if (anime != null) {
                    request.setAttribute("anime", anime);
                    request.getRequestDispatcher("/WEB-INF/pages/anime-details.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        }

        response.sendRedirect(request.getContextPath() + "/anime-list");
    }
}
