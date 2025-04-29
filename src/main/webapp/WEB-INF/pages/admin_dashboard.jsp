<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adminDashboard.css">
</head>
<body class="antialiased">

    <div class="dashboard-layout">
        <aside class="sidebar">
            <div class="sidebar-header">
                <div class="sidebar-logo">
                    <span class="sidebar-logo-text">★</span>
                </div>
                <h1 class="sidebar-title">Admin Panel</h1>
            </div>
            
          

            <nav class="sidebar-nav">
                 <ul>
                     <li>
                         <a href="#" onclick="showSection('user-management', this)" class="sidebar-link active">
                             <svg class="" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.501 20.118a7.5 7.5 0 0114.998 0A17.933 17.933 0 0112 21.75c-2.676 0-5.216-.584-7.499-1.632z" /></svg>
                             User Management
                         </a>
                     </li>
                     <li>
                         <a href="#" onclick="showSection('anime-management', this)" class="sidebar-link">
                             <svg class="" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M4.26 10.147a60.436 60.436 0 00-.491 6.347A48.627 48.627 0 0112 20.904a48.627 48.627 0 018.232-4.41 60.46 60.46 0 00-.491-6.347m-15.482 0a50.57 50.57 0 00-2.658-.813A59.905 59.905 0 0112 3.493a59.902 59.902 0 0110.399 5.84c-.896.248-1.783.52-2.658.814m-15.482 0A50.697 50.697 0 0112 13.489a50.702 50.702 0 017.74-3.342M6.75 15a.75.75 0 100-1.5.75.75 0 000 1.5zm0 0v-3.675A55.378 55.378 0 0112 8.443m-7.007 11.55A5.981 5.981 0 006.75 15.75v-1.5" /></svg>
                             Anime Management
                         </a>
                     </li>
                     <li>
                         <a href="#" onclick="showSection('add-anime', this)" class="sidebar-link">
                             <svg class="" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M12 9v6m3-3H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
                             Add New Anime
                         </a>
                     </li>
                 </ul>
            </nav>
        </aside>

        <div class="main-content-area">
            <header class="header">
                <div class="header-content">
                    <div>
                        <h1 class="header-title">Admin Dashboard</h1>
                    </div>
                    <div style="display: flex; align-items: center; column-gap: 1rem;"> <div style="position: relative;">
                            <button class="header-profile-button">
                                <span class="sr-only">Admin profile</span>
                                <div class="header-profile-avatar">A</div>
                                <span class="header-profile-name">Admin</span>
                            </button>
                            </div>
                    </div>
                </div>
            </header>

            <main class="main-content">

                <section id="user-management" class="admin-section active">
                    <div class="section-header">
                        <h2 class="section-title">User Management</h2>
                        
                            <div style="margin-bottom: 20px;">
						        <a href="${pageContext.request.contextPath}/customers?action=add" class="button-primary" style="text-decoration: none;">
						            Add New Customer
						        </a>
						         <%-- Reusing button-primary style from editCustomer.jsp, ensure it's defined or adapt --%>
						         <%-- Add this style if not already present from edit page --%>
						         <style>
						            .button-primary {
						                background-color: #6366f1; /* indigo */
						                color: #ffffff;
						                padding: 10px 15px; /* Slightly smaller padding maybe */
						                border: none;
						                border-radius: 4px;
						                cursor: pointer;
						                font-weight: bold;
						                display: inline-block; /* Make it behave like a button */
						                text-align: center;
						                transition: background-color 0.2s ease;
						            }
						            .button-primary:hover {
						                background-color: #4f46e5; /* darker indigo */
						            }
						         </style>
						    </div>                   
                    </div>
                    
                    
                    
                    <c:if test="${not empty param.success}">
				        <div class="message message-success">
				            <c:choose>
				                <c:when test="${param.success == 'UserDeleted'}">User deleted successfully.</c:when>
				                <c:when test="${param.success == 'UserUpdated'}">User updated successfully.</c:when>
				                <c:otherwise>Operation successful.</c:otherwise> <%-- Generic success --%>
				            </c:choose>
				        </div>
				    </c:if>
				    <c:if test="${not empty param.error}">
				         <div class="message message-error">
				             <c:choose>
				                 <c:when test="${param.error == 'UserNotFound'}">User not found for editing.</c:when>
				                 <c:when test="${param.error == 'InvalidUserId'}">Invalid user ID provided.</c:when>
				                 <c:when test="${param.error == 'DeleteFailed'}">Failed to delete user.</c:when>
				                 <c:when test="${param.error == 'UpdateFailed'}">Failed to update user.</c:when>
				                 <c:when test="${param.error == 'UpdateFailedUserNotFound'}">Update failed: User not found.</c:when>
				                 <c:when test="${param.error == 'ServerError'}">An internal server error occurred.</c:when>
				                 <c:otherwise>An error occurred.</c:otherwise> <%-- Generic error --%>
				             </c:choose>
				         </div>
				    </c:if>

                    <div class="section-content-container">
                        <div class="table-container">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Username</th>
                                        <th>Email</th>
                                        <th>Joined</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                 <c:choose>
					                <c:when test="${empty customers}">
					                    <tr>
					                        <td colspan="5" style="text-align: center; padding: 20px;" class="text-gray-400">No customers found.</td>
					                    </tr>
					                </c:when>
					                <c:otherwise>
					                    <c:forEach var="customer" items="${customers}">
		                                    <tr>
		                                        <td class="text-white">${customer.username}</td>
		                                        <td class="text-gray-300">${customer.email}</td>
		                                        <td class="text-gray-400">
		                                        	<c:if test="${not empty customer.createdAt}">
					                                    ${customer.createdAt.toString().substring(0, 10)}
					                                </c:if>
		                                        </td>
		                                        <td>
		                                            <span class="status-badge status-badge-green">Active</span>
		                                        </td>
		                                        <td class="action-button-group">
		                                           <!--  <button onclick="alert('Edit user: AnimeFan42')" class="button-link-indigo" title="Edit User">
		                                                <svg class="button-link-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg>
		                                            </button>
		                                            <button onclick="confirm('Are you sure you want to delete user: AnimeFan42?')" class="button-link-red" title="Delete User">
		                                                <svg class="button-link-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
		                                            </button> -->
		                                           
		                                            <a href="${pageContext.request.contextPath}/customers?action=edit&userId=${customer.userId}" class="button-link-indigo" title="Edit User ${customer.username}">
					                                    <svg class="button-link-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
					                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path>
					                                    </svg>
					                                </a>
					
					                                <%-- Delete Form: Submits via POST to the servlet to perform deletion --%>
					                                <form action="${pageContext.request.contextPath}/customers" method="POST" onsubmit="return confirm('Are you sure you want to delete user: ${customer.username}?');">
					                                    <%-- Hidden fields to send data --%>
					                                    <input type="hidden" name="action" value="delete">
					                                    <input type="hidden" name="userId" value="${customer.userId}">
					
					                                    <%-- Submit button styled like a link --%>
					                                    <button type="submit" class="button-link-red" title="Delete User ${customer.username}">
					                                        <svg class="button-link-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
					                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
					                                        </svg>
					                                    </button>
					                                </form>
		                                        </td>
		                                        
		                                    </tr>
		                                    	</c:forEach>
							                 </c:otherwise>
							             </c:choose>
                                    </tbody>
                            </table>
                        </div>
                        <div class="pagination-container">
                            <div class="sm-hidden"> <a href="#" class="button button-secondary"> Previous </a>
                                <a href="#" class="button button-secondary" style="margin-left: 0.75rem;"> Next </a>
                            </div>
                            <div class="sm-flex"> <div><p class="pagination-info">Showing <span class="font-medium">1</span> to <span class="font-medium">3</span> of <span class="font-medium">97</span> results</p></div>
                                <div><nav class="pagination-nav" aria-label="Pagination">
                                    <a href="#">
                                        <span class="sr-only">Previous</span>
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true"><path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd" /></svg>
                                    </a>
                                    <a href="#" aria-current="page"> 1 </a>
                                    <a href="#"> 2 </a>
                                    <a href="#" class="md-inline-flex"> 3 </a>
                                    <span class="md-inline-flex"> ... </span>
                                    <a href="#" class="md-inline-flex"> 8 </a>
                                    <a href="#"> 9 </a>
                                    <a href="#"> 10 </a>
                                    <a href="#">
                                        <span class="sr-only">Next</span>
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" /></svg>
                                    </a>
                                </nav></div>
                            </div>
                        </div>
                    </div>
                </section>

                <section id="anime-management" class="admin-section">
                     <div class="section-header">
                        <h2 class="section-title">Anime Management</h2>
                        <button onclick="showSection('add-anime', this)" class="button button-primary">
                             <svg class="button-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" /></svg>
                            Add New Anime
                        </button>
                    </div>
                    <div class="section-content-container">
                        <div class="table-container">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Title</th>
                                        <th>Genre</th>
                                        <th>Episodes</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="text-gray-400">ANI001</td>
                                        <td class="text-white">Attack on Titan: Final Season</td>
                                        <td class="text-gray-300">Action, Drama, Fantasy</td>
                                        <td class="text-gray-400">28</td>
                                        <td>
                                            <span class="status-badge status-badge-blue">Airing</span>
                                        </td>
                                        <td class="action-button-group">
                                            <button onclick="alert('Edit anime: ANI001')" class="button-link-indigo" title="Edit Anime">
                                                <svg class="button-link-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg>
                                            </button>
                                            <button onclick="confirm('Are you sure you want to delete anime: ANI001?')" class="button-link-red" title="Delete Anime">
                                                <svg class="button-link-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="text-gray-400">ANI002</td>
                                        <td class="text-white">Frieren: Beyond Journey's End</td>
                                        <td class="text-gray-300">Adventure, Drama, Fantasy</td>
                                        <td class="text-gray-400">28</td>
                                        <td>
                                            <span class="status-badge status-badge-green">Finished</span>
                                        </td>
                                        <td class="action-button-group">
                                            <button onclick="alert('Edit anime: ANI002')" class="button-link-indigo" title="Edit Anime">
                                                <svg class="button-link-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg>
                                            </button>
                                            <button onclick="confirm('Are you sure you want to delete anime: ANI002?')" class="button-link-red" title="Delete Anime">
                                                <svg class="button-link-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
                                            </button>
                                        </td>
                                    </tr>
                                    </tbody>
                            </table>
                        </div>
                         <div class="pagination-container">
                             <div class="sm-hidden"> <a href="#" class="button button-secondary"> Previous </a>
                                <a href="#" class="button button-secondary" style="margin-left: 0.75rem;"> Next </a>
                            </div>
                            <div class="sm-flex"> <div><p class="pagination-info">Showing <span class="font-medium">1</span> to <span class="font-medium">2</span> of <span class="font-medium">567</span> results</p></div>
                                <div><nav class="pagination-nav" aria-label="Pagination">
                                     <a href="#">
                                        <span class="sr-only">Previous</span>
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true"><path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd" /></svg>
                                    </a>
                                    <a href="#" aria-current="page"> 1 </a>
                                    <a href="#"> 2 </a>
                                    <a href="#">
                                        <span class="sr-only">Next</span>
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" /></svg>
                                    </a>
                                </nav></div>
                            </div>
                        </div>
                    </div>
                </section>

                <section id="add-anime" class="admin-section">
                    <h2 class="section-title" style="margin-bottom: 1.5rem;">Add New Anime</h2>
                     <div class="form-container">
                         <form id="add-anime-form">
                             <div class="form-grid">
                                <div>
                                    <label for="anime-title-add" class="form-label">Anime Title</label>
                                    <input type="text" id="anime-title-add" name="anime-title" required class="form-input">
                                </div>
                                <div>
                                    <label for="anime-genre-add" class="form-label">Genre <span class="form-label-note">(comma-separated)</span></label>
                                    <input type="text" id="anime-genre-add" name="anime-genre" required class="form-input" placeholder="e.g., Action, Adventure">
                                </div>
                                 <div>
                                    <label for="anime-type-add" class="form-label">Type</label>
                                    <select id="anime-type-add" name="anime-type" class="form-select">
                                        <option>TV</option>
                                        <option>Movie</option>
                                        <option>OVA</option>
                                        <option>ONA</option>
                                        <option>Special</option>
                                        <option>Music</option>
                                    </select>
                                </div>
                                 <div>
                                    <label for="anime-episodes-add" class="form-label">Episodes</label>
                                    <input type="number" id="anime-episodes-add" name="anime-episodes" min="0" class="form-input" placeholder="Leave blank if unknown">
                                </div>
                                <div>
                                    <label for="anime-status-add" class="form-label">Status</label>
                                    <select id="anime-status-add" name="anime-status" class="form-select">
                                        <option>Finished Airing</option>
                                        <option>Currently Airing</option>
                                        <option>Not yet aired</option>
                                    </select>
                                </div>
                                 <div>
                                    <label for="image-url-add" class="form-label">Image URL</label>
                                    <input type="url" id="image-url-add" name="image-url" class="form-input" placeholder="https://example.com/image.jpg">
                                </div>
                                 <div class="md-col-span-2">
                                    <label for="anime-synopsis-add" class="form-label">Synopsis</label>
                                    <textarea id="anime-synopsis-add" name="anime-synopsis" rows="5" class="form-textarea"></textarea>
                                </div>
                            </div>
                            <div class="form-actions">
                                <button type="button" onclick="showSection('anime-management', this)" class="button button-secondary">
                                    Cancel
                                </button>
                                <button type="submit" class="button button-primary">
                                    Save Anime
                                </button>
                            </div>
                         </form>
                     </div>
                </section>

            </main>
        </div>
    </div>

    <script>
        /**
         * Shows the specified section and hides others.
         * Also updates the active state of the sidebar links.
         * @param {string} sectionId - The ID of the section to show.
         * @param {HTMLElement} [clickedLink=null] - The sidebar link element that was clicked.
         */
        function showSection(sectionId, clickedLink = null) {
            // Hide all sections first
            document.querySelectorAll('.admin-section').forEach(section => {
                section.classList.remove('active');
            });

            // Remove active class from all sidebar links
            document.querySelectorAll('.sidebar-link').forEach(link => {
                link.classList.remove('active');
            });

            // Show the target section
            const targetSection = document.getElementById(sectionId);
            if (targetSection) {
                // Use setTimeout to ensure display:block happens before transition starts
                 setTimeout(() => {
                    targetSection.classList.add('active');
                 }, 10); // Small delay helps ensure transition visibility
            }

            // Add active class to the clicked sidebar link (or find it if needed)
            let targetLink = clickedLink;
            if (!targetLink) {
                 // If called from a button (like Add New Anime), find the corresponding sidebar link
                 const links = document.querySelectorAll('.sidebar-link');
                 for (let link of links) {
                     const onclickAttr = link.getAttribute('onclick');
                     if (onclickAttr && onclickAttr.includes(`showSection('${sectionId}'`)) {
                         targetLink = link;
                         break;
                     }
                 }
            }
             if (targetLink) {
                 targetLink.classList.add('active');
             }

            // Prevent default anchor behavior if triggered by a link click
            if (clickedLink && clickedLink.tagName === 'A' && event) {
                event.preventDefault();
            }
        }

        /**
         * Handles the submission of the "Add New Anime" form.
         * Prevents default submission and logs data to console.
         * @param {Event} event - The form submission event.
         */
        function handleAddAnimeSubmit(event) {
            event.preventDefault(); // Prevent default form submission
            // --- Add your actual form submission logic here ---
            const formData = new FormData(event.target);
            const animeData = Object.fromEntries(formData.entries());
            console.log('Anime data to save:', animeData);
            alert('Anime "saved"! (Check console for data). Implement actual save logic.');
            // Optionally, clear the form or switch back to the anime list
            // event.target.reset();
            // showSection('anime-management'); // Need to find the link element here if switching view
        }

        // Add event listener for the form after the DOM is loaded
        document.addEventListener('DOMContentLoaded', () => {
            const addAnimeForm = document.getElementById('add-anime-form');
            if (addAnimeForm) {
                addAnimeForm.addEventListener('submit', handleAddAnimeSubmit);
            }

            // Ensure the default section's link is marked active on load
            // (The section itself already has the 'active' class in HTML)
            const initialActiveLink = document.querySelector('.sidebar-link.active');
            // No need to call showSection on load if default state is set in HTML
        });

    </script>

</body>
</html>
