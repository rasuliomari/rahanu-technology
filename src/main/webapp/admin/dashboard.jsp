<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Admin Dashboard | RAHANU TECHNOLOGY</title>


    <!-- Bootstrap 5.3.3 -->
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">


    <!-- Bootstrap Icons -->
    <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


    <style>

        * {
            box-sizing: border-box;
        }


        body {
            margin: 0;
            background: #f5f7fb;
            font-family: Arial, Helvetica, sans-serif;
        }


        /* ==============================
           SIDEBAR
           ============================== */

        .admin-sidebar {
            min-height: 100vh;
            background: #0d47a1;
            padding: 20px 15px;
        }


        .admin-brand {
            color: white;
            font-size: 1.25rem;
            font-weight: 700;
            letter-spacing: 0.5px;
        }


        .admin-brand-subtitle {
            color: rgba(255, 255, 255, 0.65);
            font-size: 0.75rem;
            letter-spacing: 1.5px;
        }


        .sidebar-link {
            color: rgba(255, 255, 255, 0.85);
            text-decoration: none;
            display: block;
            padding: 12px 15px;
            border-radius: 10px;
            margin-bottom: 5px;
            transition: all 0.2s ease;
        }


        .sidebar-link:hover {
            color: white;
            background: rgba(255, 255, 255, 0.12);
        }


        .sidebar-link.active {
            color: white;
            background: rgba(255, 255, 255, 0.18);
            font-weight: 600;
        }


        .sidebar-link i {
            width: 22px;
        }


        /* ==============================
           MAIN CONTENT
           ============================== */

        .main-content {
            padding: 30px;
        }


        .top-navbar {
            background: white;
            border-radius: 15px;
            padding: 15px 20px;
            margin-bottom: 30px;
            box-shadow: 0 4px 18px rgba(0, 0, 0, 0.05);
        }


        .admin-title {
            font-weight: 700;
            color: #212529;
        }


        .welcome-text {
            color: #6c757d;
        }


        /* ==============================
           STAT CARDS
           ============================== */

        .stat-link {
            text-decoration: none;
            color: inherit;
            display: block;
            height: 100%;
        }


        .stat-card {
            border: none;
            border-radius: 18px;
            background: white;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.06);
            transition: all 0.25s ease;
            height: 100%;
        }


        .stat-link:hover .stat-card {
            transform: translateY(-4px);
            box-shadow: 0 10px 28px rgba(0, 0, 0, 0.10);
        }


        .stat-label {
            color: #6c757d;
            font-size: 0.9rem;
            margin-bottom: 5px;
        }


        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: #212529;
        }


        .stat-icon {
            width: 52px;
            height: 52px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.35rem;
        }


        /* ==============================
           CONTENT CARDS
           ============================== */

        .content-card {
            border: none;
            border-radius: 18px;
            background: white;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.06);
        }


        .content-card h5 {
            font-weight: 700;
        }


        .quick-action {
            text-decoration: none;
            border-radius: 12px;
            padding: 15px;
            display: flex;
            align-items: center;
            gap: 12px;
            background: #f8f9fa;
            color: #212529;
            transition: all 0.2s ease;
        }


        .quick-action:hover {
            background: #eef4ff;
            color: #0d47a1;
            transform: translateY(-2px);
        }


        .quick-action-icon {
            width: 42px;
            height: 42px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
        }


        /* ==============================
           RESPONSIVE
           ============================== */

        @media (max-width: 991px) {

            .admin-sidebar {
                min-height: auto;
            }

            .main-content {
                padding: 20px 15px;
            }

        }


        @media (max-width: 576px) {

            .main-content {
                padding: 15px 10px;
            }

            .top-navbar {
                padding: 15px;
            }

            .stat-number {
                font-size: 1.7rem;
            }

        }

    </style>

</head>


<body>


<div class="container-fluid">

    <div class="row">


        <!-- =========================================
             SIDEBAR
             ========================================= -->

        <div class="col-lg-2 px-0">

            <aside class="admin-sidebar">


                <!-- BRAND -->

                <div class="mb-4 px-2">

                    <div class="admin-brand">

                        <i class="bi bi-cpu-fill me-2"></i>

                        RAHANU

                    </div>

                    <div class="admin-brand-subtitle">

                        TECHNOLOGY

                    </div>

                </div>


                <!-- NAVIGATION -->

                <nav>


                    <!-- DASHBOARD -->

                    <a href="${pageContext.request.contextPath}/admin/dashboard"
                       class="sidebar-link active">

                        <i class="bi bi-speedometer2 me-2"></i>

                        Dashboard

                    </a>


                    <!-- TEAM -->

                    <a href="${pageContext.request.contextPath}/admin/team"
                       class="sidebar-link">

                        <i class="bi bi-people-fill me-2"></i>

                        Team

                    </a>


                    <!-- PROJECTS -->

                    <a href="${pageContext.request.contextPath}/admin/projects"
                       class="sidebar-link">

                        <i class="bi bi-kanban-fill me-2"></i>

                        Projects

                    </a>


                    <!-- SERVICES -->

                    <a href="${pageContext.request.contextPath}/admin/services"
                       class="sidebar-link">

                        <i class="bi bi-grid-fill me-2"></i>

                        Services

                    </a>


                    <!-- MESSAGES -->

                    <a href="${pageContext.request.contextPath}/admin/messages"
                       class="sidebar-link">

                        <i class="bi bi-envelope-fill me-2"></i>

                        Messages

                        <c:if test="${unreadMessageCount > 0}">

                            <span class="badge bg-danger float-end">

                                ${unreadMessageCount}

                            </span>

                        </c:if>

                    </a>


                    <!-- SETTINGS -->

                    <a href="${pageContext.request.contextPath}/admin/settings"
                       class="sidebar-link">

                        <i class="bi bi-gear-fill me-2"></i>

                        Settings

                    </a>


                    <hr class="border-light opacity-25">


                    <!-- VIEW WEBSITE -->

                    <a href="${pageContext.request.contextPath}/"
                       class="sidebar-link">

                        <i class="bi bi-globe2 me-2"></i>

                        View Website

                    </a>


                    <!-- LOGOUT -->

                    <a href="${pageContext.request.contextPath}/admin/logout"
                       class="sidebar-link">

                        <i class="bi bi-box-arrow-right me-2"></i>

                        Logout

                    </a>


                </nav>

            </aside>

        </div>


        <!-- =========================================
             MAIN CONTENT
             ========================================= -->

        <div class="col-lg-10">

            <main class="main-content">


                <!-- TOP NAVBAR -->

                <div class="top-navbar
                            d-flex
                            justify-content-between
                            align-items-center">

                    <div>

                        <h4 class="admin-title mb-1">

                            Admin Dashboard

                        </h4>

                        <div class="welcome-text">

                            Welcome to RAHANU TECHNOLOGY administration.

                        </div>

                    </div>


                    <!-- ADMIN USER -->

                    <div class="text-end">

                        <div class="fw-semibold">

                            <i class="bi bi-person-circle me-1"></i>

                            <c:choose>

                                <c:when test="${not empty sessionScope.adminUser.fullName}">

                                    ${sessionScope.adminUser.fullName}

                                </c:when>

                                <c:otherwise>

                                    Administrator

                                </c:otherwise>

                            </c:choose>

                        </div>

                        <small class="text-muted">

                            Administrator

                        </small>

                    </div>

                </div>


                <!-- =========================================
                     STATISTICS
                     ========================================= -->

                <div class="row g-4 mb-4">


                    <!-- TEAM -->

                    <div class="col-md-6 col-xl-3">

                        <a href="${pageContext.request.contextPath}/admin/team"
                           class="stat-link">

                            <div class="card stat-card">

                                <div class="card-body p-4">

                                    <div class="d-flex
                                                justify-content-between
                                                align-items-start">

                                        <div>

                                            <div class="stat-label">

                                                Team Members

                                            </div>

                                            <div class="stat-number">

                                                ${teamCount}

                                            </div>

                                            <small class="text-muted">

                                                Active members

                                            </small>

                                        </div>


                                        <div class="stat-icon
                                                    bg-primary-subtle
                                                    text-primary">

                                            <i class="bi bi-people-fill"></i>

                                        </div>

                                    </div>

                                </div>

                            </div>

                        </a>

                    </div>


                    <!-- PROJECTS -->

                    <div class="col-md-6 col-xl-3">

                        <a href="${pageContext.request.contextPath}/admin/projects"
                           class="stat-link">

                            <div class="card stat-card">

                                <div class="card-body p-4">

                                    <div class="d-flex
                                                justify-content-between
                                                align-items-start">

                                        <div>

                                            <div class="stat-label">

                                                Projects

                                            </div>

                                            <div class="stat-number">

                                                ${projectCount}

                                            </div>

                                            <small class="text-muted">

                                                Total projects

                                            </small>

                                        </div>


                                        <div class="stat-icon
                                                    bg-success-subtle
                                                    text-success">

                                            <i class="bi bi-kanban-fill"></i>

                                        </div>

                                    </div>

                                </div>

                            </div>

                        </a>

                    </div>


                    <!-- SERVICES -->

                    <div class="col-md-6 col-xl-3">

                        <a href="${pageContext.request.contextPath}/admin/services"
                           class="stat-link">

                            <div class="card stat-card">

                                <div class="card-body p-4">

                                    <div class="d-flex
                                                justify-content-between
                                                align-items-start">

                                        <div>

                                            <div class="stat-label">

                                                Services

                                            </div>

                                            <div class="stat-number">

                                                ${serviceCount}

                                            </div>

                                            <small class="text-muted">

                                                Active services

                                            </small>

                                        </div>


                                        <div class="stat-icon
                                                    bg-warning-subtle
                                                    text-warning">

                                            <i class="bi bi-grid-fill"></i>

                                        </div>

                                    </div>

                                </div>

                            </div>

                        </a>

                    </div>


                    <!-- MESSAGES -->

                    <div class="col-md-6 col-xl-3">

                        <a href="${pageContext.request.contextPath}/admin/messages"
                           class="stat-link">

                            <div class="card stat-card">

                                <div class="card-body p-4">

                                    <div class="d-flex
                                                justify-content-between
                                                align-items-start">

                                        <div>

                                            <div class="stat-label">

                                                Messages

                                            </div>

                                            <div class="stat-number">

                                                ${messageCount}

                                            </div>


                                            <c:choose>

                                                <c:when test="${unreadMessageCount > 0}">

                                                    <small class="text-danger fw-semibold">

                                                        ${unreadMessageCount}
                                                        unread

                                                    </small>

                                                </c:when>


                                                <c:otherwise>

                                                    <small class="text-success">

                                                        All messages read

                                                    </small>

                                                </c:otherwise>

                                            </c:choose>

                                        </div>


                                        <div class="stat-icon
                                                    bg-danger-subtle
                                                    text-danger">

                                            <i class="bi bi-envelope-fill"></i>

                                        </div>

                                    </div>

                                </div>

                            </div>

                        </a>

                    </div>


                </div>


                <!-- =========================================
                     LOWER CONTENT
                     ========================================= -->

                <div class="row g-4">


                    <!-- QUICK ACTIONS -->

                    <div class="col-lg-8">

                        <div class="card content-card">

                            <div class="card-body p-4">

                                <h5 class="mb-1">

                                    Quick Actions

                                </h5>

                                <p class="text-muted mb-4">

                                    Quickly access the main management
                                    sections of your website.

                                </p>


                                <div class="row g-3">


                                    <!-- MESSAGES -->

                                    <div class="col-md-6">

                                        <a href="${pageContext.request.contextPath}/admin/messages"
                                           class="quick-action">

                                            <div class="quick-action-icon
                                                        bg-danger-subtle
                                                        text-danger">

                                                <i class="bi bi-envelope-fill"></i>

                                            </div>

                                            <div>

                                                <div class="fw-semibold">

                                                    View Messages

                                                </div>

                                                <small class="text-muted">

                                                    ${unreadMessageCount}
                                                    unread messages

                                                </small>

                                            </div>

                                        </a>

                                    </div>


                                    <!-- TEAM -->

                                    <div class="col-md-6">

                                        <a href="${pageContext.request.contextPath}/admin/team"
                                           class="quick-action">

                                            <div class="quick-action-icon
                                                        bg-primary-subtle
                                                        text-primary">

                                                <i class="bi bi-people-fill"></i>

                                            </div>

                                            <div>

                                                <div class="fw-semibold">

                                                    Manage Team

                                                </div>

                                                <small class="text-muted">

                                                    Manage team members

                                                </small>

                                            </div>

                                        </a>

                                    </div>


                                    <!-- PROJECTS -->

                                    <div class="col-md-6">

                                        <a href="${pageContext.request.contextPath}/admin/projects"
                                           class="quick-action">

                                            <div class="quick-action-icon
                                                        bg-success-subtle
                                                        text-success">

                                                <i class="bi bi-kanban-fill"></i>

                                            </div>

                                            <div>

                                                <div class="fw-semibold">

                                                    Manage Projects

                                                </div>

                                                <small class="text-muted">

                                                    Manage company projects

                                                </small>

                                            </div>

                                        </a>

                                    </div>


                                    <!-- SERVICES -->

                                    <div class="col-md-6">

                                        <a href="${pageContext.request.contextPath}/admin/services"
                                           class="quick-action">

                                            <div class="quick-action-icon
                                                        bg-warning-subtle
                                                        text-warning">

                                                <i class="bi bi-grid-fill"></i>

                                            </div>

                                            <div>

                                                <div class="fw-semibold">

                                                    Manage Services

                                                </div>

                                                <small class="text-muted">

                                                    Manage company services

                                                </small>

                                            </div>

                                        </a>

                                    </div>


                                </div>

                            </div>

                        </div>

                    </div>


                    <!-- SYSTEM INFORMATION -->

                    <div class="col-lg-4">

                        <div class="card content-card">

                            <div class="card-body p-4">

                                <h5 class="mb-1">

                                    System Overview

                                </h5>

                                <p class="text-muted mb-4">

                                    Current website content.

                                </p>


                                <div class="d-flex
                                            justify-content-between
                                            border-bottom
                                            pb-3 mb-3">

                                    <span class="text-muted">

                                        Team Members

                                    </span>

                                    <span class="fw-bold">

                                        ${teamCount}

                                    </span>

                                </div>


                                <div class="d-flex
                                            justify-content-between
                                            border-bottom
                                            pb-3 mb-3">

                                    <span class="text-muted">

                                        Projects

                                    </span>

                                    <span class="fw-bold">

                                        ${projectCount}

                                    </span>

                                </div>


                                <div class="d-flex
                                            justify-content-between
                                            border-bottom
                                            pb-3 mb-3">

                                    <span class="text-muted">

                                        Services

                                    </span>

                                    <span class="fw-bold">

                                        ${serviceCount}

                                    </span>

                                </div>


                                <div class="d-flex
                                            justify-content-between
                                            border-bottom
                                            pb-3 mb-3">

                                    <span class="text-muted">

                                        Messages

                                    </span>

                                    <span class="fw-bold">

                                        ${messageCount}

                                    </span>

                                </div>


                                <div class="d-flex
                                            justify-content-between">

                                    <span class="text-muted">

                                        Unread Messages

                                    </span>

                                    <span class="fw-bold text-danger">

                                        ${unreadMessageCount}

                                    </span>

                                </div>


                            </div>

                        </div>

                    </div>


                </div>


            </main>

        </div>

    </div>

</div>


<!-- Bootstrap JavaScript -->

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>


</body>

</html>
