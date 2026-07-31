package com.hospital.servlet;

import com.hospital.dao.AppointmentDAO;
import com.hospital.dao.DoctorDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;

@WebServlet("/bookAppointment")
public class AppointmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Integer patientId = (session != null) ? (Integer) session.getAttribute("patientId") : null;
        if (patientId == null) {
            resp.sendRedirect("login");
            return;
        }

        // Show doctor search results (optionally filtered by specialization)
        String specialization = req.getParameter("specialization");
        req.setAttribute("doctors", new DoctorDAO().search(specialization));
        req.getRequestDispatcher("/bookAppointment.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Integer patientId = (session != null) ? (Integer) session.getAttribute("patientId") : null;

        if (patientId == null) {
            resp.sendRedirect("login");
            return;
        }

        try {
            int doctorId = Integer.parseInt(req.getParameter("doctorId"));
            LocalDate visitDate = LocalDate.parse(req.getParameter("visitDate"));
            LocalTime visitTime = LocalTime.parse(req.getParameter("visitTime"));

            int appointmentId = new AppointmentDAO().bookAppointment(patientId, doctorId, visitDate, visitTime);

            if (appointmentId != -1) {
                req.setAttribute("message", "Appointment booked successfully!");
            } else {
                // Slot conflict — the database's UNIQUE KEY on (doctor_id, visit_date, visit_time) rejected it
                req.setAttribute("error", "That time slot is already booked for this doctor. Please choose another slot.");
            }
        } catch (Exception e) {
            req.setAttribute("error", "Invalid input. Please check the date/time and try again.");
        }

        req.setAttribute("doctors", new DoctorDAO().search(null));
        req.getRequestDispatcher("/bookAppointment.jsp").forward(req, resp);
    }
}
