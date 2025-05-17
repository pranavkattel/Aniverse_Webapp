package com.aniverse.dao;

import com.aniverse.model.Genre;
import com.aniverse.config.DbConfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class GenreDAO {
    
    public List<Genre> getAllGenres() throws SQLException, ClassNotFoundException {
        List<Genre> genres = new ArrayList<>();
        
        String sql = "SELECT genre_id, name FROM genre ORDER BY name";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Genre genre = new Genre();
                genre.setGenreId(rs.getInt("genre_id"));
                genre.setName(rs.getString("name"));
                genres.add(genre);
            }
        }
        
        return genres;
    }
    
    public Genre getGenreById(int genreId) throws SQLException, ClassNotFoundException {
        Genre genre = null;
        
        String sql = "SELECT genre_id, name FROM genre WHERE genre_id = ?";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, genreId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    genre = new Genre();
                    genre.setGenreId(rs.getInt("genre_id"));
                    genre.setName(rs.getString("name"));
                }
            }
        }
        
        return genre;
    }
    
    // Get genres for a specific anime
    public List<Genre> getGenresByAnimeId(int animeId) throws SQLException, ClassNotFoundException {
        List<Genre> genres = new ArrayList<>();
        
        String sql = "SELECT g.genre_id, g.name " +
                     "FROM genre g " +
                     "JOIN anime_genres ag ON g.genre_id = ag.genre_id " +
                     "WHERE ag.anime_id = ? " +
                     "ORDER BY g.name";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, animeId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Genre genre = new Genre();
                    genre.setGenreId(rs.getInt("genre_id"));
                    genre.setName(rs.getString("name"));
                    genres.add(genre);
                }
            }
        }
        
        return genres;
    }
}