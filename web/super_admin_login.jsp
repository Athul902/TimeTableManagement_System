<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.mongodb.MongoClient, com.mongodb.client.MongoDatabase, com.mongodb.client.MongoCollection, org.bson.Document" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    MongoClient mongo = new MongoClient("localhost", 27017);
    MongoDatabase database = mongo.getDatabase("timetable"); // Replace with your database name
    MongoCollection<Document> collection = database.getCollection("superadmins");

    Document admin = collection.find(new Document("username", username)).first();
    mongo.close();

    if (admin != null && admin.getString("password").equals(password)) {
        // Super admin login successful
        session.setAttribute("superAdmin", true); // Set a session variable
        response.sendRedirect("superAdmin.html"); // Redirect to dashboard
    } else {
        // Invalid login
        response.sendRedirect("super_admin_loginError.jsp?error=1"); // Redirect with error parameter
    }
%>
