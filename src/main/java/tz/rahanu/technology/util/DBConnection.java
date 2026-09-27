package tz.rahanu.technology.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
            "jdbc:postgresql://localhost:5432/rahanu_technology";

    private static final String USER =
            "rahanu_admin";

    private static final String PASSWORD =
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

        return DriverManager.getConnection(
                URL,
                USER,
                PASSWORD
        );
    }
}