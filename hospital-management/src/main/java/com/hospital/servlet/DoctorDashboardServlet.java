package com.hospital.servlet;

import com.hospital.dao.AppointmentDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/doctorDashboard")
public class DoctorDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Integer doctorId = (session != null) ? (Integer) session.getAttribute("doctorId") : null;

        if (doctorId == null) {
            resp.sendRedirect("login");
            return;
        }

        req.setAttribute("appointments", new AppointmentDAO().findByDoctor(doctorId));

        req.getRequestDispatcher("/doctorDashboard.jsp").forward(req, resp);
    }
}
