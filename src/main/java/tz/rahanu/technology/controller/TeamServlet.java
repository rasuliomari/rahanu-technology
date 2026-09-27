package tz.rahanu.technology.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import tz.rahanu.technology.dao.TeamDAO;
import tz.rahanu.technology.model.TeamMember;

import java.io.IOException;
import java.util.List;

@WebServlet("/team")
public class TeamServlet extends HttpServlet {

    private TeamDAO teamDAO;

    @Override
    public void init() {

        teamDAO = new TeamDAO();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<TeamMember> teamMembers =
                teamDAO.getAllActiveMembers();

        request.setAttribute(
                "teamMembers",
                teamMembers
        );

        request.getRequestDispatcher(
                "/team.jsp"
        ).forward(request, response);
    }
}
