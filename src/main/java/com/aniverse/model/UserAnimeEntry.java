package com.aniverse.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.List; // For genres

public class UserAnimeEntry {
    // Fields from user_anime_list
    private int entryId;
    private int userId;
    private int animeId;
    private String watchStatus;
    private BigDecimal userScore;
    private Integer progress; // Can be null
    private String notes;
    private Timestamp lastUpdated;

    // Fields from anime table
    private String title;
    private String synopsis;
    private String type;
    private Integer episodes; // Total episodes
    private Integer episodesAired; // For user's progress reference if needed
    private String status; // Anime's general status (e.g., "Finished Airing")
    private Date startDate;
    private Date endDate;
    private String season;
    private BigDecimal overallScore; // Anime's general score
    private String duration;
    private String source;
    private Integer malId;

    // Potentially joined fields (optional, but good for display)
    private String studioName;
    private String ageRatingName;
    private List<String> genres; // List of genre names

    // Constructor
    public UserAnimeEntry(int entryId, int userId, int animeId, String watchStatus, BigDecimal userScore,
                          Integer progress, String notes, Timestamp lastUpdated, String title, String synopsis,
                          String type, Integer episodes, Integer episodesAired, String status, Date startDate,
                          Date endDate, String season, BigDecimal overallScore, String duration,
                          String source, Integer malId) {
        this.entryId = entryId;
        this.userId = userId;
        this.animeId = animeId;
        this.watchStatus = watchStatus;
        this.userScore = userScore;
        this.progress = progress;
        this.notes = notes;
        this.lastUpdated = lastUpdated;
        this.title = title;
        this.synopsis = synopsis;
        this.type = type;
        this.episodes = episodes;
        this.episodesAired = episodesAired;
        this.status = status;
        this.startDate = startDate;
        this.endDate = endDate;
        this.season = season;
        this.overallScore = overallScore;
        this.duration = duration;
        this.source = source;
        this.malId = malId;
    }

    // Getters and Setters for all fields (omitted for brevity, but you should add them)
    // Example Getter/Setter:
    public int getEntryId() { return entryId; }
    public void setEntryId(int entryId) { this.entryId = entryId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getWatchStatus() { return watchStatus; }
    public void setWatchStatus(String watchStatus) { this.watchStatus = watchStatus; }
    public BigDecimal getUserScore() { return userScore; }
    public void setUserScore(BigDecimal userScore) { this.userScore = userScore; }
    public Integer getProgress() { return progress; }
    public void setProgress(Integer progress) { this.progress = progress; }
    // ... and so on for all fields

    public List<String> getGenres() { return genres; }
    public void setGenres(List<String> genres) { this.genres = genres; }
    public String getStudioName() { return studioName; }
    public void setStudioName(String studioName) { this.studioName = studioName; }
    public String getAgeRatingName() { return ageRatingName; }
    public void setAgeRatingName(String ageRatingName) { this.ageRatingName = ageRatingName; }
    public Integer getEpisodes() { return episodes; }
    public void setEpisodes(Integer episodes) { this.episodes = episodes; }
    public String getSynopsis() { return synopsis; }
    public void setSynopsis(String synopsis) { this.synopsis = synopsis; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public Integer getEpisodesAired() { return episodesAired; }
    public void setEpisodesAired(Integer episodesAired) { this.episodesAired = episodesAired; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }
    public Date getEndDate() { return endDate; }
    public void setEndDate(Date endDate) { this.endDate = endDate; }
    public String getSeason() { return season; }
    public void setSeason(String season) { this.season = season; }
    public BigDecimal getOverallScore() { return overallScore; }
    public void setOverallScore(BigDecimal overallScore) { this.overallScore = overallScore; }
    public String getDuration() { return duration; }
    public void setDuration(String duration) { this.duration = duration; }
    public String getSource() { return source; }
    public void setSource(String source) { this.source = source; }
    public Integer getMalId() { return malId; }
    public void setMalId(Integer malId) { this.malId = malId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getAnimeId() { return animeId; }
    public void setAnimeId(int animeId) { this.animeId = animeId; }
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
    public Timestamp getLastUpdated() { return lastUpdated; }
    public void setLastUpdated(Timestamp lastUpdated) { this.lastUpdated = lastUpdated; }


    @Override
    public String toString() {
        return "UserAnimeEntry{" +
                "entryId=" + entryId +
                ", userId=" + userId +
                ", animeId=" + animeId +
                ", watchStatus='" + watchStatus + '\'' +
                ", userScore=" + userScore +
                ", progress=" + progress +
                ", title='" + title + '\'' +
                ", episodes=" + episodes +
                ", status='" + status + '\'' +
                // Add other fields if needed for quick debugging
                '}';
    }
}