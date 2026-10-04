<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Admin Settings | RAHANU TECHNOLOGY</title>

    <!-- Bootstrap -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>

        body {
            background: #f5f7fb;
            font-family: Arial, sans-serif;
        }

        .admin-wrapper {
            min-height: 100vh;
        }

        /* =====================================================
           SIDEBAR
           ===================================================== */

        .sidebar {
            width: 250px;
            min-height: 100vh;
            background: #0d47a1;
            position: fixed;
            left: 0;
            top: 0;
            padding: 25px 15px;
            z-index: 1000;
        }

        .brand {
            color: white;
            font-size: 20px;
            font-weight: 700;
            text-align: center;
            margin-bottom: 35px;
        }

        .brand i {
            margin-right: 8px;
        }

        .sidebar-link {
            display: flex;
            align-items: center;
            gap: 12px;
            color: rgba(255,255,255,0.85);
            text-decoration: none;
            padding: 13px 15px;
            border-radius: 10px;
            margin-bottom: 7px;
            transition: 0.2s;
        }

        .sidebar-link:hover,
        .sidebar-link.active {
            background: rgba(255,255,255,0.15);
            color: white;
        }

        .sidebar-link i {
            font-size: 18px;
        }

        /* =====================================================
           MAIN CONTENT
           ===================================================== */

        .main-content {
            margin-left: 250px;
            padding: 25px;
        }

        .topbar {
            background: white;
            border-radius: 15px;
            padding: 18px 22px;
            margin-bottom: 25px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.04);
        }

        .page-title {
            font-size: 24px;
            font-weight: 700;
            margin: 0;
            color: #1f2937;
        }

        .page-subtitle {
            color: #6b7280;
            margin: 4px 0 0;
        }

        /* =====================================================
           CARDS
           ===================================================== */

        .settings-card {
            background: white;
            border-radius: 18px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 4px 18px rgba(0,0,0,0.05);
        }

        .settings-card h5 {
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 5px;
        }

        .settings-card .card-description {
            color: #6b7280;
            font-size: 14px;
            margin-bottom: 22px;
        }

        .section-icon {
            width: 45px;
            height: 45px;
            border-radius: 12px;
            background: #e3f2fd;
            color: #0d47a1;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            flex-shrink: 0;
        }

        .section-heading {
            display: flex;
            align-items: center;
            gap: 13px;
            margin-bottom: 20px;
        }

        .form-label {
            font-weight: 600;
            color: #374151;
        }

        .form-control {
            border-radius: 10px;
            padding: 11px 13px;
            border: 1px solid #dbe1ea;
        }

        .form-control:focus {
            border-color: #0d47a1;
            box-shadow: 0 0 0 0.2rem rgba(13,71,161,0.10);
        }

        .btn-primary {
            background: #0d47a1;
            border-color: #0d47a1;
            border-radius: 10px;
            padding: 10px 18px;
        }

        .btn-primary:hover {
            background: #083579;
            border-color: #083579;
        }

        /* =====================================================
           SYSTEM INFORMATION
           ===================================================== */

        .info-row {
            display: flex;
            justify-content: space-between;
            gap: 20px;
            padding: 13px 0;
            border-bottom: 1px solid #edf0f5;
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-label {
            color: #6b7280;
            font-weight: 600;
        }

        .info-value {
            color: #1f2937;
            text-align: right;
            word-break: break-word;
        }

        .status-badge {
            display: inline-block;
            background: #d1fae5;
            color: #065f46;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        /* =====================================================
           QUICK ACTIONS
           ===================================================== */

        .quick-action {
            display: flex;
            align-items: center;
            gap: 13px;
            text-decoration: none;
            color: #374151;
            background: #f8fafc;
            padding: 14px;
            border-radius: 12px;
            margin-bottom: 10px;
            transition: 0.2s;
        }

        .quick-action:hover {
            background: #eef4ff;
            color: #0d47a1;
        }

        .quick-action i {
            font-size: 19px;
            color: #0d47a1;
        }

        /* =====================================================
           RESPONSIVE
           ===================================================== */

        @media (max-width: 991px) {

            .sidebar {
                position: relative;
                width: 100%;
                min-height: auto;
            }

            .main-content {
                margin-left: 0;
            }

        }

        @media (max-width: 576px) {

            .main-content {
                padding: 15px;
            }

            .settings-card {
                padding: 18px;
            }

            .info-row {
                flex-direction: column;
                gap: 5px;
            }

            .info-value {
                text-align: left;
            }

            .page-title {
                font-size: 21px;
            }
        }

    </style>

</head>

<body>

<div class="admin-wrapper">

    <!-- =====================================================
         SIDEBAR
         ===================================================== -->

    <aside class="sidebar">

        <div class="brand">
            <i class="bi bi-shield-lock-fill"></i>
            RAHANU ADMIN
        </div>

        <a href="${pageContext.request.contextPath}/admin/dashboard"
           class="sidebar-link">

            <i class="bi bi-speedometer2"></i>
            <span>Dashboard</span>

        </a>

        <a href="${pageContext.request.contextPath}/admin/team"
           class="sidebar-link">

            <i class="bi bi-people-fill"></i>
            <span>Team</span>

        </a>

        <a href="${pageContext.request.contextPath}/admin/projects"
           class="sidebar-link">

            <i class="bi bi-kanban-fill"></i>
            <span>Projects</span>

        </a>

        <a href="${pageContext.request.contextPath}/admin/services"
           class="sidebar-link">

            <i class="bi bi-grid-fill"></i>
            <span>Services</span>

        </a>

        <a href="${pageContext.request.contextPath}/admin/messages"
           class="sidebar-link">

            <i class="bi bi-envelope-fill"></i>
            <span>Messages</span>

        </a>

        <a href="${pageContext.request.contextPath}/admin/settings"
           class="sidebar-link active">

            <i class="bi bi-gear-fill"></i>
            <span>Settings</span>

        </a>

        <a href="${pageContext.request.contextPath}/admin/logout"
           class="sidebar-link">

            <i class="bi bi-box-arrow-right"></i>
            <span>Logout</span>

        </a>

    </aside>


    <!-- =====================================================
         MAIN CONTENT
         ===================================================== -->

    <main class="main-content">

        <!-- TOP BAR -->

        <div class="topbar">

            <h1 class="page-title">
                <i class="bi bi-gear-fill text-primary"></i>
                Admin Settings
            </h1>

            <p class="page-subtitle">
                Manage your administrator account and system information.
            </p>

        </div>


        <!-- =================================================
             SUCCESS / ERROR MESSAGES
             ================================================= -->

        <c:if test="${not empty successMessage}">

            <div class="alert alert-success alert-dismissible fade show"
                 role="alert">

                <i class="bi bi-check-circle-fill me-2"></i>

                ${successMessage}

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="alert">
                </button>

            </div>

        </c:if>


        <c:if test="${not empty errorMessage}">

            <div class="alert alert-danger alert-dismissible fade show"
                 role="alert">

                <i class="bi bi-exclamation-triangle-fill me-2"></i>

                ${errorMessage}

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="alert">
                </button>

            </div>

        </c:if>


        <div class="row">

            <!-- =================================================
                 LEFT COLUMN
                 ================================================= -->

            <div class="col-lg-8">


                <!-- =============================================
                     ADMINISTRATOR PROFILE
                     ============================================= -->

                <div class="settings-card">

                    <div class="section-heading">

                        <div class="section-icon">
                            <i class="bi bi-person-fill"></i>
                        </div>

                        <div>

                            <h5>
                                Administrator Profile
                            </h5>

                            <div class="card-description mb-0">
                                Update your administrator account information.
                            </div>

                        </div>

                    </div>


                    <form method="post"
                          action="${pageContext.request.contextPath}/admin/settings">

                        <input type="hidden"
                               name="action"
                               value="updateProfile">


                        <div class="row g-3">

                            <div class="col-md-6">

                                <label class="form-label">
                                    Full Name
                                </label>

                                <input type="text"
                                       name="fullName"
                                       class="form-control"
                                       value="${admin.fullName}"
                                       maxlength="150"
                                       required>

                            </div>


                            <div class="col-md-6">

                                <label class="form-label">
                                    Username
                                </label>

                                <input type="text"
                                       name="username"
                                       class="form-control"
                                       value="${admin.username}"
                                       maxlength="100"
                                       required>

                            </div>


                            <div class="col-12">

                                <label class="form-label">
                                    Account Status
                                </label>

                                <div>

                                    <c:choose>

                                        <c:when test="${admin.active}">

                                            <span class="status-badge">
                                                <i class="bi bi-check-circle-fill me-1"></i>
                                                Active
                                            </span>

                                        </c:when>

                                        <c:otherwise>

                                            <span class="badge bg-danger">
                                                Inactive
                                            </span>

                                        </c:otherwise>

                                    </c:choose>

                                </div>

                            </div>


                            <div class="col-12">

                                <button type="submit"
                                        class="btn btn-primary">

                                    <i class="bi bi-save me-1"></i>
                                    Save Profile

                                </button>

                            </div>

                        </div>

                    </form>

                </div>


                <!-- =============================================
                     CHANGE PASSWORD
                     ============================================= -->

                <div class="settings-card">

                    <div class="section-heading">

                        <div class="section-icon">
                            <i class="bi bi-key-fill"></i>
                        </div>

                        <div>

                            <h5>
                                Change Password
                            </h5>

                            <div class="card-description mb-0">
                                Change the password used to access the admin panel.
                            </div>

                        </div>

                    </div>


                    <c:if test="${not empty passwordSuccess}">

                        <div class="alert alert-success">

                            <i class="bi bi-check-circle-fill me-2"></i>

                            ${passwordSuccess}

                        </div>

                    </c:if>


                    <c:if test="${not empty passwordError}">

                        <div class="alert alert-danger">

                            <i class="bi bi-exclamation-triangle-fill me-2"></i>

                            ${passwordError}

                        </div>

                    </c:if>


                    <form method="post"
                          action="${pageContext.request.contextPath}/admin/settings">

                        <input type="hidden"
                               name="action"
                               value="changePassword">


                        <div class="mb-3">

                            <label class="form-label">
                                Current Password
                            </label>

                            <input type="password"
                                   name="currentPassword"
                                   class="form-control"
                                   autocomplete="current-password"
                                   required>

                        </div>


                        <div class="mb-3">

                            <label class="form-label">
                                New Password
                            </label>

                            <input type="password"
                                   name="newPassword"
                                   class="form-control"
                                   minlength="8"
                                   autocomplete="new-password"
                                   required>

                            <div class="form-text">
                                Minimum 8 characters.
                            </div>

                        </div>


                        <div class="mb-4">

                            <label class="form-label">
                                Confirm New Password
                            </label>

                            <input type="password"
                                   name="confirmPassword"
                                   class="form-control"
                                   minlength="8"
                                   autocomplete="new-password"
                                   required>

                        </div>


                        <button type="submit"
                                class="btn btn-primary">

                            <i class="bi bi-shield-lock me-1"></i>
                            Change Password

                        </button>

                    </form>

                </div>

            </div>


            <!-- =================================================
                 RIGHT COLUMN
                 ================================================= -->

            <div class="col-lg-4">


                <!-- =============================================
                     SYSTEM INFORMATION
                     ============================================= -->

                <div class="settings-card">

                    <div class="section-heading">

                        <div class="section-icon">
                            <i class="bi bi-server"></i>
                        </div>

                        <div>

                            <h5>
                                System Information
                            </h5>

                            <div class="card-description mb-0">
                                Current application configuration.
                            </div>

                        </div>

                    </div>


                    <div class="info-row">

                        <div class="info-label">
                            Application
                        </div>

                        <div class="info-value">
                            ${applicationName}
                        </div>

                    </div>


                    <div class="info-row">

                        <div class="info-label">
                            Database
                        </div>

                        <div class="info-value">
                            ${databaseName}
                        </div>

                    </div>


                    <div class="info-row">

                        <div class="info-label">
                            Database URL
                        </div>

                        <div class="info-value small">
                            ${databaseUrl}
                        </div>

                    </div>


                    <div class="info-row">

                        <div class="info-label">
                            Team Uploads
                        </div>

                        <div class="info-value small">
                            ${uploadDirectory}
                        </div>

                    </div>


                    <div class="info-row">

                        <div class="info-label">
                            Tomcat
                        </div>

                        <div class="info-value small">
                            ${tomcatHome}
                        </div>

                    </div>


                    <div class="info-row">

                        <div class="info-label">
                            Status
                        </div>

                        <div class="info-value">

                            <span class="status-badge">
                                <i class="bi bi-check-circle-fill me-1"></i>
                                Online
                            </span>

                        </div>

                    </div>

                </div>


                <!-- =============================================
                     QUICK ACTIONS
                     ============================================= -->

                <div class="settings-card">

                    <div class="section-heading">

                        <div class="section-icon">
                            <i class="bi bi-lightning-fill"></i>
                        </div>

                        <div>

                            <h5>
                                Quick Actions
                            </h5>

                            <div class="card-description mb-0">
                                Frequently used administrator actions.
                            </div>

                        </div>

                    </div>


                    <a href="${pageContext.request.contextPath}/admin/dashboard"
                       class="quick-action">

                        <i class="bi bi-speedometer2"></i>

                        <span>
                            Back to Dashboard
                        </span>

                    </a>


                    <a href="${pageContext.request.contextPath}/admin/logout"
                       class="quick-action">

                        <i class="bi bi-box-arrow-right"></i>

                        <span>
                            Logout
                        </span>

                    </a>

                </div>

            </div>

        </div>

    </main>

</div>


<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>

