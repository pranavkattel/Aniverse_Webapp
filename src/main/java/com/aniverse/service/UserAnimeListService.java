package com.aniverse.service;

import com.aniverse.config.DbConfig; // Import BigDecimal for score
import com.aniverse.model.UserAnimeEntry;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet; // Import Types for setting NULL
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

public class UserAnimeListService {

    private Connection dbConn;

    public UserAnimeListService() {
        // Connection will be initialized when needed
    }

    /**
     * Add an anime to user's list or update it if it already exists.
     *
     * @param userId User ID
     * @param animeId Anime ID
     * @param watchStatus Watch status
     * @param userScore User's score for the anime (can be null)
     * @param progress Number of episodes watched (can be null)
     * @param notes User's notes for the anime (can be null or empty)
     * @return true if successful, false otherwise
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    public boolean addOrUpdateAnimeInUserList(int userId, int animeId, String watchStatus,
                                           BigDecimal userScore, Integer progress, String notes)
            throws ClassNotFoundException, SQLException {

        if (isAnimeInUserList(userId, animeId)) {
            // Update the existing entry
            return updateAnimeInUserList(userId, animeId, watchStatus, userScore, progress, notes);
        } else {
            // Add new entry
            return addAnimeToUserList(userId, animeId, watchStatus, userScore, progress, notes);
        }
    }


    private boolean addAnimeToUserList(int userId, int animeId, String watchStatus,
                                      BigDecimal userScore, Integer progress, String notes)
            throws ClassNotFoundException, SQLException {

        dbConn = DbConfig.getDbConnection();
        boolean result = false;

        // Include new fields: user_score, progress, notes
        // The last_updated field will be set automatically by the database
        String sql = "INSERT INTO user_anime_list (user_id, anime_id, watch_status, user_score, progress, notes) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement preparedStatement = dbConn.prepareStatement(sql)) {
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, animeId);
            preparedStatement.setString(3, watchStatus);

            // Handle nullable fields
            if (userScore != null) {
                preparedStatement.setBigDecimal(4, userScore);
            } else {
                preparedStatement.setNull(4, Types.DECIMAL);
            }

            if (progress != null) {
                preparedStatement.setInt(5, progress);
            } else {
                preparedStatement.setNull(5, Types.INTEGER);
            }

            if (notes != null && !notes.isEmpty()) {
                preparedStatement.setString(6, notes);
            } else {
                preparedStatement.setNull(6, Types.VARCHAR);
            }

            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                result = true;
            }
        } finally {
            if (dbConn != null) {
                dbConn.close();
            }
        }
        return result;
    }

    /**
     * Check if anime is already in user's list
     *
     * @param userId User ID
     * @param animeId Anime ID
     * @return true if anime is already in user's list
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    public boolean isAnimeInUserList(int userId, int animeId)
            throws ClassNotFoundException, SQLException {

        dbConn = DbConfig.getDbConnection();
        boolean result = false;

        String sql = "SELECT entry_id FROM user_anime_list WHERE user_id = ? AND anime_id = ?";

        try (PreparedStatement preparedStatement = dbConn.prepareStatement(sql)) {
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, animeId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    result = true;
                }
            }
        } finally {
            if (dbConn != null) {
                dbConn.close();
            }
        }
        return result;
    }

    /**
     * Update anime details in user's list.
     *
     * @param userId User ID
     * @param animeId Anime ID
     * @param watchStatus New watch status
     * @param userScore User's score for the anime (can be null)
     * @param progress Number of episodes watched (can be null)
     * @param notes User's notes for the anime (can be null or empty)
     * @return true if successful, false otherwise
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    public boolean updateAnimeInUserList(int userId, int animeId, String watchStatus,
                                          BigDecimal userScore, Integer progress, String notes)
            throws ClassNotFoundException, SQLException {

        dbConn = DbConfig.getDbConnection();
        boolean result = false;

        // Dynamically build the SET part of the query if needed, or update all provided fields.
        // For simplicity, this example updates all provided fields.
        // last_updated will be updated automatically by the database.
        String sql = "UPDATE user_anime_list SET watch_status = ?, user_score = ?, progress = ?, notes = ? WHERE user_id = ? AND anime_id = ?";

        try (PreparedStatement preparedStatement = dbConn.prepareStatement(sql)) {
            preparedStatement.setString(1, watchStatus);

            if (userScore != null) {
                preparedStatement.setBigDecimal(2, userScore);
            } else {
                preparedStatement.setNull(2, Types.DECIMAL);
            }

            if (progress != null) {
                preparedStatement.setInt(3, progress);
            } else {
                preparedStatement.setNull(3, Types.INTEGER);
            }

            if (notes != null && !notes.trim().isEmpty()) {
                preparedStatement.setString(4, notes);
            } else {
                preparedStatement.setNull(4, Types.VARCHAR);
            }
            
            preparedStatement.setInt(5, userId);
            preparedStatement.setInt(6, animeId);

            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                result = true;
            }
        } finally {
            if (dbConn != null) {
                dbConn.close();
            }
        }
        return result;
    }

    /**
     * Update an anime entry in the user's list.
     *
     * @param entryId Entry ID
     * @param watchStatus New watch status
     * @param userScore New user score
     * @param progress New progress
     * @return true if successful, false otherwise
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    public boolean updateUserAnimeEntry(int entryId, String watchStatus, BigDecimal userScore, Integer progress)
            throws ClassNotFoundException, SQLException {
        dbConn = DbConfig.getDbConnection();
        String sql = "UPDATE user_anime_list SET watch_status = ?, user_score = ?, progress = ? WHERE entry_id = ?";
        try (PreparedStatement preparedStatement = dbConn.prepareStatement(sql)) {
            preparedStatement.setString(1, watchStatus);
            if (userScore != null) {
                preparedStatement.setBigDecimal(2, userScore);
            } else {
                preparedStatement.setNull(2, Types.DECIMAL);
            }
            if (progress != null) {
                preparedStatement.setInt(3, progress);
            } else {
                preparedStatement.setNull(3, Types.INTEGER);
            }
            preparedStatement.setInt(4, entryId);
            return preparedStatement.executeUpdate() > 0;
        } finally {
            if (dbConn != null) {
                dbConn.close();
            }
        }
    }

    /**
     * Delete an anime entry from the user's list.
     *
     * @param entryId Entry ID
     * @return true if successful, false otherwise
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    public boolean deleteUserAnimeEntry(int entryId) throws ClassNotFoundException, SQLException {
        dbConn = DbConfig.getDbConnection();
        String sql = "DELETE FROM user_anime_list WHERE entry_id = ?";
        try (PreparedStatement preparedStatement = dbConn.prepareStatement(sql)) {
            preparedStatement.setInt(1, entryId);
            return preparedStatement.executeUpdate() > 0;
        } finally {
            if (dbConn != null) {
                dbConn.close();
            }
        }
    }

    public List<UserAnimeEntry> getUserAnimeListWithDetails(int userId)
            throws ClassNotFoundException, SQLException {

        dbConn = DbConfig.getDbConnection();
        List<UserAnimeEntry> userAnimeList = new ArrayList<>();

        String sql = "SELECT ual.*, " +
                     "a.title, a.synopsis, a.type, a.episodes, a.episodes_aired, " +
                     "a.status, a.start_date, a.end_date, a.season, a.score as overall_score, " +
                     "a.duration, a.source, a.mal_id, " +
                     "s.studio_name, ar.rating_name " +
                     "FROM user_anime_list ual " +
                     "JOIN anime a ON ual.anime_id = a.anime_id " +
                     "LEFT JOIN studios s ON a.studio_id = s.studio_id " +
                     "LEFT JOIN age_ratings ar ON a.rating_id = ar.rating_id " +
                     "WHERE ual.user_id = ? " +
                     "ORDER BY ual.last_updated DESC";

        try (PreparedStatement preparedStatement = dbConn.prepareStatement(sql)) {
            preparedStatement.setInt(1, userId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    UserAnimeEntry entry = new UserAnimeEntry(
                        resultSet.getInt("entry_id"),
                        resultSet.getInt("user_id"),
                        resultSet.getInt("anime_id"),
                        resultSet.getString("watch_status"),
                        resultSet.getBigDecimal("user_score"), // Already fetching user_score
                        resultSet.getInt("progress"),         // Already fetching progress
                        resultSet.getString("notes"),           // Already fetching notes
                        resultSet.getTimestamp("last_updated"),
                        resultSet.getString("title"),
                        resultSet.getString("synopsis"),
                        resultSet.getString("type"),
                        resultSet.getInt("episodes"),
                        resultSet.getInt("episodes_aired"),
                        resultSet.getString("status"),
                        resultSet.getDate("start_date"),
                        resultSet.getDate("end_date"),
                        resultSet.getString("season"),
                        resultSet.getBigDecimal("overall_score"),
                        resultSet.getString("duration"),
                        resultSet.getString("source"),
                        resultSet.getInt("mal_id")
                    );

                    entry.setStudioName(resultSet.getString("studio_name"));
                    entry.setAgeRatingName(resultSet.getString("rating_name"));
                    userAnimeList.add(entry);
                }
            }

            for (UserAnimeEntry entry : userAnimeList) {
                entry.setGenres(getAnimeGenres(entry.getAnimeId()));
            }
        } finally {
            if (dbConn != null) {
                dbConn.close();
            }
        }
        return userAnimeList;
    }

    private List<String> getAnimeGenres(int animeId) throws ClassNotFoundException, SQLException {
        List<String> genres = new ArrayList<>();
        Connection genreConnection = DbConfig.getDbConnection();

        String sql = "SELECT g.name FROM anime_genres ag " +
                     "JOIN genre g ON ag.genre_id = g.genre_id " +
                     "WHERE ag.anime_id = ?";

        try (PreparedStatement preparedStatement = genreConnection.prepareStatement(sql)) {
            preparedStatement.setInt(1, animeId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    genres.add(resultSet.getString("name"));
                }
            }
        } finally {
            if (genreConnection != null) {
                genreConnection.close();
            }
        }
        return genres;
    }
}