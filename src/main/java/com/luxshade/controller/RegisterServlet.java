package com.luxshade.controller;

import com.luxshade.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

@WebServlet("/register")
@MultipartConfig
public class RegisterServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name            = request.getParameter("name");
        String email           = request.getParameter("email");
        String phone           = request.getParameter("phone");
        String dob             = request.getParameter("dob");
        String address         = request.getParameter("address");
        String password        = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Helper to re-populate form on error
        request.setAttribute("name",    name);
        request.setAttribute("email",   email);
        request.setAttribute("phone",   phone);
        request.setAttribute("dob",     dob);
        request.setAttribute("address", address);

        // Validate full name — no numbers allowed
        if (!name.matches("[a-zA-Z\\s]+")) {
            request.setAttribute("error", "Full name must not contain numbers or special characters.");
            request.getRequestDispatcher("/pages/user/register.jsp").forward(request, response);
            return;
        }

        // Validate phone — digits only, 10 digits
        if (!phone.matches("\\d{10}")) {
            request.setAttribute("error", "Phone number must be exactly 10 digits.");
            request.getRequestDispatcher("/pages/user/register.jsp").forward(request, response);
            return;
        }

        // Validate password length
        if (password.length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters.");
            request.getRequestDispatcher("/pages/user/register.jsp").forward(request, response);
            return;
        }

        // Validate passwords match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/pages/user/register.jsp").forward(request, response);
            return;
        }

        // Handle profile picture upload
        String profilePicPath = null;
        Part filePart = request.getPart("profile_pic");
        if (filePart != null && filePart.getSize() > 0) {
            String uploadDir = getServletContext().getRealPath("/uploads/profiles");
            File uploadFolder = new File(uploadDir);
            if (!uploadFolder.exists()) {
                uploadFolder.mkdirs();
            }
            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            filePart.write(uploadDir + File.separator + fileName);
            profilePicPath = "uploads/profiles/" + fileName;
        }

        // Register user
        String result = userService.registerUser(name, email, password, phone, dob, address);

        if ("success".equals(result)) {
            // Redirect to login with success message
            response.sendRedirect(request.getContextPath() + "/login?registered=true");
        } else {
            request.setAttribute("error", result);
            request.getRequestDispatcher("/pages/user/register.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/pages/user/register.jsp").forward(request, response);
    }
}