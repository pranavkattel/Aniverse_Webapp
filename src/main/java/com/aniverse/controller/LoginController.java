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
import com.aniverse.util.PasswordUtil;

/**
 * Servlet implementation class login
 */
@WebServlet( asyncSupported = true, urlPatterns = { "/login" })
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Service service;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
        super();
        this.service = new Service();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Forward to the Login JSP page
        request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
        String password = request.getParameter("password");

        System.out.println("Username: " + username);
        System.out.println("Password: " + password);

        // Get the user based on the provided username
        User user = service.getUserByUsername(username);
        if (user != null) {
            // Decrypt the stored password
            String decryptedPassword = PasswordUtil.decrypt(user.getPassword(), username);

            // Check if the password matches
            if (decryptedPassword != null && decryptedPassword.equals(password)) {
                // Valid login
            	String role = user.getRole();
                HttpSession session = request.getSession(); // Get the session
                session.setAttribute("user", username);   // Set the username in session
                session.setAttribute("role", role);       // Set the role in session

                if ("admin".equals(role)) {
                    response.sendRedirect(request.getContextPath() + "/admin");
                    System.out.println("forwarded ");
                } else {
                    response.sendRedirect(request.getContextPath() + "/dashboard");
                }
            } else {
                // Invalid password
            	 request.setAttribute("message1", "Invalid password for user");
                System.out.println("Invalid password for user: " + username);
                request.getRequestDispatcher("WEB-INF/pages/login.jsp").forward(request, response);
            }
        } else {
            // Invalid username
        	 request.setAttribute("message", "Username not found");
            System.out.println("Username not found: " + username);
            request.getRequestDispatcher("WEB-INF/pages/login.jsp").forward(request, response);
        }
    }

}
