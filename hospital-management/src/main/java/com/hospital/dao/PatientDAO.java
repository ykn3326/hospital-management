package com.hospital.dao;

import com.hospital.model.Patient;
import com.hospital.util.DBConnection;

import java.sql.*;
import java.time.LocalDate;

public class PatientDAO {

    /** Inserts a new patient and returns the generated patient_id, or -1 on failure. */
    public int registerPatient(Patient p) {
        String sql = "INSERT INTO patient (name, email, password_hash, phone, gender, dob, address) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, p.getName());
            ps.setString(2, p.getEmail());
            ps.setString(3, p.getPasswordHash());
            ps.setString(4, p.getPhone());
            ps.setString(5, p.getGender());
            ps.setDate(6, p.getDob() != null ? Date.valueOf(p.getDob()) : null);
            ps.setString(7, p.getAddress());

            int rows = ps.executeUpdate();
            if (rows == 0) return -1;

            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
            return -1;
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    /** Looks up a patient by email — used during login. Returns null if not found. */
    public Patient findByEmail(String email) {
        String sql = "SELECT * FROM patient WHERE email = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Patient findById(int patientId) {
        String sql = "SELECT * FROM patient WHERE patient_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, patientId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Patient mapRow(ResultSet rs) throws SQLException {
        Patient p = new Patient();
        p.setPatientId(rs.getInt("patient_id"));
        p.setName(rs.getString("name"));
        p.setEmail(rs.getString("email"));
        p.setPasswordHash(rs.getString("password_hash"));
        p.setPhone(rs.getString("phone"));
        p.setGender(rs.getString("gender"));
        Date dob = rs.getDate("dob");
        p.setDob(dob != null ? dob.toLocalDate() : null);
        p.setAddress(rs.getString("address"));
        return p;
    }
}
