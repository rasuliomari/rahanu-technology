package tz.rahanu.technology.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tz.rahanu.technology.dao.DashboardDAO;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private DashboardDAO dashboardDAO;

    @Override
    public void init() {

        dashboardDAO = new DashboardDAO();

        System.out.println(
                "RAHANU TECHNOLOGY: AdminDashboardServlet initialized."
        );
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        /*
         * Make sure the administrator is logged in.
         */
        if (session == null ||
                session.getAttribute("adminUser") == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/login"
            );

            return;
        }

        /*
         * Load dashboard statistics.
         */
        int teamCount =
                dashboardDAO.getTeamCount();

        int projectCount =
                dashboardDAO.getProjectCount();

        int serviceCount =
                dashboardDAO.getServiceCount();

        int messageCount =
                dashboardDAO.getMessageCount();

        int unreadMessageCount =
                dashboardDAO.getUnreadMessageCount();

        /*
         * Send statistics to dashboard.jsp.
         */
        request.setAttribute(
                "teamCount",
                teamCount
        );

        request.setAttribute(
                "projectCount",
                projectCount
        );

        request.setAttribute(
                "serviceCount",
                serviceCount
        );

        request.setAttribute(
                "messageCount",
                messageCount
        );

        request.setAttribute(
                "unreadMessageCount",
                unreadMessageCount
        );

        request.getRequestDispatcher(
                "/admin/dashboard.jsp"
        ).forward(request, response);
    }
}
