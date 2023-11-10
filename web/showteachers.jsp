<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.mongodb.MongoClient, com.mongodb.client.MongoDatabase, com.mongodb.client.MongoCollection, org.bson.Document" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Show Faculty</title>
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

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            .table-container {
                margin: 40px 80px;
            }

            th, td {
                padding: 10px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #f2f2f2;
            }

            .modal {
                display: none;
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.4);
            }

            .modal-content {
                background-color: #fff;
                margin: 10% auto;
                padding: 20px;
                border-radius: 5px;
                width: 70%;
            }

            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <div class="navbar">
            <h1>Faculty Information</h1>
            <button class="back-button" onclick="window.location.href = 'index.html'">Back</button>
        </div>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Employee ID</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Gender</th>
                        <th>Age</th>
                        <th>Date of Birth</th>
                        <th>Address</th>
                        <th>Mobile</th>
                        <th>Email</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        MongoClient mongo = new MongoClient("localhost", 27017);
                        MongoDatabase database = mongo.getDatabase("timetable");
                        MongoCollection<Document> collection = database.getCollection("chart");
                        for (Document document : collection.find()) {
                    %>
                    <tr>
                        <td><%= document.get("Employee_ID")%></td>
                        <td><%= document.get("First_Name")%></td>
                        <td><%= document.get("Last_Name")%></td>
                        <td><%= document.get("Gender")%></td>
                        <td><%= document.get("Age")%></td>
                        <td><%= document.get("Date_of_Birth")%></td>
                        <td><%= document.get("Address")%></td>
                        <td><%= document.get("Mobile")%></td>
                        <td><%= document.get("Email")%></td>
                    </tr>
                    <%
                        }
                        mongo.close();
                    %>
                </tbody>
            </table>
        </div>
    </body>
</html>
