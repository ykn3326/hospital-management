<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.hospital.model.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Dashboard - Hospital Management System</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body class="page-enter">
    <nav class="navbar" id="navbar">
        <div class="brand">
            <div class="brand-icon">
                <i class="fas fa-user-injured"></i>
            </div>
            <span>Patient Dashboard</span>
        </div>
        <div class="nav-links">
            <a href="bookAppointment"><i class="fas fa-calendar-plus"></i> Book Appointment</a>
            <a href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </nav>

    <div class="container">

        <div class="dashboard-header">
            <div>
                <h2><i class="fas fa-heartbeat" style="color: var(--primary);"></i> My Health Overview</h2>
                <p class="dashboard-welcome">Welcome, <strong><%= session.getAttribute("patientName") %></strong></p>
            </div>
        </div>

        <% if (session.getAttribute("message") != null) { %>
            <div class="alert alert-success">
                <span class="alert-icon"><i class="fas fa-check-circle"></i></span>
                <span><%= session.getAttribute("message") %></span>
            </div>
            <% session.removeAttribute("message"); %>
        <% } %>

        <!-- Appointments Section -->
        <div class="section-card">
            <h3 class="section-title">
                <i class="fas fa-calendar-alt" style="color: var(--primary);"></i>
                My Appointments
            </h3>

            <%
                List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
            %>

            <% if (appointments == null || appointments.isEmpty()) { %>
                <div class="empty-state">
                    <div class="empty-icon"><i class="fas fa-calendar-plus"></i></div>
                    <p>No appointments yet. <a href="bookAppointment">Book one now</a>.</p>
                </div>
            <% } else { %>
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th><i class="fas fa-user-md"></i> Doctor</th>
                                <th><i class="fas fa-calendar"></i> Date</th>
                                <th><i class="fas fa-clock"></i> Time</th>
                                <th><i class="fas fa-info-circle"></i> Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Appointment a : appointments) { %>
                            <tr>
                                <td><strong>Dr. <%= a.getDoctorName() %></strong></td>
                                <td><%= a.getVisitDate() %></td>
                                <td><%= a.getVisitTime() %></td>
                                <td>
                                    <% if ("BOOKED".equals(a.getStatus())) { %>
                                        <span class="badge badge-booked"><i class="fas fa-hourglass-half"></i> Booked</span>
                                    <% } else if ("COMPLETED".equals(a.getStatus())) { %>
                                        <span class="badge badge-completed"><i class="fas fa-check"></i> Completed</span>
                                    <% } else { %>
                                        <span class="badge badge-cancelled"><i class="fas fa-times"></i> <%= a.getStatus() %></span>
                                    <% } %>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>
        </div>

        <!-- Medical History Section -->
        <div class="section-card">
            <h3 class="section-title">
                <i class="fas fa-notes-medical" style="color: var(--secondary);"></i>
                Medical History
            </h3>

            <%
                List<MedicalRecord> records = (List<MedicalRecord>) request.getAttribute("records");
            %>

            <% if (records == null || records.isEmpty()) { %>
                <div class="empty-state">
                    <div class="empty-icon"><i class="fas fa-file-medical"></i></div>
                    <p>No medical records yet.</p>
                </div>
            <% } else { %>
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th><i class="fas fa-stethoscope"></i> Diagnosis</th>
                                <th><i class="fas fa-edit"></i> Notes</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (MedicalRecord r : records) { %>
                            <tr>
                                <td><%= r.getDiagnosis() %></td>
                                <td><%= r.getNotes() != null ? r.getNotes() : "—" %></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>
        </div>

        <!-- Bills Section -->
        <div class="section-card">
            <h3 class="section-title">
                <i class="fas fa-file-invoice-dollar" style="color: var(--accent);"></i>
                My Bills
            </h3>

            <%
                List<Bill> bills = (List<Bill>) request.getAttribute("bills");
            %>

            <% if (bills == null || bills.isEmpty()) { %>
                <div class="empty-state">
                    <div class="empty-icon"><i class="fas fa-receipt"></i></div>
                    <p>No bills yet.</p>
                </div>
            <% } else { %>
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th><i class="fas fa-user-md"></i> Consultation Fee</th>
                                <th><i class="fas fa-pills"></i> Medicine Charges</th>
                                <th><i class="fas fa-calculator"></i> Total</th>
                                <th><i class="fas fa-credit-card"></i> Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Bill b : bills) { %>
                            <tr>
                                <td>&#8377;<%= b.getConsultationFee() %></td>
                                <td>&#8377;<%= b.getMedicineCharges() %></td>
                                <td><strong>&#8377;<%= b.getTotalAmount() %></strong></td>
                                <td>
                                    <% if ("PAID".equals(b.getPaymentStatus())) { %>
                                        <span class="badge badge-paid"><i class="fas fa-check-circle"></i> Paid</span>
                                    <% } else if ("PENDING".equals(b.getPaymentStatus())) { %>
                                        <span class="badge badge-pending"><i class="fas fa-clock"></i> Pending</span>
                                    <% } else { %>
                                        <span class="badge badge-unpaid"><i class="fas fa-exclamation-circle"></i> <%= b.getPaymentStatus() %></span>
                                    <% } %>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>
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

