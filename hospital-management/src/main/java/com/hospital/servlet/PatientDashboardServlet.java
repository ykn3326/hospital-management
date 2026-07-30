package com.hospital.servlet;

import com.hospital.dao.AppointmentDAO;
import com.hospital.dao.BillDAO;
import com.hospital.dao.MedicalRecordDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/patientDashboard")
public class PatientDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Integer patientId = (session != null) ? (Integer) session.getAttribute("patientId") : null;

        if (patientId == null) {
            resp.sendRedirect("login");
            return;
        }

        req.setAttribute("appointments", new AppointmentDAO().findByPatient(patientId));
        req.setAttribute("records", new MedicalRecordDAO().findByPatient(patientId));
        req.setAttribute("bills", new BillDAO().findByPatient(patientId));

        req.getRequestDispatcher("/patientDashboard.jsp").forward(req, resp);
    }
}
