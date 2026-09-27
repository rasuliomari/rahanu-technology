<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        ${project.title} | RAHANU TECHNOLOGY
    </title>

    <!-- Bootstrap -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <!-- Main CSS -->
    <link rel="stylesheet" href="css/style.css">

    <!-- Project Details CSS -->
    <link rel="stylesheet" href="css/project-details.css">

</head>

<body>

<!-- ================= NAVBAR ================= -->

<jsp:include page="includes/navbar.jsp"/>


<!-- ================= PROJECT DETAILS ================= -->

<section class="project-details-section">

    <div class="container">

        <!-- BACK LINK -->

        <div class="project-back">

            <a href="projects">

                <i class="bi bi-arrow-left"></i>

                Back to Projects

            </a>

        </div>


        <div class="row g-5 align-items-start">

            <!-- ================= IMAGE ================= -->

            <div class="col-lg-6">

                <div class="details-image">

                    <c:choose>

                        <c:when test="${not empty project.image}">

                            <img
                                src="${project.image}"
                                alt="${project.title}">

                        </c:when>

                        <c:otherwise>

                            <div class="details-default-image">

                                <i class="bi bi-code-slash"></i>

                            </div>

                        </c:otherwise>

                    </c:choose>

                </div>

            </div>


            <!-- ================= INFORMATION ================= -->

            <div class="col-lg-6">

                <div class="project-details-content">

                    <!-- STATUS -->

                    <c:if test="${not empty project.status}">

                        <span class="details-status">

                            <i class="bi bi-circle-fill"></i>

                            ${project.status}

                        </span>

                    </c:if>


                    <!-- FEATURED -->

                    <c:if test="${project.featured}">

                        <div class="details-featured">

                            <i class="bi bi-star-fill"></i>

                            Featured Project

                        </div>

                    </c:if>


                    <!-- TITLE -->

                    <h1>
                        ${project.title}
                    </h1>


                    <!-- SHORT DESCRIPTION -->

                    <p class="details-short-description">

                        ${project.shortDescription}

                    </p>


                    <!-- DATE -->

                    <c:if test="${not empty project.projectDate}">

                        <div class="details-date">

                            <i class="bi bi-calendar3"></i>

                            Project Date:
                            ${project.projectDate}

                        </div>

                    </c:if>


                    <!-- TECHNOLOGIES -->

                    <c:if test="${not empty project.technologies}">

                        <div class="details-technologies">

                            <h5>
                                <i class="bi bi-stack"></i>
                                Technologies
                            </h5>

                            <div class="technology-list">

                                <c:forEach
                                    var="technology"
                                    items="${project.technologies.split(',')}">

                                    <span>

                                        ${technology.trim()}

                                    </span>

                                </c:forEach>

                            </div>

                        </div>

                    </c:if>


                    <!-- ACTION BUTTONS -->

                    <div class="details-actions">

                        <c:if test="${not empty project.githubUrl}">

                            <a
                                href="${project.githubUrl}"
                                target="_blank"
                                rel="noopener noreferrer"
                                class="btn btn-dark">

                                <i class="bi bi-github"></i>

                                GitHub

                            </a>

                        </c:if>


                        <c:if test="${not empty project.liveUrl}">

                            <a
                                href="${project.liveUrl}"
                                target="_blank"
                                rel="noopener noreferrer"
                                class="btn btn-primary">

                                <i class="bi bi-box-arrow-up-right"></i>

                                Live Demo

                            </a>

                        </c:if>

                    </div>

                </div>

            </div>

        </div>


        <!-- ================= DESCRIPTION ================= -->

        <div class="row mt-5">

            <div class="col-lg-10 mx-auto">

                <div class="full-description-card">

                    <h2>

                        <i class="bi bi-file-text"></i>

                        About This Project

                    </h2>

                    <div class="description-content">

                        <c:choose>

                            <c:when test="${not empty project.description}">

                                <p>
                                    ${project.description}
                                </p>

                            </c:when>

                            <c:otherwise>

                                <p>
                                    Detailed information about this
                                    project will be available soon.
                                </p>

                            </c:otherwise>

                        </c:choose>

                    </div>

                </div>

            </div>

        </div>


        <!-- ================= BOTTOM CTA ================= -->

        <div class="project-details-cta">

            <div class="row align-items-center">

                <div class="col-lg-8">

                    <h2>
                        Need a Similar Solution?
                    </h2>

                    <p>
                        RAHANU TECHNOLOGY can help transform your
                        idea into a reliable and secure digital
                        solution.
                    </p>

                </div>

                <div class="col-lg-4 text-lg-end">

                    <a
                        href="contact.jsp"
                        class="btn btn-primary btn-lg">

                        <i class="bi bi-chat-dots-fill"></i>

                        Contact Us

                    </a>

                </div>

            </div>

        </div>

    </div>

</section>


<!-- ================= FOOTER ================= -->

<jsp:include page="includes/footer.jsp"/>


<!-- Bootstrap JS -->

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

<script src="js/main.js"></script>

</body>

</html>
