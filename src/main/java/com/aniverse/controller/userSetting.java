package com.aniverse.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.aniverse.model.User;
import com.aniverse.service.Service;

/**
 * Servlet implementation class userSetting
 * Handles account settings updates (username, email, password) and deletion.
 * (Simplified doPost method)
 */
@WebServlet("/accountsettings") // Match the form action URL in JSP
public class userSetting extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Service service;
    String currentUsernameFromSession;

    public userSetting() {
        super();
        this.service = new Service();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
        	System.out.println("sdkjiahusgvdvasjd");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        currentUsernameFromSession = (String) session.getAttribute("user");
        User currentUser = service.getUserByUsername(currentUsernameFromSession);

        if (currentUser == null) {
            System.err.println("GET Error: User '" + currentUsernameFromSession + "' found in session but not in DB.");
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=User not found");
            return;
        }

        request.setAttribute("userFromDb", currentUser);
        request.getRequestDispatcher("/WEB-INF/pages/userSetting.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Get current session
        System.out.println("print 1");

        User currentUser = service.getUserByUsername(currentUsernameFromSession); // Use session username

        // --- Check if user exists (could have been deleted between GET and POST) ---
        if (currentUser == null) {
            System.err.println("POST Error: User '" + currentUsernameFromSession + "' in session but not found in DB.");
            session.invalidate(); // Log out the stale session
            response.sendRedirect(request.getContextPath() + "/login?error=User session error");
            return;
        }

        // --- Get Action and Parameters ---
        String action = request.getParameter("action");
        String currentPassword = request.getParameter("currentPassword");

        // --- Basic Validation ---
        if (action == null || action.trim().isEmpty()) {
            request.setAttribute("errorMessage_general", "Invalid action specified.");
            // --- FIX 2: Forward directly, don't call doGet ---
            request.setAttribute("userFromDb", currentUser); // Need user data for the form
            request.getRequestDispatcher("/WEB-INF/pages/userSetting.jsp").forward(request, response);
            return;
        }
        if (currentPassword == null || currentPassword.trim().isEmpty()) {
            request.setAttribute("errorMessage_" + action, "Current password is required to make changes.");
            // --- FIX 2: Forward directly ---
            request.setAttribute("userFromDb", currentUser); // Need user data for the form
            request.getRequestDispatcher("/WEB-INF/pages/userSetting.jsp").forward(request, response);
            return;
        }

        // --- Verify Current Password ---
        boolean passwordVerified = service.verifyPassword(currentUser.getUserId(), currentPassword);

        if (!passwordVerified) {
            request.setAttribute("errorMessage_" + action, "Incorrect current password.");
            // --- FIX 2: Forward directly ---
            request.setAttribute("userFromDb", currentUser); // Need user data for the form
            request.getRequestDispatcher("/WEB-INF/pages/userSetting.jsp").forward(request, response);
            return;
        }

        // --- Process Action ---
        boolean updateOccurred = false; // Flag to check if we need to refresh user data
        try {
            switch (action) {
                case "changeUsername":
                    String newUsername = request.getParameter("newUsername");
                    // Validation...
                    if (newUsername == null || newUsername.trim().isEmpty() || newUsername.length() > 50) {
                        request.setAttribute("errorMessage_changeUsername", "New username cannot be empty and must be 50 characters or less.");
                    } else if (newUsername.trim().equals(currentUser.getUsername())) {
                        request.setAttribute("errorMessage_changeUsername", "New username cannot be the same as the current username.");
                    } else {
                        boolean success = service.updateUsername(currentUser.getUserId(), newUsername.trim());
                        if (success) {
                            request.setAttribute("successMessage_changeUsername", "Username updated successfully!");
                            session.setAttribute("user", newUsername.trim()); // Update session immediately
                            updateOccurred = true; // Mark that data changed
                            // Update the local variable for consistency if needed later in this request
                            currentUsernameFromSession = newUsername.trim();
                        } else {
                            request.setAttribute("errorMessage_changeUsername", "Failed to update username. It might already be taken or a database error occurred.");
                        }
                    }
                    break;

                case "changeEmail":
                    String newEmail = request.getParameter("newEmail");
                    // Validation...
                     if (newEmail == null || newEmail.trim().isEmpty() || !newEmail.contains("@") || newEmail.length() > 100 ) {
                           request.setAttribute("errorMessage_changeEmail", "Please enter a valid email address (max 100 characters).");
                     } else if (newEmail.trim().equals(currentUser.getEmail())) {
                           request.setAttribute("errorMessage_changeEmail", "New email cannot be the same as the current email.");
                     } else {
                        boolean success = service.updateEmail(currentUser.getUserId(), newEmail.trim());
                        if (success) {
                            request.setAttribute("successMessage_changeEmail", "Email updated successfully!");
                            updateOccurred = true; // Mark that data changed
                        } else {
                             request.setAttribute("errorMessage_changeEmail", "Failed to update email. It might already be in use or a database error occurred.");
                        }
                    }
                    break;

                case "changePassword":
                    String newPassword = request.getParameter("newPassword");
                    String confirmNewPassword = request.getParameter("confirmNewPassword");
                    // Validation...
                    if (newPassword == null || newPassword.isEmpty() || newPassword.length() < 8) {
                         request.setAttribute("errorMessage_changePassword", "New password must be at least 8 characters long.");
                    } else if (!newPassword.equals(confirmNewPassword)) {
                         request.setAttribute("errorMessage_changePassword", "New passwords do not match.");
                    } else {
                        // Ensure your service.updatePassword HASHES the password!
                        boolean success = service.updatePassword(currentUser.getUserId(), newPassword);
                        if (success) {
                            request.setAttribute("successMessage_changePassword", "Password updated successfully!");
                            // No need to set updateOccurred = true unless you redisplay password info
                        } else {
                            request.setAttribute("errorMessage_changePassword", "Failed to update password due to a database error.");
                        }
                    }
                    break;

                case "deleteAccount":
                    String confirmDelete = request.getParameter("confirmDelete");
                    // Validation...
                     if (confirmDelete == null || !confirmDelete.equals("on")) {
                         request.setAttribute("errorMessage_deleteAccount", "You must check the confirmation box to delete your account.");
                     } else {
                        boolean success = service.deleteUser(currentUser.getUserId());
                        if (success) {
                            session.invalidate(); // Log out
                            System.out.println("Account deleted for user ID: " + currentUser.getUserId());
                            response.sendRedirect(request.getContextPath() + "/login?message=Account deleted successfully");
                            return; // Stop processing, already redirected
                        } else {
                            request.setAttribute("errorMessage_deleteAccount", "Failed to delete account due to a database error.");
                        }
                    }
                    break;

                default:
                    request.setAttribute("errorMessage_general", "Unknown action specified.");
                    break;
            }
        } catch (Exception e) {
             System.err.println("Error processing action '" + action + "' for user '" + currentUsernameFromSession + "': " + e.getMessage());
             e.printStackTrace();
             request.setAttribute("errorMessage_" + action, "An unexpected error occurred. Please try again later.");
        }

        // --- Redisplay Form (FIX 2 Continued) ---
        // If an update occurred, re-fetch the user data to show the *latest* info
        User userToDisplay = updateOccurred ? service.getUserByUsername(currentUsernameFromSession) : currentUser;
        if (userToDisplay == null && updateOccurred) {
            // Edge case: Username was updated, but fetching the new user failed? Or user was deleted concurrently?
            System.err.println("POST Error: Failed to re-fetch user '" + currentUsernameFromSession + "' after update.");
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/login?error=Post-update session error");
            return;
        } else if (userToDisplay == null) {
             // If original currentUser somehow became null here without an update (shouldn't happen based on checks above)
             System.err.println("POST Error: currentUser is unexpectedly null before forwarding.");
             session.invalidate();
             response.sendRedirect(request.getContextPath() + "/login?error=Unexpected session error");
             return;
        }


        request.setAttribute("userFromDb", userToDisplay); // Pass the potentially updated user object
        request.getRequestDispatcher("/WEB-INF/pages/userSetting.jsp").forward(request, response); // Forward directly to JSP
    }

    @Override
    public void destroy() {
        if (service != null) {
            service.closeConnection();
        }
        super.destroy();
    }
}
