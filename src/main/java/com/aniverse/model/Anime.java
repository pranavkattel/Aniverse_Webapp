package com.aniverse.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class Anime {
    // Primary fields from anime table
    private int animeId;
    private String title;
    private String synopsis;
    private String type;
    private Integer episodes;
    private Integer episodesAired;
    private String status;
    private Date startDate;
    private Date endDate;
    private String season;
    private int studioId;
    private int ratingId;
    private BigDecimal score;
    private String duration;
    private String source;
    private Integer malId;
    
    // Related entity fields
    private String studioName;
    private String ratingName;
    private List<String> genres;
    
    // Constructor
    public Anime() {
        this.genres = new ArrayList<>();
    }
    
    // Full constructor
    public Anime(int animeId, String title, String synopsis, String type, Integer episodes, Integer episodesAired,
                String status, Date startDate, Date endDate, String season, int studioId, int ratingId,
                BigDecimal score, String duration, String source, Integer malId) {
        this.animeId = animeId;
        this.title = title;
        this.synopsis = synopsis;
        this.type = type;
        this.episodes = episodes;
        this.episodesAired = episodesAired;
        this.status = status;
        this.startDate = startDate;
        this.endDate = endDate;
        this.season = season;
        this.studioId = studioId;
        this.ratingId = ratingId;
        this.score = score;
        this.duration = duration;
        this.source = source;
        this.malId = malId;
        this.genres = new ArrayList<>();
    }
    
    // Getters and Setters
    public int getAnimeId() {
        return animeId;
    }
    
    public void setAnimeId(int animeId) {
        this.animeId = animeId;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getSynopsis() {
        return synopsis;
    }
    
    public void setSynopsis(String synopsis) {
        this.synopsis = synopsis;
    }
    
    public String getType() {
        return type;
    }
    
    public void setType(String type) {
        this.type = type;
    }
    
    public Integer getEpisodes() {
        return episodes;
    }
    
    public void setEpisodes(Integer episodes) {
        this.episodes = episodes;
    }
    
    public Integer getEpisodesAired() {
        return episodesAired;
    }
    
    public void setEpisodesAired(Integer episodesAired) {
        this.episodesAired = episodesAired;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Date getStartDate() {
        return startDate;
    }
    
    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }
    
    public Date getEndDate() {
        return endDate;
    }
    
    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
    
    public String getSeason() {
        return season;
    }
    
    public void setSeason(String season) {
        this.season = season;
    }
    
    public Integer getStudioId() {
        return studioId;
    }
    
    public void setStudioId(int studioId) {
        this.studioId = studioId;
    }
    
    public Integer getRatingId() {
        return ratingId;
    }
    
    public void setRatingId(int ratingId) {
        this.ratingId = ratingId;
    }
    
    public BigDecimal getScore() {
        return score;
    }
    
    public void setScore(BigDecimal score) {
        this.score = score;
    }
    
    public String getDuration() {
        return duration;
    }
    
    public void setDuration(String duration) {
        this.duration = duration;
    }
    
    public String getSource() {
        return source;
    }
    
    public void setSource(String source) {
        this.source = source;
    }
    
    public Integer getMalId() {
        return malId;
    }
    
    public void setMalId(Integer malId) {
        this.malId = malId;
    }
    
    // Related entity getters and setters
    public String getStudioName() {
        return studioName;
    }
    
    public void setStudioName(String studioName) {
        this.studioName = studioName;
    }
    
    public String getRatingName() {
        return ratingName;
    }
    
    public void setRatingName(String ratingName) {
        this.ratingName = ratingName;
    }
    
    public List<String> getGenres() {
        return genres;
    }
    
    public void setGenres(List<String> genres) {
        this.genres = genres;
    }
    
    public void addGenre(String genre) {
        if (this.genres == null) {
            this.genres = new ArrayList<>();
        }
        this.genres.add(genre);
    }
    
    @Override
    public String toString() {
        return "Anime{" +
                "animeId=" + animeId +
                ", title='" + title + '\'' +
                ", type='" + type + '\'' +
                ", episodes=" + episodes +
                ", status='" + status + '\'' +
                ", score=" + score +
                ", studio='" + studioName + '\'' +
                ", genres=" + genres +
                '}';
    }
}