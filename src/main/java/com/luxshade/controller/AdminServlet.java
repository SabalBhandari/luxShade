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

@WebServlet(urlPatterns = {"/admin/dashboard", "/admin/users"})
public class AdminServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String uri = request.getRequestURI();

        if (uri.endsWith("/admin/dashboard")) {
            // Load pending users for dashboard
            List<User> pendingUsers = userService.getPendingUsers();
            request.setAttribute("pendingUsers", pendingUsers);
            request.getRequestDispatcher("/pages/Admin/Dashboard.jsp")
                    .forward(request, response);

        } else if (uri.endsWith("/admin/users")) {
            // Load all users with optional status filter
            String status = request.getParameter("status");
            List<User> allUsers;

            if (status != null && !status.isEmpty()) {
                allUsers = userService.getUsersByStatus(status);
            } else {
                allUsers = userService.getAllUsers();
            }

            // Load counts for stat cards
            request.setAttribute("allUsers", allUsers);
            request.setAttribute("totalUsers",    userService.getAllUsers().size());
            request.setAttribute("approvedUsers", userService.getUsersByStatus("approved").size());
            request.setAttribute("pendingUsers",  userService.getUsersByStatus("pending").size());
            request.setAttribute("rejectedUsers", userService.getUsersByStatus("rejected").size());

            request.getRequestDispatcher("/pages/Admin/Users.jsp")
                    .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String uri      = request.getRequestURI();
        String action   = request.getParameter("action");
        String userIdStr = request.getParameter("userId");
        int userId      = Integer.parseInt(userIdStr);

        if (uri.endsWith("/admin/dashboard")) {
            // Handle approve/reject from dashboard
            if ("approve".equals(action)) {
                userService.updateUserStatus(userId, "approved");
            } else if ("reject".equals(action)) {
                userService.updateUserStatus(userId, "rejected");
            }
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");

        } else if (uri.endsWith("/admin/users")) {
            request.getSession().removeAttribute("success");
            request.getSession().removeAttribute("error");
            if ("approve".equals(action)) {
                boolean success = userService.updateUserStatus(userId, "approved");
                if (success) {
                    request.getSession().setAttribute("success", "User approved successfully.");
                } else {
                    request.getSession().setAttribute("error", "Failed to approve user.");
                }
            } else if ("reject".equals(action)) {
                boolean success = userService.updateUserStatus(userId, "rejected");
                if (success) {
                    request.getSession().setAttribute("success", "User rejected.");
                } else {
                    request.getSession().setAttribute("error", "Failed to reject user.");
                }
            } else if ("delete".equals(action)) {
                boolean success = userService.deleteUser(userId);
                if (success) {
                    request.getSession().setAttribute("success", "User deleted successfully.");
                } else {
                    request.getSession().setAttribute("error", "Failed to delete user.");
                }
            }
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }
}