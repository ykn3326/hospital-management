package com.hospital.servlet;

import com.hospital.dao.PatientDAO;
import com.hospital.model.Patient;
import com.hospital.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");
        String gender = req.getParameter("gender");
        String dobStr = req.getParameter("dob");
        String address = req.getParameter("address");

        // Basic input validation
        if (name == null || name.isBlank() || email == null || email.isBlank()
                || password == null || password.length() < 6 || phone == null || phone.isBlank()) {
            req.setAttribute("error", "Please fill all required fields. Password must be at least 6 characters.");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        PatientDAO dao = new PatientDAO();

        // Prevent duplicate registration with the same email
        if (dao.findByEmail(email) != null) {
            req.setAttribute("error", "An account with this email already exists.");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        Patient p = new Patient();
        p.setName(name);
        p.setEmail(email);
        p.setPasswordHash(PasswordUtil.hash(password));
        p.setPhone(phone);
        p.setGender(gender);
        try {
            p.setDob(dobStr != null && !dobStr.isBlank() ? LocalDate.parse(dobStr) : null);
        } catch (java.time.format.DateTimeParseException e) {
            req.setAttribute("error", "Please provide a valid date of birth.");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }
        p.setAddress(address);

        int newId = dao.registerPatient(p);

        if (newId != -1) {
            req.getSession().setAttribute("patientId", newId);
            req.getSession().setAttribute("patientName", name);
            resp.sendRedirect("patientDashboard");
        } else {
            req.setAttribute("error", "Registration failed. Please try again.");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        }
    }
}
