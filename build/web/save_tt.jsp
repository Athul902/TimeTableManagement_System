<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" 
         import="com.mongodb.MongoClient, com.mongodb.client.MongoDatabase, com.mongodb.client.MongoCollection, org.bson.Document" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Your head content here -->
</head>
<body>
    <%
    String selectedCourse = request.getParameter("selectedCourse");
    String date = request.getParameter("date");
    String lectureMode = request.getParameter("lectureMode");
    String faculty = request.getParameter("faculty");
    String selectedSubject = request.getParameter("selectedSubject");
    String timeFrom = request.getParameter("timeFrom");
    String timeTo = request.getParameter("timeTo");

    if (selectedCourse != null && date != null && lectureMode != null && faculty != null && selectedSubject != null && timeFrom != null && timeTo != null) {
        try {
            MongoClient mongoClient = new MongoClient("localhost", 27017);
            MongoDatabase database = mongoClient.getDatabase("timetable");
            MongoCollection<Document> collection = database.getCollection("timetable_entries");

            Document entry = new Document()
                .append("selectedCourse", selectedCourse)
                .append("date", date)
                .append("lectureMode", lectureMode)
                .append("faculty", faculty)
                .append("selectedSubject", selectedSubject)
                .append("timeFrom", timeFrom)
                .append("timeTo", timeTo)
                .append("faculty1", faculty)
                .append("selectedSubject1", selectedSubject)
                .append("timeFrom1", timeFrom)
                .append("timeTo1", timeTo)
                .append("faculty2", faculty)
                .append("selectedSubject2", selectedSubject)
                .append("timeFrom2", timeFrom)
                .append("timeTo2", timeTo)
                .append("faculty3", faculty)
                .append("selectedSubject3", selectedSubject)
                .append("timeFrom3", timeFrom)
                .append("timeTo3", timeTo)
                .append("faculty4", faculty)
                .append("selectedSubject4", selectedSubject)
                .append("timeFrom4", timeFrom)
                .append("timeTo4", timeTo)
                .append("faculty5", faculty)
                .append("selectedSubject5", selectedSubject)
                .append("timeFrom5", timeFrom)
                .append("timeTo5", timeTo)
                .append("faculty6", faculty)
                .append("selectedSubject6", selectedSubject)
                .append("timeFrom6", timeFrom)
                .append("timeTo6", timeTo);

            collection.insertOne(entry);
            mongoClient.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

    <div class="form-container">
        <p>Subject saved successfully.</p>
        <p>Redirecting, please wait...</p>
    </div>

    <script>
        setTimeout(function () {
            window.location.href = "index1.jsp"; // Redirect to the appropriate page
        }, 3000); // Redirect after 3 seconds
    </script>
</body>
</html>
