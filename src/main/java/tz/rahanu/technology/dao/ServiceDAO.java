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
                PreparedStatement statement =
                        connection.prepareStatement(sql);
                ResultSet resultSet =
                        statement.executeQuery()
        ) {

            System.out.println(
                    "RAHANU TECHNOLOGY: Loading services..."
            );

            while (resultSet.next()) {

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

                services.add(service);
            }

            System.out.println(
                    "RAHANU TECHNOLOGY: "
                    + services.size()
                    + " services loaded."
            );

        } catch (Exception e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to load services."
            );

            e.printStackTrace();
        }

        return services;
    }
}