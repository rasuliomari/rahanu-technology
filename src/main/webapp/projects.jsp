<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Projects | RAHANU TECHNOLOGY</title>

<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet">

<link
    rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/projects.css">

</head>

<body>

<jsp:include page="includes/navbar.jsp"/>

<section class="projects-hero">

<div class="container">

    <div class="row justify-content-center text-center">

        <div class="col-lg-8">

            <span class="section-label">
                <i class="bi bi-code-square"></i>
                OUR WORK
            </span>

            <h1>
                Projects &amp;
                <span>Solutions</span>
            </h1>

            <p>
                Explore some of the digital products, software
                solutions and technology projects developed by
                RAHANU TECHNOLOGY.
            </p>

        </div>

    </div>

</div>

</section>

<section class="projects-section">

<div class="container">

    <div class="row g-4">

        <c:choose>

            <c:when test="${not empty projects}">

                <c:forEach var="project" items="${projects}">

                    <div class="col-lg-4 col-md-6">

                        <div class="project-card">

                            <div class="project-image">

                                <c:choose>

                                    <c:when test="${not empty project.image}">

                                        <img
                                            src="${project.image}"
                                            alt="${project.title}">

                                    </c:when>

                                    <c:otherwise>

                                        <div class="default-project-image">

                                            <i class="bi bi-code-slash"></i>

                                        </div>

                                    </c:otherwise>

                                </c:choose>

                                <c:if test="${not empty project.status}">

                                    <span class="project-status">
                                        ${project.status}
                                    </span>

                                </c:if>

                            </div>


                            <div class="project-content">

                                <c:if test="${project.featured}">

                                    <span class="featured-project">

                                        <i class="bi bi-star-fill"></i>
                                        Featured

                                    </span>

                                </c:if>


                                <h3>
                                    ${project.title}
                                </h3>


                                <p class="project-description">
                                    ${project.shortDescription}
                                </p>


                                <c:if test="${not empty project.technologies}">

                                    <div class="project-technologies">

                                        <c:forEach
                                            var="technology"
                                            items="${project.technologies.split(',')}">

                                            <span class="technology-badge">
                                                ${technology.trim()}
                                            </span>

                                        </c:forEach>

                                    </div>

                                </c:if>


                                <c:if test="${not empty project.projectDate}">

                                    <div class="project-date">

                                        <i class="bi bi-calendar3"></i>

                                        ${project.projectDate}

                                    </div>

                                </c:if>


                                <div class="project-actions">

                                    <a
                                        href="project?slug=${project.slug}"
                                        class="btn btn-project">

                                        <i class="bi bi-eye"></i>
                                        View Details

                                    </a>


                                    <c:if test="${not empty project.githubUrl}">

                                        <a
                                            href="${project.githubUrl}"
                                            target="_blank"
                                            rel="noopener noreferrer"
                                            class="btn btn-github"
                                            aria-label="GitHub">

                                            <i class="bi bi-github"></i>

                                        </a>

                                    </c:if>


                                    <c:if test="${not empty project.liveUrl}">

                                        <a
                                            href="${project.liveUrl}"
                                            target="_blank"
                                            rel="noopener noreferrer"
                                            class="btn btn-live"
                                            aria-label="Live Demo">

                                            <i class="bi bi-box-arrow-up-right"></i>

                                        </a>

                                    </c:if>

                                </div>

                            </div>

                        </div>

                    </div>

                </c:forEach>

            </c:when>

            <c:otherwise>

                <div class="col-12">

                    <div class="empty-projects">

                        <i class="bi bi-folder-x"></i>

                        <h3>No Projects Available</h3>

                        <p>
                            Our projects are currently being updated.
                            Please check again later.
                        </p>

                    </div>

                </div>

            </c:otherwise>

        </c:choose>

    </div>

</div>

</section>

<section class="projects-cta">

<div class="container">

    <div class="row justify-content-center text-center">

        <div class="col-lg-8">

            <i class="bi bi-lightbulb-fill cta-icon"></i>

            <h2>
                Have a Project in Mind?
            </h2>

            <p>
                Let's turn your idea into a secure, reliable
                and innovative digital solution.
            </p>

            <a
                href="contact.jsp"
                class="btn btn-light btn-lg">

                <i class="bi bi-chat-dots-fill"></i>
                Start a Conversation

            </a>

        </div>

    </div>

</div>

</section>

<jsp:include page="includes/footer.jsp"/>

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

<script src="js/main.js"></script>

</body>

</html>
