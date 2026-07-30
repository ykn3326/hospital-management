<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.hospital.model.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Patient Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="navbar">
        <span>Patient Dashboard</span>
        <div>
            <a href="bookAppointment">Book Appointment</a>
            <a href="logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <h2>Welcome, <%= session.getAttribute("patientName") %></h2>

        <% if (session.getAttribute("message") != null) { %>
            <div class="success"><%= session.getAttribute("message") %></div>
            <% session.removeAttribute("message"); %>
        <% } %>

        <h3>My Appointments</h3>
        <%
            List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
        %>
        <% if (appointments == null || appointments.isEmpty()) { %>
            <p>No appointments yet. <a href="bookAppointment">Book one now</a>.</p>
        <% } else { %>
        <table>
            <tr><th>Doctor</th><th>Date</th><th>Time</th><th>Status</th></tr>
            <% for (Appointment a : appointments) { %>
            <tr>
                <td><%= a.getDoctorName() %></td>
                <td><%= a.getVisitDate() %></td>
                <td><%= a.getVisitTime() %></td>
                <td><%= a.getStatus() %></td>
            </tr>
            <% } %>
        </table>
        <% } %>

        <h3>Medical History</h3>
        <%
            List<MedicalRecord> records = (List<MedicalRecord>) request.getAttribute("records");
        %>
        <% if (records == null || records.isEmpty()) { %>
            <p>No medical records yet.</p>
        <% } else { %>
        <table>
            <tr><th>Diagnosis</th><th>Notes</th></tr>
            <% for (MedicalRecord r : records) { %>
            <tr>
                <td><%= r.getDiagnosis() %></td>
                <td><%= r.getNotes() %></td>
            </tr>
            <% } %>
        </table>
        <% } %>

        <h3>My Bills</h3>
        <%
            List<Bill> bills = (List<Bill>) request.getAttribute("bills");
        %>
        <% if (bills == null || bills.isEmpty()) { %>
            <p>No bills yet.</p>
        <% } else { %>
        <table>
            <tr><th>Consultation Fee</th><th>Medicine Charges</th><th>Total</th><th>Status</th></tr>
            <% for (Bill b : bills) { %>
            <tr>
                <td>&#8377;<%= b.getConsultationFee() %></td>
                <td>&#8377;<%= b.getMedicineCharges() %></td>
                <td>&#8377;<%= b.getTotalAmount() %></td>
                <td><%= b.getPaymentStatus() %></td>
            </tr>
            <% } %>
        </table>
        <% } %>
    </div>
</body>
</html>
