package com.luxshade.service;

import com.luxshade.dao.UserDAO;
import com.luxshade.model.User;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Date;

public class UserService {
    private final UserDAO userDAO = new UserDAO();

    // Register with all new fields
    public String registerUser(String name, String email, String password,
                               String phone, String dob, String address) {
        if (userDAO.emailExists(email)) {
            return "Email already registered.";
        }
        if (userDAO.phoneExists(phone)) {
            return "Phone number already registered.";
        }
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        Date dobDate = null;
        if (dob != null && !dob.isEmpty()) {
            dobDate = Date.valueOf(dob); // expects "yyyy-MM-dd" format
        }
        User user = new User(name, email, hashedPassword, phone, dobDate, address);
        boolean success = userDAO.registerUser(user);
        return success ? "success" : "Registration failed. Please try again.";
    }

    // Login — also checks approval status
    public User loginUser(String email, String password) {
        User user = userDAO.getUserByEmail(email);
        if (user == null) return null;
        if (!BCrypt.checkpw(password, user.getPassword())) return null;
        return user; // let the controller check status
    }

    // Admin: approve or reject user
    public boolean updateUserStatus(int userId, String status) {
        return userDAO.updateUserStatus(userId, status);
    }

    // Update profile
    public boolean updateUser(User user) {
        return userDAO.updateUser(user);
    }

    // Delete user
    public boolean deleteUser(int userId) {
        return userDAO.deleteUser(userId);
    }
}