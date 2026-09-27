package tz.rahanu.technology.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import tz.rahanu.technology.dao.ServiceDAO;
import tz.rahanu.technology.model.Service;

import java.io.IOException;
import java.util.List;

@WebServlet("/services")
public class ServiceServlet extends HttpServlet {

    private ServiceDAO serviceDAO;

    @Override
    public void init() {

        serviceDAO = new ServiceDAO();

        System.out.println(
                "RAHANU TECHNOLOGY: ServiceServlet initialized."
        );
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println(
                "RAHANU TECHNOLOGY: ServiceServlet called."
        );

        List<Service> services =
                serviceDAO.getAllActiveServices();

        request.setAttribute(
                "services",
                services
        );

        request.getRequestDispatcher(
                "/services.jsp"
        ).forward(request, response);
    }
}