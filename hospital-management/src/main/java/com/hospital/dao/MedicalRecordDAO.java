package com.hospital.dao;

import com.hospital.model.MedicalRecord;
import com.hospital.model.Prescription;
import com.hospital.util.DBConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.util.List;

public class MedicalRecordDAO {

    /**
     * Called when a doctor completes a consultation.
     * In a single database transaction, this:
     *   1. Marks the appointment as COMPLETED
     *   2. Creates the medical record (diagnosis + notes)
     *   3. Inserts each prescribed medicine
     *   4. Calculates and creates the bill (consultation fee + medicine costs)
     *
     * Using one transaction means if any step fails, nothing is saved —
     * we never end up with, say, a bill but no medical record.
     */
    public boolean completeConsultation(int appointmentId, int doctorId, String diagnosis,
                                         String notes, List<Prescription> prescriptions) {

        String updateApptSql = "UPDATE appointment SET status = 'COMPLETED' "
                + "WHERE appointment_id = ? AND doctor_id = ? AND status = 'BOOKED'";
        String insertRecordSql = "INSERT INTO medical_record (appointment_id, diagnosis, notes) VALUES (?, ?, ?)";
        String insertPrescriptionSql = "INSERT INTO prescription (record_id, medicine_name, dosage, duration_days, cost) VALUES (?, ?, ?, ?, ?)";
        String getFeeSql = "SELECT consultation_fee FROM doctor WHERE doctor_id = ?";
        String insertBillSql = "INSERT INTO bill (appointment_id, consultation_fee, medicine_charges, total_amount, payment_status) VALUES (?, ?, ?, ?, 'UNPAID')";

        Connection con = null;
        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false); // start transaction

            // 1. Mark appointment completed
            try (PreparedStatement ps = con.prepareStatement(updateApptSql)) {
                ps.setInt(1, appointmentId);
                ps.setInt(2, doctorId);
                if (ps.executeUpdate() != 1) {
                    con.rollback();
                    return false;
                }
            }

            // 2. Insert medical record
            int recordId;
            try (PreparedStatement ps = con.prepareStatement(insertRecordSql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, appointmentId);
                ps.setString(2, diagnosis);
                ps.setString(3, notes);
                ps.executeUpdate();
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (!keys.next()) {
                        throw new SQLException("Medical record was created without a generated ID.");
                    }
                    recordId = keys.getInt(1);
                }
            }

            // 3. Insert prescriptions, tallying medicine cost as we go
            BigDecimal medicineTotal = BigDecimal.ZERO;
            if (prescriptions != null) {
                try (PreparedStatement ps = con.prepareStatement(insertPrescriptionSql)) {
                    for (Prescription pres : prescriptions) {
                        if (pres == null || pres.getMedicineName() == null || pres.getMedicineName().isBlank()
                                || pres.getDurationDays() < 0
                                || (pres.getCost() != null && pres.getCost().signum() < 0)) {
                            throw new SQLException("Invalid prescription data.");
                        }
                        ps.setInt(1, recordId);
                        ps.setString(2, pres.getMedicineName());
                        ps.setString(3, pres.getDosage());
                        ps.setInt(4, pres.getDurationDays());
                        ps.setBigDecimal(5, pres.getCost() != null ? pres.getCost() : BigDecimal.ZERO);
                        ps.addBatch();
                        medicineTotal = medicineTotal.add(pres.getCost() != null ? pres.getCost() : BigDecimal.ZERO);
                    }
                    ps.executeBatch();
                }
            }

            // 4. Look up consultation fee, then create the bill automatically
            BigDecimal consultationFee = BigDecimal.ZERO;
            try (PreparedStatement ps = con.prepareStatement(getFeeSql)) {
                ps.setInt(1, doctorId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) consultationFee = rs.getBigDecimal("consultation_fee");
                }
            }
            BigDecimal total = consultationFee.add(medicineTotal);

            try (PreparedStatement ps = con.prepareStatement(insertBillSql)) {
                ps.setInt(1, appointmentId);
                ps.setBigDecimal(2, consultationFee);
                ps.setBigDecimal(3, medicineTotal);
                ps.setBigDecimal(4, total);
                ps.executeUpdate();
            }

            con.commit(); // all steps succeeded — save everything
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            if (con != null) {
                try { con.rollback(); } catch (SQLException rollbackEx) { rollbackEx.printStackTrace(); }
            }
            return false;
        } finally {
            if (con != null) {
                try { con.setAutoCommit(true); con.close(); } catch (SQLException ignored) {}
            }
        }
    }

    /** Fetches the full medical history (diagnosis + notes) for a patient, across all their appointments. */
    public List<MedicalRecord> findByPatient(int patientId) {
        String sql = "SELECT mr.* FROM medical_record mr " +
                     "JOIN appointment a ON mr.appointment_id = a.appointment_id " +
                     "WHERE a.patient_id = ? ORDER BY mr.created_at DESC";
        List<MedicalRecord> list = new java.util.ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, patientId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    MedicalRecord mr = new MedicalRecord();
                    mr.setRecordId(rs.getInt("record_id"));
                    mr.setAppointmentId(rs.getInt("appointment_id"));
                    mr.setDiagnosis(rs.getString("diagnosis"));
                    mr.setNotes(rs.getString("notes"));
                    list.add(mr);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
