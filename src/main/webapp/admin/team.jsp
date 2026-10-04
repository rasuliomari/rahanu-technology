<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="tz.rahanu.technology.model.TeamMember" %>

<%
    List<TeamMember> teamMembers =
            (List<TeamMember>) request.getAttribute("teamMembers");

    TeamMember editMember =
            (TeamMember) request.getAttribute("editMember");

    String successMessage =
            (String) session.getAttribute("successMessage");

    String errorMessage =
            (String) session.getAttribute("errorMessage");

    session.removeAttribute("successMessage");
    session.removeAttribute("errorMessage");

    boolean editing = editMember != null;

    String contextPath =
            request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Team Management | RAHANU TECHNOLOGY</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
        rel="stylesheet">

    <style>

        body {
            background: #f5f7fb;
        }

        .admin-navbar {
            background: #0d6efd;
        }

        .admin-sidebar {
            min-height: calc(100vh - 56px);
            background: #111827;
        }

        .admin-sidebar a {
            color: #d1d5db;
            text-decoration: none;
            display: block;
            padding: 12px 18px;
            border-radius: 8px;
            margin-bottom: 4px;
        }

        .admin-sidebar a:hover,
        .admin-sidebar a.active {
            background: #1d4ed8;
            color: #ffffff;
        }

        .content-area {
            padding: 30px;
        }

        .card {
            border: none;
            border-radius: 14px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.06);
        }

        .team-photo {
            width: 65px;
            height: 65px;
            object-fit: cover;
            border-radius: 50%;
            border: 3px solid #e5e7eb;
        }

        .preview-photo {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 50%;
            border: 4px solid #e5e7eb;
        }

        .table td {
            vertical-align: middle;
        }

    </style>

</head>

<body>


<!-- ========================================================= -->
<!-- NAVBAR -->
<!-- ========================================================= -->

<nav class="navbar navbar-dark admin-navbar">

    <div class="container-fluid">

        <a class="navbar-brand fw-bold"
           href="<%= contextPath %>/admin/dashboard">

            <i class="bi bi-shield-lock-fill me-2"></i>

            RAHANU TECHNOLOGY

        </a>

        <a href="<%= contextPath %>/admin/logout"
           class="btn btn-light btn-sm">

            <i class="bi bi-box-arrow-right"></i>

            Logout

        </a>

    </div>

</nav>


<div class="container-fluid">

    <div class="row">


        <!-- ===================================================== -->
        <!-- SIDEBAR -->
        <!-- ===================================================== -->

        <div class="col-md-2 admin-sidebar p-3">

            <a href="<%= contextPath %>/admin/dashboard">

                <i class="bi bi-speedometer2 me-2"></i>

                Dashboard

            </a>


            <a href="<%= contextPath %>/admin/team"
               class="active">

                <i class="bi bi-people-fill me-2"></i>

                Team

            </a>


            <a href="<%= contextPath %>/admin/projects">

                <i class="bi bi-kanban-fill me-2"></i>

                Projects

            </a>


            <a href="<%= contextPath %>/admin/services">

                <i class="bi bi-grid-fill me-2"></i>

                Services

            </a>


            <a href="<%= contextPath %>/admin/messages">

                <i class="bi bi-envelope-fill me-2"></i>

                Messages

            </a>


            <a href="<%= contextPath %>/admin/settings">

                <i class="bi bi-gear-fill me-2"></i>

                Settings

            </a>


            <hr class="border-secondary">


            <a href="<%= contextPath %>/">

                <i class="bi bi-globe me-2"></i>

                View Website

            </a>

        </div>


        <!-- ===================================================== -->
        <!-- MAIN CONTENT -->
        <!-- ===================================================== -->

        <div class="col-md-10 content-area">


            <div class="d-flex justify-content-between align-items-center mb-4">

                <div>

                    <h2 class="fw-bold mb-1">

                        Team Management

                    </h2>

                    <p class="text-muted mb-0">

                        Manage RAHANU TECHNOLOGY team members and profile photos.

                    </p>

                </div>

            </div>


            <!-- ================================================= -->
            <!-- MESSAGES -->
            <!-- ================================================= -->

            <% if (successMessage != null) { %>

                <div class="alert alert-success alert-dismissible fade show">

                    <i class="bi bi-check-circle-fill me-2"></i>

                    <%= successMessage %>

                    <button type="button"
                            class="btn-close"
                            data-bs-dismiss="alert"></button>

                </div>

            <% } %>


            <% if (errorMessage != null) { %>

                <div class="alert alert-danger alert-dismissible fade show">

                    <i class="bi bi-exclamation-triangle-fill me-2"></i>

                    <%= errorMessage %>

                    <button type="button"
                            class="btn-close"
                            data-bs-dismiss="alert"></button>

                </div>

            <% } %>


            <div class="row g-4">


                <!-- ================================================= -->
                <!-- FORM -->
                <!-- ================================================= -->

                <div class="col-lg-5">

                    <div class="card">

                        <div class="card-body p-4">

                            <h5 class="fw-bold mb-4">

                                <i class="bi bi-person-plus-fill me-2"></i>

                                <%= editing
                                        ? "Edit Team Member"
                                        : "Add Team Member" %>

                            </h5>


                            <form
                                method="post"
                                action="<%= contextPath %>/admin/team"
                                enctype="multipart/form-data">


                                <input
                                    type="hidden"
                                    name="action"
                                    value="save">


                                <% if (editing) { %>

                                    <input
                                        type="hidden"
                                        name="id"
                                        value="<%= editMember.getId() %>">

                                <% } %>


                                <!-- NAME -->

                                <div class="mb-3">

                                    <label class="form-label fw-semibold">

                                        Full Name

                                    </label>

                                    <input
                                        type="text"
                                        name="fullName"
                                        class="form-control"
                                        required
                                        value="<%= editing
                                                ? editMember.getFullName()
                                                : "" %>">

                                </div>


                                <!-- POSITION -->

                                <div class="mb-3">

                                    <label class="form-label fw-semibold">

                                        Position

                                    </label>

                                    <input
                                        type="text"
                                        name="position"
                                        class="form-control"
                                        required
                                        value="<%= editing
                                                ? editMember.getPosition()
                                                : "" %>">

                                </div>


                                <!-- ROLE TYPE -->

                                <div class="mb-3">

                                    <label class="form-label fw-semibold">

                                        Role Type

                                    </label>

                                    <input
                                        type="text"
                                        name="roleType"
                                        class="form-control"
                                        placeholder="Founder / Developer / Engineer"
                                        value="<%= editing
                                                ? editMember.getRoleType()
                                                : "" %>">

                                </div>


                                <!-- BIOGRAPHY -->

                                <div class="mb-3">

                                    <label class="form-label fw-semibold">

                                        Biography

                                    </label>

                                    <textarea
                                        name="biography"
                                        class="form-control"
                                        rows="4"><%= editing
                                                ? editMember.getBiography()
                                                : "" %></textarea>

                                </div>


                                <!-- SKILLS -->

                                <div class="mb-3">

                                    <label class="form-label fw-semibold">

                                        Skills

                                    </label>

                                    <textarea
                                        name="skills"
                                        class="form-control"
                                        rows="3"
                                        placeholder="Java, PostgreSQL, Cybersecurity"><%= editing
                                                ? editMember.getSkills()
                                                : "" %></textarea>

                                </div>


                                <!-- PHOTO -->

                                <div class="mb-3">

                                    <label class="form-label fw-semibold">

                                        Profile Photo

                                    </label>

                                    <% if (editing &&
                                            editMember.getPhoto() != null &&
                                            !editMember.getPhoto().isBlank()) { %>

                                        <div class="mb-3">

                                            <img
                                                src="<%= contextPath %>/<%= editMember.getPhoto() %>"
                                                class="preview-photo"
                                                alt="Current profile photo">

                                        </div>

                                    <% } %>


                                    <input
                                        type="file"
                                        name="photo"
                                        class="form-control"
                                        accept=".jpg,.jpeg,.png,.webp">


                                    <div class="form-text">

                                        JPG, JPEG, PNG or WEBP. Maximum 5 MB.

                                        <% if (editing) { %>

                                            Leave empty to keep the current photo.

                                        <% } %>

                                    </div>

                                </div>


                                <!-- LINKEDIN -->

                                <div class="mb-3">

                                    <label class="form-label fw-semibold">

                                        LinkedIn URL

                                    </label>

                                    <input
                                        type="url"
                                        name="linkedinUrl"
                                        class="form-control"
                                        value="<%= editing
                                                ? editMember.getLinkedinUrl()
                                                : "" %>">

                                </div>


                                <!-- GITHUB -->

                                <div class="mb-3">

                                    <label class="form-label fw-semibold">

                                        GitHub URL

                                    </label>

                                    <input
                                        type="url"
                                        name="githubUrl"
                                        class="form-control"
                                        value="<%= editing
                                                ? editMember.getGithubUrl()
                                                : "" %>">

                                </div>


                                <!-- DISPLAY ORDER -->

                                <div class="mb-3">

                                    <label class="form-label fw-semibold">

                                        Display Order

                                    </label>

                                    <input
                                        type="number"
                                        name="displayOrder"
                                        class="form-control"
                                        value="<%= editing
                                                ? editMember.getDisplayOrder()
                                                : "0" %>">

                                </div>


                                <!-- ACTIVE -->

                                <div class="form-check mb-4">

                                    <input
                                        type="checkbox"
                                        name="active"
                                        value="true"
                                        class="form-check-input"
                                        id="activeMember"
                                        <%= !editing || editMember.isActive()
                                                ? "checked"
                                                : "" %>>

                                    <label
                                        class="form-check-label"
                                        for="activeMember">

                                        Show this member on the website

                                    </label>

                                </div>


                                <div class="d-flex gap-2">

                                    <button
                                        type="submit"
                                        class="btn btn-primary">

                                        <i class="bi bi-save me-1"></i>

                                        <%= editing
                                                ? "Update Member"
                                                : "Add Member" %>

                                    </button>


                                    <% if (editing) { %>

                                        <a
                                            href="<%= contextPath %>/admin/team"
                                            class="btn btn-secondary">

                                            Cancel

                                        </a>

                                    <% } %>

                                </div>

                            </form>

                        </div>

                    </div>

                </div>


                <!-- ================================================= -->
                <!-- TEAM TABLE -->
                <!-- ================================================= -->

                <div class="col-lg-7">

                    <div class="card">

                        <div class="card-body p-4">

                            <div class="d-flex justify-content-between mb-3">

                                <h5 class="fw-bold">

                                    Team Members

                                </h5>

                                <span class="badge bg-primary">

                                    <%= teamMembers == null
                                            ? 0
                                            : teamMembers.size() %>

                                </span>

                            </div>


                            <div class="table-responsive">

                                <table class="table align-middle">

                                    <thead>

                                    <tr>

                                        <th>Member</th>

                                        <th>Position</th>

                                        <th>Status</th>

                                        <th>Order</th>

                                        <th>Actions</th>

                                    </tr>

                                    </thead>

                                    <tbody>

                                    <% if (teamMembers != null &&
                                            !teamMembers.isEmpty()) { %>


                                        <% for (TeamMember member :
                                                teamMembers) { %>

                                            <tr>

                                                <td>

                                                    <div class="d-flex align-items-center">

                                                        <%
                                                            String photo =
                                                                    member.getPhoto();

                                                            if (photo == null ||
                                                                    photo.isBlank()) {

                                                                photo =
                                                                    "uploads/team/default-team.jpg";
                                                            }
                                                        %>

                                                        <img
                                                            src="<%= contextPath %>/<%= photo %>"
                                                            class="team-photo me-3"
                                                            alt="<%= member.getFullName() %>">

                                                        <div>

                                                            <div class="fw-bold">

                                                                <%= member.getFullName() %>

                                                            </div>

                                                            <small class="text-muted">

                                                                <%= member.getRoleType() == null
                                                                        ? ""
                                                                        : member.getRoleType() %>

                                                            </small>

                                                        </div>

                                                    </div>

                                                </td>


                                                <td>

                                                    <%= member.getPosition() %>

                                                </td>


                                                <td>

                                                    <% if (member.isActive()) { %>

                                                        <span class="badge bg-success">

                                                            Active

                                                        </span>

                                                    <% } else { %>

                                                        <span class="badge bg-secondary">

                                                            Inactive

                                                        </span>

                                                    <% } %>

                                                </td>


                                                <td>

                                                    <%= member.getDisplayOrder() %>

                                                </td>


                                                <td>

                                                    <div class="d-flex gap-1">


                                                        <a
                                                            href="<%= contextPath %>/admin/team?action=edit&id=<%= member.getId() %>"
                                                            class="btn btn-sm btn-outline-primary">

                                                            <i class="bi bi-pencil"></i>

                                                        </a>


                                                        <form
                                                            method="post"
                                                            action="<%= contextPath %>/admin/team"
                                                            class="d-inline">

                                                            <input
                                                                type="hidden"
                                                                name="action"
                                                                value="toggle">

                                                            <input
                                                                type="hidden"
                                                                name="id"
                                                                value="<%= member.getId() %>">


                                                            <button
                                                                type="submit"
                                                                class="btn btn-sm btn-outline-warning">

                                                                <% if (member.isActive()) { %>

                                                                    <i class="bi bi-eye-slash"></i>

                                                                <% } else { %>

                                                                    <i class="bi bi-eye"></i>

                                                                <% } %>

                                                            </button>

                                                        </form>

                                                    </div>

                                                </td>

                                            </tr>

                                        <% } %>


                                    <% } else { %>

                                        <tr>

                                            <td
                                                colspan="5"
                                                class="text-center text-muted py-4">

                                                No team members found.

                                            </td>

                                        </tr>

                                    <% } %>

                                    </tbody>

                                </table>

                            </div>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>


<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>