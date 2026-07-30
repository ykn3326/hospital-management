package com.hospital.servlet;

import com.hospital.dao.MedicalRecordDAO;
import com.hospital.model.Prescription;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 * Handles the "complete consultation" form submitted by a doctor:
 * diagnosis, notes, and a list of prescribed medicines (name/dosage/days/cost
 * repeated as parallel arrays medName[], medDosage[], medDays[], medCost[]).
 * On success, this also auto-generates the bill (see MedicalRecordDAO).
 */
@WebServlet("/completeConsultation")
public class CompleteConsultationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Integer doctorId = (session != null) ? (Integer) session.getAttribute("doctorId") : null;

        if (doctorId == null) {
            resp.sendRedirect("login");
            return;
        }

        int appointmentId = Integer.parseInt(req.getParameter("appointmentId"));
        String diagnosis = req.getParameter("diagnosis");
        String notes = req.getParameter("notes");

        String[] medNames = req.getParameterValues("medName");
        String[] medDosages = req.getParameterValues("medDosage");
        String[] medDays = req.getParameterValues("medDays");
        String[] medCosts = req.getParameterValues("medCost");

        List<Prescription> prescriptions = new ArrayList<>();
        if (medNames != null) {
            for (int i = 0; i < medNames.length; i++) {
                if (medNames[i] == null || medNames[i].isBlank()) continue;
                Prescription p = new Prescription();
                p.setMedicineName(medNames[i]);
                p.setDosage(medDosages[i]);
                p.setDurationDays(Integer.parseInt(medDays[i]));
                p.setCost(new BigDecimal(medCosts[i]));
                prescriptions.add(p);
            }
        }

        boolean success = new MedicalRecordDAO().completeConsultation(
                appointmentId, doctorId, diagnosis, notes, prescriptions);

        req.getSession().setAttribute("message",
                success ? "Consultation completed and bill generated." : "Something went wrong. Please try again.");

        resp.sendRedirect("doctorDashboard");
    }
}
