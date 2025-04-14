package com.aniverse.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.aniverse.config.Dbconfig;
import com.aniverse.model.User;

public class RegisterService {
	private Connection dbConn;
 

    /**
     * Initializes the database connection.
     */
    public RegisterService() {
    	 try {
             dbConn = Dbconfig.getDbConnection();
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
            insertStmt.setString(3, user.getPassword()); // Make sure this is hashed if needed
            insertStmt.setString(4, "customer");

            return insertStmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("User registration failed: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
