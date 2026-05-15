package com.luxshade.controller;

import com.luxshade.model.User;
import com.luxshade.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Load pending users
        List<User> pendingUsers = userService.getPendingUsers();
        request.setAttribute("pendingUsers", pendingUsers);

        request.getRequestDispatcher("/pages/Admin/Dashboard.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action    = request.getParameter("action");
        String userIdStr = request.getParameter("userId");
        int userId       = Integer.parseInt(userIdStr);

        if ("approve".equals(action)) {
            userService.updateUserStatus(userId, "approved");
        } else if ("reject".equals(action)) {
            userService.updateUserStatus(userId, "rejected");
        }

        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
}