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
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()
        ) {

            while (resultSet.next()) {
                projects.add(mapProject(resultSet));
            }

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
                PreparedStatement statement = connection.prepareStatement(sql)
        ) {

            statement.setString(1, slug);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapProject(resultSet);
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

    public Project getProjectById(int id) {

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
                WHERE id = ?
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)
        ) {

            statement.setInt(1, id);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapProject(resultSet);
                }
            }

        } catch (Exception e) {
            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to load project by ID."
            );
            e.printStackTrace();
        }

        return null;
    }

    public boolean insertProject(Project project) {

        String sql = """
                INSERT INTO projects
                (
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
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)
        ) {

            setProjectParameters(statement, project, false);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to insert project."
            );
            e.printStackTrace();
        }

        return false;
    }

    public boolean updateProject(Project project) {

        String sql = """
                UPDATE projects
                SET
                    title = ?,
                    slug = ?,
                    short_description = ?,
                    description = ?,
                    technologies = ?,
                    image = ?,
                    github_url = ?,
                    live_url = ?,
                    project_date = ?,
                    status = ?,
                    is_featured = ?
                WHERE id = ?
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)
        ) {

            setProjectParameters(statement, project, true);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to update project."
            );
            e.printStackTrace();
        }

        return false;
    }

    public boolean deleteProject(int id) {

        String sql = """
                DELETE FROM projects
                WHERE id = ?
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)
        ) {

            statement.setInt(1, id);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to delete project."
            );
            e.printStackTrace();
        }

        return false;
    }

    private void setProjectParameters(
            PreparedStatement statement,
            Project project,
            boolean includeId
    ) throws Exception {

        statement.setString(1, project.getTitle());
        statement.setString(2, project.getSlug());
        statement.setString(3, project.getShortDescription());
        statement.setString(4, project.getDescription());
        statement.setString(5, project.getTechnologies());
        statement.setString(6, project.getImage());
        statement.setString(7, project.getGithubUrl());
        statement.setString(8, project.getLiveUrl());

        if (project.getProjectDate() != null) {
            statement.setDate(
                    9,
                    Date.valueOf(project.getProjectDate())
            );
        } else {
            statement.setDate(9, null);
        }

        statement.setString(10, project.getStatus());
        statement.setBoolean(11, project.isFeatured());

        if (includeId) {
            statement.setInt(12, project.getId());
        }
    }

    private Project mapProject(ResultSet resultSet)
            throws Exception {

        Project project = new Project();

        project.setId(resultSet.getInt("id"));
        project.setTitle(resultSet.getString("title"));
        project.setSlug(resultSet.getString("slug"));
        project.setShortDescription(
                resultSet.getString("short_description")
        );
        project.setDescription(
                resultSet.getString("description")
        );
        project.setTechnologies(
                resultSet.getString("technologies")
        );
        project.setImage(resultSet.getString("image"));
        project.setGithubUrl(
                resultSet.getString("github_url")
        );
        project.setLiveUrl(
                resultSet.getString("live_url")
        );

        Date date = resultSet.getDate("project_date");

        if (date != null) {
            project.setProjectDate(
                    date.toLocalDate()
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