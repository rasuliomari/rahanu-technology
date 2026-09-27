<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Messages | RAHANU TECHNOLOGY</title>

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

        .page-card {
            border: none;
            border-radius: 18px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.06);
        }

        .message-row {
            transition: 0.2s ease;
        }

        .message-row:hover {
            background: #f8f9fa;
        }

        .unread-row {
            font-weight: 600;
            background: #f0f6ff;
        }

        .subject-text {
            max-width: 250px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .message-actions {
            white-space: nowrap;
        }

        @media (max-width: 768px) {

            .main-content {
                padding: 20px 15px;
            }

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

                        <c:if test="${unreadMessageCount > 0}">
                            <span class="badge bg-danger float-end">
                                ${unreadMessageCount}
                            </span>
                        </c:if>

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


                <!-- HEADER -->
                <div class="d-flex justify-content-between
                            align-items-center mb-4">

                    <div>

                        <h2 class="fw-bold mb-1">
                            Contact Messages
                        </h2>

                        <p class="text-muted mb-0">
                            Manage messages submitted through the website.
                        </p>

                    </div>


                    <div class="text-end">

                        <span class="badge bg-primary rounded-pill px-3 py-2">

                            <i class="bi bi-envelope me-1"></i>

                            ${messages.size()} Messages

                        </span>

                    </div>

                </div>


                <!-- MESSAGE TABLE -->

                <div class="card page-card">

                    <div class="card-body p-0">

                        <c:choose>

                            <c:when test="${not empty messages}">

                                <div class="table-responsive">

                                    <table class="table table-hover
                                                  align-middle mb-0">

                                        <thead class="table-light">

                                        <tr>

                                            <th class="px-4">
                                                Status
                                            </th>

                                            <th>
                                                Name
                                            </th>

                                            <th>
                                                Email
                                            </th>

                                            <th>
                                                Subject
                                            </th>

                                            <th>
                                                Date
                                            </th>

                                            <th class="text-end px-4">
                                                Actions
                                            </th>

                                        </tr>

                                        </thead>


                                        <tbody>

                                        <c:forEach
                                                var="message"
                                                items="${messages}">

                                            <tr class="message-row
                                                ${!message.read ? 'unread-row' : ''}">

                                                <!-- STATUS -->
                                                <td class="px-4">

                                                    <c:choose>

                                                        <c:when test="${message.read}">

                                                            <span class="badge bg-success-subtle
                                                                         text-success">

                                                                <i class="bi bi-envelope-open me-1"></i>
                                                                Read

                                                            </span>

                                                        </c:when>

                                                        <c:otherwise>

                                                            <span class="badge bg-danger-subtle
                                                                         text-danger">

                                                                <i class="bi bi-envelope-fill me-1"></i>
                                                                Unread

                                                            </span>

                                                        </c:otherwise>

                                                    </c:choose>

                                                </td>


                                                <!-- NAME -->
                                                <td>

                                                    ${message.fullName}

                                                </td>


                                                <!-- EMAIL -->
                                                <td>

                                                    <a href="mailto:${message.email}"
                                                       class="text-decoration-none">

                                                        ${message.email}

                                                    </a>

                                                </td>


                                                <!-- SUBJECT -->
                                                <td>

                                                    <div class="subject-text">

                                                        ${message.subject}

                                                    </div>

                                                </td>


                                                <!-- DATE -->
                                                <td>

                                                    <small class="text-muted">

                                                        ${message.createdAt}

                                                    </small>

                                                </td>


                                                <!-- ACTIONS -->
                                                <td class="text-end px-4
                                                           message-actions">


                                                    <!-- VIEW -->
                                                    <a href="${pageContext.request.contextPath}/admin/messages?action=view&id=${message.id}"
                                                       class="btn btn-sm btn-primary">

                                                        <i class="bi bi-eye"></i>

                                                    </a>


                                                    <!-- READ / UNREAD -->
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

                                                                <button
                                                                        type="submit"
                                                                        class="btn btn-sm btn-outline-warning"
                                                                        title="Mark as unread">

                                                                    <i class="bi bi-envelope"></i>

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

                                                                <button
                                                                        type="submit"
                                                                        class="btn btn-sm btn-outline-success"
                                                                        title="Mark as read">

                                                                    <i class="bi bi-envelope-open"></i>

                                                                </button>

                                                            </form>

                                                        </c:otherwise>

                                                    </c:choose>


                                                    <!-- DELETE -->
                                                    <form method="post"
                                                          action="${pageContext.request.contextPath}/admin/messages"
                                                          class="d-inline"
                                                          onsubmit="return confirm('Are you sure you want to delete this message?');">

                                                        <input type="hidden"
                                                               name="action"
                                                               value="delete">

                                                        <input type="hidden"
                                                               name="id"
                                                               value="${message.id}">

                                                        <button
                                                                type="submit"
                                                                class="btn btn-sm btn-outline-danger"
                                                                title="Delete">

                                                            <i class="bi bi-trash"></i>

                                                        </button>

                                                    </form>

                                                </td>

                                            </tr>

                                        </c:forEach>

                                        </tbody>

                                    </table>

                                </div>

                            </c:when>


                            <c:otherwise>

                                <div class="text-center py-5">

                                    <i class="bi bi-envelope-open
                                              display-4 text-muted"></i>

                                    <h5 class="mt-3">
                                        No Messages
                                    </h5>

                                    <p class="text-muted">
                                        There are currently no contact messages.
                                    </p>

                                </div>

                            </c:otherwise>

                        </c:choose>

                    </div>

                </div>

            </main>

        </div>

    </div>

</div>


<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>
