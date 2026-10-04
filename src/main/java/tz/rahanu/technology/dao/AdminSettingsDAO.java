package tz.rahanu.technology.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import tz.rahanu.technology.model.AdminUser;
import tz.rahanu.technology.util.DBConnection;

public class AdminSettingsDAO {

    /*
     * ============================================================
     * GET ADMIN USER BY ID
     * ============================================================
     */
    public AdminUser getAdminById(int id) {

        String sql =
                "SELECT id, username, password_hash, full_name, is_active " +
                "FROM admin_users " +
                "WHERE id = ?";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, id);

            try (ResultSet result = statement.executeQuery()) {

                if (result.next()) {

                    return new AdminUser(
                            result.getInt("id"),
                            result.getString("username"),
                            result.getString("password_hash"),
                            result.getString("full_name"),
                            result.getBoolean("is_active")
                    );
                }
            }

        } catch (Exception e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to load administrator."
            );

            e.printStackTrace();
        }

        return null;
    }


    /*
     * ============================================================
     * CHECK WHETHER USERNAME IS ALREADY USED
     * ============================================================
     */
    public boolean usernameExists(
            String username,
            int currentAdminId) {

        String sql =
                "SELECT id " +
                "FROM admin_users " +
                "WHERE LOWER(username) = LOWER(?) " +
                "AND id <> ?";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setString(1, username);
            statement.setInt(2, currentAdminId);

            try (ResultSet result = statement.executeQuery()) {

                return result.next();
            }

        } catch (Exception e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to check username."
            );

            e.printStackTrace();
        }

        return true;
    }


    /*
     * ============================================================
     * UPDATE PROFILE
     * ============================================================
     */
    public boolean updateProfile(
            int id,
            String username,
            String fullName) {

        String sql =
                "UPDATE admin_users " +
                "SET username = ?, full_name = ? " +
                "WHERE id = ?";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setString(1, username);
            statement.setString(2, fullName);
            statement.setInt(3, id);

            return statement.executeUpdate() == 1;

        } catch (Exception e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to update administrator profile."
            );

            e.printStackTrace();
        }

        return false;
    }


    /*
     * ============================================================
     * UPDATE PASSWORD
     * ============================================================
     */
    public boolean updatePassword(
            int id,
            String passwordHash) {

        String sql =
                "UPDATE admin_users " +
                "SET password_hash = ? " +
                "WHERE id = ?";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setString(1, passwordHash);
            statement.setInt(2, id);

            return statement.executeUpdate() == 1;

        } catch (Exception e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to update administrator password."
            );

            e.printStackTrace();
        }

        return false;
    }
}

