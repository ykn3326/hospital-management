package com.hospital.dao;

import com.hospital.model.Appointment;
import com.hospital.util.DBConnection;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {

    /**
     * Books an appointment. Relies on the UNIQUE KEY (doctor_id, visit_date, visit_time)
     * in the database to guarantee no two patients can double-book the same slot,
     * even under concurrent requests.
     *
     * @return the new appointment_id, or -1 if the slot was already taken / booking failed.
     */
    public int bookAppointment(int patientId, int doctorId, LocalDate visitDate, LocalTime visitTime) {
        String sql = "INSERT INTO appointment (patient_id, doctor_id, visit_date, visit_time, status) VALUES (?, ?, ?, ?, 'BOOKED')";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, patientId);
            ps.setInt(2, doctorId);
            ps.setDate(3, Date.valueOf(visitDate));
            ps.setTime(4, Time.valueOf(visitTime));

            int rows = ps.executeUpdate();
            if (rows == 0) return -1;

            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
            return -1;
        } catch (SQLIntegrityConstraintViolationException dup) {
            // This slot is already booked for this doctor — the UNIQUE KEY caught it.
            return -1;
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    /** Returns all appointments for a given patient, most recent first. */
    public List<Appointment> findByPatient(int patientId) {
        String sql = "SELECT a.*, d.name AS doctor_name FROM appointment a " +
                     "JOIN doctor d ON a.doctor_id = d.doctor_id " +
                     "WHERE a.patient_id = ? ORDER BY a.visit_date DESC, a.visit_time DESC";
        return runListQuery(sql, patientId);
    }

    /** Returns all appointments for a given doctor, most recent first. */
    public List<Appointment> findByDoctor(int doctorId) {
        String sql = "SELECT a.*, p.name AS patient_name FROM appointment a " +
                     "JOIN patient p ON a.patient_id = p.patient_id " +
                     "WHERE a.doctor_id = ? ORDER BY a.visit_date DESC, a.visit_time DESC";
        return runListQuery(sql, doctorId);
    }

    private List<Appointment> runListQuery(String sql, int id) {
        List<Appointment> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Appointment a = new Appointment();
                    a.setAppointmentId(rs.getInt("appointment_id"));
                    a.setPatientId(rs.getInt("patient_id"));
                    a.setDoctorId(rs.getInt("doctor_id"));
                    a.setVisitDate(rs.getDate("visit_date").toLocalDate());
                    a.setVisitTime(rs.getTime("visit_time").toLocalTime());
                    a.setStatus(rs.getString("status"));
                    try { a.setDoctorName(rs.getString("doctor_name")); } catch (SQLException ignored) {}
                    try { a.setPatientName(rs.getString("patient_name")); } catch (SQLException ignored) {}
                    list.add(a);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Appointment findById(int appointmentId) {
        String sql = "SELECT * FROM appointment WHERE appointment_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, appointmentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Appointment a = new Appointment();
                    a.setAppointmentId(rs.getInt("appointment_id"));
                    a.setPatientId(rs.getInt("patient_id"));
                    a.setDoctorId(rs.getInt("doctor_id"));
                    a.setVisitDate(rs.getDate("visit_date").toLocalDate());
                    a.setVisitTime(rs.getTime("visit_time").toLocalTime());
                    a.setStatus(rs.getString("status"));
                    return a;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateStatus(int appointmentId, String status) {
        String sql = "UPDATE appointment SET status = ? WHERE appointment_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, appointmentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
