package com.hospital.servlet;

import com.hospital.dao.DoctorDAO;
import com.hospital.dao.PatientDAO;
import com.hospital.model.Doctor;
import com.hospital.model.Patient;
import com.hospital.util.DBConnection;
import com.hospital.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String role = req.getParameter("role"); // "patient", "doctor", or "admin"

        if (email == null || password == null || role == null) {
            req.setAttribute("error", "All fields are required.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        HttpSession session = req.getSession();

        switch (role) {
            case "patient" -> {
                Patient p = new PatientDAO().findByEmail(email);
                if (p != null && PasswordUtil.verify(password, p.getPasswordHash())) {
                    session.setAttribute("patientId", p.getPatientId());
                    session.setAttribute("patientName", p.getName());
                    resp.sendRedirect("patientDashboard");
                    return;
                }
            }
            case "doctor" -> {
                Doctor d = new DoctorDAO().findByEmail(email);
                if (d != null && PasswordUtil.verify(password, d.getPasswordHash())) {
                    session.setAttribute("doctorId", d.getDoctorId());
                    session.setAttribute("doctorName", d.getName());
                    resp.sendRedirect("doctorDashboard");
                    return;
                }
            }
            case "admin" -> {
                // Admin table is small — a direct lookup here keeps things simple
                String sql = "SELECT * FROM admin WHERE username = ?";
                try (Connection con = DBConnection.getConnection();
                     PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setString(1, email); // username reused in the same field
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next() && PasswordUtil.verify(password, rs.getString("password_hash"))) {
                            session.setAttribute("adminId", rs.getInt("admin_id"));
                            session.setAttribute("adminName", rs.getString("full_name"));
                            resp.sendRedirect("adminDashboard");
                            return;
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        // If we reach here, login failed
        req.setAttribute("error", "Invalid email/username or password.");
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }
}
