<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Admin Login | RAHANU TECHNOLOGY</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
            rel="stylesheet">

    <style>

        body {

            min-height: 100vh;

            background:
                linear-gradient(
                    135deg,
                    #0d6efd,
                    #063b88
                );

            display: flex;

            align-items: center;

            justify-content: center;

            font-family:
                system-ui,
                -apple-system,
                "Segoe UI",
                sans-serif;
        }

        .login-wrapper {

            width: 100%;

            max-width: 440px;

            padding: 20px;
        }

        .login-card {

            background: white;

            border-radius: 24px;

            padding: 40px;

            box-shadow:
                0 20px 60px
                rgba(0, 0, 0, 0.20);
        }

        .brand-icon {

            width: 70px;

            height: 70px;

            margin: 0 auto 20px;

            display: flex;

            align-items: center;

            justify-content: center;

            border-radius: 20px;

            background: rgba(
                13,
                110,
                253,
                0.1
            );

            color: #0d6efd;

            font-size: 2rem;
        }

        .brand-title {

            font-weight: 800;

            color: #212529;
        }

        .brand-subtitle {

            color: #6c757d;

            font-size: 0.95rem;
        }

        .form-label {

            font-weight: 600;
        }

        .form-control {

            padding: 13px 15px;

            border-radius: 11px;
        }

        .form-control:focus {

            border-color: #0d6efd;

            box-shadow:
                0 0 0 0.2rem
                rgba(13, 110, 253, 0.12);
        }

        .login-btn {

            width: 100%;

            padding: 13px;

            border-radius: 11px;

            font-weight: 700;
        }

        .back-link {

            color: #6c757d;

            text-decoration: none;

            font-size: 0.9rem;
        }

        .back-link:hover {

            color: #0d6efd;
        }

    </style>

</head>

<body>

<div class="login-wrapper">

    <div class="login-card">

        <div class="text-center">

            <div class="brand-icon">

                <i class="bi bi-shield-lock-fill"></i>

            </div>

            <h2 class="brand-title">
                RAHANU TECHNOLOGY
            </h2>

            <p class="brand-subtitle mb-4">
                Administrator Portal
            </p>

        </div>


        <% if (request.getAttribute("errorMessage") != null) { %>

            <div
                    class="alert alert-danger"
                    role="alert">

                <i class="bi bi-exclamation-triangle-fill me-2"></i>

                <%= request.getAttribute("errorMessage") %>

            </div>

        <% } %>


        <form
                method="post"
                action="${pageContext.request.contextPath}/admin/login">

            <div class="mb-3">

                <label
                        for="username"
                        class="form-label">

                    Username

                </label>

                <div class="input-group">

                    <span class="input-group-text">

                        <i class="bi bi-person"></i>

                    </span>

                    <input
                            type="text"
                            class="form-control"
                            id="username"
                            name="username"
                            placeholder="Enter username"
                            autocomplete="username"
                            required>

                </div>

            </div>


            <div class="mb-4">

                <label
                        for="password"
                        class="form-label">

                    Password

                </label>

                <div class="input-group">

                    <span class="input-group-text">

                        <i class="bi bi-lock"></i>

                    </span>

                    <input
                            type="password"
                            class="form-control"
                            id="password"
                            name="password"
                            placeholder="Enter password"
                            autocomplete="current-password"
                            required>

                </div>

            </div>


            <button
                    type="submit"
                    class="btn btn-primary login-btn">

                <i class="bi bi-box-arrow-in-right me-2"></i>

                Sign In

            </button>

        </form>


        <div class="text-center mt-4">

            <a
                    href="${pageContext.request.contextPath}/"
                    class="back-link">

                <i class="bi bi-arrow-left me-1"></i>

                Back to Website

            </a>

        </div>

    </div>

</div>


<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>
