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

@WebServlet("/projects")
public class ProjectServlet extends HttpServlet {

    private ProjectDAO projectDAO;

    @Override
    public void init() {

        projectDAO = new ProjectDAO();

        System.out.println(
                "RAHANU TECHNOLOGY: ProjectServlet initialized."
        );
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println(
                "RAHANU TECHNOLOGY: ProjectServlet called."
        );

        List<Project> projects =
                projectDAO.getAllProjects();

        request.setAttribute(
                "projects",
                projects
        );

        request.getRequestDispatcher(
                "/projects.jsp"
        ).forward(request, response);
    }
}

