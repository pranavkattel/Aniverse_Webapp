package com.aniverse.service;

import com.aniverse.config.DbConfig;
import com.aniverse.model.User;
import com.aniverse.model.UserAnimeEntry;
import com.aniverse.util.PasswordUtil;
import java.sql.*;
import java.util.ArrayList; // Assuming you have this User model
import java.util.List; // Assuming you have this DB config
// *** IMPORTANT: Add a password hashing library dependency (e.g., BCrypt) ***
// Example Maven dependency for BCrypt:
// <dependency>
//     <groupId>org.mindrot</groupId>
//     <artifactId>jbcrypt</artifactId>
//     <version>0.4</version> // Or the latest version
// </dependency>
// import org.mindrot.jbcrypt.BCrypt; // Import the hashing library

public class Service {
    private Connection dbConn;
    private boolean isConnectionError = false;

    public Service() {
        try {
            dbConn = DbConfig.getDbConnection();
            if (dbConn == null) {
                System.err.println("Failed to establish database connection.");
                isConnectionError = true;
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace(); // Log the full stack trace
            System.err.println("Exception during DB connection setup: " + ex.getMessage());
            isConnectionError = true;
        }
    }

    // --- Helper method to execute simple count queries ---
    private int getCount(String query) {
        if (isConnectionError) return 0;
        try (PreparedStatement stmt = dbConn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error executing count query [" + query + "]: " + e.getMessage());
            e.printStackTrace();
        }
        return 0; // Return 0 if no result or error
    }

     // --- Helper method to execute simple string result queries ---
    private String getStringValue(String query) {
        if (isConnectionError) return "N/A";
        try (PreparedStatement stmt = dbConn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (SQLException e) {
            System.err.println("Error executing string query [" + query + "]: " + e.getMessage());
            e.printStackTrace();
        }
        return "N/A"; // Return default if no result or error
    }


    // --- Dashboard Stat Methods (Keep them here or move to another service) ---
    // ... (Your existing dashboard methods: getTotalUserCount, getTotalAnimeCount, etc.) ...
    public int getTotalUserCount() { return getCount("SELECT COUNT(*) FROM users"); }
    public int getTotalAnimeCount() { return getCount("SELECT COUNT(*) FROM anime"); } // Example query
    public int getNewUsersTodayCount() { return getCount("SELECT COUNT(*) FROM users WHERE DATE(created_at) = CURDATE()"); }
    public int getReviewsTodayCount() { return getCount("SELECT COUNT(*) FROM reviews WHERE DATE(review_date) = CURDATE()"); } // Example query
    public int getTotalWatchlistCount() { return getCount("SELECT COUNT(*) FROM user_watchlists"); } // Example query
    public int getAnimeAddedThisMonthCount() { return getCount("SELECT COUNT(*) FROM anime WHERE YEAR(added_date) = YEAR(CURDATE()) AND MONTH(added_date) = MONTH(CURDATE())"); } // Example query
    public String getTopGenre() { return getStringValue("SELECT g.name FROM anime_genres ag JOIN genre g ON ag.genre_id = g.genre_id GROUP BY g.name ORDER BY COUNT(ag.anime_id) DESC LIMIT 1;"); }
    public int getTotalCommentCount() { return getCount("SELECT COUNT(*) FROM comments"); } // Example query
    public int getCommentsTodayCount() { return getCount("SELECT COUNT(*) FROM comments WHERE DATE(comment_date) = CURDATE()"); } // Example query
    public String getHighestRatedAnime() { return getStringValue("select title from anime where score = (select max(score) from anime);"); }
    public int getModerationQueueCount() { return getCount("SELECT COUNT(*) FROM content WHERE status = 'pending_moderation'"); } // Example query
    public int getReportedContentCount() { return getCount("SELECT COUNT(*) FROM reports WHERE status = 'open'"); } // Example query
    public String getMostDiscussedAnime() { return getStringValue("SELECT a.title FROM anime a JOIN comments c ON a.anime_id = c.anime_id WHERE c.comment_date >= CURDATE() - INTERVAL 7 DAY GROUP BY a.title ORDER BY COUNT(c.comment_id) DESC LIMIT 1"); }
    public String getTopSeason() { return getStringValue("select season from anime group by season order by count(*) desc limit 1;"); }
    public int getActionAnimes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime_genres ag JOIN genre g ON ag.genre_id = g.genre_id WHERE g.name = 'Action'"); }
    public int getAdventureAnimes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime_genres ag JOIN genre g ON ag.genre_id = g.genre_id WHERE g.name = 'Adventure'"); }
    public int getComedyAnimes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime_genres ag JOIN genre g ON ag.genre_id = g.genre_id WHERE g.name = 'Comedy'"); }
    public int getDramaAnimes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime_genres ag JOIN genre g ON ag.genre_id = g.genre_id WHERE g.name = 'Drama'"); }
    public int getFantasyAnimes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime_genres ag JOIN genre g ON ag.genre_id = g.genre_id WHERE g.name = 'Fantasy'"); }
    public int getHistoricalAnimes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime_genres ag JOIN genre g ON ag.genre_id = g.genre_id WHERE g.name = 'Historical'"); }
    public int getHorrorAnimes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime_genres ag JOIN genre g ON ag.genre_id = g.genre_id WHERE g.name = 'Horror'"); }
    public int getMagicAnimes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime_genres ag JOIN genre g ON ag.genre_id = g.genre_id WHERE g.name = 'Magic'"); }
    public int getMechaAnimes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime_genres ag JOIN genre g ON ag.genre_id = g.genre_id WHERE g.name = 'Mecha'"); }
    public int getMusicAnimes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime_genres ag JOIN genre g ON ag.genre_id = g.genre_id WHERE g.name = 'Music'"); }
    public int getMysteryAnimes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime_genres ag JOIN genre g ON ag.genre_id = g.genre_id WHERE g.name = 'Mystery'"); }
    public int getRomanceAnimes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime_genres ag JOIN genre g ON ag.genre_id = g.genre_id WHERE g.name = 'Romance'"); }
    public int getSchoolAnimes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime_genres ag JOIN genre g ON ag.genre_id = g.genre_id WHERE g.name = 'School'"); }
    public int getSciFiAnimes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime_genres ag JOIN genre g ON ag.genre_id = g.genre_id WHERE g.name = 'Sci-Fi'"); }
    public int getShoujoAnimes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime_genres ag JOIN genre g ON ag.genre_id = g.genre_id WHERE g.name = 'Shoujo'"); }
    public int getShounenAnimes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime_genres ag JOIN genre g ON ag.genre_id = g.genre_id WHERE g.name = 'Shounen'"); }
    public int getSliceOfLifeAnimes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime_genres ag JOIN genre g ON ag.genre_id = g.genre_id WHERE g.name = 'Slice of Life'"); }
    public int getSportsAnimes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime_genres ag JOIN genre g ON ag.genre_id = g.genre_id WHERE g.name = 'Sports'"); }
    public int getSupernaturalAnimes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime_genres ag JOIN genre g ON ag.genre_id = g.genre_id WHERE g.name = 'Supernatural'"); }
    public int getThrillerAnimes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime_genres ag JOIN genre g ON ag.genre_id = g.genre_id WHERE g.name = 'Thriller'"); }
    public int getRating0to1Animes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime WHERE score >= 0 AND score < 1"); }
    public int getRating1to2Animes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime WHERE score >= 1 AND score < 2"); }
    public int getRating2to3Animes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime WHERE score >= 2 AND score < 3"); }
    public int getRating3to4Animes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime WHERE score >= 3 AND score < 4"); }
    public int getRating4to5Animes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime WHERE score >= 4 AND score < 5"); }
    public int getRating5to6Animes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime WHERE score >= 5 AND score < 6"); }
    public int getRating6to7Animes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime WHERE score >= 6 AND score < 7"); }
    public int getRating7to8Animes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime WHERE score >= 7 AND score < 8"); }
    public int getRating8to9Animes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime WHERE score >= 8 AND score < 9"); }
    public int getRating9to10Animes() { return getCount("SELECT COUNT(*) AS anime_count FROM anime WHERE score >= 9 AND score <= 10"); }

    public int getServerLoad() { return 43; } // Placeholder


    // --- Existing User Methods ---
    public List<User> getAllUsers() {
        if (isConnectionError) {
            System.err.println("getAllUsers: Connection Error!");
            return new ArrayList<>();
        }
        List<User> users = new ArrayList<>();
        // *** SECURITY: Avoid selecting the password unless absolutely necessary ***
        String query = "SELECT user_id, username, email, role, created_at, last_login FROM users";
        try (PreparedStatement stmt = dbConn.prepareStatement(query);
             ResultSet result = stmt.executeQuery()) {
            while (result.next()) {
                User user = new User(
                    result.getInt("user_id"),
                    result.getString("username"),
                    result.getString("email"),
                    null, // Don't load password hash here unless needed for specific admin tasks
                    result.getString("role"),
                    result.getTimestamp("created_at"),
                    result.getTimestamp("last_login")
                );
                users.add(user);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching all users: " + e.getMessage());
            e.printStackTrace();
        }
        return users;
    }

    // Gets user by username, including the hashed password for login/verification
    public User getUserByUsername(String username) {
        if (isConnectionError) {
            System.err.println("getUserByUsername: Connection Error!");
            return null;
        }
        String query = "SELECT * FROM users WHERE username = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, username);
            try (ResultSet result = stmt.executeQuery()) {
                if (result.next()) {
                    return new User(
                        result.getInt("user_id"),
                        result.getString("username"),
                        result.getString("email"),
                        result.getString("password"), // Encrypted password
                        result.getString("role"),
                        result.getTimestamp("created_at"),
                        result.getTimestamp("last_login")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching user by username '" + username + "': " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

     public User getUserById(int userId) {
        if (isConnectionError) {
            System.err.println("getUserById: Connection Error!");
            return null;
        }
        // Select password hash if needed for verification within the service
        String query = "SELECT * FROM users WHERE user_id = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            try (ResultSet result = stmt.executeQuery()) {
                if (result.next()) {
                    return new User(
                        result.getInt("user_id"),
                        result.getString("username"),
                        result.getString("email"),
                        result.getString("password"), // Load HASHED password
                        result.getString("role"),
                        result.getTimestamp("created_at"),
                        result.getTimestamp("last_login")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching user by ID " + userId + ": " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // --- NEW: Password Verification ---
    /**
     * Verifies a provided plain text password against the stored hash for a user.
     * @param userId The ID of the user.
     * @param providedPassword The plain text password entered by the user.
     * @return true if the password matches, false otherwise.
     */
    public boolean verifyPassword(int userId, String providedPassword) {
        if (isConnectionError || providedPassword == null) {
            return false;
        }
        String query = "SELECT username, password FROM users WHERE user_id = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String username = rs.getString("username");
                    String encryptedPassword = rs.getString("password");

                    if (encryptedPassword == null) {
                        System.err.println("User ID " + userId + " has no password stored.");
                        return false;
                    }

                    // Decrypt the stored password
                    String decryptedPassword = PasswordUtil.decrypt(encryptedPassword, username);

                    // Compare the decrypted password with the provided password
                    return decryptedPassword != null && decryptedPassword.equals(providedPassword);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error verifying password for user ID " + userId + ": " + e.getMessage());
            e.printStackTrace();
        } catch (IllegalArgumentException e) {
            System.err.println("Error during password check (likely invalid hash format): " + e.getMessage());
        }
        return false;
    }


    // --- NEW: Update Methods ---

    /**
     * Updates the username for a given user ID.
     * @param userId The ID of the user to update.
     * @param newUsername The new username.
     * @return true if the update was successful, false otherwise.
     */
    public boolean updateUsername(int userId, String newUsername) {
        if (isConnectionError || newUsername == null || newUsername.trim().isEmpty()) {
            return false;
        }
        // Optional: Check if the new username already exists
        if (isUsernameTaken(newUsername, userId)) {
             System.err.println("Username '" + newUsername + "' is already taken.");
             return false; // Indicate failure due to duplicate username
        }

        String query = "UPDATE users SET username = ? WHERE user_id = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, newUsername);
            stmt.setInt(2, userId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
             if (e.getErrorCode() == 1062) { // Duplicate entry check (MySQL specific)
                 System.err.println("Error updating username: Username '" + newUsername + "' likely already exists. " + e.getMessage());
             } else {
                 System.err.println("Error updating username for user ID " + userId + ": " + e.getMessage());
                 e.printStackTrace();
             }
            return false;
        }
    }

     /**
     * Updates the email for a given user ID.
     * @param userId The ID of the user to update.
     * @param newEmail The new email address.
     * @return true if the update was successful, false otherwise.
     */
    public boolean updateEmail(int userId, String newEmail) {
        if (isConnectionError || newEmail == null || newEmail.trim().isEmpty()) {
            // Basic validation - consider more robust email format check
            return false;
        }
         // Optional: Check if the new email already exists
        if (isEmailTaken(newEmail, userId)) {
             System.err.println("Email '" + newEmail + "' is already taken.");
             return false; // Indicate failure due to duplicate email
        }

        String query = "UPDATE users SET email = ? WHERE user_id = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, newEmail);
            stmt.setInt(2, userId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
             if (e.getErrorCode() == 1062) { // Duplicate entry check (MySQL specific)
                 System.err.println("Error updating email: Email '" + newEmail + "' likely already exists. " + e.getMessage());
             } else {
                System.err.println("Error updating email for user ID " + userId + ": " + e.getMessage());
                e.printStackTrace();
             }
            return false;
        }
    }

    /**
     * Updates the password for a given user ID.
     * @param userId The ID of the user to update.
     * @param newPassword The new plain text password (will be hashed).
     * @return true if the update was successful, false otherwise.
     */
    public boolean updatePassword(int userId, String username, String newPassword) {
        if (isConnectionError || newPassword == null || newPassword.isEmpty()) {
             // Add password complexity checks here if desired
            return false;
        }

        // *** SECURITY: Hash the new password before storing ***
        // String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
        // --- TEMPORARY PLAINTEXT STORAGE (REMOVE THIS IN PRODUCTION) ---
        String hashedPassword = PasswordUtil.encrypt(username, newPassword);; // Replace with actual hashing

        // --- END TEMPORARY ---


        String query = "UPDATE users SET password = ? WHERE user_id = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, hashedPassword);
            stmt.setInt(2, userId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating password for user ID " + userId + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // --- Helper methods to check for existing username/email ---
    private boolean isUsernameTaken(String username, int currentUserId) {
        // Checks if username exists for a *different* user
        String query = "SELECT COUNT(*) FROM users WHERE username = ? AND user_id != ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, username);
            stmt.setInt(2, currentUserId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking if username '" + username + "' is taken: " + e.getMessage());
        }
        return false; // Default to false on error, or handle differently
    }

    private boolean isEmailTaken(String email, int currentUserId) {
        // Checks if email exists for a *different* user
        String query = "SELECT COUNT(*) FROM users WHERE email = ? AND user_id != ?";
         try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, email);
            stmt.setInt(2, currentUserId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking if email '" + email + "' is taken: " + e.getMessage());
        }
        return false; // Default to false on error
    }


    // --- User Deletion ---
    public boolean deleteUser(int userId) {
        if (isConnectionError) {
            System.err.println("deleteUser: Connection Error!");
            return false;
        }
        System.out.println("Deleting user with ID: " + userId);

        // First, delete related records from user_anime_list
        String deleteRelatedQuery = "DELETE FROM user_anime_list WHERE user_id = ?";
        String deleteUserQuery = "DELETE FROM users WHERE user_id = ?";

        try (PreparedStatement deleteRelatedStmt = dbConn.prepareStatement(deleteRelatedQuery);
             PreparedStatement deleteUserStmt = dbConn.prepareStatement(deleteUserQuery)) {

            // Delete related records
            deleteRelatedStmt.setInt(1, userId);
            deleteRelatedStmt.executeUpdate();

            // Now delete the user
            deleteUserStmt.setInt(1, userId);
            int rowsAffected = deleteUserStmt.executeUpdate();

            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error deleting user ID " + userId + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }


    // --- User Addition (Ensure Hashing) ---
    public boolean addUser(User user) {
        if (isConnectionError || user == null) {
            System.err.println("addUser: Connection Error or User object is null!");
            return false;
        }

        if (user.getUsername() == null || user.getEmail() == null || user.getPassword() == null || user.getRole() == null) {
            System.err.println("addUser: Missing required user fields (username, email, password, role).");
            return false;
        }

        // *** SECURITY WARNING: HASH the password before storing ***
        // String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        // --- TEMPORARY PLAINTEXT STORAGE (REMOVE THIS IN PRODUCTION) ---
        String hashedPassword = user.getPassword(); // Replace with actual hashing
        System.err.println("WARNING: Storing plaintext password during add. Implement hashing!");
        // --- END TEMPORARY ---


        String query = "INSERT INTO users (username, email, password, role, created_at) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)";

        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, hashedPassword); // Store the HASHED password
            stmt.setString(4, user.getRole());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Return true if one row was inserted

        } catch (SQLException e) {
            if (e.getErrorCode() == 1062) { // Check for duplicate entry (MySQL/MariaDB)
                 System.err.println("Error adding user: Duplicate entry for username or email. " + e.getMessage());
            } else {
                 System.err.println("Error adding user '" + user.getUsername() + "': " + e.getMessage());
                 e.printStackTrace();
            }
            return false;
        }
    }

    // --- Other existing methods ---
    public List<User> getAllCustomers() {
       if (isConnectionError) {
           System.err.println("getAllCustomers: Connection Error!");
           return new ArrayList<>(); // Return empty list
       }
       List<User> customers = new ArrayList<>();
       // Avoid selecting password hash unless needed
       String query = "SELECT user_id, username, email, role, created_at, last_login FROM users WHERE role = 'customer'";
       try (PreparedStatement statement = dbConn.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery()) {

           while (resultSet.next()) {
               User user = new User(
                   resultSet.getInt("user_id"),
                   resultSet.getString("username"),
                   resultSet.getString("email"),
                   null, // Don't load password hash
                   resultSet.getString("role"),
                   resultSet.getTimestamp("created_at"),
                   resultSet.getTimestamp("last_login")
               );
               customers.add(user);
           }
       } catch (SQLException e) {
            System.err.println("Error fetching customers: " + e.getMessage());
            e.printStackTrace();
       }
       return customers;
   }

   // updateUser is less specific now, prefer the targeted update methods
   // You might keep it for admin bulk updates if needed, but ensure it handles hashing if password is included.
   
   public boolean updateUser(User user) {
	return isConnectionError;
       // ... (Existing code, but ensure password isn't updated here unless hashed) ...
      
   }
   
   // --- NEW METHOD to get user's anime list with details ---
   public List<UserAnimeEntry> getUserAnimeList(int userId) {
       if (isConnectionError) {
           System.err.println("getUserAnimeList: Connection Error!");
           return new ArrayList<>();
       }
       List<UserAnimeEntry> userAnimeEntries = new ArrayList<>();
       // Query to join user_anime_list with anime table
       // Also joins with studios and age_ratings for more complete data
       String query = "SELECT ual.entry_id, ual.user_id, ual.anime_id, ual.watch_status, ual.user_score, ual.progress, ual.notes, ual.last_updated, " +
                      "a.title, a.synopsis, a.type, a.episodes, a.episodes_aired, a.status, a.start_date, a.end_date, a.season, a.score AS overall_score, a.duration, a.source, a.mal_id, " +
                      "s.studio_name, ar.rating_name " +
                      "FROM user_anime_list ual " +
                      "JOIN anime a ON ual.anime_id = a.anime_id " +
                      "LEFT JOIN studios s ON a.studio_id = s.studio_id " + // LEFT JOIN in case studio is null
                      "LEFT JOIN age_ratings ar ON a.rating_id = ar.rating_id " + // LEFT JOIN in case age_rating is null
                      "WHERE ual.user_id = ?";

       try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
           stmt.setInt(1, userId);
           try (ResultSet rs = stmt.executeQuery()) {
               while (rs.next()) {
                   // Handling potential null for Integer progress
                   Integer progress = rs.getObject("progress") != null ? rs.getInt("progress") : null;
                   Integer episodes = rs.getObject("episodes") != null ? rs.getInt("episodes") : null;
                   Integer episodesAired = rs.getObject("episodes_aired") != null ? rs.getInt("episodes_aired") : null;
                   Integer malId = rs.getObject("mal_id") != null ? rs.getInt("mal_id") : null;


                   UserAnimeEntry entry = new UserAnimeEntry(
                       rs.getInt("entry_id"),
                       rs.getInt("user_id"),
                       rs.getInt("anime_id"),
                       rs.getString("watch_status"),
                       rs.getBigDecimal("user_score"),
                       progress,
                       rs.getString("notes"),
                       rs.getTimestamp("last_updated"),
                       rs.getString("title"),
                       rs.getString("synopsis"),
                       rs.getString("type"),
                       episodes,
                       episodesAired,
                       rs.getString("status"),
                       rs.getDate("start_date"),
                       rs.getDate("end_date"),
                       rs.getString("season"),
                       rs.getBigDecimal("overall_score"),
                       rs.getString("duration"),
                       rs.getString("source"),
                       malId
                   );
                   entry.setStudioName(rs.getString("studio_name")); // From studios table
                   entry.setAgeRatingName(rs.getString("rating_name")); // From age_ratings table

                   // Fetch genres for this anime separately (or you could use GROUP_CONCAT in SQL if preferred and parse it)
                   // For simplicity here, we'll fetch it in a sub-query manner, which is not the most performant for large lists.
                   // A better approach for performance with many entries would be to fetch all genres for all animes in the list in one go after this loop.
                   entry.setGenres(getAnimeGenres(rs.getInt("anime_id")));

                   userAnimeEntries.add(entry);
               }
           }
       } catch (SQLException e) {
           System.err.println("Error fetching user anime list for user_id '" + userId + "': " + e.getMessage());
           e.printStackTrace();
       }
       return userAnimeEntries;
   }

   // Helper method to get genres for a specific anime_id
   public List<String> getAnimeGenres(int animeId) {
       if (isConnectionError) return new ArrayList<>();
       List<String> genres = new ArrayList<>();
       String query = "SELECT g.name FROM anime_genres ag JOIN genre g ON ag.genre_id = g.genre_id WHERE ag.anime_id = ?";
       try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
           stmt.setInt(1, animeId);
           try (ResultSet rs = stmt.executeQuery()) {
               while (rs.next()) {
                   genres.add(rs.getString("name"));
               }
           }
       } catch (SQLException e) {
           System.err.println("Error fetching genres for anime_id '" + animeId + "': " + e.getMessage());
           // Don't print stack trace here to avoid flooding logs if called many times,
           // but consider a more robust logging strategy.
       }
       return genres;
   }
   


    // Optional: Method to close the connection
    public void closeConnection() {
        if (dbConn != null) {
            try {
                dbConn.close();
                System.out.println("Database connection closed.");
            } catch (SQLException e) {
                System.err.println("Error closing database connection: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }
}
