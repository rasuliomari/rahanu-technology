package tz.rahanu.technology.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/uploads/team/*")
public class TeamImageServlet extends HttpServlet {

    private static final Path TEAM_UPLOAD_DIRECTORY =
            Paths.get("/opt/rahanu-technology-data/team");

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String path =
                request.getPathInfo();

        if (path == null ||
                path.equals("/") ||
                path.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND
            );

            return;
        }

        /*
         * Remove the leading slash.
         */
        String filename =
                path.substring(1);

        /*
         * Prevent path traversal.
         */
        Path file =
                TEAM_UPLOAD_DIRECTORY
                        .resolve(filename)
                        .normalize();

        if (!file.startsWith(
                TEAM_UPLOAD_DIRECTORY.normalize())) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN
            );

            return;
        }

        if (!Files.exists(file) ||
                !Files.isRegularFile(file)) {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND
            );

            return;
        }

        String contentType =
                getServletContext()
                        .getMimeType(
                                file.getFileName()
                                        .toString()
                        );

        if (contentType == null) {

            contentType =
                    "application/octet-stream";
        }

        response.setContentType(
                contentType
        );

        response.setContentLengthLong(
                Files.size(file)
        );

        response.setHeader(
                "Cache-Control",
                "public, max-age=86400"
        );

        try (
                var inputStream =
                        Files.newInputStream(file);

                OutputStream outputStream =
                        response.getOutputStream()
        ) {

            inputStream.transferTo(
                    outputStream
            );
        }
    }
}
