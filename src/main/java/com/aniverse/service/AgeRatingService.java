package com.aniverse.service;

import com.aniverse.dao.AgeRatingDAO;
import com.aniverse.model.AgeRating;

import java.sql.SQLException;
import java.util.List;

public class AgeRatingService {
    private AgeRatingDAO ratingDAO;
    
    public AgeRatingService() {
        this.ratingDAO = new AgeRatingDAO();
    }
    
    public List<AgeRating> getAllRatings() throws SQLException, ClassNotFoundException {
        return ratingDAO.getAllRatings();
    }
    
    public AgeRating getRatingById(int ratingId) throws SQLException, ClassNotFoundException {
        return ratingDAO.getRatingById(ratingId);
    }
    
    // You can add more methods as needed
}