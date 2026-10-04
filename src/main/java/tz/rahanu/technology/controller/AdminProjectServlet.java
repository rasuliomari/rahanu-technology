package tz.rahanu.technology.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import tz.rahanu.technology.dao.ProjectDAO;
import tz.rahanu.technology.model.Project;
import tz.rahanu.technology.util.AdminAuthUtil;

@WebServlet("/admin/projects")
public class AdminProjectServlet extends HttpServlet {

    private ProjectDAO projectDAO;

    @Override
    public void init() {
        projectDAO = new ProjectDAO();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        if (!AdminAuthUtil.isAuthenticated(request)) {
            response.sendRedirect(
                    request.getContextPath() + "/admin/login"
            );
            return;
        }

        String action =
                request.getParameter("action");

        if ("edit".equals(action)) {

            int id =
                    parseInt(
                            request.getParameter("id"),
                            0
                    );

            Project project =
                    projectDAO.getProjectById(id);

            request.setAttribute(
                    "editProject",
                    project
            );
        }

        List<Project> projects =
                projectDAO.getAllProjects();

        request.setAttribute(
                "projects",
                projects
        );

        request.getRequestDispatcher(
                "/admin/projects.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        if (!AdminAuthUtil.isAuthenticated(request)) {
            response.sendRedirect(
                    request.getContextPath() + "/admin/login"
            );
            return;
        }

        String action =
                request.getParameter("action");

        try {

            if ("save".equals(action)) {

                Project project =
                        new Project();

                project.setTitle(
                        request.getParameter("title")
                );

                project.setSlug(
                        request.getParameter("slug")
                );

                project.setShortDescription(
                        request.getParameter(
                                "shortDescription"
                        )
                );

                project.setDescription(
                        request.getParameter(
                                "description"
                        )
                );

                project.setTechnologies(
                        request.getParameter(
                                "technologies"
                        )
                );

                project.setImage(
                        request.getParameter("image")
                );

                project.setGithubUrl(
                        request.getParameter(
                                "githubUrl"
                        )
                );

                project.setLiveUrl(
                        request.getParameter(
                                "liveUrl"
                        )
                );

                String date =
                        request.getParameter(
                                "projectDate"
                        );

                if (date != null &&
                        !date.trim().isEmpty()) {

                    project.setProjectDate(
                            LocalDate.parse(date)
                    );
                }

                project.setStatus(
                        request.getParameter("status")
                );

                project.setFeatured(
                        "true".equals(
                                request.getParameter(
                                        "featured"
                                )
                        )
                );

                int id =
                        parseInt(
                                request.getParameter("id"),
                                0
                        );

                if (id > 0) {

                    project.setId(id);

                    projectDAO.updateProject(
                            project
                    );

                } else {

                    projectDAO.insertProject(
                            project
                    );
                }

            } else if ("delete".equals(action)) {

                int id =
                        parseInt(
                                request.getParameter("id"),
                                0
                        );

                if (id > 0) {
                    projectDAO.deleteProject(id);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        response.sendRedirect(
                request.getContextPath()
                        + "/admin/projects"
        );
    }

    private int parseInt(
            String value,
            int defaultValue) {

        try {
            return Integer.parseInt(value);
        } catch (Exception e) {
            return defaultValue;
        }
    }
}
