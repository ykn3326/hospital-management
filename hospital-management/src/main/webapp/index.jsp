<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Digital Hospital and Patient Management System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="navbar">
        <span>Digital Hospital and Patient Management System</span>
        <div>
            <a href="login">Login</a>
            <a href="register">Register</a>
        </div>
    </div>

    <section class="hero-panel">
        <div class="hero-copy">
            <h1>Welcome to the Hospital Management Portal</h1>
            <p>One platform for appointment booking, patient records, doctor workflows, and hospital operations.</p>
            <div class="hero-stats">
                <div class="stat-card">
                    <div class="value">Appointments</div>
                    <div>Easy scheduling for patients and doctors</div>
                </div>
                <div class="stat-card">
                    <div class="value">Records</div>
                    <div>Secure patient information in one place</div>
                </div>
                <div class="stat-card">
                    <div class="value">Billing</div>
                    <div>Track invoices and payments quickly</div>
                </div>
            </div>
            <div class="hero-buttons">
                <a class="btn" href="login">Login</a>
                <a class="btn btn-secondary" href="register">Register</a>
            </div>
        </div>
        <div class="hero-image">
            <img src="images/hospital-hero.svg" alt="Hospital illustration" />
        </div>
    </section>

    <div class="container">
        <div class="promo-cards">
            <div class="promo-card">
                <img src="images/doctor-patient.svg" alt="Doctor and patient illustration" />
                <h3>Patient-centric workflows</h3>
                <p>Patients can easily book visits while doctors stay on top of consultations.</p>
            </div>
            <div class="promo-card">
                <img src="images/medical-chart.svg" alt="Medical chart illustration" />
                <h3>Smart analytics</h3>
                <p>Access treatment timelines, diagnoses, and billing insights at a glance.</p>
            </div>
        </div>
    </div>
</body>
</html>
