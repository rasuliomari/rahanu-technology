<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="tz.rahanu.technology.model.TeamMember" %>

<%
List<TeamMember> teamMembers =
(List<TeamMember>) request.getAttribute("teamMembers");

String contextPath = request.getContextPath();

%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Our Team | RAHANU TECHNOLOGY</title>

<meta name="description"
      content="Meet the RAHANU TECHNOLOGY team.">

<!-- Bootstrap -->
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet">

<!-- Bootstrap Icons -->
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
    rel="stylesheet">

<!-- Main CSS -->
<link
    rel="stylesheet"
    href="<%= contextPath %>/css/style.css">

<!-- Team CSS -->
<link
    rel="stylesheet"
    href="<%= contextPath %>/css/team.css">

</head>

<body>

<!-- ========================================================= -->

<!-- NAVBAR -->

<!-- ========================================================= -->

<jsp:include page="includes/navbar.jsp"/>

<!-- ========================================================= -->

<!-- TEAM HERO -->

<!-- ========================================================= -->

<section class="team-hero">

<div class="container text-center">

    <div class="team-hero-content">

        <span class="team-label">

            <i class="bi bi-people-fill"></i>

            RAHANU TECHNOLOGY

        </span>

        <h1>

            Meet Our
            <span>Team</span>

        </h1>

        <p>

            Our team brings together software development,
            cybersecurity, networking and technology expertise
            to build reliable digital solutions.

        </p>

    </div>

</div>

</section>

<!-- ========================================================= -->

<!-- TEAM MEMBERS -->

<!-- ========================================================= -->

<section class="team-section">

<div class="container">

    <div class="text-center mb-5">

        <span class="text-primary fw-bold">
            OUR PEOPLE
        </span>

        <h2 class="fw-bold mt-2">
            Technology Professionals
        </h2>

        <p class="text-muted mx-auto"
           style="max-width: 700px;">

            Meet the people behind RAHANU TECHNOLOGY and the
            expertise they bring to our digital solutions.

        </p>

    </div>


    <div class="row g-4">


        <% if (teamMembers != null &&
               !teamMembers.isEmpty()) { %>


            <% for (TeamMember member : teamMembers) { %>

                <div class="col-md-6 col-lg-4">

                    <div class="team-card">


                        <!-- ================================================= -->
                        <!-- TEAM MEMBER PHOTO -->
                        <!-- ================================================= -->

                        <div class="team-image">

                            <%
                                String photo = member.getPhoto();

                                boolean hasPhoto =
                                        photo != null &&
                                        !photo.trim().isEmpty();
                            %>


                            <% if (hasPhoto) { %>

                                <img
                                    src="<%= contextPath %>/<%= photo %>"
                                    alt="Photo of <%= member.getFullName() %>"
                                    loading="lazy">

                            <% } else { %>

                                <div class="default-team-image">

                                    <i class="bi bi-person-circle"></i>

                                </div>

                            <% } %>


                            <!-- TEAM ROLE -->

                            <div class="team-role">

                                <%= member.getRoleType() != null &&
                                    !member.getRoleType().isBlank()
                                    ? member.getRoleType()
                                    : "TEAM MEMBER" %>

                            </div>

                        </div>


                        <!-- ================================================= -->
                        <!-- TEAM MEMBER INFORMATION -->
                        <!-- ================================================= -->

                        <div class="team-content">

                            <h4>
                                <%= member.getFullName() %>
                            </h4>


                            <h6>
                                <%= member.getPosition() %>
                            </h6>


                            <!-- BIOGRAPHY -->

                            <% if (member.getBiography() != null &&
                                   !member.getBiography().isBlank()) { %>

                                <p>
                                    <%= member.getBiography() %>
                                </p>

                            <% } %>


                            <!-- ================================================= -->
                            <!-- SKILLS -->
                            <!-- ================================================= -->

                            <% if (member.getSkills() != null &&
                                   !member.getSkills().isBlank()) { %>

                                <div class="team-skills">

                                    <%
                                        String[] skills =
                                                member.getSkills()
                                                      .split(",");

                                        for (String skill : skills) {

                                            skill = skill.trim();

                                            if (!skill.isEmpty()) {
                                    %>

                                        <span>
                                            <%= skill %>
                                        </span>

                                    <%
                                            }
                                        }
                                    %>

                                </div>

                            <% } %>


                            <!-- ================================================= -->
                            <!-- SOCIAL LINKS -->
                            <!-- ================================================= -->

                            <% if ((member.getLinkedinUrl() != null &&
                                   !member.getLinkedinUrl().isBlank())
                                   ||
                                   (member.getGithubUrl() != null &&
                                   !member.getGithubUrl().isBlank())) { %>

                                <div class="team-social">


                                    <!-- LinkedIn -->

                                    <% if (member.getLinkedinUrl() != null &&
                                           !member.getLinkedinUrl().isBlank()) { %>

                                        <a
                                            href="<%= member.getLinkedinUrl() %>"
                                            target="_blank"
                                            rel="noopener noreferrer"
                                            title="LinkedIn"
                                            aria-label="LinkedIn">

                                            <i class="bi bi-linkedin"></i>

                                        </a>

                                    <% } %>


                                    <!-- GitHub -->

                                    <% if (member.getGithubUrl() != null &&
                                           !member.getGithubUrl().isBlank()) { %>

                                        <a
                                            href="<%= member.getGithubUrl() %>"
                                            target="_blank"
                                            rel="noopener noreferrer"
                                            title="GitHub"
                                            aria-label="GitHub">

                                            <i class="bi bi-github"></i>

                                        </a>

                                    <% } %>


                                </div>

                            <% } %>

                        </div>

                    </div>

                </div>

            <% } %>


        <% } else { %>


            <!-- ================================================= -->
            <!-- NO TEAM MEMBERS -->
            <!-- ================================================= -->

            <div class="col-12">

                <div class="team-empty">

                    <i class="bi bi-people"></i>

                    <h4>
                        Our team information is currently unavailable.
                    </h4>

                    <p>
                        Please check back again later.
                    </p>

                </div>

            </div>


        <% } %>

    </div>

</div>

</section>

<!-- ========================================================= -->

<!-- CTA -->

<!-- ========================================================= -->

<section
    class="about-cta"
    style="
        padding: 90px 0;
        background: linear-gradient(135deg, #0d6efd, #084298);
        color: white;
    ">

<div class="container text-center">

    <i class="bi bi-chat-dots fs-1 mb-3"></i>

    <h2 class="fw-bold">
        Let's Build Something Together
    </h2>

    <p
        class="mx-auto"
        style="
            max-width: 650px;
            color: rgba(255,255,255,0.82);
            line-height: 1.8;
        ">

        Have a software, cybersecurity or technology project?
        Talk to our team about your requirements.

    </p>

    <a
        href="<%= contextPath %>/contact.jsp"
        class="btn btn-light btn-lg px-4">

        Contact Us

        <i class="bi bi-arrow-right ms-2"></i>

    </a>

</div>

</section>

<!-- ========================================================= -->

<!-- FOOTER -->

<!-- ========================================================= -->

<jsp:include page="includes/footer.jsp"/>

<!-- ========================================================= -->

<!-- BOOTSTRAP JS -->

<!-- ========================================================= -->

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>
