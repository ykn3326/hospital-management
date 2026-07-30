package com.hospital.dao;

import com.hospital.model.Doctor;
import com.hospital.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DoctorDAO {

    public Doctor findByEmail(String email) {
        String sql = "SELECT * FROM doctor WHERE email = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Doctor findById(int doctorId) {
        String sql = "SELECT * FROM doctor WHERE doctor_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, doctorId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /** Returns all doctors, optionally filtered by specialization (pass null/empty for all). */
    public List<Doctor> search(String specialization) {
        List<Doctor> list = new ArrayList<>();
        String sql = (specialization == null || specialization.isBlank())
                ? "SELECT * FROM doctor ORDER BY name"
                : "SELECT * FROM doctor WHERE specialization LIKE ? ORDER BY name";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (specialization != null && !specialization.isBlank()) {
                ps.setString(1, "%" + specialization + "%");
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private Doctor mapRow(ResultSet rs) throws SQLException {
        Doctor d = new Doctor();
        d.setDoctorId(rs.getInt("doctor_id"));
        d.setName(rs.getString("name"));
        d.setEmail(rs.getString("email"));
        d.setPasswordHash(rs.getString("password_hash"));
        d.setSpecialization(rs.getString("specialization"));
        d.setPhone(rs.getString("phone"));
        d.setConsultationFee(rs.getBigDecimal("consultation_fee"));
        return d;
    }
}
