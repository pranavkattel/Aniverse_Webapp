package com.aniverse.service;

import com.aniverse.config.DbConfig;
import com.aniverse.model.User;
import com.aniverse.util.PasswordUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RegisterService {
	private Connection dbConn;
 

    /**
     * Initializes the database connection.
     */
    public RegisterService() {
    	 try {
             dbConn = DbConfig.getDbConnection();
         } catch (SQLException | ClassNotFoundException ex) {
             ex.printStackTrace();
            
         }
    }

    /**
     * Registers a new user with the role 'customer'.
     *
     * @param user the user data to register (only username, email, and password are required)
     * @return true if registration succeeds, false otherwise
     */
    public Boolean registerUser(User user) {
        if (dbConn == null) {
            System.err.println("Database connection is not available.");
            return false;
        }

        String insertQuery = "INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, ?)";

        try (PreparedStatement insertStmt = dbConn.prepareStatement(insertQuery)) {
            insertStmt.setString(1, user.getUsername());
            insertStmt.setString(2, user.getEmail());
            // Encrypt the password before storing it
            String encryptedPassword = PasswordUtil.encrypt(user.getUsername(), user.getPassword());
            insertStmt.setString(3, encryptedPassword);
            insertStmt.setString(4, "customer");

            return insertStmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("User registration failed: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
