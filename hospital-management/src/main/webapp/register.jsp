<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="navbar">
        <span>Digital Hospital and Patient Management System</span>
        <div><a href="index.jsp">Home</a></div>
    </div>

    <div class="container login-section" style="grid-template-columns: 1.1fr 0.9fr;">
        <div class="login-card">
            <h2>Create your patient profile</h2>

            <% if (request.getAttribute("error") != null) { %>
                <div class="error"><%= request.getAttribute("error") %></div>
            <% } %>

            <form action="register" method="post">
                <label>Full Name</label>
                <input type="text" name="name" required>

                <label>Email</label>
                <input type="email" name="email" required>

                <label>Password (min. 6 characters)</label>
                <div class="password-row">
                    <input type="password" name="password" minlength="6" required>
                    <button type="button" class="toggle-password">Show</button>
                </div>
                <div class="role-hint">Your password should be at least 6 characters long.</div>

                <label>Phone</label>
                <input type="text" name="phone" required>

                <label>Gender</label>
                <select name="gender">
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Other">Other</option>
                </select>

                <label>Date of Birth</label>
                <input type="date" name="dob">

                <label>Address</label>
                <textarea name="address" rows="2"></textarea>

                <button type="submit">Register</button>
            </form>

            <p class="help-text">Already have an account? <a href="login">Log in</a>.</p>
        </div>

        <div class="promo-card" style="align-self:start;">
            <img src="images/doctor-patient.svg" alt="Doctor and patient illustration" />
            <h3>Register in seconds</h3>
            <p>Sign up now to access seamless booking, medical records, and treatment tracking.</p>
        </div>
    </div>

    <script src="js/login.js"></script>
</body>
</html>
