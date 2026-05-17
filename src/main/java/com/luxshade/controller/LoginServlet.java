package com.luxshade.controller;

import com.luxshade.model.User;
import com.luxshade.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userService.loginUser(email, password);

        if (user == null) {
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("/pages/user/login.jsp").forward(request, response);
            return;
        }

        // Check if admin approved the account
        if ("pending".equals(user.getStatus())) {
            request.setAttribute("error", "Your account is pending approval by the admin.");
            request.getRequestDispatcher("/pages/user/login.jsp").forward(request, response);
            return;
        }

        if ("rejected".equals(user.getStatus())) {
            request.setAttribute("error", "Your account has been rejected. Please contact support.");
            request.getRequestDispatcher("/pages/user/login.jsp").forward(request, response);
            return;
        }

        // Login success — create session
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        session.setAttribute("userId", user.getUserId());
        session.setAttribute("userName", user.getName());
        session.setAttribute("userRole", user.getRole());
        session.setMaxInactiveInterval(30 * 60);

        // Redirect based on role
        if ("admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Show success message after registration
        String registered = request.getParameter("registered");
        if ("true".equals(registered)) {
            request.setAttribute("success", "Registration successful! Please wait for admin approval.");
        }
        request.getRequestDispatcher("/pages/user/login.jsp").forward(request, response);
    }
}