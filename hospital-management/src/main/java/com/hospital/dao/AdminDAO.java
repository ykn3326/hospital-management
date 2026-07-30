package com.hospital.dao;

import com.hospital.util.DBConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Provides the simple hospital-wide numbers shown on the Admin dashboard:
 * total patients, total doctors, appointments today, and total revenue collected.
 */
public class AdminDAO {

    public Map<String, Object> getDashboardSummary() {
        Map<String, Object> summary = new LinkedHashMap<>();

        try (Connection con = DBConnection.getConnection()) {

            summary.put("totalPatients", singleCount(con, "SELECT COUNT(*) FROM patient"));
            summary.put("totalDoctors", singleCount(con, "SELECT COUNT(*) FROM doctor"));
            summary.put("appointmentsToday", singleCount(con,
                    "SELECT COUNT(*) FROM appointment WHERE visit_date = CURDATE()"));

            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT COALESCE(SUM(total_amount), 0) FROM bill WHERE payment_status = 'PAID'");
                 ResultSet rs = ps.executeQuery()) {
                rs.next();
                summary.put("totalRevenue", rs.getBigDecimal(1));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return summary;
    }

    private int singleCount(Connection con, String sql) throws SQLException {
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            rs.next();
            return rs.getInt(1);
        }
    }
}
