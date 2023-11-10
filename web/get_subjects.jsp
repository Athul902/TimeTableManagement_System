<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.mongodb.MongoClient, com.mongodb.client.MongoDatabase, com.mongodb.client.MongoCollection, org.bson.Document" %>
<%
    String courseName = request.getParameter("courseName");

    // Connect to the MongoDB and fetch subjects based on the course name
    MongoClient mongo = new MongoClient("localhost", 27017);
    MongoDatabase database = mongo.getDatabase("timetable");
    MongoCollection<Document> collection = database.getCollection("subjects");

    ArrayList<String> subjects = new ArrayList<>();
    for (Document document : collection.find(new Document("courseName", courseName))) {
        subjects.add(document.getString("subjectName"));
    }

    mongo.close();

    // Return the subjects as a JSON array
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    out.print(subjects);
%>
