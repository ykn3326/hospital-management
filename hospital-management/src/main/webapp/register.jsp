
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Hospital Management System</title>
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

    <div class="login-section" style="max-width: 900px; margin-top: 24px;">
        <div class="login-card">
            <h2><i class="fas fa-user-plus" style="color: var(--primary);"></i> Create Your Patient Profile</h2>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    <span class="alert-icon"><i class="fas fa-exclamation-circle"></i></span>
                    <span><%= request.getAttribute("error") %></span>
                </div>
            <% } %>

            <form action="register" method="post" id="registerForm">
                <div class="form-group">
                    <label><i class="fas fa-user"></i> Full Name</label>
                    <input type="text" name="name" class="form-input" placeholder="Enter your full name" required>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-envelope"></i> Email</label>
                    <input type="email" name="email" class="form-input" placeholder="Enter your email address" required>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-key"></i> Password <span class="hint">(min. 6 characters)</span></label>
                    <div class="password-input-group">
                        <input type="password" name="password" class="form-input" minlength="6" placeholder="Create a strong password" required>
                        <button type="button" class="toggle-password"><i class="fas fa-eye"></i></button>
                    </div>
                    <div class="hint">Your password should be at least 6 characters long.</div>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-phone"></i> Phone</label>
                    <input type="text" name="phone" class="form-input" placeholder="Enter your phone number" required>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label><i class="fas fa-venus-mars"></i> Gender</label>
                        <select name="gender" class="form-select">
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-calendar"></i> Date of Birth</label>
                        <input type="date" name="dob" class="form-input">
                    </div>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-map-marker-alt"></i> Address</label>
                    <textarea name="address" class="form-textarea" rows="2" placeholder="Enter your address"></textarea>
                </div>

                <button type="submit" class="btn btn-primary btn-lg w-full">
                    <i class="fas fa-user-check"></i> Create Account
                </button>
            </form>

            <p class="help-text">
                Already have an account? <a href="login"><i class="fas fa-sign-in-alt"></i> Log in</a>
            </p>
        </div>

        <div class="promo-card" style="align-self: start;">
            <img src="images/doctor-patient.svg" alt="Doctor and patient illustration">
            <h3><i class="fas fa-rocket" style="color: var(--primary);"></i> Register in Seconds</h3>
            <p>Sign up now to access seamless booking, medical records, and treatment tracking — all in one place.</p>
            <div style="margin-top: 16px; display: flex; flex-direction: column; gap: 10px;">
                <div style="display: flex; align-items: center; gap: 10px; font-size: 0.9rem; color: var(--text-secondary);">
                    <i class="fas fa-check-circle" style="color: var(--success);"></i>
                    <span>Quick appointment booking</span>
                </div>
                <div style="display: flex; align-items: center; gap: 10px; font-size: 0.9rem; color: var(--text-secondary);">
                    <i class="fas fa-check-circle" style="color: var(--success);"></i>
                    <span>Access medical records</span>
                </div>
                <div style="display: flex; align-items: center; gap: 10px; font-size: 0.9rem; color: var(--text-secondary);">
                    <i class="fas fa-check-circle" style="color: var(--success);"></i>
                    <span>Track billing & payments</span>
                </div>
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

