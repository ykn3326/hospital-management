<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="navbar">
        <span>Digital Hospital and Patient Management System</span>
        <div><a href="index.jsp">Home</a></div>
    </div>

    <section class="hero-panel">
        <div class="hero-copy">
            <h1>Welcome back to your hospital dashboard</h1>
            <p>Manage appointments, view patient records, and access important hospital services in one secure place.</p>
            <div class="hero-stats">
                <div class="stat-card">
                    <div class="value">24/7</div>
                    <div>Care support</div>
                </div>
                <div class="stat-card">
                    <div class="value">+500</div>
                    <div>Successful visits</div>
                </div>
                <div class="stat-card">
                    <div class="value">3</div>
                    <div>Roles available</div>
                </div>
            </div>
        </div>
        <div class="hero-image">
            <img src="images/hospital-hero.svg" alt="Digital hospital illustration">
        </div>
    </section>

    <div class="container login-section">
        <div class="login-card">
            <h2>Login</h2>

            <% if (request.getAttribute("error") != null) { %>
                <div class="error"><%= request.getAttribute("error") %></div>
            <% } %>

            <form action="login" method="post">
                <label>Login as</label>
                <select name="role" required>
                    <option value="patient">Patient</option>
                    <option value="doctor">Doctor</option>
                    <option value="admin">Admin</option>
                </select>
                <div class="role-hint">Select your account type to continue.</div>

                <label>Email / Username</label>
                <input type="text" name="email" required>

                <label>Password</label>
                <div class="password-row">
                    <input type="password" name="password" required>
                    <button type="button" class="toggle-password">Show</button>
                </div>

                <button type="submit">Log In</button>
            </form>

            <p class="help-text">New patient? <a href="register">Register here</a>.</p>
        </div>

        <div class="promo-cards">
            <div class="promo-card">
                <img src="images/doctor-patient.svg" alt="Doctor and patient" />
                <h3>Fast appointment booking</h3>
                <p>Find doctors, schedule visits, and keep your care plan on track.</p>
            </div>
            <div class="promo-card">
                <img src="images/medical-chart.svg" alt="Medical chart" />
                <h3>Smart record access</h3>
                <p>Securely view medical histories, prescriptions, and lab results in one place.</p>
            </div>
        </div>
    </div>

    <script src="js/login.js"></script>
</body>
</html>
