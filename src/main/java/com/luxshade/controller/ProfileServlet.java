package com.luxshade.controller;

import com.luxshade.model.User;
import com.luxshade.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import org.mindrot.jbcrypt.BCrypt;

import java.io.File;
import java.io.IOException;

@WebServlet("/profile")
@MultipartConfig
public class ProfileServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        // Refresh user from DB to get latest data
        User freshUser = userService.getUserById(user.getUserId());
        request.setAttribute("profileUser", freshUser);

        request.getRequestDispatcher("/pages/user/profile.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        User sessionUser = (User) session.getAttribute("user");

        if ("updateProfile".equals(action)) {
            handleProfileUpdate(request, response, sessionUser);
        } else if ("changePassword".equals(action)) {
            handlePasswordChange(request, response, sessionUser);
        }
    }

    // ─── UPDATE PROFILE ───
    private void handleProfileUpdate(HttpServletRequest request,
                                     HttpServletResponse response,
                                     User sessionUser)
            throws ServletException, IOException {

        String name    = request.getParameter("name");
        String phone   = request.getParameter("phone");
        String dob     = request.getParameter("dob");
        String address = request.getParameter("address");

        // Validate name
        if (!name.matches("[a-zA-Z\\s]+")) {
            request.setAttribute("profileError",
                    "Full name must not contain numbers or special characters.");
            forwardToProfile(request, response, sessionUser);
            return;
        }

        // Validate phone
        if (!phone.matches("\\d{10}")) {
            request.setAttribute("profileError",
                    "Phone number must be exactly 10 digits.");
            forwardToProfile(request, response, sessionUser);
            return;
        }

        // Get existing user
        User user = userService.getUserById(sessionUser.getUserId());

        // Handle profile picture upload
        Part filePart = request.getPart("profile_pic");
        if (filePart != null && filePart.getSize() > 0) {
            String uploadDir = getServletContext().getRealPath("/uploads/profiles");
            File uploadFolder = new File(uploadDir);
            if (!uploadFolder.exists()) uploadFolder.mkdirs();
            String fileName = System.currentTimeMillis() + "_" +
                    filePart.getSubmittedFileName();
            filePart.write(uploadDir + File.separator + fileName);
            user.setProfilePic("uploads/profiles/" + fileName);
        }

        user.setName(name);
        user.setPhone(phone);
        user.setAddress(address);
        if (dob != null && !dob.isEmpty()) {
            user.setDob(java.sql.Date.valueOf(dob));
        }

        boolean success = userService.updateUser(user);
        if (success) {
            // Update session with new name
            request.getSession().setAttribute("userName", user.getName());
            request.getSession().setAttribute("user", user);
            request.setAttribute("profileSuccess", "Profile updated successfully.");
        } else {
            request.setAttribute("profileError", "Failed to update profile.");
        }

        forwardToProfile(request, response, user);
    }

    // ─── CHANGE PASSWORD ───
    private void handlePasswordChange(HttpServletRequest request,
                                      HttpServletResponse response,
                                      User sessionUser)
            throws ServletException, IOException {

        String currentPassword = request.getParameter("currentPassword");
        String newPassword     = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        User user = userService.getUserById(sessionUser.getUserId());

        // Verify current password
        if (!BCrypt.checkpw(currentPassword, user.getPassword())) {
            request.setAttribute("passwordError", "Current password is incorrect.");
            forwardToProfile(request, response, user);
            return;
        }

        // Validate new password length
        if (newPassword.length() < 6) {
            request.setAttribute("passwordError",
                    "New password must be at least 6 characters.");
            forwardToProfile(request, response, user);
            return;
        }

        // Confirm passwords match
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("passwordError", "Passwords do not match.");
            forwardToProfile(request, response, user);
            return;
        }

        // Hash and update
        String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
        user.setPassword(hashedPassword);
        boolean success = userService.updateUserPassword(sessionUser.getUserId(),
                hashedPassword);
        if (success) {
            request.setAttribute("passwordSuccess", "Password changed successfully.");
        } else {
            request.setAttribute("passwordError", "Failed to change password.");
        }

        forwardToProfile(request, response, user);
    }

    // ─── HELPER ───
    private void forwardToProfile(HttpServletRequest request,
                                  HttpServletResponse response,
                                  User user)
            throws ServletException, IOException {
        request.setAttribute("profileUser", user);
        request.getRequestDispatcher("/pages/user/profile.jsp")
                .forward(request, response);
    }
}