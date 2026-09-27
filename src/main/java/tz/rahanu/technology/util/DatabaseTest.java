package tz.rahanu.technology.util;

import java.sql.Connection;

public class DatabaseTest {

    public static void main(String[] args) {

        try (Connection connection = DBConnection.getConnection()) {

            System.out.println(
                    "======================================"
            );

            System.out.println(
                    "RAHANU TECHNOLOGY DATABASE"
            );

            System.out.println(
                    "Connection successful!"
            );

            System.out.println(
                    "Database: "
                    + connection.getCatalog()
            );

            System.out.println(
                    "======================================"
            );

        } catch (Exception e) {

            System.err.println(
                    "Database connection failed!"
            );

            e.printStackTrace();
        }
    }
}
