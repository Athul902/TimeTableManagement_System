<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" 
         import="com.mongodb.MongoClient, com.mongodb.client.MongoDatabase, com.mongodb.client.MongoCollection, org.bson.Document" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Your head content here -->
</head>
<body>
    <%
        String courseName = request.getParameter("courseName");
        String subjectFullName = request.getParameter("subjectFullName");
        String subjectShortName = request.getParameter("subjectShortName");
        String subjectCode = request.getParameter("subjectCode");

        MongoClient mongo = new MongoClient("localhost", 27017);
        MongoDatabase database = mongo.getDatabase("timetable"); // Replace with your database name
        MongoCollection<Document> collection = database.getCollection("subjects");

        Document courseDocument = new Document("courseName", courseName)
                .append("subjectFullName", subjectFullName).append("subjectShortName", subjectShortName)
                .append("subjectCode", subjectCode);

        collection.insertOne(courseDocument);
        mongo.close();
    %>

    <div class="form-container">
        <p>Subject saved successfully.</p>
        <p>Redirecting, please wait...</p>
    </div>

    <script>
        setTimeout(function () {
            window.location.href = "add_sub.jsp"; // Redirect to the appropriate page
        }, 3000); // Redirect after 3 seconds
    </script>
</body>
</html>
