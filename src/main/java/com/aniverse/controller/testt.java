package com.aniverse.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.aniverse.model.Program;
import com.aniverse.model.User;
import com.aniverse.service.Service;


/**
 * Servlet implementation class testt
 */
@WebServlet("/testt")
public class testt extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Service service;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public testt() {
        super();
        this.service = new Service(); 
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get the list of users from the service
		List<User> users = service.getAllUsers();

		// Set the response type to HTML
		response.setContentType("text/html");

		// Start building the HTML response
		StringBuilder htmlResponse = new StringBuilder();
		htmlResponse.append("<html><body>");

		// User List
		htmlResponse.append("<h2>User List:</h2>");
		if (users != null && !users.isEmpty()) {
			htmlResponse.append("<table border='1'>");
			htmlResponse.append("<tr><th>ID</th><th>Username</th><th>Email</th><th>Role</th><th>Created At</th><th>Last Login</th></tr>");
			for (User user : users) {
				htmlResponse.append("<tr>");
				htmlResponse.append("<td>").append(user.getUserId()).append("</td>");
				htmlResponse.append("<td>").append(user.getUsername()).append("</td>");
				htmlResponse.append("<td>").append(user.getEmail()).append("</td>");
				htmlResponse.append("<td>").append(user.getRole()).append("</td>");
				htmlResponse.append("<td>").append(user.getCreatedAt()).append("</td>");
				htmlResponse.append("<td>").append(user.getLastLogin() != null ? user.getLastLogin() : "Never").append("</td>");
				htmlResponse.append("</tr>");
			}
			htmlResponse.append("</table>");
		} else {
			htmlResponse.append("<p>No users found.</p>");
		}

		htmlResponse.append("</body></html>");

		// Write the HTML response
		response.getWriter().write(htmlResponse.toString());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
