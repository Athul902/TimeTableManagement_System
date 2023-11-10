<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@ page import="com.mongodb.MongoClient, com.mongodb.client.MongoDatabase, com.mongodb.client.MongoCollection, org.bson.Document, java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Set Timetable</title>
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

            .header{
                text-align: center;
                margin: 30px;
                font-size: 28px;
            }
            .form-row {
                display: inline-block; /* Display form rows inline */
                margin-right: 20px; /* Add some spacing between form rows */
                vertical-align: top; /* Align form rows vertically at the top */
            }

            .form-row label {
                font-weight: bold; /* Make the text bold */
                display: inline-block; /* Display the label inline with the input/select */
                margin-right: 0; /* Add some spacing between the label and input/select */
                width: auto; /* Allow the label width to adjust based on content */
            }

            input[type=text] {
                padding: 10px;
                font-size: 17px;
                text-align: center;
            }

            input[type=date] {
                padding: 10px;
                font-size: 17px;
                text-align: center;
            }

            .save{
                padding: 13px 46px;
                font-size: 17px;
                text-align: center;
                margin: 1% 2% 2% 47%;
            }


            .hs {
                width: 32%;
                padding:10px;
                font-size: 17px;
                border-radius:10px;
            }

            /* Style the form container */
            .container {
                width: 65%; /* Set the desired width for your form container */
                margin: 0 auto; /* Center the form container horizontally */
                padding: 20px; /* Add some padding for spacing */
                text-align: center;
                border: 1px solid #ccc; /* Add a border for visual separation */
                background-color: #f7f7f7; /* Set a background color if needed */
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); /* Add a subtle shadow */
            }

            /* Align the H1 tag to the left */
            .container h2 {
                text-align: left;
                margin-left: 15%;
            }

            .form-row1 {
                display: inline-block; /* Display form rows inline */
                vertical-align: top; /* Align form rows vertically at the top */
            }

            .form-row label1 {
                font-weight: bold; /* Make the text bold */
                display: inline-block; /* Display the label inline with the input/select */
                margin-right: 0; /* Add some spacing between the label and input/select */
                width: auto; /* Allow the label width to adjust based on content */
            }

            .form-row2 {
                display: inline-block; /* Display form rows inline */
                vertical-align: top; /* Align form rows vertically at the top */
            }

            .form-row label2 {
                font-weight: bold; /* Make the text bold */
                display: inline-block; /* Display the label inline with the input/select */
                margin-right: 0; /* Add some spacing between the label and input/select */
                width: auto; /* Allow the label width to adjust based on content */
            }

            .form-row3 {
                display: inline-block; /* Display form rows inline */
                vertical-align: top; /* Align form rows vertically at the top */
            }

            .form-row label3 {
                font-weight: bold; /* Make the text bold */
                display: inline-block; /* Display the label inline with the input/select */
                margin-right: 0; /* Add some spacing between the label and input/select */
                width: auto; /* Allow the label width to adjust based on content */
            }

            .form-row4 {
                display: inline-block; /* Display form rows inline */
                vertical-align: top; /* Align form rows vertically at the top */
            }

            .form-row label4 {
                font-weight: bold; /* Make the text bold */
                display: inline-block; /* Display the label inline with the input/select */
                margin-right: 0; /* Add some spacing between the label and input/select */
                width: auto; /* Allow the label width to adjust based on content */
            }

            .form-row5 {
                display: inline-block; /* Display form rows inline */
                vertical-align: top; /* Align form rows vertically at the top */
            }

            .form-row label5 {
                font-weight: bold; /* Make the text bold */
                display: inline-block; /* Display the label inline with the input/select */
                margin-right: 0; /* Add some spacing between the label and input/select */
                width: auto; /* Allow the label width to adjust based on content */
            }

            .form-row6 {
                display: inline-block; /* Display form rows inline */
                vertical-align: top; /* Align form rows vertically at the top */
            }

            .form-row label6 {
                font-weight: bold; /* Make the text bold */
                display: inline-block; /* Display the label inline with the input/select */
                margin-right: 0; /* Add some spacing between the label and input/select */
                width: auto; /* Allow the label width to adjust based on content */
            }

        </style>
    </head>
    <body>
        <div class="navbar">
            <h1>Set Timetable</h1>
            <button class="back-button" onclick="window.location.href = 'index1.jsp'">Back</button>
        </div>
        <div class="form-container">
            <form action="save_tt.jsp" method="post">
                <%
                    // Retrieve form data
                    String selectedCourse = request.getParameter("selectedCourse");
                    // ... other form data

                    // Connect to MongoDB
                    MongoClient mongoClientD = new MongoClient("localhost", 27017);
                    MongoDatabase databaseD = mongoClientD.getDatabase("timetable");
                    MongoCollection<Document> collectionD = databaseD.getCollection("timetable_entries");

                    // Delete existing entries for the selected course
                    Document deleteFilterD = new Document("selectedCourse", selectedCourse);
                    collectionD.deleteMany(deleteFilterD);
                    %>
                <div class="header">
                    <div class="form-row">
                        <label for="selectedCourse">Selected Course:</label>
                        <input type="text" id="selectedCourse" name="selectedCourse" value="<%= request.getParameter("course")%>" readonly>
                    </div>
                    <div class="form-row">
                        <label for="date">Date:</label>
                        <input type="date" id="date" name="date" required>
                    </div>
                    <div class="form-row">
                        <label for="lectureMode">Lecture Mode:</label>
                        <select id="lectureMode" name="lectureMode" class="hs">
                            <option value="online">Offline</option>
                            <option value="offline">Online</option>
                        </select>
                    </div>
                </div>
                <div class="container">
                    <h2>Lecture 1:</h2>
                    <div class="form-row1">
                        <label for="faculty">Select Faculty:</label>
                        <select id="faculty" name="faculty" >
                            <!-- Add a default option -->
                            <option value="">Select a Faculty</option>
                            <!-- Populate faculty options from the database -->
                            <%
                                MongoClient mongo1 = new MongoClient("localhost", 27017);
                                MongoDatabase database1 = mongo1.getDatabase("timetable");
                                MongoCollection<Document> collection1 = database1.getCollection("chart");
                                ArrayList<String> facultyNames1 = new ArrayList<>();
                                for (Document document : collection1.find()) {
                                    String fullName = document.getString("First_Name") + " " + document.getString("Last_Name");
                                    facultyNames1.add(fullName);
                                }
                                mongo1.close();
                                for (String faculty : facultyNames1) {
                            %>                           
                            <option value="<%= faculty%>"><%= faculty%></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="form-row1">
                        <label for="selectedSubject">Select Subject:</label>
                        <select id="selectedSubject" name="selectedSubject">
                            <!-- Add a default option -->
                            <option value="">Select a Subject</option>

                            <!-- Populate subjects based on the selected course -->
                            <%
                                String selectedCourse01 = request.getParameter("course");
                                MongoClient mongo01 = new MongoClient("localhost", 27017);
                                MongoDatabase database01 = mongo01.getDatabase("timetable");
                                MongoCollection<Document> collection01 = database01.getCollection("subjects");
                                ArrayList<String> subjectNames01 = new ArrayList<>();
                                for (Document document : collection01.find()) {
                                    String courseName = document.getString("courseName");
                                    if (courseName.equals(selectedCourse01)) {
                                        subjectNames01.add(document.getString("subjectFullName"));
                                    }
                                }
                                mongo01.close();
                                for (String subject : subjectNames01) {
                            %>                            
                            <option value="<%= subject%>"><%= subject%></option>
                            <% }%>
                        </select>
                    </div>

                    <div class="form-row1">
                        <label for="timeFrom">Time From:</label>
                        <input type="time" id="timeFrom" name="timeFrom">
                    </div>
                    <div class="form-row1">
                        <label for="timeTo">Time To:</label>
                        <input type="time" id="timeTo" name="timeTo">
                    </div>
                    <h2>Lecture 2:</h2>
                    <div class="form-row2">
                        <label for="faculty">Select Faculty:</label>
                        <select id="faculty" name="faculty">
                            <!-- Add a default option -->
                            <option value="">Select a Faculty</option>
                            <!-- Populate faculty options from the database -->
                            <%
                                MongoClient mongo2 = new MongoClient("localhost", 27017);
                                MongoDatabase database2 = mongo2.getDatabase("timetable");
                                MongoCollection<Document> collection2 = database2.getCollection("chart");
                                ArrayList<String> facultyName2 = new ArrayList<>();
                                for (Document document : collection2.find()) {
                                    String fullName = document.getString("First_Name") + " " + document.getString("Last_Name");
                                    facultyName2.add(fullName);
                                }
                                mongo2.close();
                                for (String faculty : facultyName2) {
                            %>
                            <option value="<%= faculty%>"><%= faculty%></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="form-row2">
                        <label for="selectedSubject">Select Subject:</label>
                        <select id="selectedSubject" name="selectedSubject">
                            <!-- Add a default option -->
                            <option value="">Select a Subject</option>
                            <!-- Populate subjects based on the selected course -->
                            <%
                                String selectedCourse02 = request.getParameter("course");
                                MongoClient mongo02 = new MongoClient("localhost", 27017);
                                MongoDatabase database02 = mongo02.getDatabase("timetable");
                                MongoCollection<Document> collection02 = database02.getCollection("subjects");
                                ArrayList<String> subjectNames02 = new ArrayList<>();
                                for (Document document : collection02.find()) {
                                    String courseName = document.getString("courseName");
                                    if (courseName.equals(selectedCourse02)) {
                                        subjectNames02.add(document.getString("subjectFullName"));
                                    }
                                }
                                mongo02.close();
                                for (String subject : subjectNames02) {
                            %>
                            <option value="<%= subject%>"><%= subject%></option>
                            <% }%>
                        </select>
                    </div>
                    <div class="form-row2">
                        <label for="timeFrom">Time From:</label>
                        <input type="time" id="timeFrom" name="timeFrom">
                    </div>
                    <div class="form-row2">
                        <label for="timeTo">Time To:</label>
                        <input type="time" id="timeTo" name="timeTo">
                    </div>
                    <h2>Lecture 3:</h2>
                    <div class="form-row3">
                        <label for="faculty">Select Faculty:</label>
                        <select id="faculty" name="faculty">
                            <!-- Add a default option -->
                            <option value="">Select a Faculty</option>
                            <!-- Populate faculty options from the database -->
                            <%
                                MongoClient mongo3 = new MongoClient("localhost", 27017);
                                MongoDatabase database3 = mongo3.getDatabase("timetable");
                                MongoCollection<Document> collection3 = database3.getCollection("chart");
                                ArrayList<String> facultyNames3 = new ArrayList<>();
                                for (Document document : collection3.find()) {
                                    String fullName = document.getString("First_Name") + " " + document.getString("Last_Name");
                                    facultyNames3.add(fullName);
                                }
                                mongo3.close();
                                for (String faculty : facultyNames3) {
                            %>
                            <option value="<%= faculty%>"><%= faculty%></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="form-row3">
                        <label for="selectedSubject">Select Subject:</label>
                        <select id="selectedSubject" name="selectedSubject">
                            <!-- Add a default option -->
                            <option value="">Select a Subject</option>
                            <!-- Populate subjects based on the selected course -->
                            <%
                                String selectedCourse03 = request.getParameter("course");
                                MongoClient mongo03 = new MongoClient("localhost", 27017);
                                MongoDatabase database03 = mongo03.getDatabase("timetable");
                                MongoCollection<Document> collection03 = database03.getCollection("subjects");
                                ArrayList<String> subjectNames03 = new ArrayList<>();
                                for (Document document : collection03.find()) {
                                    String courseName = document.getString("courseName");
                                    if (courseName.equals(selectedCourse03)) {
                                        subjectNames03.add(document.getString("subjectFullName"));
                                    }
                                }
                                mongo03.close();
                                for (String subject : subjectNames03) {
                            %>
                            <option value="<%= subject%>"><%= subject%></option>
                            <% }%>
                        </select>
                    </div>
                    <div class="form-row3">
                        <label for="timeFrom">Time From:</label>
                        <input type="time" id="timeFrom" name="timeFrom">
                    </div>
                    <div class="form-row3">
                        <label for="timeTo">Time To:</label>
                        <input type="time" id="timeTo" name="timeTo">
                    </div>
                    <h2>Lecture 4:</h2>
                    <div class="form-row4">
                        <label for="faculty">Select Faculty:</label>
                        <select id="faculty" name="faculty">
                            <!-- Add a default option -->
                            <option value="">Select a Faculty</option>
                            <!-- Populate faculty options from the database -->
                            <%
                                MongoClient mongo4 = new MongoClient("localhost", 27017);
                                MongoDatabase database4 = mongo4.getDatabase("timetable");
                                MongoCollection<Document> collection4 = database4.getCollection("chart");
                                ArrayList<String> facultyNames4 = new ArrayList<>();
                                for (Document document : collection4.find()) {
                                    String fullName = document.getString("First_Name") + " " + document.getString("Last_Name");
                                    facultyNames4.add(fullName);
                                }
                                mongo4.close();
                                for (String faculty : facultyNames4) {
                            %>
                            <option value="<%= faculty%>"><%= faculty%></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="form-row4">
                        <label for="selectedSubject">Select Subject:</label>
                        <select id="selectedSubject" name="selectedSubject">
                            <!-- Add a default option -->
                            <option value="">Select a Subject</option>
                            <!-- Populate subjects based on the selected course -->
                            <%
                                String selectedCourse04 = request.getParameter("course");
                                MongoClient mongo04 = new MongoClient("localhost", 27017);
                                MongoDatabase database04 = mongo04.getDatabase("timetable");
                                MongoCollection<Document> collection04 = database04.getCollection("subjects");
                                ArrayList<String> subjectNames04 = new ArrayList<>();
                                for (Document document : collection04.find()) {
                                    String courseName = document.getString("courseName");
                                    if (courseName.equals(selectedCourse04)) {
                                        subjectNames04.add(document.getString("subjectFullName"));
                                    }
                                }
                                mongo04.close();
                                for (String subject : subjectNames04) {
                            %>
                            <option value="<%= subject%>"><%= subject%></option>
                            <% }%>
                        </select>
                    </div>
                    <div class="form-row4">
                        <label for="timeFrom">Time From:</label>
                        <input type="time" id="timeFrom" name="timeFrom">
                    </div>
                    <div class="form-row4">
                        <label for="timeTo">Time To:</label>
                        <input type="time" id="timeTo" name="timeTo">
                    </div>
                    <h2>Lecture 5:</h2>
                    <div class="form-row5">
                        <label for="faculty">Select Faculty:</label>
                        <select id="faculty" name="faculty">
                            <!-- Add a default option -->
                            <option value="">Select a Faculty</option>
                            <!-- Populate faculty options from the database -->
                            <%
                                MongoClient mongo5 = new MongoClient("localhost", 27017);
                                MongoDatabase database5 = mongo5.getDatabase("timetable");
                                MongoCollection<Document> collection5 = database5.getCollection("chart");
                                ArrayList<String> facultyNames5 = new ArrayList<>();
                                for (Document document : collection5.find()) {
                                    String fullName = document.getString("First_Name") + " " + document.getString("Last_Name");
                                    facultyNames5.add(fullName);
                                }
                                mongo5.close();
                                for (String faculty : facultyNames5) {
                            %>
                            <option value="<%= faculty%>"><%= faculty%></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="form-row5">
                        <label for="selectedSubject">Select Subject:</label>
                        <select id="selectedSubject" name="selectedSubject">
                            <!-- Add a default option -->
                            <option value="">Select a Subject</option>
                            <!-- Populate subjects based on the selected course -->
                            <%
                                String selectedCourse05 = request.getParameter("course");
                                MongoClient mongo05 = new MongoClient("localhost", 27017);
                                MongoDatabase database05 = mongo05.getDatabase("timetable");
                                MongoCollection<Document> collection = database05.getCollection("subjects");
                                ArrayList<String> subjectNames05 = new ArrayList<>();
                                for (Document document : collection.find()) {
                                    String courseName = document.getString("courseName");
                                    if (courseName.equals(selectedCourse05)) {
                                        subjectNames05.add(document.getString("subjectFullName"));
                                    }
                                }
                                mongo05.close();
                                for (String subject : subjectNames05) {
                            %>
                            <option value="<%= subject%>"><%= subject%></option>
                            <% }%>
                        </select>
                    </div>
                    <div class="form-row5">
                        <label for="timeFrom">Time From:</label>
                        <input type="time" id="timeFrom" name="timeFrom">
                    </div>
                    <div class="form-row5">
                        <label for="timeTo">Time To:</label>
                        <input type="time" id="timeTo" name="timeTo">
                    </div>
                    <h2>Lecture 6:</h2>
                    <div class="form-row6">
                        <label for="faculty">Select Faculty:</label>
                        <select id="faculty" name="faculty">
                            <!-- Add a default option -->
                            <option value="">Select a Faculty</option>
                            <!-- Populate faculty options from the database -->
                            <%
                                MongoClient mongo6 = new MongoClient("localhost", 27017);
                                MongoDatabase database6 = mongo6.getDatabase("timetable");
                                MongoCollection<Document> collection6 = database6.getCollection("chart");
                                ArrayList<String> facultyNames6 = new ArrayList<>();
                                for (Document document : collection6.find()) {
                                    String fullName = document.getString("First_Name") + " " + document.getString("Last_Name");
                                    facultyNames6.add(fullName);
                                }
                                mongo6.close();
                                for (String faculty : facultyNames6) {
                            %>
                            <option value="<%= faculty%>"><%= faculty%></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="form-row6">
                        <label for="selectedSubject">Select Subject:</label>
                        <select id="selectedSubject" name="selectedSubject">
                            <!-- Add a default option -->
                            <option value="">Select a Subject</option>
                            <!-- Populate subjects based on the selected course -->
                            <%
                                String selectedCourse06 = request.getParameter("course");
                                MongoClient mongo06 = new MongoClient("localhost", 27017);
                                MongoDatabase database = mongo06.getDatabase("timetable");
                                MongoCollection<Document> collection06 = database.getCollection("subjects");
                                ArrayList<String> subjectNames06 = new ArrayList<>();
                                for (Document document : collection06.find()) {
                                    String courseName = document.getString("courseName");
                                    if (courseName.equals(selectedCourse06)) {
                                        subjectNames06.add(document.getString("subjectFullName"));
                                    }
                                }
                                mongo06.close();
                                for (String subject : subjectNames06) {
                            %>
                            <option value="<%= subject%>"><%= subject%></option>
                            <% }%>
                        </select>
                    </div>
                    <div class="form-row6">
                        <label for="timeFrom">Time From:</label>
                        <input type="time" id="timeFrom" name="timeFrom">
                    </div>
                    <div class="form-row6">
                        <label for="timeTo">Time To:</label>
                        <input type="time" id="timeTo" name="timeTo">
                    </div>
                </div>

                <input class="save" type="submit" value="Save">
            </form>
            <script>
                // ... (your script for superAdminLogin)
            </script>
        </div>
    </body>
</html>
