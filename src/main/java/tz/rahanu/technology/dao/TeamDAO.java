package tz.rahanu.technology.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import tz.rahanu.technology.model.TeamMember;
import tz.rahanu.technology.util.DBConnection;

public class TeamDAO {

    public List<TeamMember> getAllActiveMembers() {

        List<TeamMember> members = new ArrayList<>();

        String sql = """
                SELECT
                    id,
                    full_name,
                    position,
                    role_type,
                    biography,
                    skills,
                    photo,
                    linkedin_url,
                    github_url,
                    display_order,
                    is_active
                FROM team_members
                WHERE is_active = TRUE
                ORDER BY display_order ASC
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()
        ) {

            System.out.println(
                    "RAHANU TECHNOLOGY: Loading team members..."
            );

            while (resultSet.next()) {

                TeamMember member = new TeamMember();

                member.setId(
                        resultSet.getInt("id")
                );

                member.setFullName(
                        resultSet.getString("full_name")
                );

                member.setPosition(
                        resultSet.getString("position")
                );

                member.setRoleType(
                        resultSet.getString("role_type")
                );

                member.setBiography(
                        resultSet.getString("biography")
                );

                member.setSkills(
                        resultSet.getString("skills")
                );

                member.setPhoto(
                        resultSet.getString("photo")
                );

                member.setLinkedinUrl(
                        resultSet.getString("linkedin_url")
                );

                member.setGithubUrl(
                        resultSet.getString("github_url")
                );

                member.setDisplayOrder(
                        resultSet.getInt("display_order")
                );

                member.setActive(
                        resultSet.getBoolean("is_active")
                );

                members.add(member);
            }

            System.out.println(
                    "RAHANU TECHNOLOGY: "
                    + members.size()
                    + " team members loaded."
            );

        } catch (Exception e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to load team members."
            );

            e.printStackTrace();
        }

        return members;
    }
}