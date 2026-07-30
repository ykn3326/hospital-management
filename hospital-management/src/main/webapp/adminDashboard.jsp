<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Hospital Management System</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body class="page-enter">
    <nav class="navbar" id="navbar">
        <div class="brand">
            <div class="brand-icon">
                <i class="fas fa-user-shield"></i>
            </div>
            <span>Admin Dashboard</span>
        </div>
        <div class="nav-links">
            <a href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </nav>

    <div class="container">
        <%
            Map<String, Object> summary = (Map<String, Object>) request.getAttribute("summary");
        %>

        <div class="dashboard-header">
            <div>
                <h2><i class="fas fa-tachometer-alt" style="color: var(--primary);"></i> Dashboard Overview</h2>
                <p class="dashboard-welcome">Welcome back, <strong><%= session.getAttribute("adminName") %></strong></p>
            </div>
        </div>

        <div class="stat-card-row">
            <div class="stat-card">
                <div class="stat-icon blue"><i class="fas fa-users"></i></div>
                <div class="stat-value"><%= summary.get("totalPatients") %></div>
                <div class="stat-label">Total Patients</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon green"><i class="fas fa-user-md"></i></div>
                <div class="stat-value"><%= summary.get("totalDoctors") %></div>
                <div class="stat-label">Total Doctors</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon amber"><i class="fas fa-calendar-day"></i></div>
                <div class="stat-value"><%= summary.get("appointmentsToday") %></div>
                <div class="stat-label">Appointments Today</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon purple"><i class="fas fa-coins"></i></div>
                <div class="stat-value">&#8377;<%= summary.get("totalRevenue") %></div>
                <div class="stat-label">Total Revenue Collected</div>
            </div>
        </div>

        <div class="section-card">
            <h3 class="section-title">
                <i class="fas fa-chart-bar" style="color: var(--primary);"></i>
                System Overview
            </h3>
            <p style="color: var(--text-secondary);">Monitor hospital operations, patient registrations, doctor availability, and revenue at a glance.</p>
        </div>
    </div>

    <script>
        window.addEventListener('scroll', function() {
            const navbar = document.getElementById('navbar');
            if (window.scrollY > 10) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });
    </script>
</body>
</html>

