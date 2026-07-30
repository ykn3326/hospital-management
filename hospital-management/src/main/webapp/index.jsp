<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Digital Hospital & Patient Management System</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body class="page-enter">
    <nav class="navbar" id="navbar">
        <div class="brand">
            <div class="brand-icon">
                <i class="fas fa-heartbeat"></i>
            </div>
            <span>Hospital Management System</span>
        </div>
        <div class="nav-links">
            <a href="login">Login</a>
            <a href="register">Register</a>
        </div>
    </nav>

    <section class="hero-panel">
        <div class="hero-copy">
            <h1>Your Health,<br>Our Priority</h1>
            <p class="subtitle">One integrated platform for appointment booking, patient records, doctor workflows, and hospital operations — designed for modern healthcare.</p>
            <div class="hero-stats">
                <div class="stat-card">
                    <div class="stat-icon blue"><i class="fas fa-calendar-check"></i></div>
                    <div class="stat-value">Smart</div>
                    <div class="stat-label">Appointment Scheduling</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon green"><i class="fas fa-notes-medical"></i></div>
                    <div class="stat-value">Secure</div>
                    <div class="stat-label">Patient Records</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon amber"><i class="fas fa-file-invoice-dollar"></i></div>
                    <div class="stat-value">Fast</div>
                    <div class="stat-label">Billing & Payments</div>
                </div>
            </div>
            <div class="btn-group">
                <a class="btn btn-primary btn-lg" href="login">
                    <i class="fas fa-sign-in-alt"></i> Login
                </a>
                <a class="btn btn-secondary btn-lg" href="register">
                    <i class="fas fa-user-plus"></i> Register
                </a>
            </div>
        </div>
        <div class="hero-image">
            <img src="images/hospital-hero.svg" alt="Hospital illustration">
        </div>
    </section>

    <div class="container">
        <div class="promo-cards promo-cards-2">
            <div class="promo-card">
                <img src="images/doctor-patient.svg" alt="Doctor and patient illustration">
                <h3><i class="fas fa-user-md" style="color: var(--primary);"></i> Patient-Centric Workflows</h3>
                <p>Patients can easily book visits, view their medical history, and track billing — while doctors stay on top of consultations and prescriptions.</p>
            </div>
            <div class="promo-card">
                <img src="images/medical-chart.svg" alt="Medical chart illustration">
                <h3><i class="fas fa-chart-line" style="color: var(--secondary);"></i> Smart Analytics</h3>
                <p>Access treatment timelines, diagnoses, and billing insights at a glance. Make data-driven decisions for better patient outcomes.</p>
            </div>
        </div>
    </div>

    <script>
        // Navbar scroll effect
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

