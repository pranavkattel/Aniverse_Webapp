package com.aniverse.service;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.aniverse.model.User;
import com.aniverse.config.Dbconfig;

public class Service {
    private Connection dbConn;
    private boolean isConnectionError = false;

    public Service() {
        try {
            dbConn = Dbconfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
            isConnectionError = true;
        }
    }

    public List<User> getAllUsers() {
        if (isConnectionError) {
            System.out.println("Connection Error!");
            return null;
        }

        List<User> users = new ArrayList<>();
        String query = "SELECT user_id, username, email, password, role, created_at, last_login FROM users";

        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            ResultSet result = stmt.executeQuery();

            while (result.next()) {
                User user = new User(
                    result.getInt("user_id"),
                    result.getString("username"),
                    result.getString("email"),
                    result.getString("password"),
                    result.getString("role"),
                    result.getTimestamp("created_at"),
                    result.getTimestamp("last_login")
                );
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        return users;
    }

    public User getUserByUsername(String username) {
        if (isConnectionError) {
            System.out.println("Connection Error!");
            return null;
        }

        String query = "SELECT * FROM users WHERE username = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet result = stmt.executeQuery();

            if (result.next()) {
                int userId = result.getInt("user_id");
                String password = result.getString("password");
                String role = result.getString("role");
                String email = result.getString("email");
                Timestamp createdAt = result.getTimestamp("created_at");
                Timestamp lastLogin = result.getTimestamp("last_login");

                return new User(userId, username, email, password, role, createdAt, lastLogin);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
}
