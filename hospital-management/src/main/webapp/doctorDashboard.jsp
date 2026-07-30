<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.hospital.model.Appointment" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Dashboard - Hospital Management System</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body class="page-enter">
    <nav class="navbar" id="navbar">
        <div class="brand">
            <div class="brand-icon">
                <i class="fas fa-user-md"></i>
            </div>
            <span>Doctor Dashboard</span>
        </div>
        <div class="nav-links">
            <a href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </nav>

    <div class="container">

        <div class="dashboard-header">
            <div>
                <h2><i class="fas fa-stethoscope" style="color: var(--primary);"></i> My Practice</h2>
                <p class="dashboard-welcome">Welcome, Dr. <strong><%= session.getAttribute("doctorName") %></strong></p>
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
                <i class="fas fa-calendar-check" style="color: var(--primary);"></i>
                My Appointments
            </h3>

            <%
                List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
            %>

            <% if (appointments == null || appointments.isEmpty()) { %>
                <div class="empty-state">
                    <div class="empty-icon"><i class="fas fa-calendar-times"></i></div>
                    <p>No appointments scheduled yet. Check back later.</p>
                </div>
            <% } else { %>
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th><i class="fas fa-user"></i> Patient</th>
                                <th><i class="fas fa-calendar"></i> Date</th>
                                <th><i class="fas fa-clock"></i> Time</th>
                                <th><i class="fas fa-info-circle"></i> Status</th>
                                <th><i class="fas fa-actions"></i> Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Appointment a : appointments) { %>
                            <tr>
                                <td><strong><%= a.getPatientName() %></strong></td>
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
                                <td>
                                    <% if ("BOOKED".equals(a.getStatus())) { %>
                                        <a href="#consult-form" class="btn btn-sm btn-primary" onclick="document.getElementById('appointmentId').value='<%= a.getAppointmentId() %>'; document.getElementById('consult-form').scrollIntoView({behavior:'smooth'});">
                                            <i class="fas fa-notes-medical"></i> Consult
                                        </a>
                                    <% } else { %>
                                        <span style="color: var(--text-muted);">&mdash;</span>
                                    <% } %>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>
        </div>

        <!-- Consultation Form -->
        <div class="section-card" id="consult-form">
            <h3 class="section-title">
                <i class="fas fa-prescription" style="color: var(--success);"></i>
                Complete a Consultation
            </h3>

            <div class="consult-info">
                <i class="fas fa-info-circle"></i>
                Enter the appointment ID from the table above, add a diagnosis and prescribed medicines.
                Submitting this automatically marks the appointment complete and generates the bill.
            </div>

            <form action="completeConsultation" method="post" id="consultForm">
                <div class="form-group">
                    <label><i class="fas fa-hashtag"></i> Appointment ID</label>
                    <input type="number" name="appointmentId" id="appointmentId" class="form-input" placeholder="Enter appointment ID" required>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-stethoscope"></i> Diagnosis</label>
                    <input type="text" name="diagnosis" class="form-input" placeholder="e.g. Acute bronchitis" required>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-edit"></i> Notes</label>
                    <textarea name="notes" class="form-textarea" rows="2" placeholder="Additional notes (optional)"></textarea>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-pills"></i> Prescribed Medicines</label>
                    <div class="hint" style="margin-bottom: 10px;">Leave blank rows unused</div>

                    <% for (int i = 0; i < 3; i++) { %>
                    <div class="med-row">
                        <input type="text" name="medName" class="form-input" placeholder="Medicine name">
                        <input type="text" name="medDosage" class="form-input" placeholder="Dosage (e.g. 1-0-1)">
                        <input type="number" name="medDays" class="form-input" placeholder="Days" value="0">
                        <input type="number" name="medCost" class="form-input" placeholder="Cost (&#8377;)" value="0" step="0.01">
                    </div>
                    <% } %>
                </div>

                <button type="submit" class="btn btn-success btn-lg">
                    <i class="fas fa-file-invoice"></i> Complete Consultation & Generate Bill
                </button>
            </form>
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

