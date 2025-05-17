package com.aniverse.model;

public class Studio {
    private Integer studioId;
    private String studioName;
    
    public Studio() {
    }
    
    public Studio(Integer studioId, String studioName) {
        this.studioId = studioId;
        this.studioName = studioName;
    }
    
    public Integer getStudioId() {
        return studioId;
    }
    
    public void setStudioId(Integer studioId) {
        this.studioId = studioId;
    }
    
    public String getStudioName() {
        return studioName;
    }
    
    public void setStudioName(String studioName) {
        this.studioName = studioName;
    }
}