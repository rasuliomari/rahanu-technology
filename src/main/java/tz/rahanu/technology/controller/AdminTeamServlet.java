package tz.rahanu.technology.controller;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import tz.rahanu.technology.dao.TeamDAO;
import tz.rahanu.technology.model.TeamMember;

@WebServlet("/admin/team")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
public class AdminTeamServlet extends HttpServlet {

    private TeamDAO teamDAO;

    /*
     * Database stores this relative path.
     */
    private static final String UPLOAD_FOLDER = "uploads/team";

    /*
     * Permanent storage location.
     *
     * This directory is outside the Tomcat WAR so that
     * uploaded images are not deleted during redeployment.
     */
    private static final Path TEAM_UPLOAD_DIRECTORY =
            Paths.get("/opt/rahanu-technology-data/team");

    private static final String[] ALLOWED_EXTENSIONS = {
            ".jpg",
            ".jpeg",
            ".png",
            ".webp"
    };

    @Override
    public void init() {

        teamDAO = new TeamDAO();

        try {
            Files.createDirectories(TEAM_UPLOAD_DIRECTORY);

            System.out.println(
                    "RAHANU TECHNOLOGY: Team upload directory: "
                            + TEAM_UPLOAD_DIRECTORY
            );

        } catch (IOException e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Could not create team upload directory."
            );

            e.printStackTrace();
        }

        System.out.println(
                "RAHANU TECHNOLOGY: AdminTeamServlet initialized."
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

        if (!isAuthenticated(request)) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/login"
            );

            return;
        }

        String action =
                request.getParameter("action");

        if ("edit".equalsIgnoreCase(action)) {

            String idParameter =
                    request.getParameter("id");

            try {

                int id =
                        Integer.parseInt(idParameter);

                TeamMember member =
                        teamDAO.getById(id);

                if (member == null) {

                    request.getSession().setAttribute(
                            "errorMessage",
                            "Team member not found."
                    );

                    response.sendRedirect(
                            request.getContextPath()
                                    + "/admin/team"
                    );

                    return;
                }

                request.setAttribute(
                        "editMember",
                        member
                );

            } catch (NumberFormatException e) {

                request.getSession().setAttribute(
                        "errorMessage",
                        "Invalid team member ID."
                );

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/team"
                );

                return;
            }
        }

        request.setAttribute(
                "teamMembers",
                teamDAO.getAllMembers()
        );

        request.getRequestDispatcher(
                "/admin/team.jsp"
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

        if (!isAuthenticated(request)) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/login"
            );

            return;
        }

        request.setCharacterEncoding("UTF-8");

        String action =
                request.getParameter("action");

        if ("save".equalsIgnoreCase(action)) {

            saveTeamMember(
                    request,
                    response
            );

            return;
        }

        if ("toggle".equalsIgnoreCase(action)) {

            toggleTeamMember(
                    request,
                    response
            );

            return;
        }

        response.sendRedirect(
                request.getContextPath()
                        + "/admin/team"
        );
    }


    /*
     * ============================================================
     * SAVE TEAM MEMBER
     * ============================================================
     */
    private void saveTeamMember(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String idParameter =
                request.getParameter("id");

        String fullName =
                clean(request.getParameter("fullName"));

        String position =
                clean(request.getParameter("position"));

        String roleType =
                clean(request.getParameter("roleType"));

        String biography =
                clean(request.getParameter("biography"));

        String skills =
                clean(request.getParameter("skills"));

        String linkedinUrl =
                clean(request.getParameter("linkedinUrl"));

        String githubUrl =
                clean(request.getParameter("githubUrl"));

        String displayOrderParameter =
                request.getParameter("displayOrder");

        String activeParameter =
                request.getParameter("active");

        if (fullName.isEmpty() ||
                position.isEmpty()) {

            request.getSession().setAttribute(
                    "errorMessage",
                    "Full name and position are required."
            );

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/team"
            );

            return;
        }

        int displayOrder = 0;

        try {

            if (displayOrderParameter != null &&
                    !displayOrderParameter.trim().isEmpty()) {

                displayOrder =
                        Integer.parseInt(
                                displayOrderParameter
                        );
            }

        } catch (NumberFormatException e) {

            request.getSession().setAttribute(
                    "errorMessage",
                    "Display order must be a number."
            );

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/team"
            );

            return;
        }

        boolean active =
                "true".equalsIgnoreCase(activeParameter)
                        || "on".equalsIgnoreCase(activeParameter);


        /*
         * ========================================================
         * DETERMINE EDIT OR CREATE
         * ========================================================
         */

        boolean editing =
                idParameter != null &&
                        !idParameter.trim().isEmpty();

        TeamMember member;

        if (editing) {

            try {

                int id =
                        Integer.parseInt(idParameter);

                member =
                        teamDAO.getById(id);

                if (member == null) {

                    request.getSession().setAttribute(
                            "errorMessage",
                            "Team member not found."
                    );

                    response.sendRedirect(
                            request.getContextPath()
                                    + "/admin/team"
                    );

                    return;
                }

            } catch (NumberFormatException e) {

                request.getSession().setAttribute(
                        "errorMessage",
                        "Invalid team member ID."
                );

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/team"
                );

                return;
            }

        } else {

            member =
                    new TeamMember();
        }


        /*
         * ========================================================
         * SET TEAM MEMBER DATA
         * ========================================================
         */

        member.setFullName(fullName);
        member.setPosition(position);
        member.setRoleType(roleType);
        member.setBiography(biography);
        member.setSkills(skills);
        member.setLinkedinUrl(linkedinUrl);
        member.setGithubUrl(githubUrl);
        member.setDisplayOrder(displayOrder);
        member.setActive(active);


        /*
         * ========================================================
         * HANDLE IMAGE
         * ========================================================
         */

        Part imagePart =
                request.getPart("photo");

        String uploadedPhoto =
                saveUploadedPhoto(
                        imagePart
                );

        if (uploadedPhoto != null) {

            /*
             * New image uploaded.
             */
            member.setPhoto(uploadedPhoto);

        } else if (!editing) {

            /*
             * New member without an image.
             */
            member.setPhoto(
                    ""
            );
        }


        /*
         * ========================================================
         * SAVE DATABASE
         * ========================================================
         */

        boolean success;

        if (editing) {

            success =
                    teamDAO.update(member);

        } else {

            success =
                    teamDAO.insert(member);
        }


        if (success) {

            request.getSession().setAttribute(
                    "successMessage",
                    editing
                            ? "Team member updated successfully."
                            : "Team member added successfully."
            );

        } else {

            request.getSession().setAttribute(
                    "errorMessage",
                    "Failed to save team member."
            );
        }

        response.sendRedirect(
                request.getContextPath()
                        + "/admin/team"
        );
    }


    /*
     * ============================================================
     * SAVE UPLOADED PHOTO
     * ============================================================
     */
    private String saveUploadedPhoto(
            Part imagePart)
            throws IOException {

        if (imagePart == null) {

            return null;
        }

        String submittedFileName =
                imagePart.getSubmittedFileName();

        if (submittedFileName == null ||
                submittedFileName.trim().isEmpty()) {

            return null;
        }

        submittedFileName =
                Paths.get(submittedFileName)
                        .getFileName()
                        .toString();

        String extension =
                getExtension(submittedFileName);

        if (!isAllowedExtension(extension)) {

            throw new IllegalArgumentException(
                        "Invalid image type. "
                                + "Allowed types: JPG, JPEG, PNG and WEBP."
                );
        }

        if (imagePart.getSize() <= 0) {

            return null;
        }

        if (imagePart.getSize() > 5 * 1024 * 1024) {

           throw new IllegalArgumentException(
                        "Image is too large. Maximum size is 5 MB."
                );
        }


        /*
         * Generate a unique filename.
         */
        String filename =
                UUID.randomUUID()
                        .toString()
                        + extension;


        /*
         * Make sure the permanent directory exists.
         */
        Files.createDirectories(
                TEAM_UPLOAD_DIRECTORY
        );


        /*
         * Physical destination.
         */
        Path destination =
                TEAM_UPLOAD_DIRECTORY.resolve(filename);


        /*
         * Copy uploaded file.
         */
        try (InputStream inputStream =
                     imagePart.getInputStream()) {

            Files.copy(
                    inputStream,
                    destination,
                    StandardCopyOption.REPLACE_EXISTING
            );
        }


        System.out.println(
                "RAHANU TECHNOLOGY: Team photo saved: "
                        + destination
        );


        /*
         * Database path.
         */
        return UPLOAD_FOLDER
                + "/"
                + filename;
    }


    /*
     * ============================================================
     * TOGGLE ACTIVE STATUS
     * ============================================================
     */
    private void toggleTeamMember(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        String idParameter =
                request.getParameter("id");

        if (idParameter == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/team"
            );

            return;
        }

        try {

            int id =
                    Integer.parseInt(idParameter);

            TeamMember member =
                    teamDAO.getById(id);

            if (member == null) {

                request.getSession().setAttribute(
                        "errorMessage",
                        "Team member not found."
                );

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/team"
                );

                return;
            }

            boolean newStatus =
                    !member.isActive();

            boolean success =
                    teamDAO.setActive(
                            id,
                            newStatus
                    );

            if (success) {

                request.getSession().setAttribute(
                        "successMessage",
                        newStatus
                                ? "Team member activated."
                                : "Team member deactivated."
                );

            } else {

                request.getSession().setAttribute(
                        "errorMessage",
                        "Failed to change team member status."
                );
            }

        } catch (NumberFormatException e) {

            request.getSession().setAttribute(
                    "errorMessage",
                    "Invalid team member ID."
            );
        }

        response.sendRedirect(
                request.getContextPath()
                        + "/admin/team"
        );
    }


    /*
     * ============================================================
     * CHECK EXTENSION
     * ============================================================
     */
    private boolean isAllowedExtension(
            String extension) {

        for (String allowed :
                ALLOWED_EXTENSIONS) {

            if (allowed.equalsIgnoreCase(extension)) {

                return true;
            }
        }

        return false;
    }


    /*
     * ============================================================
     * GET EXTENSION
     * ============================================================
     */
    private String getExtension(
            String filename) {

        int dot =
                filename.lastIndexOf('.');

        if (dot < 0) {

            return "";
        }

        return filename.substring(dot)
                .toLowerCase();
    }


    /*
     * ============================================================
     * AUTHENTICATION
     * ============================================================
     */
    private boolean isAuthenticated(
            HttpServletRequest request) {

        HttpSession session =
                request.getSession(false);

        return session != null &&
                session.getAttribute(
                        "adminUser"
                ) != null;
    }


    /*
     * ============================================================
     * CLEAN STRING
     * ============================================================
     */
    private String clean(
            String value) {

        if (value == null) {

            return "";
        }

        return value.trim();
    }
}
