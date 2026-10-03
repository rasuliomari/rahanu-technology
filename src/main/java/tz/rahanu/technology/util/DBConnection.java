package tz.rahanu.technology.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String DEFAULT_URL =
            "jdbc:postgresql://localhost:5432/rahanu_technology";

    private static final String DEFAULT_USER =
            "rahanu_admin";

    private static final String DEFAULT_PASSWORD =
            "rahanu";

    static {

        try {

            Class.forName("org.postgresql.Driver");

            System.out.println(
                    "RAHANU TECHNOLOGY: PostgreSQL JDBC driver loaded successfully."
            );

        } catch (ClassNotFoundException e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: PostgreSQL JDBC driver NOT found."
            );

            e.printStackTrace();
        }
    }

    private DBConnection() {
    }

    public static Connection getConnection() throws SQLException {

        String url = getEnvironmentVariable(
                "RAHANU_DB_URL",
                DEFAULT_URL
        );

        String user = getEnvironmentVariable(
                "RAHANU_DB_USER",
                DEFAULT_USER
        );

        String password = getEnvironmentVariable(
                "RAHANU_DB_PASSWORD",
                DEFAULT_PASSWORD
        );

        return DriverManager.getConnection(
                url,
                user,
                password
        );
    }

    private static String getEnvironmentVariable(
            String name,
            String defaultValue) {

        String value = System.getenv(name);

        if (value == null || value.trim().isEmpty()) {
            return defaultValue;
        }

        return value;
    }
}