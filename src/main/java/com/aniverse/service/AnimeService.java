package com.aniverse.service;

import java.sql.SQLException;
import java.util.List;

import com.aniverse.service.AnimeDAO;
import com.aniverse.model.Anime;

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
    
    /**
     * Get anime with filtering and pagination
     */
    public List<Anime> getFilteredAnimes(String genre, String studio, String status, 
                                         String sortBy, int page, int pageSize) 
                                         throws SQLException, ClassNotFoundException {
        // Default page to 1 if invalid
        if (page < 1) {
            page = 1;
        }
        
        // Default page size to 10 if invalid
        if (pageSize < 1) {
            pageSize = 10;
        }
        
        return animeDAO.getFilteredAnimes(genre, studio, status, sortBy, page, pageSize);
    }
    
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