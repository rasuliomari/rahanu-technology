package tz.rahanu.technology.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import tz.rahanu.technology.dao.ServiceDAO;
import tz.rahanu.technology.model.Service;
import tz.rahanu.technology.util.AdminAuthUtil;

@WebServlet("/admin/services")
public class AdminServiceServlet extends HttpServlet {

    private ServiceDAO serviceDAO;

    @Override
    public void init() {
        serviceDAO = new ServiceDAO();
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

            Service service =
                    serviceDAO.getServiceById(id);

            request.setAttribute(
                    "editService",
                    service
            );
        }

        List<Service> services =
                serviceDAO.getAllServices();

        request.setAttribute(
                "services",
                services
        );

        request.getRequestDispatcher(
                "/admin/services.jsp"
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

                Service service =
                        new Service();

                service.setTitle(
                        request.getParameter("title")
                );

                service.setSlug(
                        request.getParameter("slug")
                );

                service.setShortDescription(
                        request.getParameter(
                                "shortDescription"
                        )
                );

                service.setDescription(
                        request.getParameter(
                                "description"
                        )
                );

                service.setIcon(
                        request.getParameter("icon")
                );

                service.setImage(
                        request.getParameter("image")
                );

                service.setDisplayOrder(
                        parseInt(
                                request.getParameter(
                                        "displayOrder"
                                ),
                                0
                        )
                );

                service.setFeatured(
                        "true".equals(
                                request.getParameter(
                                        "featured"
                                )
                        )
                );

                service.setActive(
                        "true".equals(
                                request.getParameter(
                                        "active"
                                )
                        )
                );

                int id =
                        parseInt(
                                request.getParameter("id"),
                                0
                        );

                if (id > 0) {

                    service.setId(id);

                    serviceDAO.updateService(
                            service
                    );

                } else {

                    serviceDAO.insertService(
                            service
                    );
                }

            } else if ("toggle".equals(action)) {

                int id =
                        parseInt(
                                request.getParameter("id"),
                                0
                        );

                boolean active =
                        "true".equals(
                                request.getParameter("active")
                        );

                serviceDAO.setActive(
                        id,
                        active
                );
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        response.sendRedirect(
                request.getContextPath()
                        + "/admin/services"
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
