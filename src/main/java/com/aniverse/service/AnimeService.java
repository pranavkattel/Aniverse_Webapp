package com.aniverse.service;

import com.aniverse.model.Anime;
import com.aniverse.dao.AnimeDAO;
import com.aniverse.config.DbConfig;
import java.sql.SQLException;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 * Service class for handling anime business logic
 */
public class AnimeService {
    private AnimeDAO animeDAO;

    public AnimeService() {
        this.animeDAO = new AnimeDAO();
    }

    /**
     * Get all anime with related data
     */
    public List<Anime> getAllAnimes() throws SQLException, ClassNotFoundException {
        return animeDAO.getAllAnimes();
    }

    public int addAnime(Anime anime, List<Integer> genreIds) throws SQLException, ClassNotFoundException {
        return animeDAO.addAnime(anime, genreIds);
    }

    /**
     * Get anime by its ID
     * @param animeId The ID of the anime to retrieve
     * @return The Anime object if found, null otherwise
     */
    public Anime getAnimeById(int animeId) throws SQLException, ClassNotFoundException {
        Connection connection = DbConfig.getDbConnection();
        String query = "SELECT a.*, s.studio_name, ar.rating_name " +
                       "FROM anime a " +
                       "LEFT JOIN studios s ON a.studio_id = s.studio_id " +
                       "LEFT JOIN age_ratings ar ON a.rating_id = ar.rating_id " +
                       "WHERE a.anime_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, animeId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Anime anime = new Anime();
                    anime.setAnimeId(rs.getInt("anime_id"));
                    anime.setTitle(rs.getString("title"));
                    anime.setSynopsis(rs.getString("synopsis"));
                    anime.setType(rs.getString("type"));
                    anime.setEpisodes(rs.getInt("episodes"));
                    anime.setEpisodesAired(rs.getInt("episodes_aired"));
                    anime.setStatus(rs.getString("status"));

                    java.sql.Date startDate = rs.getDate("start_date");
                    java.sql.Date endDate = rs.getDate("end_date");
                    anime.setStartDate(startDate);
                    anime.setEndDate(endDate);

                    anime.setSeason(rs.getString("season"));
                    anime.setStudioName(rs.getString("studio_name"));
                    anime.setRatingName(rs.getString("rating_name"));
                    anime.setScore(rs.getBigDecimal("score"));
                    anime.setDuration(rs.getString("duration"));
                    anime.setSource(rs.getString("source"));
                    anime.setMalId(rs.getInt("mal_id"));
                    anime.setGenres(getAnimeGenres(animeId)); // assuming this returns List<String>
                    return anime;
                }
            }
        } finally {
            connection.close();
        }
        return null;
    }


    private List<String> getAnimeGenres(int animeId) throws SQLException, ClassNotFoundException {
        Connection connection = DbConfig.getDbConnection();
        List<String> genres = new ArrayList<>();
        String query = "SELECT g.name FROM anime_genres ag JOIN genre g ON ag.genre_id = g.genre_id WHERE ag.anime_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, animeId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    genres.add(rs.getString("name"));
                }
            }
        } finally {
            connection.close();
        }
        return genres;
    }
    
    	
    public List<Anime> getAnimesByTitleAndGenre(String title, String genre, String status, int year) throws SQLException, ClassNotFoundException {
        return animeDAO.getAnimesByTitleAndGenre(title, genre, status, year);
    }


    /**
     * Add a new anime
     * @param newAnime The Anime object to add
     * @return The added Anime object, possibly with a generated ID
     * @throws SQLException
     * @throws ClassNotFoundException
     */
   

    /**
     * Update an existing anime
     * @param animeToUpdate The Anime object to update
     * @return The updated Anime object
     */
    public Anime updateAnime(Anime animeToUpdate) throws SQLException, ClassNotFoundException {
        return animeDAO.updateAnime(animeToUpdate);
    }

    /**
     * Delete an anime by its ID
     * @param animeId The ID of the anime to delete
     * @return true if deletion was successful, false otherwise
     */
    public boolean deleteAnime(int animeId) throws SQLException, ClassNotFoundException {
        return animeDAO.deleteAnime(animeId);
    }

    /**
     * Get anime with filtering and pagination
     */
   

    /**
     * Get the total count of anime matching the filters
     */
    public int getTotalAnimeCount(String genre, String studio, String status)
                                    throws SQLException, ClassNotFoundException {
        return animeDAO.getTotalAnimeCount(genre, studio, status);
    }

    /**
     * Calculate total pages needed for pagination
     */
    public int calculateTotalPages(int totalItems, int pageSize) {
        if (pageSize <= 0) {
            pageSize = 10; // Default page size
        }
        return (int) Math.ceil((double) totalItems / pageSize);
    }

    /**
     * Get all available genres
     */
    public List<String> getAllGenres() throws SQLException, ClassNotFoundException {
        return animeDAO.getAllGenres();
    }

    /**
     * Get all studios
     */
    public List<String> getAllStudios() throws SQLException, ClassNotFoundException {
        return animeDAO.getAllStudios();
    }

    /**
     * Get all status values
     */
    public List<String> getAllStatuses() throws SQLException, ClassNotFoundException {
        return animeDAO.getAllStatuses();
    }
}