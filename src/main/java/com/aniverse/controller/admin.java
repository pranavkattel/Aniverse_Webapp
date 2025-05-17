package com.aniverse.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import com.aniverse.model.Anime;
import com.aniverse.model.User;
import com.aniverse.service.AnimeService;
import com.aniverse.service.Service;

/**
 * Servlet implementation class admin
 */
@WebServlet("/admin")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class admin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Service service;
	private AnimeService animeService;
	private Service dataService;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public admin() {
        super();
        this.service = new Service(); 
        dataService = new Service();
        animeService = new AnimeService();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false); // Do not create a new session if one does not exist
//		if (session == null || session.getAttribute("user") == null || !"admin".equals(session.getAttribute("role"))) {
//	        // User is not logged in or does not have the role "user", redirect to login page
//	        response.sendRedirect(request.getContextPath() + "/login");
//	        return; // Stop further processing
//	    }
//		request.getRequestDispatcher("WEB-INF/pages/admin_dashboard.jsp").forward(request, response);
        // Fetch all the data needed for the dashboard using the service
        int totalUsers = dataService.getTotalUserCount();
        int totalAnime = dataService.getTotalAnimeCount();
        int newUsersToday = dataService.getNewUsersTodayCount();
        int reviewsToday = dataService.getReviewsTodayCount();
        int totalWatchlists = dataService.getTotalWatchlistCount();
        int animeAddedThisMonth = dataService.getAnimeAddedThisMonthCount();
        String topGenre = dataService.getTopGenre();
        int totalComments = dataService.getTotalCommentCount();
        int commentsToday = dataService.getCommentsTodayCount();
        String highestRatedAnime = dataService.getHighestRatedAnime();
        int moderationQueue = dataService.getModerationQueueCount();
        int reportedContent = dataService.getReportedContentCount();
        String mostDiscussedAnime = dataService.getMostDiscussedAnime();
        String topSeason = dataService.getTopSeason();
        int serverLoad = dataService.getServerLoad();
        int actionAnimes = dataService.getActionAnimes();
        int adventureAnimes = dataService.getAdventureAnimes();
        int comedyAnimes = dataService.getComedyAnimes();
        int dramaAnimes = dataService.getDramaAnimes();
        int fantasyAnimes = dataService.getFantasyAnimes();
        int historicalAnimes = dataService.getHistoricalAnimes();
        int horrorAnimes = dataService.getHorrorAnimes();
        int magicAnimes = dataService.getMagicAnimes();
        int mechaAnimes = dataService.getMechaAnimes();
        int musicAnimes = dataService.getMusicAnimes();
        int mysteryAnimes = dataService.getMysteryAnimes();
        int romanceAnimes = dataService.getRomanceAnimes();
        int schoolAnimes = dataService.getSchoolAnimes();
        int sciFiAnimes = dataService.getSciFiAnimes();
        int shoujoAnimes = dataService.getShoujoAnimes();
        int shounenAnimes = dataService.getShounenAnimes();
        int sliceOfLifeAnimes = dataService.getSliceOfLifeAnimes();
        int sportsAnimes = dataService.getSportsAnimes();
        int supernaturalAnimes = dataService.getSupernaturalAnimes();
        int thrillerAnimes = dataService.getThrillerAnimes();
        int rating0to1Animes = dataService.getRating0to1Animes();
        int rating1to2Animes = dataService.getRating1to2Animes();
        int rating2to3Animes = dataService.getRating2to3Animes();
        int rating3to4Animes = dataService.getRating3to4Animes();
        int rating4to5Animes = dataService.getRating4to5Animes();
        int rating5to6Animes = dataService.getRating5to6Animes();
        int rating6to7Animes = dataService.getRating6to7Animes();
        int rating7to8Animes = dataService.getRating7to8Animes();
        int rating8to9Animes = dataService.getRating8to9Animes();
        int rating9to10Animes = dataService.getRating9to10Animes();


        // Set the fetched data as request attributes
        // The names here ("totalUsers", "totalAnime", etc.) are what you'll use in the JSP
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalAnime", totalAnime);
        request.setAttribute("newUsersToday", newUsersToday);
        request.setAttribute("reviewsToday", reviewsToday);
        request.setAttribute("totalWatchlists", totalWatchlists);
        request.setAttribute("animeAddedThisMonth", animeAddedThisMonth);
        request.setAttribute("topGenre", topGenre);
        request.setAttribute("totalComments", totalComments);
        request.setAttribute("commentsToday", commentsToday);
        request.setAttribute("highestRatedAnime", highestRatedAnime);
        request.setAttribute("moderationQueue", moderationQueue);
        request.setAttribute("reportedContent", reportedContent);
        request.setAttribute("mostDiscussedAnime", mostDiscussedAnime);
        request.setAttribute("topSeason", topSeason);
        request.setAttribute("serverLoad", serverLoad);
        request.setAttribute("actionAnimes", actionAnimes);
        request.setAttribute("adventureAnimes", adventureAnimes);
        request.setAttribute("comedyAnimes", comedyAnimes);
        request.setAttribute("dramaAnimes", dramaAnimes);
        request.setAttribute("fantasyAnimes", fantasyAnimes);
        request.setAttribute("historicalAnimes", historicalAnimes);
        request.setAttribute("horrorAnimes", horrorAnimes);
        request.setAttribute("magicAnimes", magicAnimes);
        request.setAttribute("mechaAnimes", mechaAnimes);
        request.setAttribute("musicAnimes", musicAnimes);
        request.setAttribute("mysteryAnimes", mysteryAnimes);
        request.setAttribute("romanceAnimes", romanceAnimes);
        request.setAttribute("schoolAnimes", schoolAnimes);
        request.setAttribute("sciFiAnimes", sciFiAnimes);
        request.setAttribute("shoujoAnimes", shoujoAnimes);
        request.setAttribute("shounenAnimes", shounenAnimes);
        request.setAttribute("sliceOfLifeAnimes", sliceOfLifeAnimes);
        request.setAttribute("sportsAnimes", sportsAnimes);
        request.setAttribute("supernaturalAnimes", supernaturalAnimes);
        request.setAttribute("thrillerAnimes", thrillerAnimes);
        request.setAttribute("rating0to1Animes", rating0to1Animes);
        request.setAttribute("rating1to2Animes", rating1to2Animes);
        request.setAttribute("rating2to3Animes", rating2to3Animes);
        request.setAttribute("rating3to4Animes", rating3to4Animes);
        request.setAttribute("rating4to5Animes", rating4to5Animes);
        request.setAttribute("rating5to6Animes", rating5to6Animes);
        request.setAttribute("rating6to7Animes", rating6to7Animes);
        request.setAttribute("rating7to8Animes", rating7to8Animes);
        request.setAttribute("rating8to9Animes", rating8to9Animes);
        request.setAttribute("rating9to10Animes", rating9to10Animes);

        

        // --- Placeholder Trend Data (You might calculate this in the service or servlet) ---
        // For simplicity, I'm adding static trend text. You'd fetch previous data
        // and calculate percentages in a real application.
        request.setAttribute("userTrendText", "12% from last month");
        request.setAttribute("animeTrendText", "8% from last month");
        request.setAttribute("newUsersTrendText", "15% from yesterday");
        request.setAttribute("reviewsTrendText", "3% from yesterday"); // Down trend
        request.setAttribute("activeUsersTrendText", "5% from this time yesterday");
        request.setAttribute("watchlistTrendText", "7% from last month");
        request.setAttribute("animeAddedTrendText", "18% from last month");
        request.setAttribute("genreTrendText", "32% of all anime"); // Info text
        request.setAttribute("commentsTrendText", "9% from last month");
        request.setAttribute("commentsTodayTrendText", "6% from yesterday");
        request.setAttribute("ratingTrendText", "4.8/5 (9,327 ratings)"); // Info text
        request.setAttribute("moderationTrendText", "25% from yesterday"); // Down trend
        request.setAttribute("reportedTrendText", "2 from yesterday");
        request.setAttribute("discussedTrendText", "845 comments this week"); // Info text
        request.setAttribute("seasonTrendText", "42 new anime series"); // Info text
        request.setAttribute("loadTrendText", "5% from peak hours"); // Down trend

        // Determine trend direction (up/down) based on comparison (example for reviews)
        // You would compare today's value with yesterday's/last month's
        request.setAttribute("reviewsTrendDirection", "down"); // Example
        request.setAttribute("moderationTrendDirection", "down"); // Example
        request.setAttribute("loadTrendDirection", "down"); // Example
		String action = request.getParameter("action");
		List<User> customers = service.getAllCustomers();
        request.setAttribute("customers", customers); // Set attribute for the JSP
        try {
			List <Anime> allanime = animeService.getAllAnimes();
			 request.setAttribute("animeList", allanime);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("works");
		       
		}
        // Forward to the JSP page (relative path from webapp root)
        request.getRequestDispatcher("WEB-INF/pages/admin_dashboard.jsp").forward(request, response);

        if ("edit".equals(action)) {
            // Show edit form
            showEditForm(request, response);
        } else if ("add".equals(action) && session != null && "admin".equals(session.getAttribute("role"))) { // **** NEW: Handle 'add' action ****
            // Show the add customer form
            showAddForm(request, response);
        }
        else {
            // Default action: list all customers
            listCustomers(request, response);
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action = request.getParameter("action");

		System.out.println(action);

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
            case "addAnime":
                
                break;
            case "updateAnime":
                updateAnime(request, response);
                break;
            case "deleteAnime":
                deleteAnime(request, response);
                break;
            default:
                listCustomers(request, response);
                break;
        }
	}
    
    private String getFileExtension(Part part) {
        String submittedFileName = part.getSubmittedFileName();
        if (submittedFileName == null) return "";
        int lastDot = submittedFileName.lastIndexOf('.');
        if (lastDot == -1) return "";
        return submittedFileName.substring(lastDot).toLowerCase();
    }

    private void updateAnime(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String animeIdStr = request.getParameter("animeId");
            if (animeIdStr == null || animeIdStr.trim().isEmpty()) {
                 response.sendRedirect(request.getContextPath() + "/admin?errorAnime=UpdateFailedInvalidId#anime-management");
                return;
            }
            int animeId = Integer.parseInt(animeIdStr);

            String title = request.getParameter("title");
            String genresString = request.getParameter("genres");
            String type = request.getParameter("type");
            String episodesStr = request.getParameter("episodes");
            String status = request.getParameter("status");
            String imageUrl = request.getParameter("imageUrl");
            String synopsis = request.getParameter("synopsis");

            if (title == null || title.trim().isEmpty()) {
                // Forward back to the edit form with an error and pre-filled data if possible
                // For simplicity, redirecting now.
                response.sendRedirect(request.getContextPath() + "/admin?errorAnime=UpdateFailedMissingTitle&editAnimeId=" + animeId + "#add-anime");
                return;
            }
            
            // It's better to fetch the existing anime to update its fields,
            // rather than creating a new object. This preserves fields not on the form.
            Anime animeToUpdate = animeService.getAnimeById(animeId); // You'll need this method in AnimeService/DAO
            
            if (animeToUpdate == null) {
               response.sendRedirect(request.getContextPath() + "/admin?errorAnime=AnimeNotFoundForUpdate#anime-management");
               return;
            }
            
            animeToUpdate.setTitle(title.trim());
            animeToUpdate.setType(type);
            animeToUpdate.setStatus(status);
            animeToUpdate.setSynopsis(synopsis);

            if (episodesStr != null && !episodesStr.trim().isEmpty()) {
                try {
                    animeToUpdate.setEpisodes(Integer.parseInt(episodesStr));
                } catch (NumberFormatException e) {
                    // Keep existing episodes value if new one is invalid, or set to 0
                    // animeToUpdate.setEpisodes(animeToUpdate.getEpisodes()); // No change
                    System.err.println("Invalid number format for episodes during update: " + episodesStr + ". Keeping existing value or defaulting.");
                    // Or set to a default if that's preferred: animeToUpdate.setEpisodes(0);
                }
            } else {
                 // If episodes field is submitted blank, decide behavior: clear it (set to 0/null) or keep existing.
                 // Setting to 0 if blank:
                 animeToUpdate.setEpisodes(0); 
            }

            if (genresString != null && !genresString.trim().isEmpty()) {
                 List<String> genreList = Arrays.stream(genresString.split(","))
                                             .map(String::trim)
                                             .filter(genreName -> !genreName.isEmpty())
                                             .collect(Collectors.toList());
                animeToUpdate.setGenres(genreList);
            } else {
                // If genres string is empty, clear the existing genres
                animeToUpdate.setGenres(new ArrayList<>()); 
            }

            Anime success = animeService.updateAnime(animeToUpdate); 
            System.out.print(success);
            

           
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin?errorAnime=UpdateFailedInvalidIdFormat#anime-management");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin?errorAnime=UpdateFailedServerError#anime-management");
        }
    }

    private void deleteAnime(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	System.out.print("rahuysaj");
        try {
            String animeIdStr = request.getParameter("animeId");
             if (animeIdStr == null || animeIdStr.trim().isEmpty()) {
                 response.sendRedirect(request.getContextPath() + "/admin?errorAnime=DeleteFailedInvalidId#anime-management");
                return;
            }
            int animeId = Integer.parseInt(animeIdStr);
            
            boolean success = animeService.deleteAnime(animeId); 

            System.out.print(success);
            response.sendRedirect(request.getContextPath() + "/admin?success=AnimeDeleted");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin?error=DeleteFailedInvalidIdFormat#anime-management");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

	private void listCustomers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
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
                 response.sendRedirect(request.getContextPath() + "/admin"); // Redirect with error param
            }
        } catch (NumberFormatException e) {
             System.err.println("Invalid User ID format for edit: " + request.getParameter("userId"));
             response.sendRedirect(request.getContextPath() + "/admin?error=InvalidUserId"); // Redirect with error param
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
                 response.sendRedirect(request.getContextPath() + "/admin?error=UpdateFailedUserNotFound");
                 return;
            }

            // Update only the fields from the form
            userToUpdate.setUsername(username);
            userToUpdate.setEmail(email);
            // userToUpdate.setSomeOtherField(request.getParameter("someOtherField"));

            boolean success = service.updateUser(userToUpdate);

            if (success) {
                System.out.println("User updated successfully: ID " + userId);
                 response.sendRedirect(request.getContextPath() + "/admin?success=UserUpdated"); // Redirect after successful POST
            } else {
                 System.err.println("Update failed for user ID: " + userId);
                 // Optionally, redirect back to edit form with an error message
                 // request.setAttribute("errorMessage", "Update failed. Please try again.");
                 // request.setAttribute("customerToEdit", userToUpdate); // Send back the attempted data
                 // request.getRequestDispatcher("/editCustomer.jsp").forward(request, response);
                 // For simplicity now, just redirect to list
                 response.sendRedirect(request.getContextPath() + "/admin?error=UpdateFailed");
            }

        } catch (NumberFormatException e) {
             System.err.println("Invalid User ID format for update: " + request.getParameter("userId"));
             response.sendRedirect(request.getContextPath() + "/admin?error=InvalidUserId");
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
                 response.sendRedirect(request.getContextPath() + "/admin?success=UserDeleted"); // Redirect after successful POST
            } else {
                System.err.println("Delete failed for user ID: " + userId);
                response.sendRedirect(request.getContextPath() + "/admin?error=DeleteFailed");
            }
        } catch (NumberFormatException e) {
             System.err.println("Invalid User ID format for delete: " + request.getParameter("userId"));
             response.sendRedirect(request.getContextPath() + "/admin?error=InvalidUserId");
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
            response.sendRedirect(request.getContextPath() + "/admin?action=add&error=MissingFields"); 
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
            response.sendRedirect(request.getContextPath() + "/admin?success=UserAdded"); // Redirect on success
        } else {
            System.err.println("Failed to add new customer: " + username);
            // Redirect back to list view with a generic error, or back to add form with specific error
            response.sendRedirect(request.getContextPath() + "/admin?error=AddFailed");
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
