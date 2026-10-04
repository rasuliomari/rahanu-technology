<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>About Us | RAHANU TECHNOLOGY</title>

    <meta name="description"
          content="Learn about RAHANU TECHNOLOGY, our mission, vision and technology services.">

    <!-- Bootstrap -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
        rel="stylesheet">

    <!-- Main CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>

        .about-hero {
            padding: 160px 0 100px;
            background:
                linear-gradient(
                    135deg,
                    #07111f 0%,
                    #102b4a 100%
                );
            color: white;
        }

        .about-hero-content {
            max-width: 850px;
            margin: auto;
        }

        .about-label {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            border-radius: 50px;
            background: rgba(77, 171, 247, 0.12);
            border: 1px solid rgba(77, 171, 247, 0.25);
            color: #4dabf7;
            font-size: 0.85rem;
            font-weight: 700;
            letter-spacing: 1px;
        }

        .about-hero h1 {
            margin-top: 20px;
            font-size: clamp(2.5rem, 5vw, 4rem);
            font-weight: 850;
        }

        .about-hero h1 span {
            color: #4dabf7;
        }

        .about-hero p {
            max-width: 750px;
            margin: 20px auto 0;
            color: rgba(255,255,255,0.72);
            font-size: 1.1rem;
            line-height: 1.8;
        }

        .about-section {
            padding: 100px 0;
            background: #ffffff;
        }

        .about-section-alt {
            background: #f8fafc;
        }

        .about-section-label {
            color: #0d6efd;
            font-size: 0.85rem;
            font-weight: 800;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        .about-section h2 {
            margin-top: 10px;
            margin-bottom: 20px;
            color: #172b4d;
            font-size: 2.4rem;
            font-weight: 800;
        }

        .about-section p {
            color: #667085;
            line-height: 1.85;
        }

        .about-card {
            height: 100%;
            padding: 35px 30px;
            background: #ffffff;
            border: 1px solid #e7edf5;
            border-radius: 18px;
            box-shadow: 0 10px 30px rgba(20, 60, 100, 0.06);
            transition: all 0.3s ease;
        }

        .about-card:hover {
            transform: translateY(-7px);
            box-shadow: 0 18px 40px rgba(20, 60, 100, 0.12);
        }

        .about-icon {
            width: 65px;
            height: 65px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 22px;
            border-radius: 16px;
            background: linear-gradient(
                135deg,
                #0d6efd,
                #0a58ca
            );
            color: #ffffff;
            font-size: 1.8rem;
        }

        .about-card h4 {
            color: #172b4d;
            font-weight: 750;
            margin-bottom: 12px;
        }

        .about-card p {
            margin-bottom: 0;
        }

        .about-highlight {
            padding: 45px;
            border-radius: 22px;
            background:
                linear-gradient(
                    135deg,
                    #f1f7ff,
                    #e8f2ff
                );
            border: 1px solid #dceaff;
        }

        .about-highlight h3 {
            color: #172b4d;
            font-weight: 800;
            margin-bottom: 18px;
        }

        .about-highlight ul {
            padding-left: 0;
            list-style: none;
            margin-bottom: 0;
        }

        .about-highlight li {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            margin-bottom: 14px;
            color: #667085;
        }

        .about-highlight li i {
            color: #0d6efd;
            margin-top: 4px;
        }

        .about-cta {
            padding: 90px 0;
            background:
                linear-gradient(
                    135deg,
                    #0d6efd,
                    #084298
                );
            color: white;
        }

        .about-cta h2 {
            font-size: 2.4rem;
            font-weight: 800;
            margin-bottom: 15px;
        }

        .about-cta p {
            max-width: 700px;
            margin: 0 auto 30px;
            color: rgba(255,255,255,0.82);
            line-height: 1.8;
        }

        @media (max-width: 768px) {

            .about-hero {
                padding: 130px 0 75px;
            }

            .about-section {
                padding: 70px 0;
            }

            .about-section h2 {
                font-size: 2rem;
            }

            .about-highlight {
                padding: 30px 25px;
            }

            .about-cta {
                padding: 70px 0;
            }

            .about-cta h2 {
                font-size: 2rem;
            }

        }

    </style>

</head>

<body>

<!-- NAVBAR -->
<jsp:include page="includes/navbar.jsp"/>


<!-- ========================================================= -->
<!-- HERO -->
<!-- ========================================================= -->

<section class="about-hero">

    <div class="container text-center">

        <div class="about-hero-content">

            <span class="about-label">
                <i class="bi bi-building"></i>
                ABOUT RAHANU TECHNOLOGY
            </span>

            <h1>
                Building Technology.
                <span>Securing Tomorrow.</span>
            </h1>

            <p>
                RAHANU TECHNOLOGY is a technology company focused on
                software development, cybersecurity, digital forensics,
                networking and innovative digital solutions.
            </p>

        </div>

    </div>

</section>


<!-- ========================================================= -->
<!-- WHO WE ARE -->
<!-- ========================================================= -->

<section class="about-section">

    <div class="container">

        <div class="row align-items-center g-5">

            <div class="col-lg-6">

                <span class="about-section-label">
                    WHO WE ARE
                </span>

                <h2>
                    Technology Solutions Designed Around Real Needs
                </h2>

                <p>
                    RAHANU TECHNOLOGY provides technology solutions for
                    businesses, organizations, institutions and individuals.
                    Our work combines software development, cybersecurity
                    and digital technology to help our clients solve
                    practical problems.
                </p>

                <p>
                    We focus on creating modern, maintainable and
                    user-friendly systems while also helping organizations
                    understand and improve the security of their digital
                    infrastructure.
                </p>

            </div>

            <div class="col-lg-6">

                <div class="about-highlight">

                    <h3>
                        What We Focus On
                    </h3>

                    <ul>

                        <li>
                            <i class="bi bi-check-circle-fill"></i>
                            <span>
                                Modern websites and web applications
                            </span>
                        </li>

                        <li>
                            <i class="bi bi-check-circle-fill"></i>
                            <span>
                                Mobile application development
                            </span>
                        </li>

                        <li>
                            <i class="bi bi-check-circle-fill"></i>
                            <span>
                                Authorized penetration testing and security assessments
                            </span>
                        </li>

                        <li>
                            <i class="bi bi-check-circle-fill"></i>
                            <span>
                                Cybersecurity and technology solutions
                            </span>
                        </li>

                        <li>
                            <i class="bi bi-check-circle-fill"></i>
                            <span>
                                Digital forensic investigation and analysis
                            </span>
                        </li>

                        <li>
                            <i class="bi bi-check-circle-fill"></i>
                            <span>
                                Network and technology infrastructure support
                            </span>
                        </li>

                    </ul>

                </div>

            </div>

        </div>

    </div>

</section>


<!-- ========================================================= -->
<!-- MISSION / VISION -->
<!-- ========================================================= -->

<section class="about-section about-section-alt">

    <div class="container">

        <div class="row g-4">

            <div class="col-lg-6">

                <div class="about-card">

                    <div class="about-icon">
                        <i class="bi bi-bullseye"></i>
                    </div>

                    <h4>
                        Our Mission
                    </h4>

                    <p>
                        To create reliable digital solutions and provide
                        practical technology and cybersecurity services
                        that help organizations and individuals use
                        technology effectively and securely.
                    </p>

                </div>

            </div>

            <div class="col-lg-6">

                <div class="about-card">

                    <div class="about-icon">
                        <i class="bi bi-eye"></i>
                    </div>

                    <h4>
                        Our Vision
                    </h4>

                    <p>
                        To grow as a trusted technology company delivering
                        innovative software, cybersecurity and digital
                        solutions that contribute to a stronger digital
                        environment.
                    </p>

                </div>

            </div>

        </div>

    </div>

</section>


<!-- ========================================================= -->
<!-- VALUES -->
<!-- ========================================================= -->

<section class="about-section">

    <div class="container">

        <div class="text-center mb-5">

            <span class="about-section-label">
                OUR APPROACH
            </span>

            <h2>
                What Guides Our Work
            </h2>

        </div>

        <div class="row g-4">

            <div class="col-md-6 col-lg-4">

                <div class="about-card">

                    <div class="about-icon">
                        <i class="bi bi-shield-check"></i>
                    </div>

                    <h4>
                        Security
                    </h4>

                    <p>
                        We consider security an important part of
                        building and managing modern digital systems.
                    </p>

                </div>

            </div>

            <div class="col-md-6 col-lg-4">

                <div class="about-card">

                    <div class="about-icon">
                        <i class="bi bi-lightbulb"></i>
                    </div>

                    <h4>
                        Innovation
                    </h4>

                    <p>
                        We explore practical technologies and approaches
                        that can create useful digital solutions.
                    </p>

                </div>

            </div>

            <div class="col-md-6 col-lg-4">

                <div class="about-card">

                    <div class="about-icon">
                        <i class="bi bi-people"></i>
                    </div>

                    <h4>
                        Collaboration
                    </h4>

                    <p>
                        We work with clients and technology professionals
                        to understand requirements and develop effective
                        solutions.
                    </p>

                </div>

            </div>

        </div>

    </div>

</section>


<!-- ========================================================= -->
<!-- CTA -->
<!-- ========================================================= -->

<section class="about-cta">

    <div class="container text-center">

        <i class="bi bi-cpu-fill fs-1 mb-3"></i>

        <h2>
            Have a Technology Project?
        </h2>

        <p>
            Let's discuss your requirements and explore how RAHANU
            TECHNOLOGY can help turn your idea into a practical
            digital solution.
        </p>

        <a href="${pageContext.request.contextPath}/contact.jsp"
           class="btn btn-light btn-lg px-4">

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