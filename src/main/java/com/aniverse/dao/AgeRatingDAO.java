package com.aniverse.dao;

import com.aniverse.model.AgeRating;
import com.aniverse.config.DbConfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AgeRatingDAO {
    
    public List<AgeRating> getAllRatings() throws SQLException, ClassNotFoundException {
        List<AgeRating> ratings = new ArrayList<>();
        
        String sql = "SELECT rating_id, rating_name FROM age_ratings ORDER BY rating_name";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                AgeRating rating = new AgeRating();
                rating.setRatingId(rs.getInt("rating_id"));
                rating.setRatingName(rs.getString("rating_name"));
                ratings.add(rating);
            }
        }
        
        return ratings;
    }
    
    public AgeRating getRatingById(int ratingId) throws SQLException, ClassNotFoundException {
        AgeRating rating = null;
        
        String sql = "SELECT rating_id, rating_name FROM age_ratings WHERE rating_id = ?";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, ratingId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    rating = new AgeRating();
                    rating.setRatingId(rs.getInt("rating_id"));
                    rating.setRatingName(rs.getString("rating_name"));
                }
            }
        }
        
        return rating;
    }
    
    // You can add more methods as needed
}