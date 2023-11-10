<%@ page import="com.mongodb.MongoClient, com.mongodb.client.MongoDatabase, com.mongodb.client.MongoCollection, org.bson.Document, java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Show Timetable</title>
        <!-- Add your styles here -->
    </head>
    <body>
        <!-- Add your header, navigation, or any other content here -->

        <div class="timetable-container">
            <h2>Timetable</h2>
            <table>
                <thead>
                    <tr>
                        <th>Time</th>
                        <th>Subject</th>
                        <th>Faculty</th>
                    </tr>
                </thead>
                <tbody>
                    <%-- Retrieve the selected course and date from URL parameters --%>
                    <%
                        String selectedCourse = request.getParameter("course");
                        String selectedDate = request.getParameter("date");

                        out.println("Selected Course: " + selectedCourse); // Debugging
                        out.println("Selected Date: " + selectedDate);     // Debugging

                        MongoClient mongo = new MongoClient("localhost", 27017);
                        MongoDatabase database = mongo.getDatabase("timetable");
                        MongoCollection<Document> collection = database.getCollection("timetable_entries");

                        ArrayList<Document> timetableEntries = new ArrayList<>();

                        // Query the database to fetch timetable entries for the selected course and date
                        // Modify this query according to your database schema
                        for (Document document : collection.find(new Document("course", selectedCourse).append("date", selectedDate))) {
                            timetableEntries.add(document);                         
                            
                        }
                        
                        mongo.close();

                        // Iterate through the fetched timetable entries and display them
                        for (Document document : timetableEntries) {
                    %>
                    <tr>
                        <td><%= document.get("timeFrom")%> - <%= document.get("timeTo")%></td>
                        <td><%= document.get("selectedSubject1")%></td>
                        <td><%= document.get("faculty1")%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>

        <!-- Add your footer or any other content here -->
    </body>
</html>
