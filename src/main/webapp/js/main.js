document.addEventListener("DOMContentLoaded", function () {

    const navbar =
        document.querySelector(".rahanu-navbar");

    if (navbar) {

        window.addEventListener("scroll", function () {

            if (window.scrollY > 50) {

                navbar.classList.add("navbar-scrolled");

            } else {

                navbar.classList.remove("navbar-scrolled");

            }

        });

    }

});
