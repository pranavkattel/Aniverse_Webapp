package com.aniverse.model;

public class AgeRating {
    private Integer ratingId;
    private String ratingName;
    
    public AgeRating() {
    }
    
    public AgeRating(Integer ratingId, String ratingName) {
        this.ratingId = ratingId;
        this.ratingName = ratingName;
    }
    
    public Integer getRatingId() {
        return ratingId;
    }
    
    public void setRatingId(Integer ratingId) {
        this.ratingId = ratingId;
    }
    
    public String getRatingName() {
        return ratingName;
    }
    
    public void setRatingName(String ratingName) {
        this.ratingName = ratingName;
    }
}