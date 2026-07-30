<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Hospital Management System</title>
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
            <a href="index.jsp"><i class="fas fa-home"></i> Home</a>
        </div>
    </nav>

    <section class="hero-panel" style="min-height: auto; margin-bottom: 0;">
        <div class="hero-copy">
            <h1>Welcome Back</h1>
            <p class="subtitle">Manage appointments, view patient records, and access important hospital services in one secure place.</p>
            <div class="hero-stats">
                <div class="stat-card">
                    <div class="stat-icon blue"><i class="fas fa-clock"></i></div>
                    <div class="stat-value">24/7</div>
                    <div class="stat-label">Care Support</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon green"><i class="fas fa-check-circle"></i></div>
                    <div class="stat-value">+500</div>
                    <div class="stat-label">Successful Visits</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon amber"><i class="fas fa-user-tag"></i></div>
                    <div class="stat-value">3</div>
                    <div class="stat-label">Roles Available</div>
                </div>
            </div>
        </div>
        <div class="hero-image">
            <img src="images/hospital-hero.svg" alt="Digital hospital illustration">
        </div>
    </section>

    <div class="login-section">
        <div class="login-card">
            <h2><i class="fas fa-lock" style="color: var(--primary);"></i> Login to Your Account</h2>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    <span class="alert-icon"><i class="fas fa-exclamation-circle"></i></span>
                    <span><%= request.getAttribute("error") %></span>
                </div>
            <% } %>

            <form action="login" method="post" id="loginForm">
                <div class="form-group">
                    <label><i class="fas fa-user-tag"></i> Login as</label>
                    <select name="role" class="form-select" required>
                        <option value="patient">Patient</option>
                        <option value="doctor">Doctor</option>
                        <option value="admin">Admin</option>
                    </select>
                    <div class="role-hint">
                        <i class="fas fa-info-circle"></i>
                        <span>Select your account type to continue.</span>
                    </div>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-envelope"></i> Email / Username</label>
                    <input type="text" name="email" class="form-input" placeholder="Enter your email address" required>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-key"></i> Password</label>
                    <div class="password-input-group">
                        <input type="password" name="password" class="form-input" placeholder="Enter your password" required>
                        <button type="button" class="toggle-password"><i class="fas fa-eye"></i></button>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary btn-lg w-full">
                    <i class="fas fa-sign-in-alt"></i> Log In
                </button>
            </form>

            <p class="help-text">
                New patient? <a href="register"><i class="fas fa-user-plus"></i> Register here</a>
            </p>
        </div>

        <div class="promo-cards">
            <div class="promo-card">
                <img src="images/doctor-patient.svg" alt="Doctor and patient">
                <h3><i class="fas fa-calendar-plus" style="color: var(--primary);"></i> Fast Appointment Booking</h3>
                <p>Find doctors, schedule visits, and keep your care plan on track with just a few clicks.</p>
            </div>
            <div class="promo-card">
                <img src="images/medical-chart.svg" alt="Medical chart">
                <h3><i class="fas fa-shield-alt" style="color: var(--secondary);"></i> Smart Record Access</h3>
                <p>Securely view medical histories, prescriptions, and lab results — all in one place.</p>
            </div>
        </div>
    </div>

    <script src="js/login.js"></script>
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

