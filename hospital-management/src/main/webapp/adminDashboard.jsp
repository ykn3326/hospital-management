<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="navbar">
        <span>Admin Dashboard</span>
        <div><a href="logout">Logout</a></div>
    </div>

    <div class="container">
        <h2>Welcome, <%= session.getAttribute("adminName") %></h2>

        <%
            Map<String, Object> summary = (Map<String, Object>) request.getAttribute("summary");
        %>
        <div class="card-row">
            <div class="stat-card">
                <div class="value"><%= summary.get("totalPatients") %></div>
                <div>Total Patients</div>
            </div>
            <div class="stat-card">
                <div class="value"><%= summary.get("totalDoctors") %></div>
                <div>Total Doctors</div>
            </div>
            <div class="stat-card">
                <div class="value"><%= summary.get("appointmentsToday") %></div>
                <div>Appointments Today</div>
            </div>
            <div class="stat-card">
                <div class="value">&#8377;<%= summary.get("totalRevenue") %></div>
                <div>Total Revenue Collected</div>
            </div>
        </div>
    </div>
</body>
</html>
