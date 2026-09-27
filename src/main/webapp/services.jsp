<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Services | RAHANU TECHNOLOGY</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link rel="stylesheet" href="css/style.css">

    <style>

        .services-hero {
            padding: 100px 0 80px;
            background:
                linear-gradient(
                    135deg,
                    #f8fbff 0%,
                    #eaf4ff 100%
                );
        }

        .section-label {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            margin-bottom: 20px;
            border-radius: 50px;
            background: #e7f1ff;
            color: #0d6efd;
            font-size: 0.85rem;
            font-weight: 700;
            letter-spacing: 1px;
        }

        .services-hero h1 {
            font-size: 3rem;
            font-weight: 800;
            color: #172b4d;
            margin-bottom: 20px;
        }

        .services-hero h1 span {
            color: #0d6efd;
        }

        .services-hero p {
            color: #667085;
            font-size: 1.1rem;
            line-height: 1.8;
            margin: 0;
        }

        .services-section {
            padding: 90px 0;
            background: #ffffff;
        }

        .service-card {
            height: 100%;
            padding: 35px 30px;
            background: #ffffff;
            border: 1px solid #e7edf5;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(20, 60, 100, 0.07);
            transition: all 0.3s ease;
        }

        .service-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 18px 40px rgba(20, 60, 100, 0.13);
            border-color: #cfe2ff;
        }

        .service-icon {
            width: 70px;
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 25px;
            border-radius: 18px;
            background: linear-gradient(
                135deg,
                #0d6efd,
                #0a58ca
            );
            color: #ffffff;
            font-size: 2rem;
        }

        .service-card h3 {
            color: #172b4d;
            font-size: 1.35rem;
            font-weight: 700;
            margin-bottom: 15px;
        }

        .service-card p {
            color: #667085;
            line-height: 1.8;
            margin-bottom: 0;
        }

        .featured-service {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            margin-bottom: 15px;
            color: #0d6efd;
            font-size: 0.8rem;
            font-weight: 700;
        }

        .empty-services {
            padding: 70px 20px;
            text-align: center;
            border-radius: 20px;
            background: #f8fafc;
        }

        .empty-services i {
            display: block;
            margin-bottom: 20px;
            color: #98a2b3;
            font-size: 4rem;
        }

        .empty-services h3 {
            color: #172b4d;
            font-weight: 700;
        }

        .empty-services p {
            color: #667085;
            margin-bottom: 0;
        }

        .services-cta {
            padding: 90px 0;
            background: linear-gradient(
                135deg,
                #0d6efd,
                #084298
            );
            color: #ffffff;
        }

        .cta-icon {
            font-size: 3rem;
            margin-bottom: 20px;
        }

        .services-cta h2 {
            font-size: 2.3rem;
            font-weight: 800;
            margin-bottom: 15px;
        }

        .services-cta p {
            max-width: 650px;
            margin: 0 auto 30px;
            color: rgba(255, 255, 255, 0.85);
            line-height: 1.8;
        }

        @media (max-width: 768px) {

            .services-hero {
                padding: 75px 0 60px;
            }

            .services-hero h1 {
                font-size: 2.3rem;
            }

            .services-section {
                padding: 65px 0;
            }

            .services-cta {
                padding: 65px 0;
            }

            .services-cta h2 {
                font-size: 1.9rem;
            }
        }

    </style>

</head>

<body>

<jsp:include page="includes/navbar.jsp"/>


<section class="services-hero">

    <div class="container">

        <div class="row justify-content-center text-center">

            <div class="col-lg-8">

                <span class="section-label">
                    <i class="bi bi-grid-3x3-gap-fill"></i>
                    WHAT WE DO
                </span>

                <h1>
                    Our
                    <span>Services</span>
                </h1>

                <p>
                    We provide reliable technology, software development
                    and cybersecurity solutions designed to help
                    organizations build, protect and grow their digital
                    capabilities.
                </p>

            </div>

        </div>

    </div>

</section>


<section class="services-section">

    <div class="container">

        <div class="row g-4">

            <c:choose>

                <c:when test="${not empty services}">

                    <c:forEach
                        var="service"
                        items="${services}">

                        <div class="col-lg-4 col-md-6">

                            <div class="service-card">

                                <c:if test="${service.featured}">

                                    <span class="featured-service">
                                        <i class="bi bi-star-fill"></i>
                                        Featured Service
                                    </span>

                                </c:if>


                                <div class="service-icon">

                                    <c:choose>

                                        <c:when test="${not empty service.icon}">

                                            <i class="bi ${service.icon}"></i>

                                        </c:when>

                                        <c:otherwise>

                                            <i class="bi bi-gear-fill"></i>

                                        </c:otherwise>

                                    </c:choose>

                                </div>


                                <h3>
                                    ${service.title}
                                </h3>


                                <p>
                                    ${service.shortDescription}
                                </p>

                            </div>

                        </div>

                    </c:forEach>

                </c:when>


                <c:otherwise>

                    <div class="col-12">

                        <div class="empty-services">

                            <i class="bi bi-tools"></i>

                            <h3>
                                No Services Available
                            </h3>

                            <p>
                                Our services are currently being updated.
                                Please check again later.
                            </p>

                        </div>

                    </div>

                </c:otherwise>

            </c:choose>

        </div>

    </div>

</section>


<section class="services-cta">

    <div class="container">

        <div class="row justify-content-center text-center">

            <div class="col-lg-8">

                <i class="bi bi-lightbulb-fill cta-icon"></i>

                <h2>
                    Have a Technology Challenge?
                </h2>

                <p>
                    Let's discuss your requirements and build a secure,
                    reliable and practical digital solution for your needs.
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