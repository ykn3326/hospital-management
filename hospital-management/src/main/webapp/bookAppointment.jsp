<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.hospital.model.Doctor" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Appointment</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="navbar">
        <span>Book Appointment</span>
        <div>
            <a href="patientDashboard">My Dashboard</a>
            <a href="logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <h2>Find a Doctor</h2>

        <form action="bookAppointment" method="get">
            <label>Filter by specialization (optional)</label>
            <input type="text" name="specialization" placeholder="e.g. Cardiology">
            <button type="submit">Search</button>
        </form>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>
        <% if (request.getAttribute("message") != null) { %>
            <div class="success"><%= request.getAttribute("message") %></div>
        <% } %>

        <h3>Available Doctors</h3>
        <%
            List<Doctor> doctors = (List<Doctor>) request.getAttribute("doctors");
        %>
        <% if (doctors == null || doctors.isEmpty()) { %>
            <p>No doctors found.</p>
        <% } else { %>
        <table>
            <tr><th>Name</th><th>Specialization</th><th>Fee</th><th>Book</th></tr>
            <% for (Doctor d : doctors) { %>
            <tr>
                <td><%= d.getName() %></td>
                <td><%= d.getSpecialization() %></td>
                <td>&#8377;<%= d.getConsultationFee() %></td>
                <td>
                    <form action="bookAppointment" method="post" style="margin:0;">
                        <input type="hidden" name="doctorId" value="<%= d.getDoctorId() %>">
                        <input type="date" name="visitDate" required style="width:130px;display:inline-block;">
                        <input type="time" name="visitTime" required style="width:110px;display:inline-block;">
                        <button type="submit" style="margin-top:0;">Book</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </table>
        <% } %>
    </div>
</body>
</html>
