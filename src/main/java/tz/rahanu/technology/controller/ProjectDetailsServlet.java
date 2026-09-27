package tz.rahanu.technology.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import tz.rahanu.technology.dao.ProjectDAO;
import tz.rahanu.technology.model.Project;

import java.io.IOException;
import java.util.List;

@WebServlet("/project")
public class ProjectDetailsServlet extends HttpServlet {

    private ProjectDAO projectDAO;

    @Override
    public void init() {

        projectDAO = new ProjectDAO();

        System.out.println(
                "RAHANU TECHNOLOGY: ProjectDetailsServlet initialized."
        );
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String slug = request.getParameter("slug");

        if (slug == null || slug.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() + "/projects"
            );

            return;
        }

        Project project =
                projectDAO.getProjectBySlug(slug);

        if (project == null) {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Project not found"
            );

            return;
        }

        request.setAttribute(
                "project",
                project
        );

        request.getRequestDispatcher(
                "/project-details.jsp"
        ).forward(request, response);
    }
}
