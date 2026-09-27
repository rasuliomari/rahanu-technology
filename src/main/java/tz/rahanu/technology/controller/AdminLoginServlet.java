package tz.rahanu.technology.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tz.rahanu.technology.dao.AdminDAO;
import tz.rahanu.technology.model.AdminUser;

@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {

    private AdminDAO adminDAO;

    @Override
    public void init() {

        adminDAO = new AdminDAO();

        System.out.println(
                "RAHANU TECHNOLOGY: AdminLoginServlet initialized."
        );
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/admin/login.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username =
                request.getParameter("username");

        String password =
                request.getParameter("password");

        if (username == null ||
                username.trim().isEmpty() ||
                password == null ||
                password.isEmpty()) {

            request.setAttribute(
                    "errorMessage",
                    "Please enter your username and password."
            );

            request.getRequestDispatcher(
                    "/admin/login.jsp"
            ).forward(request, response);

            return;
        }

        username = username.trim();

        AdminUser admin =
                adminDAO.authenticate(
                        username,
                        password
                );

        if (admin != null) {

            HttpSession session =
                    request.getSession(true);

            session.setAttribute(
                    "adminUser",
                    admin
            );

            session.setMaxInactiveInterval(
                    30 * 60
            );

            System.out.println(
                    "RAHANU TECHNOLOGY: Admin login successful - "
                            + username
            );

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/dashboard"
            );

        } else {

            System.out.println(
                    "RAHANU TECHNOLOGY: Failed admin login - "
                            + username
            );

            request.setAttribute(
                    "errorMessage",
                    "Invalid username or password."
            );

            request.getRequestDispatcher(
                    "/admin/login.jsp"
            ).forward(request, response);
        }
    }
}
