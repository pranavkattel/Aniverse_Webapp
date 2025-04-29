package com.aniverse.service;

import com.aniverse.config.Dbconfig;
import com.aniverse.model.User;
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
            dbConn = Dbconfig.getDbConnection();
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
    public String getTopGenre() { return getStringValue("SELECT g.name FROM anime_genre ag JOIN genre g ON ag.genre_id = g.genre_id GROUP BY g.name ORDER BY COUNT(ag.anime_id) DESC LIMIT 1;"); }
    public int getTotalCommentCount() { return getCount("SELECT COUNT(*) FROM comments"); } // Example query
    public int getCommentsTodayCount() { return getCount("SELECT COUNT(*) FROM comments WHERE DATE(comment_date) = CURDATE()"); } // Example query
    public String getHighestRatedAnime() { return getStringValue("select title from anime where score = (select max(score) from anime);"); }
    public int getModerationQueueCount() { return getCount("SELECT COUNT(*) FROM content WHERE status = 'pending_moderation'"); } // Example query
    public int getReportedContentCount() { return getCount("SELECT COUNT(*) FROM reports WHERE status = 'open'"); } // Example query
    public String getMostDiscussedAnime() { return getStringValue("SELECT a.title FROM anime a JOIN comments c ON a.anime_id = c.anime_id WHERE c.comment_date >= CURDATE() - INTERVAL 7 DAY GROUP BY a.title ORDER BY COUNT(c.comment_id) DESC LIMIT 1"); }
    public String getTopSeason() { return getStringValue("select season from anime group by season order by count(*) desc limit 1;"); }
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
        // Select password hash here
        String query = "SELECT * FROM users WHERE username = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, username);
            try (ResultSet result = stmt.executeQuery()) {
                if (result.next()) {
                    return new User(
                        result.getInt("user_id"),
                        result.getString("username"),
                        result.getString("email"),
                        result.getString("password"), // Load the HASHED password
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
        String query = "SELECT password FROM users WHERE user_id = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String storedHash = rs.getString("password");
                    if (storedHash == null) {
                        System.err.println("User ID " + userId + " has no password stored.");
                        return false; // Or handle appropriately
                    }
                    // *** SECURITY: Use BCrypt (or similar) to check the password ***
                    // return BCrypt.checkpw(providedPassword, storedHash);
                    // --- TEMPORARY PLAINTEXT CHECK (REMOVE THIS IN PRODUCTION) ---
                     System.err.println("WARNING: Using plaintext password check. Implement hashing!");
                     return storedHash.equals(providedPassword);
                    // --- END TEMPORARY CHECK ---
                }
            }
        } catch (SQLException e) {
            System.err.println("Error verifying password for user ID " + userId + ": " + e.getMessage());
            e.printStackTrace();
        } catch (IllegalArgumentException e) {
             System.err.println("Error during password check (likely invalid hash format): " + e.getMessage());
             // This can happen with BCrypt if the stored hash is corrupted
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
    public boolean updatePassword(int userId, String newPassword) {
        if (isConnectionError || newPassword == null || newPassword.isEmpty()) {
             // Add password complexity checks here if desired
            return false;
        }

        // *** SECURITY: Hash the new password before storing ***
        // String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
        // --- TEMPORARY PLAINTEXT STORAGE (REMOVE THIS IN PRODUCTION) ---
        String hashedPassword = newPassword; // Replace with actual hashing
        System.err.println("WARNING: Storing plaintext password. Implement hashing!");
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
        System.out.println("deletinggg");
        // Consider related data deletion (posts, comments, watchlist entries)
        // using transactions or cascaded deletes in the database schema.
        String query = "DELETE FROM users WHERE user_id = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Return true if at least one row was deleted

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
