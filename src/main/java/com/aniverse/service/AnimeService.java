package com.aniverse.service;

import com.aniverse.model.Anime;
import com.aniverse.dao.AnimeDAO;
import java.sql.SQLException;
import java.util.List;

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
        return animeDAO.getAnimeById(animeId);
    }
    
    	
    public List<Anime> getAnimesByTitleAndGenre(String title, String genre, String status, int year) throws SQLException, ClassNotFoundException {
        return animeDAO.getAnimesByTitleAndGenre(title, genre, status, year);
    }


    /**
     * Add a new anime
     * @param newAnime The Anime object to add
     * @return The added Anime object, possibly with a generated ID
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