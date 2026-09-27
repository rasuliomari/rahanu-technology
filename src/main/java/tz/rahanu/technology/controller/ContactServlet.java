package tz.rahanu.technology.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import tz.rahanu.technology.dao.ContactDAO;
import tz.rahanu.technology.model.ContactMessage;

import java.io.IOException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    private ContactDAO contactDAO;

    @Override
    public void init() {

        contactDAO = new ContactDAO();

        System.out.println(
                "RAHANU TECHNOLOGY: ContactServlet initialized."
        );
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/contact.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String fullName =
                request.getParameter("fullName");

        String email =
                request.getParameter("email");

        String phone =
                request.getParameter("phone");

        String subject =
                request.getParameter("subject");

        String message =
                request.getParameter("message");

        /*
         * Basic validation
         */
        if (
                fullName == null ||
                fullName.trim().isEmpty() ||

                email == null ||
                email.trim().isEmpty() ||

                message == null ||
                message.trim().isEmpty()
        ) {

            request.setAttribute(
                    "errorMessage",
                    "Please fill in all required fields."
            );

            request.getRequestDispatcher(
                    "/contact.jsp"
            ).forward(request, response);

            return;
        }

        ContactMessage contactMessage =
                new ContactMessage();

        contactMessage.setFullName(
                fullName.trim()
        );

        contactMessage.setEmail(
                email.trim()
        );

        contactMessage.setPhone(
                phone != null
                        ? phone.trim()
                        : ""
        );

        contactMessage.setSubject(
                subject != null
                        ? subject.trim()
                        : ""
        );

        contactMessage.setMessage(
                message.trim()
        );

        boolean saved =
                contactDAO.saveMessage(
                        contactMessage
                );

        if (saved) {

            request.setAttribute(
                    "successMessage",
                    "Thank you! Your message has been sent successfully."
            );

        } else {

            request.setAttribute(
                    "errorMessage",
                    "Sorry, we could not send your message. Please try again."
            );
        }

        request.getRequestDispatcher(
                "/contact.jsp"
        ).forward(request, response);
    }
}
