package com.hospital.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Simple utility class that opens a new JDBC connection to the
 * hospital_db MySQL database.
 *
 * Update DB_URL, DB_USER and DB_PASSWORD to match your local MySQL setup.
 */
public class DBConnection {

    private static final String DB_URL = databaseUrl();
    private static final String DB_USER = environment("DB_USER", environment("MYSQLUSER", "root"));
    private static final String DB_PASSWORD = environment("DB_PASSWORD",
            environment("MYSQLPASSWORD", "your_mysql_password"));

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found. Check pom.xml dependency.", e);
        }
    }

    /**
     * Opens and returns a new database connection.
     * Callers are responsible for closing it (use try-with-resources).
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    private static String databaseUrl() {
        String explicitUrl = System.getenv("DB_URL");
        if (explicitUrl != null && !explicitUrl.isBlank()) {
            return explicitUrl;
        }

        String host = environment("MYSQLHOST", "localhost");
        String port = environment("MYSQLPORT", "3306");
        String database = environment("MYSQLDATABASE", "hospital_db");
        return "jdbc:mysql://" + host + ":" + port + "/" + database
                + "?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    }

    private static String environment(String name, String defaultValue) {
        String value = System.getenv(name);
        return value == null || value.isBlank() ? defaultValue : value;
    }
}
