package tz.rahanu.technology.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import tz.rahanu.technology.util.DBConnection;

public class DashboardDAO {

    public int getTeamCount() {
        return getCount(
                "SELECT COUNT(*) FROM team_members WHERE is_active = TRUE"
        );
    }

    public int getProjectCount() {
        return getCount(
                "SELECT COUNT(*) FROM projects"
        );
    }

    public int getServiceCount() {
        return getCount(
                "SELECT COUNT(*) FROM services WHERE is_active = TRUE"
        );
    }

    public int getMessageCount() {
        return getCount(
                "SELECT COUNT(*) FROM contact_messages"
        );
    }

    public int getUnreadMessageCount() {
        return getCount(
                "SELECT COUNT(*) FROM contact_messages WHERE is_read = FALSE"
        );
    }

    private int getCount(String sql) {

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql);

                ResultSet resultSet =
                        statement.executeQuery()
        ) {

            if (resultSet.next()) {
                return resultSet.getInt(1);
            }

        } catch (Exception e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to get dashboard count."
            );

            e.printStackTrace();
        }

        return 0;
    }
}
