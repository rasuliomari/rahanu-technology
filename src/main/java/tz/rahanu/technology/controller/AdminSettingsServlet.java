package tz.rahanu.technology.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import tz.rahanu.technology.dao.AdminSettingsDAO;
import tz.rahanu.technology.model.AdminUser;
import tz.rahanu.technology.util.PasswordUtil;
import tz.rahanu.technology.util.StorageConfig;

@WebServlet("/admin/settings")
public class AdminSettingsServlet extends HttpServlet {

    private AdminSettingsDAO settingsDAO;


    /*
     * ============================================================
     * INITIALIZE
     * ============================================================
     */
    @Override
    public void init() {

        settingsDAO = new AdminSettingsDAO();

        System.out.println(
                "RAHANU TECHNOLOGY: AdminSettingsServlet initialized."
        );
    }


    /*
     * ============================================================
     * GET
     * ============================================================
     */
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        /*
         * Make sure administrator is logged in.
         */
        if (session == null ||
                session.getAttribute("adminUser") == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/login"
            );

            return;
        }

        AdminUser sessionAdmin =
                (AdminUser) session.getAttribute(
                        "adminUser"
                );

        /*
         * Always load the latest administrator information
         * from the database.
         */
        AdminUser admin =
                settingsDAO.getAdminById(
                        sessionAdmin.getId()
                );

        if (admin == null) {

            session.invalidate();

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/login"
            );

            return;
        }

        /*
         * Update session with latest administrator data.
         */
        session.setAttribute(
                "adminUser",
                admin
        );

        /*
         * System information.
         */
        String applicationName =
                getEnvironment(
                        "RAHANU_APP_NAME",
                        "RAHANU TECHNOLOGY"
                );

        String databaseName =
                getEnvironment(
                        "RAHANU_DB_NAME",
                        "rahanu_technology"
                );

        String databaseUrl =
                getEnvironment(
                        "RAHANU_DB_URL",
                        "jdbc:postgresql://localhost:5432/"
                                + databaseName
                );

        String uploadDirectory =
                StorageConfig.getTeamUploadDirectory();

        String tomcatHome =
                System.getProperty(
                        "catalina.home",
                        "Apache Tomcat"
                );

        request.setAttribute(
                "applicationName",
                applicationName
        );

        request.setAttribute(
                "databaseName",
                databaseName
        );

        request.setAttribute(
                "databaseUrl",
                databaseUrl
        );

        request.setAttribute(
                "uploadDirectory",
                uploadDirectory
        );

        request.setAttribute(
                "tomcatHome",
                tomcatHome
        );

        request.setAttribute(
                "admin",
                admin
        );

        request.getRequestDispatcher(
                "/admin/settings.jsp"
        ).forward(request, response);
    }


    /*
     * ============================================================
     * POST
     * ============================================================
     */
    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        /*
         * Authentication check.
         */
        if (session == null ||
                session.getAttribute("adminUser") == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/login"
            );

            return;
        }

        AdminUser sessionAdmin =
                (AdminUser) session.getAttribute(
                        "adminUser"
                );

        String action =
                clean(request.getParameter("action"));


        /*
         * ========================================================
         * UPDATE PROFILE
         * ========================================================
         */
        if ("updateProfile".equals(action)) {

            updateProfile(
                    request,
                    response,
                    session,
                    sessionAdmin
            );

            return;
        }


        /*
         * ========================================================
         * CHANGE PASSWORD
         * ========================================================
         */
        if ("changePassword".equals(action)) {

            changePassword(
                    request,
                    response,
                    session,
                    sessionAdmin
            );

            return;
        }


        request.setAttribute(
                "errorMessage",
                "Invalid settings action."
        );

        doGet(request, response);
    }


    /*
     * ============================================================
     * UPDATE PROFILE
     * ============================================================
     */
    private void updateProfile(
            HttpServletRequest request,
            HttpServletResponse response,
            HttpSession session,
            AdminUser sessionAdmin)
            throws ServletException, IOException {

        String fullName =
                clean(request.getParameter("fullName"));

        String username =
                clean(request.getParameter("username"));


        /*
         * Validation.
         */
        if (fullName.isEmpty() ||
                username.isEmpty()) {

            request.setAttribute(
                    "errorMessage",
                    "Full name and username are required."
            );

            doGet(request, response);

            return;
        }


        if (fullName.length() > 150) {

            request.setAttribute(
                    "errorMessage",
                    "Full name must not exceed 150 characters."
            );

            doGet(request, response);

            return;
        }


        if (username.length() > 100) {

            request.setAttribute(
                    "errorMessage",
                    "Username must not exceed 100 characters."
            );

            doGet(request, response);

            return;
        }


        /*
         * Check username uniqueness.
         */
        if (settingsDAO.usernameExists(
                username,
                sessionAdmin.getId())) {

            request.setAttribute(
                    "errorMessage",
                    "That username is already being used."
            );

            doGet(request, response);

            return;
        }


        boolean updated =
                settingsDAO.updateProfile(
                        sessionAdmin.getId(),
                        username,
                        fullName
                );


        if (updated) {

            AdminUser updatedAdmin =
                    settingsDAO.getAdminById(
                            sessionAdmin.getId()
                    );

            session.setAttribute(
                    "adminUser",
                    updatedAdmin
            );

            request.setAttribute(
                    "successMessage",
                    "Administrator profile updated successfully."
            );

            System.out.println(
                    "RAHANU TECHNOLOGY: Administrator profile updated."
            );

        } else {

            request.setAttribute(
                    "errorMessage",
                    "Failed to update administrator profile."
            );
        }

        doGet(request, response);
    }


    /*
     * ============================================================
     * CHANGE PASSWORD
     * ============================================================
     */
    private void changePassword(
            HttpServletRequest request,
            HttpServletResponse response,
            HttpSession session,
            AdminUser sessionAdmin)
            throws ServletException, IOException {

        String currentPassword =
                request.getParameter("currentPassword");

        String newPassword =
                request.getParameter("newPassword");

        String confirmPassword =
                request.getParameter("confirmPassword");


        /*
         * Required fields.
         */
        if (currentPassword == null ||
                currentPassword.isEmpty() ||
                newPassword == null ||
                newPassword.isEmpty() ||
                confirmPassword == null ||
                confirmPassword.isEmpty()) {

            request.setAttribute(
                    "passwordError",
                    "All password fields are required."
            );

            doGet(request, response);

            return;
        }


        /*
         * Load latest administrator record.
         */
        AdminUser admin =
                settingsDAO.getAdminById(
                        sessionAdmin.getId()
                );

        if (admin == null) {

            session.invalidate();

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/login"
            );

            return;
        }


        /*
         * Verify current password.
         */
        boolean currentPasswordCorrect =
                PasswordUtil.verifyPassword(
                        currentPassword,
                        admin.getPasswordHash()
                );

        if (!currentPasswordCorrect) {

            request.setAttribute(
                    "passwordError",
                    "The current password is incorrect."
            );

            doGet(request, response);

            return;
        }


        /*
         * Minimum password length.
         */
        if (newPassword.length() < 8) {

            request.setAttribute(
                    "passwordError",
                    "The new password must contain at least 8 characters."
            );

            doGet(request, response);

            return;
        }


        /*
         * Make sure passwords match.
         */
        if (!newPassword.equals(confirmPassword)) {

            request.setAttribute(
                    "passwordError",
                    "The new passwords do not match."
            );

            doGet(request, response);

            return;
        }


        /*
         * Prevent using the same password.
         */
        if (PasswordUtil.verifyPassword(
                newPassword,
                admin.getPasswordHash())) {

            request.setAttribute(
                    "passwordError",
                    "The new password must be different from the current password."
            );

            doGet(request, response);

            return;
        }


        /*
         * Generate a new secure PBKDF2 hash.
         */
        String newPasswordHash =
                PasswordUtil.hashPassword(
                        newPassword
                );


        boolean updated =
                settingsDAO.updatePassword(
                        admin.getId(),
                        newPasswordHash
                );


        if (updated) {

            /*
             * Update password hash in the session object.
             */
            admin.setPasswordHash(
                    newPasswordHash
            );

            session.setAttribute(
                    "adminUser",
                    admin
            );

            request.setAttribute(
                    "passwordSuccess",
                    "Password changed successfully."
            );

            System.out.println(
                    "RAHANU TECHNOLOGY: Administrator password changed successfully."
            );

        } else {

            request.setAttribute(
                    "passwordError",
                    "Failed to change password."
            );
        }

        doGet(request, response);
    }


    /*
     * ============================================================
     * ENVIRONMENT VARIABLE
     * ============================================================
     */
    private String getEnvironment(
            String variable,
            String defaultValue) {

        String value =
                System.getenv(variable);

        if (value == null ||
                value.trim().isEmpty()) {

            return defaultValue;
        }

        return value.trim();
    }


    /*
     * ============================================================
     * CLEAN STRING
     * ============================================================
     */
    private String clean(String value) {

        if (value == null) {

            return "";
        }

        return value.trim();
    }
}

