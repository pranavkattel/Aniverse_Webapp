<%@page import="com.aniverse.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- Or Jakarta equivalent --%>
<%-- Example using Jakarta EE 9+ JSTL tags --%>
<%-- <%@ taglib uri="jakarta.tags.core" prefix="c" %> --%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Settings - AnimeTracker</title>
    <%-- Link your actual CSS files --%>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/userDashboard.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/accountSettings.css">
    <style>
        /* --- Include the CSS styles from the previous example here or ensure accountSettings.css contains them --- */
        .settings-container { max-width: 800px; margin: 40px auto; padding: 30px; background-color: rgba(15, 23, 42, 0.9); border-radius: 10px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.4); color: #e2e8f0; }
        .settings-section { margin-bottom: 40px; padding-bottom: 30px; border-bottom: 1px solid #334155; }
        .settings-section:last-child { border-bottom: none; margin-bottom: 0; padding-bottom: 0;}
        .settings-section h3 { color: #cbd5e1; margin-bottom: 20px; border-bottom: 1px solid #475569; padding-bottom: 10px;}
        .settings-form .form-group { margin-bottom: 20px; }
        .settings-form label { display: block; margin-bottom: 8px; font-weight: 600; color: #94a3b8; }
        .settings-form input[type="text"], .settings-form input[type="email"], .settings-form input[type="password"] { width: 100%; padding: 12px; background-color: #1e293b; border: 1px solid #334155; border-radius: 6px; color: #e2e8f0; box-sizing: border-box; }
        .settings-form input:focus { outline: none; border-color: #5d5fef; box-shadow: 0 0 0 2px rgba(93, 95, 239, 0.3); }
        .settings-button { background-color: #5d5fef; color: white; padding: 10px 20px; border: none; border-radius: 6px; cursor: pointer; font-size: 15px; transition: background-color 0.3s ease; }
        .settings-button:hover { background-color: #4338ca; }
        .delete-button { background-color: #dc2626; }
        .delete-button:hover { background-color: #b91c1c; }
        .message { padding: 12px; margin-top: 15px; border-radius: 5px; font-weight: 500; }
        .success-message { background-color: rgba(34, 197, 94, 0.2); color: #22c55e; border: 1px solid #22c55e; }
        .error-message { background-color: rgba(239, 68, 68, 0.2); color: #ef4444; border: 1px solid #ef4444; }
        .password-note { font-size: 0.9em; color: #64748b; margin-top: 5px; }
        .delete-section { border-left: 4px solid #dc2626; padding: 20px; background-color: rgba(220, 38, 38, 0.05); } /* Highlight delete */
        .delete-confirmation label { display: inline-block; margin-left: 10px; color: #f87171; font-weight: normal; cursor: pointer;}
        .delete-confirmation input[type="checkbox"] { vertical-align: middle; }
    </style>
</head>
<body>
    
  
	 <jsp:include page="/WEB-INF/components/header.jsp" />
    <div class="container settings-container">
        <h2>Account Settings</h2>
        
		


        <c:if test="${not empty userFromDb}">
            <%-- Make user data easily accessible --%>
          

            <%-- Display general error messages (e.g., connection error) if any --%>
            <%--  <c:if test="${ empty errorMessage}">
                <div class="message error-message">${errorMessage}</div>
             </c:if>
 --%>

            <%-- === Change Username Section === --%>
            <div class="settings-section">
                <h3>Change Username</h3>
                <form action="${pageContext.request.contextPath}/accountsettings" method="POST" class="settings-form">
   					<input type="hidden" name="action" value="changeUsername">
                    <div class="form-group">
                        <label>Current Username</label>
                        <input type="text" value="<c:out value='${userFromDb.getUsername()}'/>" disabled style="background-color: #334155;">
                    </div>
                    <div class="form-group">
                        <label for="newUsername">New Username</label>
                        <input type="text" id="newUsername" name="newUsername" required maxlength="50">
                    </div>
                    <div class="form-group">
                        <label for="currentPassword_username">Current Password</label>
                        <input type="password" id="currentPassword_username" name="currentPassword" required>
                        <p class="password-note">Required to change username.</p>
                    </div>
                    <%-- Display messages specific to this action --%>
                    <c:if test="${not empty successMessage_changeUsername}"><div class="message success-message">${successMessage_changeUsername}</div></c:if>
                    <c:if test="${not empty errorMessage_changeUsername}"><div class="message error-message">${errorMessage_changeUsername}</div></c:if>
                    <button type="submit" class="settings-button">Update Username</button>
                </form>
            </div>

            <%-- === Change Email Section === --%>
            <div class="settings-section">
                 <h3>Change Email Address</h3>
                 <form action="${pageContext.request.contextPath}/accountsettings" method="POST" class="settings-form">
                      <input type="hidden" name="action" value="changeEmail">
                      <div class="form-group">
                          <label>Current Email</label>
                          <input type="email" value="<c:out value='${userFromDb.getEmail()}'/>" disabled style="background-color: #334155;">
                          <p class="password-note">Consider adding email verification in a real application.</p>
                      </div>
                      <div class="form-group">
                          <label for="newEmail">New Email Address</label>
                          <input type="email" id="newEmail" name="newEmail" required maxlength="100">
                      </div>
                      <div class="form-group">
                          <label for="currentPassword_email">Current Password</label>
                          <input type="password" id="currentPassword_email" name="currentPassword" required>
                          <p class="password-note">Required to change email.</p>
                      </div>
                      <%-- Display messages specific to this action --%>
                      <c:if test="${not empty successMessage_changeEmail}"><div class="message success-message">${successMessage_changeEmail}</div></c:if>
                      <c:if test="${not empty errorMessage_changeEmail}"><div class="message error-message">${errorMessage_changeEmail}</div></c:if>
                      <button type="submit" class="settings-button">Update Email</button>
                 </form>
            </div>

            <%-- === Change Password Section === --%>
            <div class="settings-section">
                 <h3>Change Password</h3>
                 <form action="${pageContext.request.contextPath}/accountsettings" method="POST" class="settings-form">
                      <input type="hidden" name="action" value="changePassword">
                      <div class="form-group">
                          <label for="currentPassword_password">Current Password</label>
                          <input type="password" id="currentPassword_password" name="currentPassword" required>
                      </div>
                      <div class="form-group">
                          <label for="newPassword">New Password</label>
                          <input type="password" id="newPassword" name="newPassword" required minlength="8"> <%-- Example: add minlength --%>
                           <p class="password-note">Must be at least 8 characters long.</p>
                      </div>
                      <div class="form-group">
                          <label for="confirmNewPassword">Confirm New Password</label>
                          <input type="password" id="confirmNewPassword" name="confirmNewPassword" required>
                      </div>
                      <%-- Display messages specific to this action --%>
                     <c:if test="${not empty successMessage_changePassword}"><div class="message success-message">${successMessage_changePassword}</div></c:if>
                     <c:if test="${not empty errorMessage_changePassword}"><div class="message error-message">${errorMessage_changePassword}</div></c:if>
                      <button type="submit" class="settings-button">Update Password</button>
                 </form>
            </div>

            <%-- === Delete Account Section === --%>
            <div class="settings-section delete-section">
                 <h3>Delete Account</h3>
                 <p style="color: #fca5a5; font-weight: bold;">Warning: This action is irreversible!</p>
                 <p style="color: #e2e8f0;">All your data, including profile information and tracked lists, will be permanently deleted.</p>
                 <br>
                 <form action="${pageContext.request.contextPath}/accountsettings" method="POST" class="settings-form">
                      <input type="hidden" name="action" value="deleteAccount">
                      <div class="form-group">
                          <label for="currentPassword_delete">Current Password</label>
                          <input type="password" id="currentPassword_delete" name="currentPassword" required>
                           <p class="password-note">Required to authorize account deletion.</p>
                      </div>
                       <div class="form-group delete-confirmation">
                          <input type="checkbox" id="confirmDelete" name="confirmDelete" required style="width: auto; margin-right: 5px;">
                          <label for="confirmDelete">I understand the consequences and wish to permanently delete my account.</label>
                      </div>
                      <%-- Display messages specific to this action --%>
                     <c:if test="${not empty errorMessage_deleteAccount}"><div class="message error-message">${errorMessage_deleteAccount}</div></c:if>
                      <button type="submit" class="settings-button delete-button">Permanently Delete My Account</button>
                 </form>
            </div>

        </c:if> <%-- End check for loggedInUser --%>

    </div> <%-- End settings-container --%>

    <%-- Include your standard footer - Adjust path as needed --%>


    <script>
       // Optional: Add client-side validation (e.g., password match before submit)
       // Example: Check if new passwords match
       const formChangePass = document.querySelector('form input[name="action"][value="changePassword"]')?.closest('form');
       if (formChangePass) {
           formChangePass.addEventListener('submit', function(event) {
               const newPass = formChangePass.querySelector('#newPassword').value;
               const confirmPass = formChangePass.querySelector('#confirmNewPassword').value;
               if (newPass !== confirmPass) {
                   alert('New passwords do not match!');
                   event.preventDefault(); // Stop form submission
               }
           });
       }
    </script>

</body>
</html>