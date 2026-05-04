package com.luxshade.service;

import com.luxshade.dao.UserDAO;
import com.luxshade.model.User;
import org.mindrot.jbcrypt.BCrypt;

public class UserService {

    private final UserDAO userDAO = new UserDAO();

    public boolean registerUser(String name, String email, String password, String profilePic) {

        if (userDAO.emailExists(email)) {
            return false;
        }

        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        User user = new User(name, email, hashedPassword, profilePic);
        return userDAO.registerUser(user);
    }

    public User loginUser(String email, String password) {

        User user = userDAO.getUserByEmail(email);

        if (user == null) {
            return null;
        }

        if (BCrypt.checkpw(password, user.getPassword())) {
            return user;
        }

        return null;
    }
}