package com.aniverse.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.aniverse.config.Dbconfig;
import com.aniverse.model.Anime;

public class AnimeDAO {

    /**
     * Retrieves all anime with their related data (studio, rating, genres)
     * @return List of Anime objects
     */
    public List<Anime> getAllAnimes() throws SQLException, ClassNotFoundException {
        List<Anime> animeList = new ArrayList<>();
        String sql = "SELECT a.*, s.studio_name, r.rating_name " +
                     "FROM anime a " +
                     "LEFT JOIN studios s ON a.studio_id = s.studio_id " +
                     "LEFT JOIN age_ratings r ON a.rating_id = r.rating_id " +
                     "ORDER BY a.title";

        try (Connection conn = Dbconfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            Map<Integer, Anime> animeMap = new HashMap<>();

            while (rs.next()) {
                int animeId = rs.getInt("anime_id");
                Anime anime = animeMap.get(animeId);
                if (anime == null) {
                    anime = mapRowToAnime(rs);
                    animeMap.put(animeId, anime);
                    animeList.add(anime);
                }
            }
            if (!animeMap.isEmpty()) {
                fetchGenresForAnimeList(animeMap, conn);
            }
        }
        return animeList;
    }


    
    

    public List<Anime> getAnimesByTitleAndGenre(String title, String genre, String status, int year) throws SQLException, ClassNotFoundException {
        List<Anime> animeList = new ArrayList<>();

        String sql = "SELECT a.*, s.studio_name, r.rating_name " +
                   "FROM anime a " +
                   "JOIN anime_genres ag ON a.anime_id = ag.anime_id " +
                   "JOIN genre g ON ag.genre_id = g.genre_id " +
                   "LEFT JOIN studios s ON a.studio_id = s.studio_id " +
                   "LEFT JOIN age_ratings r ON a.rating_id = r.rating_id " +
                   "WHERE a.title LIKE ? AND g.name LIKE ? " +
                   "AND (? = '' OR a.status = ?) " +
                   "AND (? = 0 OR YEAR(a.start_date) = ?) " +
                   "ORDER BY a.title";

        try (Connection conn = Dbconfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + title + "%");
            stmt.setString(2, "%" + genre + "%");
            stmt.setString(3, status);
            stmt.setString(4, status);
            stmt.setInt(5, year);
            stmt.setInt(6, year);

            try (ResultSet rs = stmt.executeQuery()) {
                Map<Integer, Anime> animeMap = new HashMap<>();
                while (rs.next()) {
                    int animeId = rs.getInt("anime_id");
                    Anime anime = animeMap.get(animeId);
                    if (anime == null) {
                        anime = mapRowToAnime(rs);
                        animeMap.put(animeId, anime);
                        animeList.add(anime);
                    }
                }
                if (!animeMap.isEmpty()) {
                    fetchGenresForAnimeList(animeMap, conn);
                }
            }
        }

        return animeList;
    }

    public int addAnime(Anime anime, List<Integer> genreIds) throws SQLException, ClassNotFoundException {
        int generatedAnimeId = -1;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = Dbconfig.getDbConnection();
            conn.setAutoCommit(false); // Start transaction
            
            String sql = "INSERT INTO anime (title, synopsis, type, episodes, episodes_aired, status, " +
                        "start_date, end_date, season, studio_id, rating_id, score, duration, source) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            stmt.setString(1, anime.getTitle());
            stmt.setString(2, anime.getSynopsis());
            stmt.setString(3, anime.getType());
            
            if (anime.getEpisodes() != null) {
                stmt.setInt(4, anime.getEpisodes());
            } else {
                stmt.setNull(4, java.sql.Types.INTEGER);
            }
            
            if (anime.getEpisodesAired() != null) {
                stmt.setInt(5, anime.getEpisodesAired());
            } else {
                stmt.setNull(5, java.sql.Types.INTEGER);
            }
            
            stmt.setString(6, anime.getStatus());
            
            if (anime.getStartDate() != null) {
                stmt.setDate(7, new java.sql.Date(anime.getStartDate().getTime()));
            } else {
                stmt.setNull(7, java.sql.Types.DATE);
            }
            
            if (anime.getEndDate() != null) {
                stmt.setDate(8, new java.sql.Date(anime.getEndDate().getTime()));
            } else {
                stmt.setNull(8, java.sql.Types.DATE);
            }
            
            stmt.setString(9, anime.getSeason());
            
            if (anime.getStudioId() != null) {
                stmt.setInt(10, anime.getStudioId());
            } else {
                stmt.setNull(10, java.sql.Types.INTEGER);
            }
            
            if (anime.getRatingId() != null) {
                stmt.setInt(11, anime.getRatingId());
            } else {
                stmt.setNull(11, java.sql.Types.INTEGER);
            }
            
            if (anime.getScore() != null) {
                stmt.setBigDecimal(12, anime.getScore());
            } else {
                stmt.setNull(12, java.sql.Types.DECIMAL);
            }
            
            stmt.setString(13, anime.getDuration());
            stmt.setString(14, anime.getSource());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Creating anime failed, no rows affected.");
            }
            
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                generatedAnimeId = rs.getInt(1);
                
                // Insert genre associations if genres are provided
                if (genreIds != null && !genreIds.isEmpty()) {
                    insertAnimeGenres(conn, generatedAnimeId, genreIds);
                }
                
                conn.commit(); // Commit transaction
            } else {
                conn.rollback(); // Rollback if no ID was generated
                throw new SQLException("Creating anime failed, no ID obtained.");
            }
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback on error
                } catch (SQLException ex) {
                    throw new SQLException("Error rolling back transaction: " + ex.getMessage());
                }
            }
            throw e;
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.setAutoCommit(true); // Reset auto-commit
                conn.close();
            }
        }
        
        return generatedAnimeId;
    }

    private void insertAnimeGenres(Connection conn, int animeId, List<Integer> genreIds) throws SQLException {
        String sql = "INSERT INTO anime_genres (anime_id, genre_id) VALUES (?, ?)";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (Integer genreId : genreIds) {
                stmt.setInt(1, animeId);
                stmt.setInt(2, genreId);
                stmt.addBatch();
            }
            stmt.executeBatch();
        }
    }
    

    /**
     * Retrieves a single anime by its ID with related data.
     * @param animeId The ID of the anime to retrieve.
     * @return An Anime object, or null if not found.
     */
    public Anime getAnimeById(int animeId) throws SQLException, ClassNotFoundException {
        Anime anime = null;
        String sql = "SELECT a.*, s.studio_name, r.rating_name " +
                     "FROM anime a " +
                     "LEFT JOIN studios s ON a.studio_id = s.studio_id " +
                     "LEFT JOIN age_ratings r ON a.rating_id = r.rating_id " +
                     "WHERE a.anime_id = ?";

        try (Connection conn = Dbconfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, animeId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    anime = mapRowToAnime(rs);
                    // Fetch genres for this single anime
                    Map<Integer, Anime> animeMap = new HashMap<>();
                    animeMap.put(anime.getAnimeId(), anime);
                    fetchGenresForAnimeList(animeMap, conn);
                }
            }
        }
        return anime;
    }


    /**
     * Adds a new anime to the database.
     * @param newAnime The Anime object to add.
     * @return The added Anime object, with its new ID.
     */

    /**
     * Updates an existing anime in the database.
     * @param animeToUpdate The Anime object to update.
     * @return The updated Anime object.
     */
    public Anime updateAnime(Anime animeToUpdate) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE anime SET title = ?, synopsis = ?, type = ?, episodes = ?, episodes_aired = ?, status = ?, start_date = ?, end_date = ?, season = ?, studio_id = ?, rating_id = ?, score = ?, duration = ?, source = ?, mal_id = ? " +
                     "WHERE anime_id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = Dbconfig.getDbConnection();
            conn.setAutoCommit(false); // Start transaction

            // Resolve studio_id and rating_id
            Integer studioId = animeToUpdate.getStudioId();
            if (studioId == null && animeToUpdate.getStudioName() != null && !animeToUpdate.getStudioName().isEmpty()){
                studioId = resolveStudioId(animeToUpdate.getStudioName(), conn);
            }

            Integer ratingId = animeToUpdate.getRatingId();
            if (ratingId == null && animeToUpdate.getRatingName() != null && !animeToUpdate.getRatingName().isEmpty()){
                 ratingId = resolveRatingId(animeToUpdate.getRatingName(), conn);
            }


            stmt = conn.prepareStatement(sql);
            stmt.setString(1, animeToUpdate.getTitle());
            stmt.setString(2, animeToUpdate.getSynopsis());
            stmt.setString(3, animeToUpdate.getType());
            setNullableInt(stmt, 4, animeToUpdate.getEpisodes());
            setNullableInt(stmt, 5, animeToUpdate.getEpisodesAired());
            stmt.setString(6, animeToUpdate.getStatus());
            stmt.setDate(7, animeToUpdate.getStartDate() != null ? new java.sql.Date(animeToUpdate.getStartDate().getTime()) : null);
            stmt.setDate(8, animeToUpdate.getEndDate() != null ? new java.sql.Date(animeToUpdate.getEndDate().getTime()) : null);
            stmt.setString(9, animeToUpdate.getSeason());
            setNullableInt(stmt, 10, studioId);
            setNullableInt(stmt, 11, ratingId);
            stmt.setBigDecimal(12, animeToUpdate.getScore());
            stmt.setString(13, animeToUpdate.getDuration());
            stmt.setString(14, animeToUpdate.getSource());
            setNullableInt(stmt, 15, animeToUpdate.getMalId());
            stmt.setInt(16, animeToUpdate.getAnimeId());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Updating anime failed, no rows affected. Anime ID: " + animeToUpdate.getAnimeId() + " might not exist.");
            }

            // Update genres: delete existing and add new ones
            deleteAnimeGenres(animeToUpdate.getAnimeId(), conn);
            if (animeToUpdate.getGenres() != null && !animeToUpdate.getGenres().isEmpty()) {
                updateAnimeGenres(animeToUpdate.getAnimeId(), animeToUpdate.getGenres(), conn);
            }

            conn.commit(); // Commit transaction

            // Set resolved names for returning the object
            animeToUpdate.setStudioId(studioId);
            animeToUpdate.setRatingId(ratingId);
            animeToUpdate.setStudioName(getStudioNameById(studioId, conn));
            animeToUpdate.setRatingName(getRatingNameById(ratingId, conn));


        } catch (SQLException | ClassNotFoundException e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback transaction on error
                } catch (SQLException ex) {
                     System.err.println("Rollback failed: " + ex.getMessage());
                }
            }
            throw e; // Re-throw the original exception
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { /* ignored */ }
            if (conn != null) {
                try {
                    conn.setAutoCommit(true); // Restore auto-commit
                    conn.close();
                } catch (SQLException e) { /* ignored */ }
            }
        }
        return animeToUpdate;
    }

    /**
     * Deletes an anime by its ID.
     * @param animeId The ID of the anime to delete.
     * @return true if deletion was successful, false otherwise.
     */
    public boolean deleteAnime(int animeId) throws SQLException, ClassNotFoundException {
        String deleteAnimeGenresSql = "DELETE FROM anime_genres WHERE anime_id = ?";
        String deleteAnimeSql = "DELETE FROM anime WHERE anime_id = ?";
        Connection conn = null;
        PreparedStatement stmtGenres = null;
        PreparedStatement stmtAnime = null;
        boolean deleted = false;

        try {
            conn = Dbconfig.getDbConnection();
            conn.setAutoCommit(false); // Start transaction

            // Delete from anime_genres first due to foreign key constraints
            stmtGenres = conn.prepareStatement(deleteAnimeGenresSql);
            stmtGenres.setInt(1, animeId);
            stmtGenres.executeUpdate(); // We don't strictly need to check rows affected here

            // Delete from anime
            stmtAnime = conn.prepareStatement(deleteAnimeSql);
            stmtAnime.setInt(1, animeId);
            int affectedRows = stmtAnime.executeUpdate();

            if (affectedRows > 0) {
                deleted = true;
            }

            conn.commit(); // Commit transaction
        } catch (SQLException | ClassNotFoundException e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback transaction on error
                } catch (SQLException ex) {
                    System.err.println("Rollback failed: " + ex.getMessage());
                }
            }
            throw e; // Re-throw the original exception
        } finally {
            if (stmtGenres != null) try { stmtGenres.close(); } catch (SQLException e) { /* ignored */ }
            if (stmtAnime != null) try { stmtAnime.close(); } catch (SQLException e) { /* ignored */ }
            if (conn != null) {
                try {
                    conn.setAutoCommit(true); // Restore auto-commit
                    conn.close();
                } catch (SQLException e) { /* ignored */ }
            }
        }
        return deleted;
    }


    private Integer resolveStudioId(String studioName, Connection conn) throws SQLException {
        if (studioName == null || studioName.trim().isEmpty()) {
            return null;
        }
        String sql = "SELECT studio_id FROM studios WHERE studio_name = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studioName);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("studio_id");
                } else {
                    // Optionally, insert the new studio and return its ID
                    // For now, returning null if not found
                    // System.out.println("Studio not found: " + studioName + ". Consider adding it or handling this case.");
                    return null;
                }
            }
        }
    }

    private String getStudioNameById(Integer studioId, Connection conn) throws SQLException {
        if (studioId == null) return null;
        String sql = "SELECT studio_name FROM studios WHERE studio_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, studioId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("studio_name");
                }
            }
        }
        return null;
    }


    private Integer resolveRatingId(String ratingName, Connection conn) throws SQLException {
        if (ratingName == null || ratingName.trim().isEmpty()) {
            return null;
        }
        String sql = "SELECT rating_id FROM age_ratings WHERE rating_name = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, ratingName);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("rating_id");
                } else {
                    // Optionally, insert new rating and return its ID
                    // System.out.println("Rating not found: " + ratingName + ". Consider adding it or handling this case.");
                    return null;
                }
            }
        }
    }

    private String getRatingNameById(Integer ratingId, Connection conn) throws SQLException {
        if (ratingId == null) return null;
        String sql = "SELECT rating_name FROM age_ratings WHERE rating_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, ratingId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("rating_name");
                }
            }
        }
        return null;
    }


    private Integer getGenreIdByName(String genreName, Connection conn) throws SQLException {
        String sql = "SELECT genre_id FROM genre WHERE name = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, genreName);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("genre_id");
                } else {
                    // Optionally, create the genre if it doesn't exist
                    // For simplicity, we'll assume genres exist or throw an error implicitly
                    // throw new SQLException("Genre not found: " + genreName);
                     System.err.println("Genre not found: " + genreName + ". It will not be added.");
                    return null; // Or throw exception
                }
            }
        }
    }

    private void updateAnimeGenres(int animeId, List<String> genreNames, Connection conn) throws SQLException {
        String insertGenreSql = "INSERT INTO anime_genres (anime_id, genre_id) VALUES (?, ?)";
        try (PreparedStatement stmtGenre = conn.prepareStatement(insertGenreSql)) {
            for (String genreName : genreNames) {
                Integer genreId = getGenreIdByName(genreName, conn);
                if (genreId != null) { // Only add if genre exists
                    stmtGenre.setInt(1, animeId);
                    stmtGenre.setInt(2, genreId);
                    stmtGenre.addBatch();
                } else {
                    System.err.println("Skipping non-existent genre: " + genreName + " for anime_id: " + animeId);
                }
            }
            stmtGenre.executeBatch();
        }
    }

    private void deleteAnimeGenres(int animeId, Connection conn) throws SQLException {
        String sql = "DELETE FROM anime_genres WHERE anime_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, animeId);
            stmt.executeUpdate();
        }
    }


    // Helper to set nullable integers in PreparedStatement
    private void setNullableInt(PreparedStatement stmt, int parameterIndex, Integer value) throws SQLException {
        if (value != null) {
            stmt.setInt(parameterIndex, value);
        } else {
            stmt.setNull(parameterIndex, java.sql.Types.INTEGER);
        }
    }


    /**
     * Retrieves anime with filtering and pagination
     */
    public List<Anime> getFilteredAnimes(String genre, String studio, String status,
                                         String sortBy, int page, int pageSize)
                                         throws SQLException, ClassNotFoundException {
        List<Anime> animeList = new ArrayList<>();
        StringBuilder sqlBuilder = new StringBuilder();
        List<Object> params = new ArrayList<>();

        sqlBuilder.append("SELECT DISTINCT a.*, s.studio_name, r.rating_name FROM anime a ");
        sqlBuilder.append("LEFT JOIN studios s ON a.studio_id = s.studio_id ");
        sqlBuilder.append("LEFT JOIN age_ratings r ON a.rating_id = r.rating_id ");

        if (genre != null && !genre.isEmpty()) {
            sqlBuilder.append("JOIN anime_genres ag ON a.anime_id = ag.anime_id ");
            sqlBuilder.append("JOIN genre g ON ag.genre_id = g.genre_id ");
        }

        boolean whereAdded = false;

        if (genre != null && !genre.isEmpty()) {
            sqlBuilder.append(" WHERE g.name = ? ");
            params.add(genre);
            whereAdded = true;
        }

        if (studio != null && !studio.isEmpty()) {
            if (whereAdded) {
                sqlBuilder.append(" AND s.studio_name = ? ");
            } else {
                sqlBuilder.append(" WHERE s.studio_name = ? ");
                whereAdded = true;
            }
            params.add(studio);
        }

        if (status != null && !status.isEmpty()) {
            if (whereAdded) {
                sqlBuilder.append(" AND a.status = ? ");
            } else {
                sqlBuilder.append(" WHERE a.status = ? ");
            }
            params.add(status);
        }

        if (sortBy != null && !sortBy.isEmpty()) {
            switch (sortBy.toLowerCase()) {
                case "title":
                    sqlBuilder.append(" ORDER BY a.title ASC ");
                    break;
                case "score":
                    sqlBuilder.append(" ORDER BY a.score DESC ");
                    break;
                case "recent": // Assuming 'recent' means by start_date descending
                    sqlBuilder.append(" ORDER BY a.start_date DESC ");
                    break;
                default:
                    sqlBuilder.append(" ORDER BY a.title ASC ");
            }
        } else {
            sqlBuilder.append(" ORDER BY a.title ASC ");
        }

        int offset = (page - 1) * pageSize;
        sqlBuilder.append(" LIMIT ? OFFSET ? ");
        params.add(pageSize);
        params.add(offset);

        try (Connection conn = Dbconfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sqlBuilder.toString())) {

            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            ResultSet rs = stmt.executeQuery();
            Map<Integer, Anime> animeMap = new HashMap<>();

            while (rs.next()) {
                int animeId = rs.getInt("anime_id");
                Anime anime = animeMap.get(animeId);
                if (anime == null) { // Ensure distinct anime if multiple genres match
                    anime = mapRowToAnime(rs);
                    animeMap.put(animeId, anime);
                    animeList.add(anime);
                }
            }
            if (!animeMap.isEmpty()) {
                 fetchGenresForAnimeList(animeMap, conn);
            }
        }
        return animeList;
    }


    public int getTotalAnimeCount(String genre, String studio, String status)
                                    throws SQLException, ClassNotFoundException {
        StringBuilder sqlBuilder = new StringBuilder();
        List<Object> params = new ArrayList<>();

        sqlBuilder.append("SELECT COUNT(DISTINCT a.anime_id) as total FROM anime a ");

        if (genre != null && !genre.isEmpty()) {
            sqlBuilder.append("LEFT JOIN anime_genres ag ON a.anime_id = ag.anime_id ");
            sqlBuilder.append("LEFT JOIN genre g ON ag.genre_id = g.genre_id ");
        }

        if (studio != null && !studio.isEmpty()) {
            sqlBuilder.append("LEFT JOIN studios s ON a.studio_id = s.studio_id ");
        }

        boolean whereAdded = false;

        if (genre != null && !genre.isEmpty()) {
            sqlBuilder.append(" WHERE g.name = ? ");
            params.add(genre);
            whereAdded = true;
        }

        if (studio != null && !studio.isEmpty()) {
            if (whereAdded) {
                sqlBuilder.append(" AND s.studio_name = ? ");
            } else {
                sqlBuilder.append(" WHERE s.studio_name = ? ");
                whereAdded = true;
            }
            params.add(studio);
        }

        if (status != null && !status.isEmpty()) {
            if (whereAdded) {
                sqlBuilder.append(" AND a.status = ? ");
            } else {
                sqlBuilder.append(" WHERE a.status = ? ");
            }
            params.add(status);
        }

        try (Connection conn = Dbconfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sqlBuilder.toString())) {

            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        }
        return 0;
    }


    public List<String> getAllGenres() throws SQLException, ClassNotFoundException {
        List<String> genres = new ArrayList<>();
        String sql = "SELECT name FROM genre ORDER BY name";

        try (Connection conn = Dbconfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                genres.add(rs.getString("name"));
            }
        }
        return genres;
    }


    public List<String> getAllStudios() throws SQLException, ClassNotFoundException {
        List<String> studios = new ArrayList<>();
        String sql = "SELECT studio_name FROM studios ORDER BY studio_name";

        try (Connection conn = Dbconfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                studios.add(rs.getString("studio_name"));
            }
        }
        return studios;
    }


    public List<String> getAllStatuses() throws SQLException, ClassNotFoundException {
        List<String> statuses = new ArrayList<>();
        String sql = "SELECT DISTINCT status FROM anime WHERE status IS NOT NULL ORDER BY status";

        try (Connection conn = Dbconfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                statuses.add(rs.getString("status"));
            }
        }
        return statuses;
    }


    private Anime mapRowToAnime(ResultSet rs) throws SQLException {
        Anime anime = new Anime();
        anime.setAnimeId(rs.getInt("anime_id"));
        anime.setTitle(rs.getString("title"));
        anime.setSynopsis(rs.getString("synopsis"));
        anime.setType(rs.getString("type"));
        anime.setEpisodes(rs.getObject("episodes") != null ? rs.getInt("episodes") : null);
        anime.setEpisodesAired(rs.getObject("episodes_aired") != null ? rs.getInt("episodes_aired") : null);
        anime.setStatus(rs.getString("status"));
        anime.setStartDate(rs.getDate("start_date"));
        anime.setEndDate(rs.getDate("end_date"));
        anime.setSeason(rs.getString("season"));

        Object studioIdObj = rs.getObject("studio_id");
        if (studioIdObj != null) {
            anime.setStudioId((Integer)studioIdObj);
        }

        Object ratingIdObj = rs.getObject("rating_id");
        if (ratingIdObj != null) {
            anime.setRatingId((Integer)ratingIdObj);
        }

        anime.setScore(rs.getBigDecimal("score"));
        anime.setDuration(rs.getString("duration"));
        anime.setSource(rs.getString("source"));

        Object malIdObj = rs.getObject("mal_id");
        if (malIdObj != null) {
            anime.setMalId((Integer) malIdObj);
        }

        anime.setStudioName(rs.getString("studio_name")); // Comes from JOIN
        anime.setRatingName(rs.getString("rating_name")); // Comes from JOIN

        return anime;
    }


    private void fetchGenresForAnimeList(Map<Integer, Anime> animeMap, Connection conn) throws SQLException {
        if (animeMap.isEmpty()) {
            return;
        }

        // Create a placeholder string for IN clause: (?, ?, ?, ...)
        String placeholders = animeMap.keySet().stream()
                                .map(id -> "?")
                                .collect(Collectors.joining(","));

        String sql = "SELECT ag.anime_id, g.name " +
                     "FROM anime_genres ag " +
                     "JOIN genre g ON ag.genre_id = g.genre_id " +
                     "WHERE ag.anime_id IN (" + placeholders + ")";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            int i = 1;
            for (Integer animeId : animeMap.keySet()) {
                stmt.setInt(i++, animeId);
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int animeId = rs.getInt("anime_id");
                    String genreName = rs.getString("name");
                    Anime anime = animeMap.get(animeId);
                    if (anime != null) {
                        anime.addGenre(genreName);
                    }
                }
            }
        }
    }
}