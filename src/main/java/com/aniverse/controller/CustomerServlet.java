package com.aniverse.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp; // Import Timestamp
import java.util.List;

// Import your model and service
import com.aniverse.model.User;
import com.aniverse.service.Service;

// Update the WebServlet mapping
@WebServlet("/customers") // Changed from /testt
public class CustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Service service;

    @Override
    public void init() throws ServletException {
        super.init();
        this.service = new Service(); // Initialize service in init()
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("edit".equals(action)) {
            // Show edit form
            showEditForm(request, response);
        } else if ("add".equals(action)) { // **** NEW: Handle 'add' action ****
            // Show the add customer form
            showAddForm(request, response);
        }
        else {
            // Default action: list all customers
            listCustomers(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            listCustomers(request, response);
            return;
        }

        switch (action) {
            case "delete":
                deleteCustomer(request, response);
                break;
            case "update":
                updateCustomer(request, response);
                break;
            case "insert": // **** NEW: Handle 'insert' action ****
                 insertCustomer(request, response);
                 break;
            default:
                listCustomers(request, response);
                break;
        }
    }

    private void listCustomers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> customers = service.getAllCustomers();
        request.setAttribute("customers", customers); // Set attribute for the JSP
        // Forward to the JSP page (relative path from webapp root)
        request.getRequestDispatcher("WEB-INF/pages/customerList.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            User existingUser = service.getUserById(userId);
            if (existingUser != null && "customer".equals(existingUser.getRole())) { // Ensure it's a customer
                request.setAttribute("customerToEdit", existingUser);
                request.getRequestDispatcher("WEB-INF/pages/editCustomer.jsp").forward(request, response);
            } else {
                 // Handle case where user not found or is not a customer
                 System.err.println("Edit request for non-existent or non-customer user ID: " + userId);
                 response.sendRedirect(request.getContextPath() + "/customers?error=UserNotFound"); // Redirect with error param
            }
        } catch (NumberFormatException e) {
             System.err.println("Invalid User ID format for edit: " + request.getParameter("userId"));
             response.sendRedirect(request.getContextPath() + "/customers?error=InvalidUserId"); // Redirect with error param
        }
    }

     private void updateCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            // Retrieve other fields if you added them to the form and service update method

            // You might want to fetch the existing user to keep other fields (like role, password hash, etc.)
            User userToUpdate = service.getUserById(userId); // Fetch existing data first

            if (userToUpdate == null) {
                 System.err.println("Update failed: User not found with ID: " + userId);
                 response.sendRedirect(request.getContextPath() + "/customers?error=UpdateFailedUserNotFound");
                 return;
            }

            // Update only the fields from the form
            userToUpdate.setUsername(username);
            userToUpdate.setEmail(email);
            // userToUpdate.setSomeOtherField(request.getParameter("someOtherField"));

            boolean success = service.updateUser(userToUpdate);

            if (success) {
                System.out.println("User updated successfully: ID " + userId);
                 response.sendRedirect(request.getContextPath() + "/customers?success=UserUpdated"); // Redirect after successful POST
            } else {
                 System.err.println("Update failed for user ID: " + userId);
                 // Optionally, redirect back to edit form with an error message
                 // request.setAttribute("errorMessage", "Update failed. Please try again.");
                 // request.setAttribute("customerToEdit", userToUpdate); // Send back the attempted data
                 // request.getRequestDispatcher("/editCustomer.jsp").forward(request, response);
                 // For simplicity now, just redirect to list
                 response.sendRedirect(request.getContextPath() + "/customers?error=UpdateFailed");
            }

        } catch (NumberFormatException e) {
             System.err.println("Invalid User ID format for update: " + request.getParameter("userId"));
             response.sendRedirect(request.getContextPath() + "/customers?error=InvalidUserId");
        } /*catch (ServletException e) { // Catch potential forward exception if using forward in error case
             System.err.println("Servlet Exception during update forward: " + e.getMessage());
             response.sendRedirect(request.getContextPath() + "/customers?error=ServerError");
        }*/

    }

    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException {
         try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            boolean success = service.deleteUser(userId);

            if (success) {
                 System.out.println("User deleted successfully: ID " + userId);
                 response.sendRedirect(request.getContextPath() + "/customers?success=UserDeleted"); // Redirect after successful POST
            } else {
                System.err.println("Delete failed for user ID: " + userId);
                response.sendRedirect(request.getContextPath() + "/customers?error=DeleteFailed");
            }
        } catch (NumberFormatException e) {
             System.err.println("Invalid User ID format for delete: " + request.getParameter("userId"));
             response.sendRedirect(request.getContextPath() + "/customers?error=InvalidUserId");
        }
    }
    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Just forward to the JSP page for adding a customer
        request.getRequestDispatcher("WEB-INF/pages/addCustomer.jsp").forward(request, response);
    }

    // **** NEW Method to insert the customer ****
    private void insertCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password"); // Raw password from form
        String role = "customer"; // Automatically set role to customer for this form

        // ** Basic Server-Side Validation (Add more as needed) **
        if (username == null || username.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.isEmpty()) {
            // Redirect back to add form with an error message (more robust than this)
            System.err.println("Add user failed: Missing required fields.");
             // Ideally, set attributes and forward back to the form to show errors and retain input
             // request.setAttribute("errorMessage", "Please fill in all required fields.");
             // request.setAttribute("submittedUsername", username); // To refill form
             // request.setAttribute("submittedEmail", email);
             // try {
             //    request.getRequestDispatcher("/addCustomer.jsp").forward(request, response);
             // } catch (ServletException e) { e.printStackTrace();}
             // Simple redirect for now:
            response.sendRedirect(request.getContextPath() + "/customers?action=add&error=MissingFields"); // Need a corresponding message in JSP
            return;
        }


        // *** PLACEHOLDER FOR PASSWORD HASHING ***
        // String hashedPassword = MyPasswordHasher.hash(password);
        String hashedPassword = password; // Using plain text as per current setup - VERY INSECURE!


        // Create a new User object (without ID, createdAt, lastLogin - DB handles these)
        // Use a constructor or setters. Assuming a suitable constructor exists or using setters:
        User newUser = new User(0, username, email, hashedPassword, null, null, null);
        newUser.setUsername(username.trim());
        newUser.setEmail(email.trim());
        newUser.setPassword(hashedPassword); // Store the (ideally hashed) password
        newUser.setRole(role);
        // You might need to adjust User constructor or add setters if they don't exist
        // Example using a constructor that takes these fields (modify User class if needed):
        // User newUser = new User(username.trim(), email.trim(), hashedPassword, role);


        boolean success = service.addUser(newUser);

        if (success) {
            System.out.println("New customer added successfully: " + username);
            response.sendRedirect(request.getContextPath() + "/customers?success=UserAdded"); // Redirect on success
        } else {
            System.err.println("Failed to add new customer: " + username);
            // Redirect back to list view with a generic error, or back to add form with specific error
            response.sendRedirect(request.getContextPath() + "/customers?error=AddFailed");
        }
    }

    @Override
    public void destroy() {
        // Clean up resources like closing DB connection if applicable
        if (service != null) {
             service.closeConnection(); // Add a closeConnection method to your Service
        }
        super.destroy();
    }
}