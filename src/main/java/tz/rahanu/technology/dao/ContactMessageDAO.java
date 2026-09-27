package tz.rahanu.technology.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import tz.rahanu.technology.model.ContactMessage;
import tz.rahanu.technology.util.DBConnection;

public class ContactMessageDAO {

    /**
     * Get all contact messages.
     */
    public List<ContactMessage> getAllMessages() {

        List<ContactMessage> messages = new ArrayList<>();

        String sql =
                "SELECT id, full_name, email, phone, subject, message, " +
                "is_read, created_at " +
                "FROM contact_messages " +
                "ORDER BY created_at DESC";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()
        ) {

            while (resultSet.next()) {

                ContactMessage contactMessage = new ContactMessage();

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


    /**
     * Get one message by ID.
     */
    public ContactMessage getMessageById(int id) {

        String sql =
                "SELECT id, full_name, email, phone, subject, message, " +
                "is_read, created_at " +
                "FROM contact_messages " +
                "WHERE id = ?";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, id);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {

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

                    return contactMessage;
                }
            }

        } catch (Exception e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to load contact message."
            );

            e.printStackTrace();
        }

        return null;
    }


    /**
     * Mark a message as read.
     */
    public boolean markAsRead(int id) {

        return updateReadStatus(id, true);
    }


    /**
     * Mark a message as unread.
     */
    public boolean markAsUnread(int id) {

        return updateReadStatus(id, false);
    }


    /**
     * Update message read/unread status.
     */
    private boolean updateReadStatus(int id, boolean isRead) {

        String sql =
                "UPDATE contact_messages " +
                "SET is_read = ? " +
                "WHERE id = ?";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setBoolean(1, isRead);
            statement.setInt(2, id);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to update message status."
            );

            e.printStackTrace();
        }

        return false;
    }


    /**
     * Delete a contact message.
     */
    public boolean deleteMessage(int id) {

        String sql =
                "DELETE FROM contact_messages " +
                "WHERE id = ?";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, id);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to delete contact message."
            );

            e.printStackTrace();
        }

        return false;
    }
}
