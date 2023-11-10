<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@ page import="com.mongodb.MongoClient, com.mongodb.client.MongoDatabase, com.mongodb.client.MongoCollection, org.bson.Document, java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add New Subject</title>
        <style>
            /* Your styles here */
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
                /* Move h1 to the left side */
                margin-right: auto;
            }

            .logout-button {
                background-color: #d9534f;
                color: white;
                padding: 0.5rem 1rem;
                border: none;
                border-radius: 50px;
                cursor: pointer;
                font-size: 1rem;
                transition: background-color 0.3s, transform 0.2s;
            }

            .logout-button:hover {
                background-color: #c9302c;
                transform: translateY(-2px);
            }

            .form-container {
                max-width: 900px;
                width: 100%;
                background-color: #fff;
                padding: 2rem;
                border-radius: 8px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
                margin: 40px auto; /* Center horizontally and provide top and bottom margin */
            }

            form {
                display: flex;
                flex-direction: column;
            }

            label {
                margin-bottom: 8px;
            }

            input[type="text"], input[type="email"], input[type="number"], input[type="date"], select {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: none;
                background-color: #f0f2f5;
                color: #333;
                border-radius: 4px;
            }

            input[type="submit"] {
                background-color: #007fa3;
                color: white;
                padding: 1rem 2rem;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 1rem;
                transition: background-color 0.3s, transform 0.2s;
            }

            input[type="submit"]:hover {
                background-color: #005e7d;
                transform: translateY(-2px);
            }
        </style>
    </head>
    <body>
        <div class="navbar">
            <h1>Admin Portal</h1>
            <button class="logout-button" id="superAdminLogin">Super Admin</button>
            <button class="logout-button" id="index">Logout</button>
        </div>
        <div class="form-container">
            <form action="set_timetable.jsp" method="get"> <!-- Use GET to pass course as a parameter -->
                <label for="courseName">Select Course:</label>
                <select id="courseName" name="course" required>
                    <!-- Populate unique course options from the database -->
                    <%
                        MongoClient mongo1 = new MongoClient("localhost", 27017);
                        MongoDatabase database1 = mongo1.getDatabase("timetable");
                        MongoCollection<Document> collection1 = database1.getCollection("courses");
                        Set<String> uniqueCourseNames = new HashSet<>(); // Use a set to ensure uniqueness
                        for (Document document : collection1.find()) {
                            uniqueCourseNames.add(document.getString("courseName"));
                        }
                        mongo1.close();
                        for (String course : uniqueCourseNames) {
                    %>
                    <option value="<%= course%>"><%= course%></option>
                    <% }%>
                </select>
                <input type="submit" value="Set Timetable">
            </form>
            <script>
                const superAdminLogin = document.getElementById("superAdminLogin");

                superAdminLogin.addEventListener("click", () => {
                    window.location.href = "superAdminLogin.html"; // Redirect to index1.html
                });
                
                const index = document.getElementById("index");

                index.addEventListener("click", () => {
                    window.location.href = "index.jsp"; // Redirect to index.jsp
                });
            </script>
        </div>
    </body>
</html>
