package com.aniverse.service;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.aniverse.config.Dbconfig;
import com.aniverse.model.Anime;

public class AnimeDAO {
    
    /**
     * Retrieves all anime with their related data (studio, rating, genres)
     * @return List of Anime objects
     */
    public List<Anime> getAllAnimes() throws SQLException, ClassNotFoundException {
        List<Anime> animeList = new ArrayList<>();
        String sql = "SELECT a.*, s.studio_name, r.rating_name " +
                     "FROM anime a " +
                     "LEFT JOIN studios s ON a.studio_id = s.studio_id " +
                     "LEFT JOIN age_ratings r ON a.rating_id = r.rating_id " +
                     "ORDER BY a.title";
        
        try (Connection conn = Dbconfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            Map<Integer, Anime> animeMap = new HashMap<>();
            
            while (rs.next()) {
                int animeId = rs.getInt("anime_id");
                
                // Check if we've already created this anime object
                Anime anime = animeMap.get(animeId);
                if (anime == null) {
                    anime = mapRowToAnime(rs);
                    animeMap.put(animeId, anime);
                    animeList.add(anime);
                }
            }
            
            // Now get genres for all anime
            fetchGenresForAnimeList(animeMap, conn);
        }
        
        return animeList;
    }
    
    /**
     * Retrieves anime with filtering and pagination
     * @param genre Genre filter (optional)
     * @param studio Studio filter (optional)
     * @param status Status filter (optional)
     * @param sortBy Sort by field
     * @param page Page number
     * @param pageSize Items per page
     * @return List of filtered Anime objects
     */
    public List<Anime> getFilteredAnimes(String genre, String studio, String status, 
                                         String sortBy, int page, int pageSize) 
                                         throws SQLException, ClassNotFoundException {
        List<Anime> animeList = new ArrayList<>();
        StringBuilder sqlBuilder = new StringBuilder();
        List<Object> params = new ArrayList<>();
        
        // Base query
        sqlBuilder.append("SELECT DISTINCT a.*, s.studio_name, r.rating_name FROM anime a ");
        sqlBuilder.append("LEFT JOIN studios s ON a.studio_id = s.studio_id ");
        sqlBuilder.append("LEFT JOIN age_ratings r ON a.rating_id = r.rating_id ");
        
        // Add genre join if needed
        if (genre != null && !genre.isEmpty()) {
            sqlBuilder.append("LEFT JOIN anime_genres ag ON a.anime_id = ag.anime_id ");
            sqlBuilder.append("LEFT JOIN genre g ON ag.genre_id = g.genre_id ");
        }
        
        // Start WHERE clause
        boolean whereAdded = false;
        
        // Add genre filter
        if (genre != null && !genre.isEmpty()) {
            sqlBuilder.append(" WHERE g.name = ? ");
            params.add(genre);
            whereAdded = true;
        }
        
        // Add studio filter
        if (studio != null && !studio.isEmpty()) {
            if (whereAdded) {
                sqlBuilder.append(" AND s.studio_name = ? ");
            } else {
                sqlBuilder.append(" WHERE s.studio_name = ? ");
                whereAdded = true;
            }
            params.add(studio);
        }
        
        // Add status filter
        if (status != null && !status.isEmpty()) {
            if (whereAdded) {
                sqlBuilder.append(" AND a.status = ? ");
            } else {
                sqlBuilder.append(" WHERE a.status = ? ");
            }
            params.add(status);
        }
        
        // Add sorting
        if (sortBy != null && !sortBy.isEmpty()) {
            switch (sortBy) {
                case "title":
                    sqlBuilder.append(" ORDER BY a.title ASC ");
                    break;
                case "score":
                    sqlBuilder.append(" ORDER BY a.score DESC ");
                    break;
                case "recent":
                    sqlBuilder.append(" ORDER BY a.start_date DESC ");
                    break;
                default:
                    sqlBuilder.append(" ORDER BY a.title ASC ");
            }
        } else {
            sqlBuilder.append(" ORDER BY a.title ASC ");
        }
        
        // Add pagination
        int offset = (page - 1) * pageSize;
        sqlBuilder.append(" LIMIT ? OFFSET ? ");
        params.add(pageSize);
        params.add(offset);
        
        try (Connection conn = Dbconfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sqlBuilder.toString())) {
            
            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = stmt.executeQuery();
            Map<Integer, Anime> animeMap = new HashMap<>();
            
            while (rs.next()) {
                int animeId = rs.getInt("anime_id");
                
                // Check if we've already created this anime object
                Anime anime = animeMap.get(animeId);
                if (anime == null) {
                    anime = mapRowToAnime(rs);
                    animeMap.put(animeId, anime);
                    animeList.add(anime);
                }
            }
            
            // Now get genres for all anime
            fetchGenresForAnimeList(animeMap, conn);
        }
        
        return animeList;
    }
    
    /**
     * Counts the total number of anime matching the filter criteria
     */
    public int getTotalAnimeCount(String genre, String studio, String status) 
                                  throws SQLException, ClassNotFoundException {
        StringBuilder sqlBuilder = new StringBuilder();
        List<Object> params = new ArrayList<>();
        
        // Base query
        sqlBuilder.append("SELECT COUNT(DISTINCT a.anime_id) as total FROM anime a ");
        
        // Add joins as needed
        if (genre != null && !genre.isEmpty()) {
            sqlBuilder.append("LEFT JOIN anime_genres ag ON a.anime_id = ag.anime_id ");
            sqlBuilder.append("LEFT JOIN genre g ON ag.genre_id = g.genre_id ");
        }
        
        if (studio != null && !studio.isEmpty()) {
            sqlBuilder.append("LEFT JOIN studios s ON a.studio_id = s.studio_id ");
        }
        
        // Start WHERE clause
        boolean whereAdded = false;
        
        // Add genre filter
        if (genre != null && !genre.isEmpty()) {
            sqlBuilder.append(" WHERE g.name = ? ");
            params.add(genre);
            whereAdded = true;
        }
        
        // Add studio filter
        if (studio != null && !studio.isEmpty()) {
            if (whereAdded) {
                sqlBuilder.append(" AND s.studio_name = ? ");
            } else {
                sqlBuilder.append(" WHERE s.studio_name = ? ");
                whereAdded = true;
            }
            params.add(studio);
        }
        
        // Add status filter
        if (status != null && !status.isEmpty()) {
            if (whereAdded) {
                sqlBuilder.append(" AND a.status = ? ");
            } else {
                sqlBuilder.append(" WHERE a.status = ? ");
            }
            params.add(status);
        }
        
        try (Connection conn = Dbconfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sqlBuilder.toString())) {
            
            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        }
        
        return 0;
    }
    
    /**
     * Get a list of all available genres
     */
    public List<String> getAllGenres() throws SQLException, ClassNotFoundException {
        List<String> genres = new ArrayList<>();
        String sql = "SELECT name FROM genre ORDER BY name";
        
        try (Connection conn = Dbconfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                genres.add(rs.getString("name"));
            }
        }
        
        return genres;
    }
    
    /**
     * Get a list of all studios
     */
    public List<String> getAllStudios() throws SQLException, ClassNotFoundException {
        List<String> studios = new ArrayList<>();
        String sql = "SELECT studio_name FROM studios ORDER BY studio_name";
        
        try (Connection conn = Dbconfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                studios.add(rs.getString("studio_name"));
            }
        }
        
        return studios;
    }
    
    /**
     * Get a list of all status values
     */
    public List<String> getAllStatuses() throws SQLException, ClassNotFoundException {
        List<String> statuses = new ArrayList<>();
        String sql = "SELECT DISTINCT status FROM anime WHERE status IS NOT NULL ORDER BY status";
        
        try (Connection conn = Dbconfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                statuses.add(rs.getString("status"));
            }
        }
        
        return statuses;
    }
    
    /**
     * Maps a database row to an Anime object
     */
    private Anime mapRowToAnime(ResultSet rs) throws SQLException {
        Anime anime = new Anime();
        anime.setAnimeId(rs.getInt("anime_id"));
        anime.setTitle(rs.getString("title"));
        anime.setSynopsis(rs.getString("synopsis"));
        anime.setType(rs.getString("type"));
        anime.setEpisodes(rs.getObject("episodes") != null ? rs.getInt("episodes") : null);
        anime.setEpisodesAired(rs.getObject("episodes_aired") != null ? rs.getInt("episodes_aired") : null);
        anime.setStatus(rs.getString("status"));
        anime.setStartDate(rs.getDate("start_date"));
        anime.setEndDate(rs.getDate("end_date"));
        anime.setSeason(rs.getString("season"));
        
        // Handle nullable foreign keys
        Object studioId = rs.getObject("studio_id");
        if (studioId != null) {
            anime.setStudioId(rs.getInt("studio_id"));
        }
        
        Object ratingId = rs.getObject("rating_id");
        if (ratingId != null) {
            anime.setRatingId(rs.getInt("rating_id"));
        }
        
        anime.setScore(rs.getBigDecimal("score"));
        anime.setDuration(rs.getString("duration"));
        anime.setSource(rs.getString("source"));
        
        Object malId = rs.getObject("mal_id");
        if (malId != null) {
            anime.setMalId(rs.getInt("mal_id"));
        }
        
        // Set related entity names
        anime.setStudioName(rs.getString("studio_name"));
        anime.setRatingName(rs.getString("rating_name"));
        
        return anime;
    }
    
    /**
     * Fetches genres for a list of anime
     */
    private void fetchGenresForAnimeList(Map<Integer, Anime> animeMap, Connection conn) throws SQLException {
        if (animeMap.isEmpty()) {
            return;
        }
        
        // Build query with all anime IDs
        StringBuilder idsBuilder = new StringBuilder();
        for (Integer animeId : animeMap.keySet()) {
            if (idsBuilder.length() > 0) {
                idsBuilder.append(",");
            }
            idsBuilder.append(animeId);
        }
        
        String sql = "SELECT ag.anime_id, g.name " +
                     "FROM anime_genres ag " +
                     "JOIN genre g ON ag.genre_id = g.genre_id " +
                     "WHERE ag.anime_id IN (" + idsBuilder.toString() + ")";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                int animeId = rs.getInt("anime_id");
                String genreName = rs.getString("name");
                
                Anime anime = animeMap.get(animeId);
                if (anime != null) {
                    anime.addGenre(genreName);
                }
            }
        }
    }
}