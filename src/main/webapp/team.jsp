<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c"
           uri="jakarta.tags.core" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Our Team | RAHANU TECHNOLOGY</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
        rel="stylesheet">

    <link
        rel="stylesheet"
        href="css/style.css">

    <link
        rel="stylesheet"
        href="css/team.css">

</head>


<body>


<!-- NAVBAR -->

<jsp:include page="includes/navbar.jsp"/>


<!-- TEAM HERO -->

<section class="team-hero">

    <div class="container">

        <div class="team-hero-content text-center">

            <span class="section-label">
                THE PEOPLE BEHIND RAHANU
            </span>

            <h1>
                Meet Our <span>Team</span>
            </h1>

            <p>
                A team of technology professionals committed to
                building innovative software solutions and helping
                organizations secure their digital environment.
            </p>

        </div>

    </div>

</section>


<!-- TEAM SECTION -->

<section class="team-section">

    <div class="container">


        <div class="row g-4 justify-content-center">


            <c:forEach
                    var="member"
                    items="${teamMembers}">

                <div class="col-xl-3 col-lg-4 col-md-6">

                    <div class="team-card">


                        <!-- PHOTO -->

                        <div class="team-image">

                            <c:choose>

                                <c:when test="${not empty member.photo}">

                                    <img
                                        src="images/team/${member.photo}"
                                        alt="${member.fullName}">

                                </c:when>

                                <c:otherwise>

                                    <div class="default-team-image">

                                        <i class="bi bi-person-fill"></i>

                                    </div>

                                </c:otherwise>

                            </c:choose>


                            <div class="team-role">

                                ${member.roleType}

                            </div>

                        </div>


                        <!-- CONTENT -->

                        <div class="team-content">

                            <h4>
                                ${member.fullName}
                            </h4>

                            <h6>
                                ${member.position}
                            </h6>

                            <p>
                                ${member.biography}
                            </p>


                            <!-- Skills -->

                            <c:if test="${not empty member.skills}">

                                <div class="team-skills">

                                    <c:forEach
                                            var="skill"
                                            items="${member.skills.split(',')}">

                                        <span>
                                            ${skill}
                                        </span>

                                    </c:forEach>

                                </div>

                            </c:if>


                            <!-- Social links -->

                            <div class="team-social">

                                <c:if test="${not empty member.linkedinUrl}">

                                    <a
                                        href="${member.linkedinUrl}"
                                        target="_blank">

                                        <i class="bi bi-linkedin"></i>

                                    </a>

                                </c:if>


                                <c:if test="${not empty member.githubUrl}">

                                    <a
                                        href="${member.githubUrl}"
                                        target="_blank">

                                        <i class="bi bi-github"></i>

                                    </a>

                                </c:if>

                            </div>

                        </div>

                    </div>

                </div>

            </c:forEach>


        </div>

    </div>

</section>


<!-- CTA -->

<section class="cta-section">

    <div class="container text-center">

        <span class="section-label">
            WORK WITH US
        </span>

        <h2>
            Let's Build Something Great
        </h2>

        <p>
            Have a technology project or security challenge?
            Let's discuss how RAHANU TECHNOLOGY can help.
        </p>

        <a
            href="contact.jsp"
            class="btn btn-primary btn-lg">

            Contact Us

            <i class="bi bi-arrow-right ms-2"></i>

        </a>

    </div>

</section>


<!-- FOOTER -->

<jsp:include page="includes/footer.jsp"/>


<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>