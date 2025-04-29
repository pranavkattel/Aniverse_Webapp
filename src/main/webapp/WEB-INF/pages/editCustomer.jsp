<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Customer</title>
    <%-- Reuse or adapt styles from customerList.jsp --%>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #121212;
            color: #ffffff;
            padding: 20px;
        }
        .form-container {
            background-color: #1e1e1e;
            padding: 30px;
            border-radius: 8px;
            max-width: 500px;
            margin: 20px auto; /* Center the form */
            border: 1px solid #2d2d2d;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #d1d5db; /* light gray */
            font-weight: bold;
        }
        .form-control {
            width: 100%;
            padding: 10px 12px;
            background-color: #2d2d2d;
            border: 1px solid #4b5563; /* darker gray */
            color: #ffffff;
            border-radius: 4px;
            box-sizing: border-box; /* Include padding and border in element's total width/height */
        }
        .form-control:focus {
            outline: none;
            border-color: #6366f1; /* indigo */
            box-shadow: 0 0 0 2px rgba(99, 102, 241, 0.5);
        }
        .button-primary {
            background-color: #6366f1; /* indigo */
            color: #ffffff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.2s ease;
        }
        .button-primary:hover {
            background-color: #4f46e5; /* darker indigo */
        }
        .button-secondary {
            background-color: transparent;
            color: #9ca3af; /* medium gray */
            padding: 10px 20px;
            border: 1px solid #4b5563;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            margin-left: 10px;
            text-decoration: none; /* For link styling */
             transition: background-color 0.2s ease, color 0.2s ease;
        }
        .button-secondary:hover {
             background-color: #2d2d2d;
             color: #e5e7eb; /* lighter gray */
        }
        h1 {
            margin-bottom: 30px;
            text-align: center;
        }
         /* Style for displaying messages */
        .message {
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
            font-weight: bold;
        }
        .message-error {
             background-color: rgba(239, 68, 68, 0.2);
            color: #ef4444;
            border: 1px solid #ef4444;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Edit Customer</h1>

         <%-- Display Error Message if update failed and redirected back here --%>
         <c:if test="${not empty errorMessage}">
              <div class="message message-error">
                  ${errorMessage}
              </div>
         </c:if>

        <%-- Check if customerToEdit object exists --%>
        <c:if test="${not empty customerToEdit}">
            <form action="${pageContext.request.contextPath}/admin" method="POST">
            
                <%-- Hidden fields to identify action and user --%>
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="userId" value="${customerToEdit.userId}">

                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" class="form-control" value="${customerToEdit.username}" required>
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" class="form-control" value="${customerToEdit.email}" required>
                </div>

                <%-- Add other editable fields here if needed --%>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="text" id="someOtherField" name="someOtherField" class="form-control" value="${customerToEdit.password}">
                </div>
                

                 <%-- Display non-editable fields if desired --%>
                 <div class="form-group">
                     <label>Role</label>
                     <input type="text" class="form-control" value="${customerToEdit.role}" disabled>
                 </div>
                  <div class="form-group">
                     <label>Joined On</label>
                     <input type="text" class="form-control" value="${customerToEdit.createdAt}" disabled>
                 </div>


                <div>
                    <button type="submit" class="button-primary">Save Changes</button>
                    <%-- Link to go back to the customer list --%>
                    <a href="${pageContext.request.contextPath}/admin" class="button-secondary">Cancel</a>
                </div>
            </form>
        </c:if>

        <%-- Message if customerToEdit object is missing (e.g., direct access attempt) --%>
        <c:if test="${empty customerToEdit}">
            <p class="message message-error">Could not load customer data for editing.</p>
             <a href="${pageContext.request.contextPath}/admin" class="button-secondary">Back to List</a>
        </c:if>
    </div>
</body>
</html>