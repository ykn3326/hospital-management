<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.hospital.model.Doctor" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Appointment - Hospital Management System</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body class="page-enter">
    <nav class="navbar" id="navbar">
        <div class="brand">
            <div class="brand-icon">
                <i class="fas fa-heartbeat"></i>
            </div>
            <span>Book Appointment</span>
        </div>
        <div class="nav-links">
            <a href="patientDashboard"><i class="fas fa-columns"></i> My Dashboard</a>
            <a href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </nav>

    <div class="container">

        <div class="dashboard-header">
            <div>
                <h2><i class="fas fa-calendar-plus" style="color: var(--primary);"></i> Book an Appointment</h2>
            </div>
        </div>

        <!-- Search Section -->
        <div class="section-card">
            <h3 class="section-title">
                <i class="fas fa-search" style="color: var(--primary);"></i>
                Find a Doctor
            </h3>

            <form action="bookAppointment" method="get">
                <div class="form-row" style="align-items: end;">
                    <div class="form-group mb-0">
                        <label><i class="fas fa-stethoscope"></i> Filter by Specialization</label>
                        <input type="text" name="specialization" class="form-input" placeholder="e.g. Cardiology, Neurology, Pediatrics">
                    </div>
                    <div class="form-group mb-0">
                        <button type="submit" class="btn btn-primary" style="margin-top: 0;">
                            <i class="fas fa-search"></i> Search Doctors
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                <span class="alert-icon"><i class="fas fa-exclamation-circle"></i></span>
                <span><%= request.getAttribute("error") %></span>
            </div>
        <% } %>

        <% if (request.getAttribute("message") != null) { %>
            <div class="alert alert-success">
                <span class="alert-icon"><i class="fas fa-check-circle"></i></span>
                <span><%= request.getAttribute("message") %></span>
            </div>
        <% } %>

        <!-- Available Doctors -->
        <div class="section-card">
            <h3 class="section-title">
                <i class="fas fa-user-md" style="color: var(--success);"></i>
                Available Doctors
            </h3>

            <%
                List<Doctor> doctors = (List<Doctor>) request.getAttribute("doctors");
            %>

            <% if (doctors == null || doctors.isEmpty()) { %>
                <div class="empty-state">
                    <div class="empty-icon"><i class="fas fa-user-md-slash"></i></div>
                    <p>No doctors found. Try a different specialization or check back later.</p>
                </div>
            <% } else { %>
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th><i class="fas fa-user"></i> Name</th>
                                <th><i class="fas fa-stethoscope"></i> Specialization</th>
                                <th><i class="fas fa-rupee-sign"></i> Fee</th>
                                <th><i class="fas fa-calendar-check"></i> Book Appointment</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Doctor d : doctors) { %>
                            <tr>
                                <td><strong>Dr. <%= d.getName() %></strong></td>
                                <td><span class="badge badge-booked"><%= d.getSpecialization() %></span></td>
                                <td><strong>&#8377;<%= d.getConsultationFee() %></strong></td>
                                <td>
                                    <form action="bookAppointment" method="post" class="booking-inline">
                                        <input type="hidden" name="doctorId" value="<%= d.getDoctorId() %>">
                                        <input type="date" name="visitDate" required>
                                        <input type="time" name="visitTime" required>
                                        <button type="submit" class="btn btn-sm btn-primary" style="margin-top: 0;">
                                            <i class="fas fa-check"></i> Book
                                        </button>
                                    </form>
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

