package tz.rahanu.technology.dao;

import tz.rahanu.technology.model.ContactMessage;
import tz.rahanu.technology.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ContactDAO {

    /**
     * Save a new contact message.
     */
    public boolean saveMessage(ContactMessage contactMessage) {

        String sql = """
                INSERT INTO contact_messages
                (
                    full_name,
                    email,
                    phone,
                    subject,
                    message
                )
                VALUES
                (
                    ?,
                    ?,
                    ?,
                    ?,
                    ?
                )
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setString(
                    1,
                    contactMessage.getFullName()
            );

            statement.setString(
                    2,
                    contactMessage.getEmail()
            );

            statement.setString(
                    3,
                    contactMessage.getPhone()
            );

            statement.setString(
                    4,
                    contactMessage.getSubject()
            );

            statement.setString(
                    5,
                    contactMessage.getMessage()
            );

            int rowsInserted =
                    statement.executeUpdate();

            System.out.println(
                    "RAHANU TECHNOLOGY: Contact message saved. Rows: "
                    + rowsInserted
            );

            return rowsInserted > 0;

        } catch (Exception e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to save contact message."
            );

            e.printStackTrace();

            return false;
        }
    }

    /**
     * Get all contact messages.
     * This will be used later by the admin dashboard.
     */
    public List<ContactMessage> getAllMessages() {

        List<ContactMessage> messages =
                new ArrayList<>();

        String sql = """
                SELECT
                    id,
                    full_name,
                    email,
                    phone,
                    subject,
                    message,
                    is_read,
                    created_at
                FROM contact_messages
                ORDER BY created_at DESC, id DESC
                """;

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql);

                ResultSet resultSet =
                        statement.executeQuery()
        ) {

            while (resultSet.next()) {

                ContactMessage contactMessage =
                        new ContactMessage();

                contactMessage.setId(
                        resultSet.getInt("id")
                );

                contactMessage.setFullName(
                        resultSet.getString("full_name")
                );

                contactMessage.setEmail(
                        resultSet.getString("email")
                );

                contactMessage.setPhone(
                        resultSet.getString("phone")
                );

                contactMessage.setSubject(
                        resultSet.getString("subject")
                );

                contactMessage.setMessage(
                        resultSet.getString("message")
                );

                contactMessage.setRead(
                        resultSet.getBoolean("is_read")
                );

                contactMessage.setCreatedAt(
                        resultSet.getTimestamp("created_at")
                );

                messages.add(contactMessage);
            }

        } catch (Exception e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to load contact messages."
            );

            e.printStackTrace();
        }

        return messages;
    }
}
