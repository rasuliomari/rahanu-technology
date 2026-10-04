package tz.rahanu.technology.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import tz.rahanu.technology.model.Service;
import tz.rahanu.technology.util.DBConnection;

public class ServiceDAO {

    public List<Service> getAllActiveServices() {

        List<Service> services = new ArrayList<>();

        String sql = """
                SELECT
                    id,
                    title,
                    slug,
                    short_description,
                    description,
                    icon,
                    image,
                    display_order,
                    is_featured,
                    is_active
                FROM services
                WHERE is_active = TRUE
                ORDER BY display_order ASC, id ASC
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()
        ) {

            while (resultSet.next()) {
                services.add(mapService(resultSet));
            }

        } catch (Exception e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to load active services."
            );

            e.printStackTrace();
        }

        return services;
    }


    public List<Service> getAllServices() {

        List<Service> services = new ArrayList<>();

        String sql = """
                SELECT
                    id,
                    title,
                    slug,
                    short_description,
                    description,
                    icon,
                    image,
                    display_order,
                    is_featured,
                    is_active
                FROM services
                ORDER BY display_order ASC, id ASC
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()
        ) {

            while (resultSet.next()) {
                services.add(mapService(resultSet));
            }

        } catch (Exception e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to load all services."
            );

            e.printStackTrace();
        }

        return services;
    }


    public Service getServiceById(int id) {

        String sql = """
                SELECT
                    id,
                    title,
                    slug,
                    short_description,
                    description,
                    icon,
                    image,
                    display_order,
                    is_featured,
                    is_active
                FROM services
                WHERE id = ?
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)
        ) {

            statement.setInt(1, id);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapService(resultSet);
                }
            }

        } catch (Exception e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to load service by ID."
            );

            e.printStackTrace();
        }

        return null;
    }


    public boolean insertService(Service service) {

        String sql = """
                INSERT INTO services
                (
                    title,
                    slug,
                    short_description,
                    description,
                    icon,
                    image,
                    display_order,
                    is_featured,
                    is_active
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            setServiceParameters(
                    statement,
                    service,
                    false
            );

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to insert service."
            );

            e.printStackTrace();
        }

        return false;
    }


    public boolean updateService(Service service) {

        String sql = """
                UPDATE services
                SET
                    title = ?,
                    slug = ?,
                    short_description = ?,
                    description = ?,
                    icon = ?,
                    image = ?,
                    display_order = ?,
                    is_featured = ?,
                    is_active = ?
                WHERE id = ?
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            setServiceParameters(
                    statement,
                    service,
                    true
            );

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to update service."
            );

            e.printStackTrace();
        }

        return false;
    }


    public boolean setActive(
            int id,
            boolean active) {

        String sql = """
                UPDATE services
                SET is_active = ?
                WHERE id = ?
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setBoolean(1, active);
            statement.setInt(2, id);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to update service status."
            );

            e.printStackTrace();
        }

        return false;
    }


    private void setServiceParameters(
            PreparedStatement statement,
            Service service,
            boolean includeId)
            throws Exception {

        statement.setString(
                1,
                service.getTitle()
        );

        statement.setString(
                2,
                service.getSlug()
        );

        statement.setString(
                3,
                service.getShortDescription()
        );

        statement.setString(
                4,
                service.getDescription()
        );

        statement.setString(
                5,
                service.getIcon()
        );

        statement.setString(
                6,
                service.getImage()
        );

        statement.setInt(
                7,
                service.getDisplayOrder()
        );

        statement.setBoolean(
                8,
                service.isFeatured()
        );

        statement.setBoolean(
                9,
                service.isActive()
        );

        if (includeId) {

            statement.setInt(
                    10,
                    service.getId()
            );
        }
    }


    private Service mapService(
            ResultSet resultSet)
            throws Exception {

        Service service = new Service();

        service.setId(
                resultSet.getInt("id")
        );

        service.setTitle(
                resultSet.getString("title")
        );

        service.setSlug(
                resultSet.getString("slug")
        );

        service.setShortDescription(
                resultSet.getString("short_description")
        );

        service.setDescription(
                resultSet.getString("description")
        );

        service.setIcon(
                resultSet.getString("icon")
        );

        service.setImage(
                resultSet.getString("image")
        );

        service.setDisplayOrder(
                resultSet.getInt("display_order")
        );

        service.setFeatured(
                resultSet.getBoolean("is_featured")
        );

        service.setActive(
                resultSet.getBoolean("is_active")
        );

        return service;
    }
}