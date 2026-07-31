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

        int appointmentId;
        try {
            appointmentId = Integer.parseInt(req.getParameter("appointmentId"));
        } catch (NumberFormatException e) {
            setMessageAndRedirect(req, resp, "Please select a valid appointment.");
            return;
        }

        String diagnosis = req.getParameter("diagnosis");
        String notes = req.getParameter("notes");
        if (diagnosis == null || diagnosis.isBlank()) {
            setMessageAndRedirect(req, resp, "A diagnosis is required to complete a consultation.");
            return;
        }

        String[] medNames = req.getParameterValues("medName");
        String[] medDosages = req.getParameterValues("medDosage");
        String[] medDays = req.getParameterValues("medDays");
        String[] medCosts = req.getParameterValues("medCost");

        List<Prescription> prescriptions = new ArrayList<>();
        if (medNames != null) {
            if (medDosages == null || medDays == null || medCosts == null
                    || medDosages.length != medNames.length
                    || medDays.length != medNames.length
                    || medCosts.length != medNames.length) {
                setMessageAndRedirect(req, resp, "Prescription details are incomplete.");
                return;
            }
            for (int i = 0; i < medNames.length; i++) {
                if (medNames[i] == null || medNames[i].isBlank()) continue;
                try {
                    int durationDays = Integer.parseInt(medDays[i]);
                    BigDecimal cost = new BigDecimal(medCosts[i]);
                    if (durationDays < 0 || cost.signum() < 0) {
                        throw new NumberFormatException();
                    }
                    Prescription p = new Prescription();
                    p.setMedicineName(medNames[i].trim());
                    p.setDosage(medDosages[i]);
                    p.setDurationDays(durationDays);
                    p.setCost(cost);
                    prescriptions.add(p);
                } catch (NumberFormatException e) {
                    setMessageAndRedirect(req, resp, "Prescription days and cost must be non-negative numbers.");
                    return;
                }
            }
        }

        boolean success = new MedicalRecordDAO().completeConsultation(
                appointmentId, doctorId, diagnosis, notes, prescriptions);

        req.getSession().setAttribute("message",
                success ? "Consultation completed and bill generated." : "Something went wrong. Please try again.");

        resp.sendRedirect("doctorDashboard");
    }

    private void setMessageAndRedirect(HttpServletRequest req, HttpServletResponse resp, String message)
            throws IOException {
        req.getSession().setAttribute("message", message);
        resp.sendRedirect("doctorDashboard");
    }
}
