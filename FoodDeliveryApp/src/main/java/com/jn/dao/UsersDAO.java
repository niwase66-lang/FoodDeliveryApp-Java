package com.jn.dao;



import com.jn.models.Users;
import java.util.List;

public interface UsersDAO {

    /* ================= CREATE ================= */

    // Add new user (email must be unique)
    boolean addUser(Users user);

    /* ================= READ ================= */

    // 🔐 LOGIN / BLUR VALIDATION
    Users getUserByEmail(String email);

    boolean isUserExistsByEmail(String email);
    
    String getPasswordByEmail(String email);
    
    
    // 🔑 FETCH BY COMPOSITE PRIMARY KEY (category + user_id)
    Users getUserByCategoryAndUserId(String category, int userId);

    // Get all users of a category (ADMIN / CUSTOMER etc.)
    List<Users> getUsersByCategory(String category);

    // Get all users
    List<Users> getAllUsers();

    /* ================= UPDATE ================= */

    // Update location using composite primary key
    boolean updateUserLocation(String category, int userId, String location);

    // Update contact number using composite primary key
    boolean updateUserNumber(String category, int userId, String userNum);

    /* ================= DELETE ================= */

    // Delete user using composite primary key
    boolean deleteUser(String category, int userId);
}

