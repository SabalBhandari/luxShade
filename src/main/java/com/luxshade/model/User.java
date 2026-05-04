package com.luxshade.model;

public class User {

    private int userId;
    private String name;
    private String email;
    private String password;
    private String profilePic;

    public User() {}

    public User(int userId, String name, String email, String password, String profilePic) {
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.password = password;
        this.profilePic = profilePic;
    }

    public User(String name, String email, String password, String profilePic) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.profilePic = profilePic;
    }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getProfilePic() { return profilePic; }
    public void setProfilePic(String profilePic) { this.profilePic = profilePic; }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", profilePic='" + profilePic + '\'' +
                '}';
    }
}