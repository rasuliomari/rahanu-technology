package tz.rahanu.technology.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import tz.rahanu.technology.model.TeamMember;
import tz.rahanu.technology.util.DBConnection;

public class TeamDAO {

    /*
     * ============================================================
     * GET ACTIVE TEAM MEMBERS
     * Used by the public website.
     * ============================================================
     */
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
                ORDER BY display_order ASC, id ASC
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql);
                ResultSet resultSet =
                        statement.executeQuery()
        ) {

            while (resultSet.next()) {
                members.add(mapTeamMember(resultSet));
            }

        } catch (Exception e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to load active team members."
            );

            e.printStackTrace();
        }

        return members;
    }


    /*
     * ============================================================
     * GET ALL TEAM MEMBERS
     * Used by the admin panel.
     * ============================================================
     */
    public List<TeamMember> getAllMembers() {

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
                ORDER BY display_order ASC, id ASC
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql);
                ResultSet resultSet =
                        statement.executeQuery()
        ) {

            while (resultSet.next()) {
                members.add(mapTeamMember(resultSet));
            }

        } catch (Exception e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to load all team members."
            );

            e.printStackTrace();
        }

        return members;
    }


    /*
     * ============================================================
     * GET TEAM MEMBER BY ID
     * ============================================================
     */
    public TeamMember getById(int id) {

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
                WHERE id = ?
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, id);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapTeamMember(resultSet);
                }
            }

        } catch (Exception e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to load team member."
            );

            e.printStackTrace();
        }

        return null;
    }


    /*
     * ============================================================
     * INSERT TEAM MEMBER
     * ============================================================
     */
    public boolean insert(TeamMember member) {

        String sql = """
                INSERT INTO team_members
                (
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
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            setTeamMemberParameters(
                    statement,
                    member,
                    false
            );

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to insert team member."
            );

            e.printStackTrace();
        }

        return false;
    }


    /*
     * ============================================================
     * UPDATE TEAM MEMBER
     * ============================================================
     */
    public boolean update(TeamMember member) {

        String sql = """
                UPDATE team_members
                SET
                    full_name = ?,
                    position = ?,
                    role_type = ?,
                    biography = ?,
                    skills = ?,
                    photo = ?,
                    linkedin_url = ?,
                    github_url = ?,
                    display_order = ?,
                    is_active = ?
                WHERE id = ?
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            setTeamMemberParameters(
                    statement,
                    member,
                    true
            );

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Failed to update team member."
            );

            e.printStackTrace();
        }

        return false;
    }


    /*
     * ============================================================
     * ACTIVATE / DEACTIVATE TEAM MEMBER
     * ============================================================
     */
    public boolean setActive(
            int id,
            boolean active) {

        String sql = """
                UPDATE team_members
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
                    "RAHANU TECHNOLOGY: Failed to update team member status."
            );

            e.printStackTrace();
        }

        return false;
    }


    /*
     * ============================================================
     * SET PREPARED STATEMENT PARAMETERS
     * ============================================================
     */
    private void setTeamMemberParameters(
            PreparedStatement statement,
            TeamMember member,
            boolean includeId)
            throws Exception {

        statement.setString(
                1,
                member.getFullName()
        );

        statement.setString(
                2,
                member.getPosition()
        );

        statement.setString(
                3,
                member.getRoleType()
        );

        statement.setString(
                4,
                member.getBiography()
        );

        statement.setString(
                5,
                member.getSkills()
        );

        statement.setString(
                6,
                member.getPhoto()
        );

        statement.setString(
                7,
                member.getLinkedinUrl()
        );

        statement.setString(
                8,
                member.getGithubUrl()
        );

        statement.setInt(
                9,
                member.getDisplayOrder()
        );

        statement.setBoolean(
                10,
                member.isActive()
        );

        if (includeId) {

            statement.setInt(
                    11,
                    member.getId()
            );
        }
    }


    /*
     * ============================================================
     * MAP DATABASE ROW TO TEAM MEMBER OBJECT
     * ============================================================
     */
    private TeamMember mapTeamMember(
            ResultSet resultSet)
            throws Exception {

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

        return member;
    }
}