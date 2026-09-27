package tz.rahanu.technology.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import tz.rahanu.technology.model.Project;
import tz.rahanu.technology.util.DBConnection;

public class ProjectDAO {

    public List<Project> getAllProjects() {

        List<Project> projects = new ArrayList<>();

        String sql = """
                SELECT
                    id,
                    title,
                    slug,
                    short_description,
                    description,
                    technologies,
                    image,
                    github_url,
                    live_url,
                    project_date,
                    status,
                    is_featured
                FROM projects
                ORDER BY project_date DESC NULLS LAST, id DESC
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql);
                ResultSet resultSet =
                        statement.executeQuery()
        ) {

            System.out.println(
                    "RAHANU TECHNOLOGY: Loading projects..."
            );

            while (resultSet.next()) {

                Project project = new Project();

                project.setId(
                        resultSet.getInt("id")
                );

                project.setTitle(
                        resultSet.getString("title")
                );

                project.setSlug(
                        resultSet.getString("slug")
                );

                project.setShortDescription(
                        resultSet.getString("short_description")
                );

                project.setDescription(
                        resultSet.getString("description")
                );

                project.setTechnologies(
                        resultSet.getString("technologies")
                );

                project.setImage(
                        resultSet.getString("image")
                );

                project.setGithubUrl(
                        resultSet.getString("github_url")
                );

                project.setLiveUrl(
                        resultSet.getString("live_url")
                );

                Date projectDate =
                        resultSet.getDate("project_date");

                if (projectDate != null) {
                    project.setProjectDate(
                            projectDate.toLocalDate()
                    );
                }

                project.setStatus(
                        resultSet.getString("status")
                );

                project.setFeatured(
                        resultSet.getBoolean("is_featured")
                );

                projects.add(project);
            }

            System.out.println(
                    "RAHANU TECHNOLOGY: "
                    + projects.size()
                    + " projects loaded."
            );

        } catch (Exception e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to load projects."
            );

            e.printStackTrace();
        }

        return projects;
    }
    

    public Project getProjectBySlug(String slug) {

    String sql = """
            SELECT
                id,
                title,
                slug,
                short_description,
                description,
                technologies,
                image,
                github_url,
                live_url,
                project_date,
                status,
                is_featured
            FROM projects
            WHERE slug = ?
            LIMIT 1
            """;

    try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement statement =
                    connection.prepareStatement(sql)
    ) {

        statement.setString(1, slug);

        try (ResultSet resultSet =
                     statement.executeQuery()) {

            if (resultSet.next()) {

                Project project = new Project();

                project.setId(
                        resultSet.getInt("id")
                );

                project.setTitle(
                        resultSet.getString("title")
                );

                project.setSlug(
                        resultSet.getString("slug")
                );

                project.setShortDescription(
                        resultSet.getString("short_description")
                );

                project.setDescription(
                        resultSet.getString("description")
                );

                project.setTechnologies(
                        resultSet.getString("technologies")
                );

                project.setImage(
                        resultSet.getString("image")
                );

                project.setGithubUrl(
                        resultSet.getString("github_url")
                );

                project.setLiveUrl(
                        resultSet.getString("live_url")
                );

                Date projectDate =
                        resultSet.getDate("project_date");

                if (projectDate != null) {
                    project.setProjectDate(
                            projectDate.toLocalDate()
                    );
                }

                project.setStatus(
                        resultSet.getString("status")
                );

                project.setFeatured(
                        resultSet.getBoolean("is_featured")
                );

                return project;
            }
        }

    } catch (Exception e) {

        System.err.println(
                "RAHANU TECHNOLOGY: Failed to load project."
        );

        e.printStackTrace();
    }

    return null;
}

}