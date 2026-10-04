package tz.rahanu.technology.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class AdminAuthUtil {

    private AdminAuthUtil() {
    }

    public static boolean isAuthenticated(HttpServletRequest request) {

        HttpSession session = request.getSession(false);

        if (session == null) {
            return false;
        }

        return session.getAttribute("adminUser") != null;
    }
}
