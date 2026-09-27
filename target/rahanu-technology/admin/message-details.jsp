
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Message Details | RAHANU TECHNOLOGY</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

    <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>

        body {
            background: #f5f7fb;
            font-family: Arial, sans-serif;
        }

        .admin-sidebar {
            min-height: 100vh;
            background: #0d47a1;
        }

        .admin-brand {
            color: white;
            font-weight: 700;
            font-size: 1.2rem;
        }

        .sidebar-link {
            color: rgba(255, 255, 255, 0.85);
            text-decoration: none;
            display: block;
            padding: 12px 18px;
            border-radius: 10px;
            margin-bottom: 5px;
        }

        .sidebar-link:hover,
        .sidebar-link.active {
            color: white;
            background: rgba(255, 255, 255, 0.15);
        }

        .main-content {
            padding: 30px;
        }

        .message-card {
            border: none;
            border-radius: 18px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.06);
        }

        .message-content {
            white-space: pre-wrap;
            line-height: 1.8;
        }

        .info-label {
            font-size: 0.8rem;
            font-weight: 700;
            color: #6c757d;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

    </style>

</head>

<body>

<div class="container-fluid">

    <div class="row">

        <!-- SIDEBAR -->

        <div class="col-lg-2 px-0">

            <div class="admin-sidebar p-3">

                <div class="mb-4 px-2">

                    <div class="admin-brand">

                        <i class="bi bi-cpu-fill me-2"></i>

                        RAHANU

                    </div>

                    <small class="text-white-50">
                        TECHNOLOGY
                    </small>

                </div>


                <nav>

                    <a href="${pageContext.request.contextPath}/admin/dashboard"
                       class="sidebar-link">

                        <i class="bi bi-speedometer2 me-2"></i>
                        Dashboard

                    </a>


                    <a href="${pageContext.request.contextPath}/admin/team"
                       class="sidebar-link">

                        <i class="bi bi-people-fill me-2"></i>
                        Team

                    </a>


                    <a href="${pageContext.request.contextPath}/admin/projects"
                       class="sidebar-link">

                        <i class="bi bi-kanban-fill me-2"></i>
                        Projects

                    </a>


                    <a href="${pageContext.request.contextPath}/admin/services"
                       class="sidebar-link">

                        <i class="bi bi-grid-fill me-2"></i>
                        Services

                    </a>


                    <a href="${pageContext.request.contextPath}/admin/messages"
                       class="sidebar-link active">

                        <i class="bi bi-envelope-fill me-2"></i>
                        Messages

                    </a>


                    <a href="${pageContext.request.contextPath}/admin/settings"
                       class="sidebar-link">

                        <i class="bi bi-gear-fill me-2"></i>
                        Settings

                    </a>


                    <hr class="border-light opacity-25">


                    <a href="${pageContext.request.contextPath}/"
                       class="sidebar-link">

                        <i class="bi bi-globe2 me-2"></i>
                        View Website

                    </a>


                    <a href="${pageContext.request.contextPath}/admin/logout"
                       class="sidebar-link">

                        <i class="bi bi-box-arrow-right me-2"></i>
                        Logout

                    </a>

                </nav>

            </div>

        </div>


        <!-- MAIN CONTENT -->

        <div class="col-lg-10">

            <main class="main-content">

                <div class="mb-4">

                    <a href="${pageContext.request.contextPath}/admin/messages"
                       class="text-decoration-none">

                        <i class="bi bi-arrow-left me-1"></i>

                        Back to Messages

                    </a>

                </div>


                <c:if test="${not empty message}">

                    <div class="card message-card">

                        <div class="card-body p-4 p-lg-5">


                            <!-- HEADER -->

                            <div class="d-flex
                                        justify-content-between
                                        align-items-start
                                        mb-4">

                                <div>

                                    <h2 class="fw-bold mb-2">

                                        ${message.subject}

                                    </h2>

                                    <span class="badge
                                        ${message.read
                                            ? 'bg-success-subtle text-success'
                                            : 'bg-danger-subtle text-danger'}">

                                        <c:choose>

                                            <c:when test="${message.read}">
                                                <i class="bi bi-envelope-open me-1"></i>
                                                Read
                                            </c:when>

                                            <c:otherwise>
                                                <i class="bi bi-envelope-fill me-1"></i>
                                                Unread
                                            </c:otherwise>

                                        </c:choose>

                                    </span>

                                </div>


                                <small class="text-muted">

                                    ${message.createdAt}

                                </small>

                            </div>


                            <hr>


                            <!-- SENDER INFORMATION -->

                            <div class="row g-4 mb-4">

                                <div class="col-md-6">

                                    <div class="info-label mb-1">
                                        Sender
                                    </div>

                                    <div class="fs-5">

                                        <i class="bi bi-person-circle
                                                  me-2 text-primary"></i>

                                        ${message.fullName}

                                    </div>

                                </div>


                                <div class="col-md-6">

                                    <div class="info-label mb-1">
                                        Email
                                    </div>

                                    <div class="fs-5">

                                        <i class="bi bi-envelope me-2
                                                  text-primary"></i>

                                        <a href="mailto:${message.email}"
                                           class="text-decoration-none">

                                            ${message.email}

                                        </a>

                                    </div>

                                </div>


                                <c:if test="${not empty message.phone}">

                                    <div class="col-md-6">

                                        <div class="info-label mb-1">
                                            Phone
                                        </div>

                                        <div class="fs-5">

                                            <i class="bi bi-telephone me-2
                                                      text-primary"></i>

                                            ${message.phone}

                                        </div>

                                    </div>

                                </c:if>

                            </div>


                            <hr>


                            <!-- MESSAGE -->

                            <div class="mt-4">

                                <div class="info-label mb-2">
                                    Message
                                </div>

                                <div class="message-content fs-5">

                                    ${message.message}

                                </div>

                            </div>


                            <!-- ACTIONS -->

                            <div class="mt-5 pt-4 border-top">

                                <c:choose>

                                    <c:when test="${message.read}">

                                        <form method="post"
                                              action="${pageContext.request.contextPath}/admin/messages"
                                              class="d-inline">

                                            <input type="hidden"
                                                   name="action"
                                                   value="markUnread">

                                            <input type="hidden"
                                                   name="id"
                                                   value="${message.id}">

                                            <button type="submit"
                                                    class="btn btn-outline-warning">

                                                <i class="bi bi-envelope me-1"></i>

                                                Mark as Unread

                                            </button>

                                        </form>

                                    </c:when>

                                    <c:otherwise>

                                        <form method="post"
                                              action="${pageContext.request.contextPath}/admin/messages"
                                              class="d-inline">

                                            <input type="hidden"
                                                   name="action"
                                                   value="markRead">

                                            <input type="hidden"
                                                   name="id"
                                                   value="${message.id}">

                                            <button type="submit"
                                                    class="btn btn-success">

                                                <i class="bi bi-envelope-open me-1"></i>

                                                Mark as Read

                                            </button>

                                        </form>

                                    </c:otherwise>

                                </c:choose>


                                <a href="mailto:${message.email}"
                                   class="btn btn-primary ms-2">

                                    <i class="bi bi-reply-fill me-1"></i>

                                    Reply by Email

                                </a>


                                <form method="post"
                                      action="${pageContext.request.contextPath}/admin/messages"
                                      class="d-inline ms-2"
                                      onsubmit="return confirm('Are you sure you want to delete this message?');">

                                    <input type="hidden"
                                           name="action"
                                           value="delete">

                                    <input type="hidden"
                                           name="id"
                                           value="${message.id}">

                                    <button type="submit"
                                            class="btn btn-outline-danger">

                                        <i class="bi bi-trash me-1"></i>

                                        Delete

                                    </button>

                                </form>

                            </div>

                        </div>

                    </div>

                </c:if>

            </main>

        </div>

    </div>

</div>


<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>

