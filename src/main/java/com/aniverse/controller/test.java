package com.aniverse.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.aniverse.util.PasswordUtil;

/**
 * Servlet implementation class test
 */
@WebServlet("/test")
public class test extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public test() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 String[] usernames = {
		            "Sita_Poudel", "John_Smith", "Sarita_Thapa", "Krishna_Shrestha", "Sophia_Garcia",
		            "Prabin_Tamang", "12345", "Admin123", "Ramu123", "Satyam123"
		        };
		        String[] passwords = {
		            "S@123", "J@123", "S@123", "K@123", "S@123", 
		            "P@123", "1@123", "Admin@123", "R@123", "S@123"
		        };

		        for (int i = 0; i < usernames.length; i++) {
		            String encrypted = PasswordUtil.encrypt(usernames[i], passwords[i]);
		            System.out.println("Username: " + usernames[i]);
		            System.out.println("Password: " + passwords[i]);
		            System.out.println("Encrypted: '" + encrypted + "'");
		            System.out.println();
		        }
		    
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
