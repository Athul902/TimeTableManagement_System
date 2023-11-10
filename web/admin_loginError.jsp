<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Super Admin Login</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f7f9fc;
                color: #333;
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            .navbar {
                background-color: #293b5f;
                color: #fff;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0rem 4rem;
            }

            .navbar h1 {
                font-size: 2.5rem;
                margin: 0;
                padding: 1rem;
                background: linear-gradient(45deg, #ffffff, #007fa3);
                background-clip: text;
                -webkit-background-clip: text;
                color: transparent;
            }

            .back-button {
                background-color: #d9534f;
                color: white;
                padding: 0.5rem 1rem;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 1rem;
                transition: background-color 0.3s, transform 0.2s;
            }

            .back-button:hover {
                background-color: #c9302c;
                transform: translateY(-2px);
            }

            .login-container {
                max-width: 900px;
                width: 100%;
                background-color: #fff;
                padding: 2rem;
                border-radius: 8px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
                margin: 160px auto; /* Center horizontally and provide top and bottom margin */
            }

            form {
                display: flex;
                flex-direction: column;
            }

            label {
                margin-bottom: 8px;
            }

            input[type="text"], input[type="password"], select {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: none;
                background-color: #f0f2f5;
                color: #333;
                border-radius: 4px;
            }

            .login-button {
                background-color: #007fa3;
                color: white;
                padding: 1rem 2rem;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 1rem;
                transition: background-color 0.3s, transform 0.2s;
            }

            .login-button:hover {
                background-color: #005e7d;
                transform: translateY(-2px);
            }
        </style>
    </head>
    <body>
        <div class="navbar">
            <h1>Admin Login</h1>
            <button class="back-button" onclick="window.location.href = 'index.jsp'">Back</button>
        </div>
        <div class="login-container">            
            <form action="admin_login.jsp" method="post">
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <button class="login-button" type="submit">Login</button>
            </form>
            <% String errorParam = request.getParameter("error");
                boolean showError = errorParam != null && errorParam.equals("1");
                if (showError) { %>
            <p class="error-message">Invalid username or password. Please try again.</p>
            <% }%>
        </div>
    </body>
</html>
