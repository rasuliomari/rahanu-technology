<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Projects Management | RAHANU TECHNOLOGY</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

    <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>

        body {
            background: #f5f7fb;
            font-family: Arial, Helvetica, sans-serif;
        }

        .sidebar {
            min-height: 100vh;
            background: #0d47a1;
            padding: 20px 15px;
        }

        .brand {
            color: white;
            font-size: 1.3rem;
            font-weight: 700;
        }

        .brand-subtitle {
            color: rgba(255,255,255,.65);
            font-size: .75rem;
            letter-spacing: 1.5px;
        }

        .sidebar-link {
            color: rgba(255,255,255,.85);
            text-decoration: none;
            display: block;
            padding: 12px 15px;
            border-radius: 10px;
            margin-bottom: 5px;
        }

        .sidebar-link:hover,
        .sidebar-link.active {
            color: white;
            background: rgba(255,255,255,.18);
        }

        .main {
            padding: 30px;
        }

        .card {
            border: none;
            border-radius: 18px;
            box-shadow: 0 5px 20px rgba(0,0,0,.06);
        }

        @media(max-width:991px) {
            .sidebar {
                min-height: auto;
            }

            .main {
                padding: 20px 15px;
            }
        }

    </style>

</head>

<body>

<div class="container-fluid">

    <div class="row">

        <div class="col-lg-2 px-0">

            <aside class="sidebar">

                <div class="mb-4 px-2">

                    <div class="brand">
                        <i class="bi bi-cpu-fill me-2"></i>
                        RAHANU
                    </div>

                    <div class="brand-subtitle">
                        TECHNOLOGY
                    </div>

                </div>

                <a class="sidebar-link"
                   href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="bi bi-speedometer2 me-2"></i>
                    Dashboard
                </a>

                <a class="sidebar-link"
                   href="${pageContext.request.contextPath}/admin/team">
                    <i class="bi bi-people-fill me-2"></i>
                    Team
                </a>

                <a class="sidebar-link active"
                   href="${pageContext.request.contextPath}/admin/projects">
                    <i class="bi bi-folder-fill me-2"></i>
                    Projects
                </a>

                <a class="sidebar-link"
                   href="${pageContext.request.contextPath}/admin/services">
                    <i class="bi bi-gear-fill me-2"></i>
                    Services
                </a>

                <a class="sidebar-link"
                   href="${pageContext.request.contextPath}/admin/messages">
                    <i class="bi bi-envelope-fill me-2"></i>
                    Messages
                </a>

                <a class="sidebar-link"
                   href="${pageContext.request.contextPath}/">
                    <i class="bi bi-globe2 me-2"></i>
                    View Website
                </a>

                <a class="sidebar-link"
                   href="${pageContext.request.contextPath}/admin/logout">
                    <i class="bi bi-box-arrow-right me-2"></i>
                    Logout
                </a>

            </aside>

        </div>

        <div class="col-lg-10">

            <main class="main">

                <div class="mb-4">

                    <h2 class="fw-bold mb-1">
                        Projects Management
                    </h2>

                    <p class="text-muted">
                        Manage the projects displayed on RAHANU TECHNOLOGY.
                    </p>

                </div>

                <div class="card p-4 mb-4">

                    <h5 class="fw-bold mb-3">

                        <c:choose>

                            <c:when test="${not empty editProject}">
                                Edit Project
                            </c:when>

                            <c:otherwise>
                                Add Project
                            </c:otherwise>

                        </c:choose>

                    </h5>

                    <form method="post"
                          action="${pageContext.request.contextPath}/admin/projects">

                        <input type="hidden"
                               name="action"
                               value="save">

                        <c:if test="${not empty editProject}">

                            <input type="hidden"
                                   name="id"
                                   value="${editProject.id}">

                        </c:if>

                        <div class="row g-3">

                            <div class="col-md-6">

                                <label class="form-label">
                                    Project Title
                                </label>

                                <input type="text"
                                       name="title"
                                       class="form-control"
                                       required
                                       value="${editProject.title}">

                            </div>

                            <div class="col-md-6">

                                <label class="form-label">
                                    Slug
                                </label>

                                <input type="text"
                                       name="slug"
                                       class="form-control"
                                       required
                                       value="${editProject.slug}">

                            </div>

                            <div class="col-12">

                                <label class="form-label">
                                    Short Description
                                </label>

                                <textarea name="shortDescription"
                                          class="form-control"
                                          rows="2">${editProject.shortDescription}</textarea>

                            </div>

                            <div class="col-12">

                                <label class="form-label">
                                    Full Description
                                </label>

                                <textarea name="description"
                                          class="form-control"
                                          rows="4">${editProject.description}</textarea>

                            </div>

                            <div class="col-12">

                                <label class="form-label">
                                    Technologies
                                </label>

                                <textarea name="technologies"
                                          class="form-control"
                                          rows="2"
                                          placeholder="Java, JSP, PostgreSQL, Bootstrap">${editProject.technologies}</textarea>

                            </div>

                            <div class="col-md-4">

                                <label class="form-label">
                                    Image
                                </label>

                                <input type="text"
                                       name="image"
                                       class="form-control"
                                       value="${editProject.image}">

                            </div>

                            <div class="col-md-4">

                                <label class="form-label">
                                    GitHub URL
                                </label>

                                <input type="url"
                                       name="githubUrl"
                                       class="form-control"
                                       value="${editProject.githubUrl}">

                            </div>

                            <div class="col-md-4">

                                <label class="form-label">
                                    Live URL
                                </label>

                                <input type="url"
                                       name="liveUrl"
                                       class="form-control"
                                       value="${editProject.liveUrl}">

                            </div>

                            <div class="col-md-4">

                                <label class="form-label">
                                    Project Date
                                </label>

                                <input type="date"
                                       name="projectDate"
                                       class="form-control"
                                       value="${editProject.projectDate}">

                            </div>

                            <div class="col-md-4">

                                <label class="form-label">
                                    Status
                                </label>

                                <select name="status"
                                        class="form-select">

                                    <option value="In Development"
                                            ${editProject.status == 'In Development' ? 'selected' : ''}>
                                        In Development
                                    </option>

                                    <option value="Completed"
                                            ${editProject.status == 'Completed' ? 'selected' : ''}>
                                        Completed
                                    </option>

                                    <option value="Maintenance"
                                            ${editProject.status == 'Maintenance' ? 'selected' : ''}>
                                        Maintenance
                                    </option>

                                    <option value="Planned"
                                            ${editProject.status == 'Planned' ? 'selected' : ''}>
                                        Planned
                                    </option>

                                </select>

                            </div>

                            <div class="col-md-4">

                                <label class="form-label">
                                    Featured
                                </label>

                                <select name="featured"
                                        class="form-select">

                                    <option value="true"
                                            ${empty editProject || editProject.featured ? 'selected' : ''}>
                                        Yes
                                    </option>

                                    <option value="false"
                                            ${not empty editProject && not editProject.featured ? 'selected' : ''}>
                                        No
                                    </option>

                                </select>

                            </div>

                        </div>

                        <div class="mt-4">

                            <button class="btn btn-primary"
                                    type="submit">

                                <i class="bi bi-save me-1"></i>

                                Save Project

                            </button>

                            <c:if test="${not empty editProject}">

                                <a href="${pageContext.request.contextPath}/admin/projects"
                                   class="btn btn-secondary">

                                    Cancel

                                </a>

                            </c:if>

                        </div>

                    </form>

                </div>

                <div class="card">

                    <div class="card-body">

                        <h5 class="fw-bold mb-3">
                            Projects
                        </h5>

                        <div class="table-responsive">

                            <table class="table table-hover align-middle">

                                <thead>

                                <tr>
                                    <th>#</th>
                                    <th>Project</th>
                                    <th>Status</th>
                                    <th>Date</th>
                                    <th>Featured</th>
                                    <th>Actions</th>
                                </tr>

                                </thead>

                                <tbody>

                                <c:forEach
                                        var="project"
                                        items="${projects}">

                                    <tr>

                                        <td>
                                            ${project.id}
                                        </td>

                                        <td>

                                            <div class="fw-semibold">
                                                ${project.title}
                                            </div>

                                            <small class="text-muted">
                                                ${project.slug}
                                            </small>

                                        </td>

                                        <td>

                                            <span class="badge bg-primary">
                                                ${project.status}
                                            </span>

                                        </td>

                                        <td>
                                            ${project.projectDate}
                                        </td>

                                        <td>

                                            <c:choose>

                                                <c:when test="${project.featured}">
                                                    <span class="badge bg-success">
                                                        Featured
                                                    </span>
                                                </c:when>

                                                <c:otherwise>
                                                    <span class="badge bg-light text-dark">
                                                        No
                                                    </span>
                                                </c:otherwise>

                                            </c:choose>

                                        </td>

                                        <td>

                                            <a href="${pageContext.request.contextPath}/admin/projects?action=edit&id=${project.id}"
                                               class="btn btn-sm btn-outline-primary">

                                                <i class="bi bi-pencil"></i>

                                            </a>

                                            <form method="post"
                                                  action="${pageContext.request.contextPath}/admin/projects"
                                                  class="d-inline"
                                                  onsubmit="return confirm('Are you sure you want to delete this project?');">

                                                <input type="hidden"
                                                       name="action"
                                                       value="delete">

                                                <input type="hidden"
                                                       name="id"
                                                       value="${project.id}">

                                                <button type="submit"
                                                        class="btn btn-sm btn-outline-danger">

                                                    <i class="bi bi-trash"></i>

                                                </button>

                                            </form>

                                        </td>

                                    </tr>

                                </c:forEach>

                                <c:if test="${empty projects}">

                                    <tr>

                                        <td colspan="6"
                                            class="text-center text-muted py-4">

                                            No projects found.

                                        </td>

                                    </tr>

                                </c:if>

                                </tbody>

                            </table>

                        </div>

                    </div>

                </div>

            </main>

        </div>

    </div>

</div>

</body>

</html>
