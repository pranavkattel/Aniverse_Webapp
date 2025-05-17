package com.aniverse.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.aniverse.model.User;
import com.aniverse.service.RegisterService;
import com.aniverse.service.Service;
import com.aniverse.util.ValidationUtil;

/**
 * Servlet implementation class register
 */
@WebServlet( asyncSupported = true, urlPatterns = { "/register" })
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RegisterService RegisterService;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterController() {
        super();
        this.RegisterService = new RegisterService();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("WEB-INF/pages/register.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String errorMessage = validateRegistrationForm(request);
		request.setAttribute("message", errorMessage);
		System.out.println(errorMessage);
        if (errorMessage != null) {
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        // Extract form fields
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("Username: " + username);
        System.out.println("Password: " + password);

        // Create and save the user (using the new constructor)
        User user = new User(username, email, password);
        Boolean duplicate = RegisterService.registerUser(user);
        if(duplicate == false)
        {
        	request.setAttribute("message", "Username already exists");
        	request.getRequestDispatcher("WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        // Redirect to login after successful registration
        response.sendRedirect(request.getContextPath() + "/login");
	}
	
	private String validateRegistrationForm(HttpServletRequest req) {
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if (ValidationUtil.isNullOrEmpty(username)) return "Username is required.";
        if (ValidationUtil.isNullOrEmpty(email)) return "Email is required.";
        if (ValidationUtil.isNullOrEmpty(password)) return "Password is required.";

        if (!ValidationUtil.isAlphanumericStartingWithLetter(username))
            return "Username must start with a letter and contain only letters and numbers.";

        if (!ValidationUtil.isValidEmail(email))
            return "Invalid email format.";

        if (!ValidationUtil.isValidPassword(password))
        	
            return "Password must be at least 8 characters long, with 1 uppercase letter, 1 number, and 1 special symbol.";

        return null; // All validations passed
    }
}

