<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.hospital.model.Appointment" %>
<!DOCTYPE html>
<html>
<head>
    <title>Doctor Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="navbar">
        <span>Doctor Dashboard</span>
        <div><a href="logout">Logout</a></div>
    </div>

    <div class="container">
        <h2>Welcome, <%= session.getAttribute("doctorName") %></h2>

        <% if (session.getAttribute("message") != null) { %>
            <div class="success"><%= session.getAttribute("message") %></div>
            <% session.removeAttribute("message"); %>
        <% } %>

        <h3>My Appointments</h3>
        <%
            List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
        %>
        <% if (appointments == null || appointments.isEmpty()) { %>
            <p>No appointments yet.</p>
        <% } else { %>
        <table>
            <tr><th>Patient</th><th>Date</th><th>Time</th><th>Status</th><th>Action</th></tr>
            <% for (Appointment a : appointments) { %>
            <tr>
                <td><%= a.getPatientName() %></td>
                <td><%= a.getVisitDate() %></td>
                <td><%= a.getVisitTime() %></td>
                <td><%= a.getStatus() %></td>
                <td>
                    <% if ("BOOKED".equals(a.getStatus())) { %>
                    <a href="#consult-<%= a.getAppointmentId() %>">Complete Consultation</a>
                    <% } else { %>
                    &mdash;
                    <% } %>
                </td>
            </tr>
            <% } %>
        </table>
        <% } %>

        <h3>Complete a Consultation</h3>
        <p style="color:#666;font-size:14px;">Enter the appointment ID from the table above, add a diagnosis and any
           prescribed medicines. Submitting this automatically marks the appointment complete and generates the bill.</p>

        <form action="completeConsultation" method="post" id="consult-form">
            <label>Appointment ID</label>
            <input type="number" name="appointmentId" required>

            <label>Diagnosis</label>
            <input type="text" name="diagnosis" required>

            <label>Notes</label>
            <textarea name="notes" rows="2"></textarea>

            <h4>Prescribed Medicines (leave blank rows unused)</h4>
            <% for (int i = 0; i < 3; i++) { %>
            <div style="display:flex; gap:8px; margin-top:8px;">
                <input type="text" name="medName" placeholder="Medicine name">
                <input type="text" name="medDosage" placeholder="Dosage (e.g. 1-0-1)">
                <input type="number" name="medDays" placeholder="Days" value="0">
                <input type="number" name="medCost" placeholder="Cost" value="0" step="0.01">
            </div>
            <% } %>

            <button type="submit">Complete Consultation & Generate Bill</button>
        </form>
    </div>
</body>
</html>
