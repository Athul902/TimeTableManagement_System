<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.mongodb.MongoClient, com.mongodb.client.MongoDatabase, com.mongodb.client.MongoCollection, org.bson.Document" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Your head content here -->
</head>
<body>
    <%
        String courseName = request.getParameter("courseName");
        String branchName = request.getParameter("branchName");

        MongoClient mongo = new MongoClient("localhost", 27017);
        MongoDatabase database = mongo.getDatabase("timetable"); // Replace with your database name
        MongoCollection<Document> collection = database.getCollection("courses");

        Document courseDocument = new Document("courseName", courseName)
                .append("branchName", branchName);

        collection.insertOne(courseDocument);
        mongo.close();
    %>

    <div class="form-container">
        <p>Course data saved successfully.</p>
        <p>Redirecting, please wait...</p>
    </div>

    <script>
        setTimeout(function () {
            window.location.href = "index.html"; // Redirect to the appropriate page
        }, 3000); // Redirect after 3 seconds
    </script>
</body>
</html>
