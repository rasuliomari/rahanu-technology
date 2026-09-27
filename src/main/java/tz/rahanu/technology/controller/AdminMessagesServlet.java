package tz.rahanu.technology.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tz.rahanu.technology.dao.ContactMessageDAO;
import tz.rahanu.technology.model.ContactMessage;

@WebServlet("/admin/messages")
public class AdminMessagesServlet extends HttpServlet {

    private ContactMessageDAO contactMessageDAO;

    @Override
    public void init() {

        contactMessageDAO = new ContactMessageDAO();

        System.out.println(
                "RAHANU TECHNOLOGY: AdminMessagesServlet initialized."
        );
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdminLoggedIn(request, response)) {
            return;
        }

        String action = request.getParameter("action");
        String idParameter = request.getParameter("id");


        /*
         * View one message
         */
        if ("view".equals(action) && idParameter != null) {

            try {

                int id = Integer.parseInt(idParameter);

                ContactMessage message =
                        contactMessageDAO.getMessageById(id);

                if (message == null) {

                    response.sendRedirect(
                            request.getContextPath()
                                    + "/admin/messages"
                    );

                    return;
                }

                request.setAttribute(
                        "message",
                        message
                );

                request.getRequestDispatcher(
                        "/admin/message-details.jsp"
                ).forward(request, response);

                return;

            } catch (NumberFormatException e) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/messages"
                );

                return;
            }
        }


        /*
         * Display all messages
         */
        List<ContactMessage> messages =
                contactMessageDAO.getAllMessages();

        request.setAttribute(
                "messages",
                messages
        );

        int unreadMessageCount = 0;

            for (ContactMessage message : messages) {
                if (!message.isRead()) {
                    unreadMessageCount++;
                }
            }

            request.setAttribute(
                    "unreadMessageCount",
                    unreadMessageCount
            );

        request.getRequestDispatcher(
                "/admin/messages.jsp"
        ).forward(request, response);
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdminLoggedIn(request, response)) {
            return;
        }

        String action = request.getParameter("action");
        String idParameter = request.getParameter("id");

        if (idParameter == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/messages"
            );

            return;
        }

        try {

            int id = Integer.parseInt(idParameter);


            /*
             * Mark message as read
             */
            if ("markRead".equals(action)) {

                contactMessageDAO.markAsRead(id);
            }


            /*
             * Mark message as unread
             */
            else if ("markUnread".equals(action)) {

                contactMessageDAO.markAsUnread(id);
            }


            /*
             * Delete message
             */
            else if ("delete".equals(action)) {

                contactMessageDAO.deleteMessage(id);
            }


            /*
             * Unknown action
             */
            else {

                System.err.println(
                        "RAHANU TECHNOLOGY: Unknown message action: "
                                + action
                );
            }

        } catch (NumberFormatException e) {

            System.err.println(
                    "RAHANU TECHNOLOGY: Invalid message ID."
            );
        }

        response.sendRedirect(
                request.getContextPath()
                        + "/admin/messages"
        );
    }


    /**
     * Check whether administrator is logged in.
     */
    private boolean isAdminLoggedIn(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("adminUser") == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/login"
            );

            return false;
        }

        return true;
    }
}
