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
            <h1>Add New Subject</h1>
            <button class="back-button" onclick="window.location.href = 'index.html'">Back</button>
        </div>
        <div class="form-container">
            <form action="addsubject.jsp" method="post">
                <label for="courseName">Select Course:</label>
                <select id="courseName" name="courseName" required>
                    <%
                        MongoClient mongo = new MongoClient("localhost", 27017);
                        MongoDatabase database = mongo.getDatabase("timetable");
                        MongoCollection<Document> collection = database.getCollection("courses");
                        ArrayList<String> courseNames = new ArrayList<>();
                        for (Document document : collection.find()) {
                            courseNames.add(document.getString("courseName"));
                        }
                        mongo.close();
                        for (String course : courseNames) {
                    %>
                    <option value="<%= course%>"><%= course%></option>
                    <% }%>
                </select>

                <label for="subjectFullName">Subject Full Name:</label>
                <input type="text" id="subjectFullName" name="subjectFullName" required>

                <label for="subjectShortName">Subject Short Name:</label>
                <input type="text" id="subjectShortName" name="subjectShortName" required>

                <label for="subjectCode">Subject Code:</label>
                <input type="text" id="subjectCode" name="subjectCode" required>

                <input type="submit" value="Submit">
            </form>
        </div>
    </body>
</html>
