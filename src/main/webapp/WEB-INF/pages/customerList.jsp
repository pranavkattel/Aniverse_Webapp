<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- Optional: Import fmt taglib if you use it for date formatting --%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> --%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer List</title>
    <%-- Your existing styles --%>
    <style>
        /* ... (keep your existing CSS) ... */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #121212;
            color: #ffffff;
            padding: 20px;
        }
        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #1e1e1e;
            border-radius: 8px;
            overflow: hidden;
        }
        .table th, .table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #2d2d2d;
        }
        .table thead tr {
            background-color: #2d2d2d;
            color: #ffffff;
        }
        .text-white {
            color: #ffffff;
        }
        .text-gray-300 {
            color: #d1d5db;
        }
        .text-gray-400 {
            color: #9ca3af;
        }
        .status-badge {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
        }
        .status-badge-green {
            background-color: rgba(16, 185, 129, 0.2);
            color: #10b981;
        }
        .status-badge-yellow {
            background-color: rgba(245, 158, 11, 0.2);
            color: #f59e0b;
        }
        .action-button-group {
            display: flex;
            gap: 8px;
            align-items: center; /* Align items vertically */
        }
        /* Adjusted styles for links and forms */
         .button-link-indigo, .button-link-red {
            border: none;
            background: none;
            cursor: pointer;
            padding: 4px;
            border-radius: 4px;
            display: inline-flex; /* Use inline-flex for link/button */
            align-items: center;
            justify-content: center;
            text-decoration: none; /* Remove underline from links */
            vertical-align: middle; /* Align with text if needed */
        }
        .button-link-indigo {
            color: #6366f1;
        }
        .button-link-red {
            color: #ef4444;
        }
        .button-link-icon {
            width: 20px;
            height: 20px;
        }
        .button-link-indigo:hover {
            background-color: rgba(99, 102, 241, 0.1);
        }
         /* Style the button inside the form like the link */
        form button.button-link-red:hover {
             background-color: rgba(239, 68, 68, 0.1);
        }
        form {
            display: inline; /* Keep form from taking full width */
            margin: 0;
            padding: 0;
        }
        h1 {
            margin-bottom: 20px;
        }
         /* Style for displaying messages */
        .message {
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
            font-weight: bold;
        }
        .message-success {
            background-color: rgba(16, 185, 129, 0.2);
            color: #10b981;
            border: 1px solid #10b981;
        }
        .message-error {
             background-color: rgba(239, 68, 68, 0.2);
            color: #ef4444;
            border: 1px solid #ef4444;
        }
    </style>
</head>
<body>
    <h1>Customer List</h1>
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

     <%-- Display Success/Error Messages from Redirect --%>
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
                                <%-- Using substring for simplicity. Use fmt:formatDate for better control --%>
                                <c:if test="${not empty customer.createdAt}">
                                    ${customer.createdAt.toString().substring(0, 10)}
                                </c:if>
                                <%-- <fmt:formatDate value="${customer.createdAt}" pattern="yyyy-MM-dd" /> --%>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${customer.lastLogin != null}">
                                        <span class="status-badge status-badge-green">Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge status-badge-yellow">New</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="action-button-group">
                                <%-- Edit Link: Navigates via GET to the servlet to show the edit form --%>
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

    <%-- Remove the old script block with alert/confirm only --%>
    <%--
    <script>
        // Not needed anymore as actions are handled by links/forms
    </script>
    --%>
</body>
</html>