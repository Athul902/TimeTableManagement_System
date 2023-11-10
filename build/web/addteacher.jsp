<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.MongoClient"%>
<%@page import="com.mongodb.client.MongoDatabase"%>
<%@page contentType="text/html" pageEncoding="UTF-8"
    import="com.mongodb.client.MongoCollection"
    import="com.mongodb.client.MongoDatabase"
    import="org.bson.Document"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Add Faculty</title>
    <meta http-equiv="refresh" content="3;url=showteachers.jsp"> <!-- Redirect after 3 seconds -->
</head>
<body>
    <%
        String empId = request.getParameter("empId");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String gender = request.getParameter("gender");
        String age = request.getParameter("age");
        String dob = request.getParameter("dob");
        String address = request.getParameter("address");
        String mobile = request.getParameter("mobile");
        String email = request.getParameter("email");

        MongoClient mongo = new MongoClient("localhost", 27017);
        MongoDatabase database = mongo.getDatabase("timetable");
        MongoCollection<Document> collection = database.getCollection("chart");
        Document document = new Document("Employee_ID", empId)
                .append("First_Name", firstName)
                .append("Last_Name", lastName)
                .append("Gender", gender)
                .append("Age", age)
                .append("Date_of_Birth", dob)
                .append("Address", address)
                .append("Mobile", mobile)
                .append("Email", email);
        collection.insertOne(document);
        mongo.close();
    %>
    <p>Data Saved Successfully.</p>
    <p>Redirecting please wait...</p>
</body>
</html>
