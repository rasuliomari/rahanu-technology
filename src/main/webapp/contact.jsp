
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Contact Us | RAHANU TECHNOLOGY</title>

    <!-- Bootstrap 5.3.3 -->
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
            href="${pageContext.request.contextPath}/css/style.css">

    <style>

        /* =====================================================
           CONTACT PAGE
        ===================================================== */

        .contact-hero {
            background:
                linear-gradient(
                    135deg,
                    rgba(13, 110, 253, 0.95),
                    rgba(8, 66, 152, 0.95)
                );

            color: white;
            padding: 100px 0 80px;
        }

        .contact-hero h1 {
            font-weight: 800;
            font-size: 3rem;
        }

        .contact-hero p {
            max-width: 700px;
            margin: 20px auto 0;
            opacity: 0.9;
            font-size: 1.1rem;
        }

        .contact-section {
            padding: 80px 0;
            background: #f8f9fa;
        }

        .contact-card {
            background: white;
            border: none;
            border-radius: 20px;
            box-shadow: 0 10px 35px rgba(0, 0, 0, 0.08);
            height: 100%;
        }

        .contact-card .card-body {
            padding: 35px;
        }

        .contact-info-item {
            display: flex;
            align-items: flex-start;
            gap: 18px;
            margin-bottom: 28px;
        }

        .contact-icon {
            width: 52px;
            height: 52px;
            min-width: 52px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 14px;

            background: rgba(13, 110, 253, 0.1);
            color: #0d6efd;

            font-size: 1.35rem;
        }

        .contact-info-item h6 {
            margin-bottom: 5px;
            font-weight: 700;
        }

        .contact-info-item p {
            margin: 0;
            color: #6c757d;
        }

        .contact-info-item a {
            color: #6c757d;
            text-decoration: none;
        }

        .contact-info-item a:hover {
            color: #0d6efd;
        }

        .contact-form-title {
            font-weight: 800;
            margin-bottom: 8px;
        }

        .contact-form-description {
            color: #6c757d;
            margin-bottom: 30px;
        }

        .form-label {
            font-weight: 600;
            margin-bottom: 8px;
        }

        .form-control {
            border-radius: 10px;
            padding: 12px 15px;
            border: 1px solid #dee2e6;
        }

        .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.12);
        }

        textarea.form-control {
            resize: vertical;
            min-height: 150px;
        }

        .btn-send {
            padding: 12px 28px;
            border-radius: 10px;
            font-weight: 600;
        }

        .social-links {
            display: flex;
            gap: 10px;
            margin-top: 25px;
        }

        .social-link {
            width: 42px;
            height: 42px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 50%;

            background: #f1f3f5;
            color: #495057;

            text-decoration: none;

            transition: all 0.3s ease;
        }

        .social-link:hover {
            background: #0d6efd;
            color: white;
            transform: translateY(-3px);
        }

        .contact-bottom {
            padding: 60px 0;
            background: white;
        }

        .contact-bottom h2 {
            font-weight: 800;
        }

        .contact-bottom p {
            color: #6c757d;
        }

        @media (max-width: 768px) {

            .contact-hero {
                padding: 75px 0 60px;
            }

            .contact-hero h1 {
                font-size: 2.3rem;
            }

            .contact-section {
                padding: 50px 0;
            }

            .contact-card .card-body {
                padding: 25px;
            }
        }

    </style>

</head>

<body>

<!-- =========================================================
     NAVBAR
========================================================= -->

<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top rahanu-navbar">

    <div class="container">

        <a class="navbar-brand fw-bold d-flex align-items-center"
           href="${pageContext.request.contextPath}/">

            <i class="bi bi-cpu-fill text-primary me-2 fs-4"></i>

            <span>
                <span class="text-primary">RAHANU</span>
                <span class="text-dark"> TECHNOLOGY</span>
            </span>

        </a>

        <button
                class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#mainNavbar"
                aria-controls="mainNavbar"
                aria-expanded="false"
                aria-label="Toggle navigation">

            <span class="navbar-toggler-icon"></span>

        </button>

        <div class="collapse navbar-collapse" id="mainNavbar">

            <ul class="navbar-nav ms-auto align-items-lg-center">

                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/">
                        Home
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/about.jsp">
                        About
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/services">
                        Services
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/projects">
                        Projects
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/team">
                        Our Team
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link active"
                       aria-current="page"
                       href="${pageContext.request.contextPath}/contact">
                        Contact
                    </a>
                </li>

                <li class="nav-item ms-lg-3 mt-2 mt-lg-0">

                    <a class="btn btn-primary px-4"
                       href="${pageContext.request.contextPath}/contact">

                        Get Started

                    </a>

                </li>

            </ul>

        </div>

    </div>

</nav>


<!-- =========================================================
     CONTACT HERO
========================================================= -->

<section class="contact-hero text-center">

    <div class="container">

        <div class="mb-3">

            <i class="bi bi-chat-dots-fill fs-1"></i>

        </div>

        <h1>Let's Work Together</h1>

        <p>
            Have a project, technology challenge, or security
            requirement? Get in touch with RAHANU TECHNOLOGY
            and let's discuss how we can help.
        </p>

    </div>

</section>


<!-- =========================================================
     CONTACT SECTION
========================================================= -->

<section class="contact-section">

    <div class="container">

        <div class="row g-4">

            <!-- ===============================================
                 CONTACT INFORMATION
            ================================================ -->

            <div class="col-lg-5">

                <div class="card contact-card">

                    <div class="card-body">

                        <span class="badge bg-primary-subtle text-primary mb-3">
                            CONTACT INFORMATION
                        </span>

                        <h2 class="fw-bold mb-3">
                            Get In Touch
                        </h2>

                        <p class="text-muted mb-4">

                            We are ready to discuss your next
                            technology project, cybersecurity
                            requirement, or digital solution.

                        </p>


                        <!-- Email -->

                        <div class="contact-info-item">

                            <div class="contact-icon">

                                <i class="bi bi-envelope-fill"></i>

                            </div>

                            <div>

                                <h6>Email</h6>

                                <p>
                                    <a href="mailto:info@rahanu.com">
                                        info@rahanu.com
                                    </a>
                                </p>

                            </div>

                        </div>


                        <!-- Phone -->

                        <div class="contact-info-item">

                            <div class="contact-icon">

                                <i class="bi bi-telephone-fill"></i>

                            </div>

                            <div>

                                <h6>Phone</h6>

                                <p>
                                    <a href="tel:+255000000000">
                                        +255 XXX XXX XXX
                                    </a>
                                </p>

                            </div>

                        </div>


                        <!-- Location -->

                        <div class="contact-info-item">

                            <div class="contact-icon">

                                <i class="bi bi-geo-alt-fill"></i>

                            </div>

                            <div>

                                <h6>Location</h6>

                                <p>
                                    Tanzania
                                </p>

                            </div>

                        </div>


                        <!-- Working Hours -->

                        <div class="contact-info-item">

                            <div class="contact-icon">

                                <i class="bi bi-clock-fill"></i>

                            </div>

                            <div>

                                <h6>Working Hours</h6>

                                <p>
                                    Monday - Friday
                                    <br>
                                    08:00 AM - 05:00 PM
                                </p>

                            </div>

                        </div>


                        <!-- Social Media -->

                        <h6 class="fw-bold mt-4 mb-2">
                            Follow Us
                        </h6>

                        <div class="social-links">

                            <a href="#"
                               class="social-link"
                               aria-label="LinkedIn">

                                <i class="bi bi-linkedin"></i>

                            </a>

                            <a href="#"
                               class="social-link"
                               aria-label="GitHub">

                                <i class="bi bi-github"></i>

                            </a>

                            <a href="#"
                               class="social-link"
                               aria-label="Twitter">

                                <i class="bi bi-twitter-x"></i>

                            </a>

                            <a href="#"
                               class="social-link"
                               aria-label="Facebook">

                                <i class="bi bi-facebook"></i>

                            </a>

                        </div>

                    </div>

                </div>

            </div>


            <!-- ===============================================
                 CONTACT FORM
            ================================================ -->

            <div class="col-lg-7">

                <div class="card contact-card">

                    <div class="card-body">

                        <h2 class="contact-form-title">
                            Send Us a Message
                        </h2>

                        <p class="contact-form-description">
                            Fill in the form below and our team
                            will get back to you.
                        </p>


                        <!-- Success Message -->

                        <% if (request.getAttribute("successMessage") != null) { %>

                            <div class="alert alert-success alert-dismissible fade show"
                                 role="alert">

                                <i class="bi bi-check-circle-fill me-2"></i>

                                <%= request.getAttribute("successMessage") %>

                                <button
                                        type="button"
                                        class="btn-close"
                                        data-bs-dismiss="alert">
                                </button>

                            </div>

                        <% } %>


                        <!-- Error Message -->

                        <% if (request.getAttribute("errorMessage") != null) { %>

                            <div class="alert alert-danger alert-dismissible fade show"
                                 role="alert">

                                <i class="bi bi-exclamation-triangle-fill me-2"></i>

                                <%= request.getAttribute("errorMessage") %>

                                <button
                                        type="button"
                                        class="btn-close"
                                        data-bs-dismiss="alert">
                                </button>

                            </div>

                        <% } %>


                        <!-- Contact Form -->

                        <form method="post"
                              action="${pageContext.request.contextPath}/contact">

                            <div class="row">

                                <!-- Full Name -->

                                <div class="col-md-6 mb-3">

                                    <label
                                            for="fullName"
                                            class="form-label">

                                        Full Name
                                        <span class="text-danger">*</span>

                                    </label>

                                    <input
                                            type="text"
                                            class="form-control"
                                            id="fullName"
                                            name="fullName"
                                            placeholder="Enter your full name"
                                            maxlength="150"
                                            required>

                                </div>


                                <!-- Email -->

                                <div class="col-md-6 mb-3">

                                    <label
                                            for="email"
                                            class="form-label">

                                        Email Address
                                        <span class="text-danger">*</span>

                                    </label>

                                    <input
                                            type="email"
                                            class="form-control"
                                            id="email"
                                            name="email"
                                            placeholder="you@example.com"
                                            maxlength="200"
                                            required>

                                </div>

                            </div>


                            <div class="row">

                                <!-- Phone -->

                                <div class="col-md-6 mb-3">

                                    <label
                                            for="phone"
                                            class="form-label">

                                        Phone Number

                                    </label>

                                    <input
                                            type="text"
                                            class="form-control"
                                            id="phone"
                                            name="phone"
                                            placeholder="+255 XXX XXX XXX"
                                            maxlength="50">

                                </div>


                                <!-- Subject -->

                                <div class="col-md-6 mb-3">

                                    <label
                                            for="subject"
                                            class="form-label">

                                        Subject

                                    </label>

                                    <input
                                            type="text"
                                            class="form-control"
                                            id="subject"
                                            name="subject"
                                            placeholder="What can we help you with?"
                                            maxlength="200">

                                </div>

                            </div>


                            <!-- Message -->

                            <div class="mb-4">

                                <label
                                        for="message"
                                        class="form-label">

                                    Message
                                    <span class="text-danger">*</span>

                                </label>

                                <textarea
                                        class="form-control"
                                        id="message"
                                        name="message"
                                        rows="7"
                                        maxlength="5000"
                                        placeholder="Tell us about your project or inquiry..."
                                        required></textarea>

                            </div>


                            <!-- Submit -->

                            <button
                                    type="submit"
                                    class="btn btn-primary btn-send">

                                <i class="bi bi-send-fill me-2"></i>

                                Send Message

                            </button>

                        </form>

                    </div>

                </div>

            </div>

        </div>

    </div>

</section>


<!-- =========================================================
     CTA
========================================================= -->

<section class="contact-bottom text-center">

    <div class="container">

        <div class="row justify-content-center">

            <div class="col-lg-8">

                <i class="bi bi-lightbulb-fill text-primary fs-1"></i>

                <h2 class="mt-3">
                    Have an Idea?
                </h2>

                <p class="mt-3">
                    From software development to cybersecurity
                    and digital solutions, we can help transform
                    your ideas into practical technology solutions.
                </p>

                <a
                        href="${pageContext.request.contextPath}/projects"
                        class="btn btn-outline-primary mt-3 px-4">

                    <i class="bi bi-folder2-open me-2"></i>

                    Explore Our Projects

                </a>

            </div>

        </div>

    </div>

</section>


<!-- =========================================================
     FOOTER
========================================================= -->

<footer class="bg-dark text-white pt-5 pb-4">

    <div class="container">

        <div class="row g-4">

            <!-- Company -->

            <div class="col-lg-5">

                <h5 class="fw-bold">

                    <i class="bi bi-cpu-fill text-primary me-2"></i>

                    RAHANU TECHNOLOGY

                </h5>

                <p class="text-white-50 mt-3">

                    Building, securing and innovating digital
                    solutions for businesses, organizations
                    and individuals.

                </p>

            </div>


            <!-- Quick Links -->

            <div class="col-md-3 col-lg-3">

                <h6 class="fw-bold mb-3">
                    Quick Links
                </h6>

                <ul class="list-unstyled">

                    <li class="mb-2">
                        <a
                                href="${pageContext.request.contextPath}/"
                                class="text-white-50 text-decoration-none">
                            Home
                        </a>
                    </li>

                    <li class="mb-2">
                        <a
                                href="${pageContext.request.contextPath}/services"
                                class="text-white-50 text-decoration-none">
                            Services
                        </a>
                    </li>

                    <li class="mb-2">
                        <a
                                href="${pageContext.request.contextPath}/projects"
                                class="text-white-50 text-decoration-none">
                            Projects
                        </a>
                    </li>

                    <li class="mb-2">
                        <a
                                href="${pageContext.request.contextPath}/team"
                                class="text-white-50 text-decoration-none">
                            Our Team
                        </a>
                    </li>

                </ul>

            </div>


            <!-- Contact -->

            <div class="col-md-5 col-lg-4">

                <h6 class="fw-bold mb-3">
                    Contact
                </h6>

                <p class="text-white-50 mb-2">

                    <i class="bi bi-envelope me-2"></i>

                    info@rahanu.com

                </p>

                <p class="text-white-50 mb-2">

                    <i class="bi bi-telephone me-2"></i>

                    +255 XXX XXX XXX

                </p>

                <p class="text-white-50">

                    <i class="bi bi-geo-alt me-2"></i>

                    Tanzania

                </p>

            </div>

        </div>


        <hr class="border-secondary my-4">


        <div class="text-center text-white-50">

            <small>

                &copy;
                <%= java.time.Year.now().getValue() %>
                RAHANU TECHNOLOGY.
                All Rights Reserved.

            </small>

        </div>

    </div>

</footer>


<!-- Bootstrap JavaScript -->

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>
