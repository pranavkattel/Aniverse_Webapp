package com.aniverse.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import com.aniverse.config.Dbconfig;
import com.aniverse.model.User;
import com.aniverse.service.Service;

/**
 * Servlet implementation class testcustomer
 */
@WebServlet("/test")
public class testcustomer extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Service service;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public testcustomer() {
        super();
        this.service = new Service();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try (Connection connection = Dbconfig.getDbConnection()) {
            
            List<User> customers = service.getAllCustomers();
            
            request.setAttribute("customers", customers);
            request.getRequestDispatcher("/WEB-INF/pages/test.jsp").forward(request, response);
		}catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
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
