package com.aniverse.service;

import com.aniverse.dao.GenreDAO;
import com.aniverse.model.Genre;

import java.sql.SQLException;
import java.util.List;

public class GenreService {
    private GenreDAO genreDAO;
    
    public GenreService() {
        this.genreDAO = new GenreDAO();
    }
    
    public List<Genre> getAllGenres() throws SQLException, ClassNotFoundException {
        return genreDAO.getAllGenres();
    }
    
    public Genre getGenreById(int genreId) throws SQLException, ClassNotFoundException {
        return genreDAO.getGenreById(genreId);
    }
    
    // You can add more methods as needed
}