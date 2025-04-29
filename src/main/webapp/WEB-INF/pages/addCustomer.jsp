<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Customer</title>
    <%-- Reuse styles from editCustomer.jsp or define similar ones --%>
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
            margin: 20px auto;
            border: 1px solid #2d2d2d;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #d1d5db;
            font-weight: bold;
        }
        .form-control {
            width: 100%;
            padding: 10px 12px;
            background-color: #2d2d2d;
            border: 1px solid #4b5563;
            color: #ffffff;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .form-control:focus {
            outline: none;
            border-color: #6366f1;
            box-shadow: 0 0 0 2px rgba(99, 102, 241, 0.5);
        }
        .button-primary {
            background-color: #6366f1;
            color: #ffffff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.2s ease;
        }
        .button-primary:hover {
            background-color: #4f46e5;
        }
        .button-secondary {
            background-color: transparent;
            color: #9ca3af;
            padding: 10px 20px;
            border: 1px solid #4b5563;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            margin-left: 10px;
            text-decoration: none;
             transition: background-color 0.2s ease, color 0.2s ease;
        }
        .button-secondary:hover {
             background-color: #2d2d2d;
             color: #e5e7eb;
        }
        h1 {
            margin-bottom: 30px;
            text-align: center;
        }
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
        <h1>Add New Customer</h1>

        <%-- Display error message if redirected back from servlet --%>
         <c:if test="${not empty param.error and param.error == 'MissingFields'}">
             <p class="message message-error">Please fill in all required fields.</p>
         </c:if>
         <%-- Add handling for other potential errors like duplicate username/email if needed --%>


        <form action="${pageContext.request.contextPath}/admin" method="POST">
            <%-- Hidden field to specify the action --%>
            <input type="hidden" name="action" value="insert">

            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" class="form-control" required minlength="8"> <%-- Added minlength example --%>
            </div>

            <%-- Role is set automatically in the servlet for this flow --%>

            <div>
                <button type="submit" class="button-primary">Add Customer</button>
                <a href="${pageContext.request.contextPath}/admin" class="button-secondary">Cancel</a>
            </div>
        </form>
    </div>
</body>
</html>