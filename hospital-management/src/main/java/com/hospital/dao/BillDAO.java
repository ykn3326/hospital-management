package com.hospital.dao;

import com.hospital.model.Bill;
import com.hospital.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {

    public Bill findByAppointment(int appointmentId) {
        String sql = "SELECT * FROM bill WHERE appointment_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, appointmentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /** All bills for a patient, across all their appointments — joined for easy display. */
    public List<Bill> findByPatient(int patientId) {
        String sql = "SELECT b.* FROM bill b " +
                     "JOIN appointment a ON b.appointment_id = a.appointment_id " +
                     "WHERE a.patient_id = ? ORDER BY b.created_at DESC";
        List<Bill> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, patientId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean markAsPaid(int billId) {
        String sql = "UPDATE bill SET payment_status = 'PAID' WHERE bill_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, billId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Bill mapRow(ResultSet rs) throws SQLException {
        Bill b = new Bill();
        b.setBillId(rs.getInt("bill_id"));
        b.setAppointmentId(rs.getInt("appointment_id"));
        b.setConsultationFee(rs.getBigDecimal("consultation_fee"));
        b.setMedicineCharges(rs.getBigDecimal("medicine_charges"));
        b.setTotalAmount(rs.getBigDecimal("total_amount"));
        b.setPaymentStatus(rs.getString("payment_status"));
        return b;
    }
}
