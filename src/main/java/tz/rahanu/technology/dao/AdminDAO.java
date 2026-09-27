package tz.rahanu.technology.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import tz.rahanu.technology.model.AdminUser;
import tz.rahanu.technology.util.DBConnection;
import tz.rahanu.technology.util.PasswordUtil;

public class AdminDAO {

    public AdminUser authenticate(
            String username,
            String password) {

        String sql =
                "SELECT id, username, password_hash, full_name, is_active " +
                "FROM admin_users " +
                "WHERE username = ? " +
                "AND is_active = TRUE";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)
        ) {

            statement.setString(1, username);

            try (ResultSet result = statement.executeQuery()) {

                if (result.next()) {

                    String storedHash =
                            result.getString("password_hash");

                    boolean passwordCorrect =
                            PasswordUtil.verifyPassword(
                                    password,
                                    storedHash
                            );

                    if (passwordCorrect) {

                        return new AdminUser(
                                result.getInt("id"),
                                result.getString("username"),
                                storedHash,
                                result.getString("full_name"),
                                result.getBoolean("is_active")
                        );
                    }
                }
            }

        } catch (Exception e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Admin authentication error."
            );

            e.printStackTrace();
        }

        return null;
    }
}
