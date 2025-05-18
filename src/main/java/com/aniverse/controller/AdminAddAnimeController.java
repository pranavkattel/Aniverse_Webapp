package com.aniverse.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import com.aniverse.model.Anime;
import com.aniverse.service.AgeRatingService;
import com.aniverse.service.AnimeService;
import com.aniverse.service.GenreService;
import com.aniverse.service.StudioService;

/**
 * Servlet implementation class AdminAddAnimeServlet
 */
@WebServlet("/admin/addAnime")
@MultipartConfig
public class AdminAddAnimeController extends HttpServlet {
    
    private AnimeService animeService = new AnimeService();
    private GenreService genreService = new GenreService();
    private StudioService studioService = new StudioService();
    private AgeRatingService ratingService = new AgeRatingService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get data for form dropdowns
            request.setAttribute("genres", genreService.getAllGenres());
            request.setAttribute("studios", studioService.getAllStudios());
            request.setAttribute("ratings", ratingService.getAllRatings());
            
            // Forward to the form page
            request.getRequestDispatcher("/WEB-INF/pages/add-anime.jsp").forward(request, response);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading form data: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check admin authorization
//        HttpSession session = request.getSession();
//        if (session.getAttribute("userRole") == null || 
//            !session.getAttribute("userRole").equals("admin")) {
//            response.sendRedirect(request.getContextPath() + "/login");
//            return;
//        }
        
        try {
            // Create Anime object from form parameters
            Anime anime = new Anime();
            Part coverImagePart = request.getPart("coverImage");

            if (coverImagePart != null && coverImagePart.getSize() > 0) {
                String rawTitle = request.getParameter("title");
                String title = rawTitle.replaceAll("[\\\\/:*?\"<>|]", "_"); // only replace OS-invalid characters
                String fileName = title + ".jpg";

                String uploadDir = "C:/Users/Pranav/eclipse-workspace/Aniverse/src/main/webapp/resources/animecover";
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdirs();

                File saveFile = new File(dir, fileName);
                try (InputStream input = coverImagePart.getInputStream()) {
                    Files.copy(input, saveFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                }

      
            }
            anime.setTitle(request.getParameter("title"));
            anime.setSynopsis(request.getParameter("synopsis"));
            anime.setType(request.getParameter("type"));
            
            String episodesStr = request.getParameter("episodes");
            if (episodesStr != null && !episodesStr.trim().isEmpty()) {
                anime.setEpisodes(Integer.parseInt(episodesStr));
            }
            
            String episodesAiredStr = request.getParameter("episodesAired");
            if (episodesAiredStr != null && !episodesAiredStr.trim().isEmpty()) {
                anime.setEpisodesAired(Integer.parseInt(episodesAiredStr));
            }
            
            anime.setStatus(request.getParameter("status"));
            
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            
            String startDateStr = request.getParameter("startDate");
            if (startDateStr != null && !startDateStr.trim().isEmpty()) {
                try {
                    Date utilStartDate = dateFormat.parse(startDateStr); // java.util.Date
                    java.sql.Date sqlStartDate = new java.sql.Date(utilStartDate.getTime()); // ✅ Proper conversion
                    anime.setStartDate(sqlStartDate); // Works if anime expects java.sql.Date
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }

            String endDateStr = request.getParameter("endDate");
            if (endDateStr != null && !endDateStr.trim().isEmpty()) {
                try {
                    Date utilEndDate = dateFormat.parse(endDateStr); // java.util.Date
                    java.sql.Date sqlEndDate = new java.sql.Date(utilEndDate.getTime()); // ✅ Proper conversion
                    anime.setEndDate(sqlEndDate); // Works if anime expects java.sql.Date
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }

            
            anime.setSeason(request.getParameter("season"));
            
            String studioIdStr = request.getParameter("studioId");
            if (studioIdStr != null && !studioIdStr.trim().isEmpty()) {
                anime.setStudioId(Integer.parseInt(studioIdStr));
            }
            
            String ratingIdStr = request.getParameter("ratingId");
            if (ratingIdStr != null && !ratingIdStr.trim().isEmpty()) {
                anime.setRatingId(Integer.parseInt(ratingIdStr));
            }
            
            String scoreStr = request.getParameter("score");
            if (scoreStr != null && !scoreStr.trim().isEmpty()) {
                anime.setScore(new BigDecimal(scoreStr));
            }
            
            anime.setDuration(request.getParameter("duration"));
            anime.setSource(request.getParameter("source"));
            
            // Get selected genres
            String[] genreIdsArray = request.getParameterValues("genres");
            List<Integer> genreIds = new ArrayList<>();
            
            if (genreIdsArray != null) {
                genreIds = Arrays.stream(genreIdsArray)
                                 .map(Integer::parseInt)
                                 .collect(Collectors.toList());
            }
            
            // Save the anime
            int animeId = animeService.addAnime(anime, genreIds);
            
            if (animeId > 0) {
                // Success - redirect to the anime details page
                request.setAttribute("success", "Anime added successfully!");
                response.sendRedirect(request.getContextPath() + "/admin?success=AnimeAdded");
            } else {
                // Error creating anime
                request.setAttribute("error", "Failed to add anime.");
                doGet(request, response); // Reload the form with error message
            }
            
        } catch (SQLException | ClassNotFoundException | NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error adding anime: " + e.getMessage());
            doGet(request, response); // Reload the form with error message
        }
    }
}
