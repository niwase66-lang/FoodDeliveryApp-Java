package com.jn.daoimpl;


import com.jn.dao.UsersDAO;
import com.jn.models.Users;
import com.jn.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsersDAOImpl implements UsersDAO {

    /* ================= SQL QUERIES ================= */

    private static final String INSERT_USER_WITH_DEFAULT_CATEGORY =
        "INSERT INTO users (user_name,user_num, user_email, user_pass, user_location) VALUES (?, ?, ?, ?, ?)";

    private static final String INSERT_USER_WITH_CATEGORY =
        "INSERT INTO users (category, user_name,user_num, user_email, user_pass, user_location) VALUES (?, ?, ?, ?, ?, ?)";

    private static final String SELECT_BY_EMAIL =
        "SELECT * FROM users WHERE user_email = ?";

    private static final String CHECK_EMAIL_EXISTS =
        "SELECT 1 FROM users WHERE user_email = ?";
    
    private static final String GET_PASSWORD_BY_EMAIL=
    		"select user_pass as password from users where user_email= ? ";

    private static final String SELECT_BY_CATEGORY_AND_ID =
        "SELECT * FROM users WHERE category = ? AND user_id = ?";

    private static final String SELECT_BY_CATEGORY =
        "SELECT * FROM users WHERE category = ?";

    private static final String SELECT_ALL =
        "SELECT * FROM users";

    private static final String UPDATE_LOCATION =
        "UPDATE users SET user_location = ? WHERE category = ? AND user_id = ?";

    private static final String UPDATE_NUMBER =
        "UPDATE users SET user_num = ? WHERE category = ? AND user_id = ?";

    private static final String DELETE_USER =
        "DELETE FROM users WHERE category = ? AND user_id = ?";

    /* ================= CREATE ================= */

    @Override
    public boolean addUser(Users user) {

        boolean hasCategory = user.getCategory() != null && !user.getCategory().isEmpty();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     hasCategory ? INSERT_USER_WITH_CATEGORY : INSERT_USER_WITH_DEFAULT_CATEGORY
             )) {

            if (hasCategory) {
            	
                ps.setString(1, user.getCategory());
                ps.setString(2, user.getUserName());
                ps.setString(3, user.getUserNum());
                ps.setString(4, user.getUserEmail());
                ps.setString(5, user.getPassword());
                ps.setString(6, user.getUserLocation());
            } else {
            	
                ps.setString(1, user.getUserName());
                ps.setString(2, user.getUserNum());
                ps.setString(3, user.getUserEmail());
                ps.setString(4, user.getPassword());
                ps.setString(5, user.getUserLocation());
            }

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /* ================= READ ================= */

    // 🔐 LOGIN / BLUR VALIDATION
    @Override
    public Users getUserByEmail(String email) {

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_BY_EMAIL)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
//            	System.out.println("comesHere");
                return extractUser(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean isUserExistsByEmail(String email) {

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(CHECK_EMAIL_EXISTS)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            return rs.next();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    
    @Override
    public String getPasswordByEmail(String email) {
    	
    	try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(GET_PASSWORD_BY_EMAIL)) {
    		
    		ps.setString(1, email);
    		ResultSet rs = ps.executeQuery();
    		if(rs.next()) {
    			return rs.getString("password");
    		}
    		else {
    			return "BITEX";
    		}

               

           } catch (SQLException e) {
               e.printStackTrace();
           }
    	return "BITEX";
    }

    // 🔑 COMPOSITE PRIMARY KEY (category + user_id)
    @Override
    public Users getUserByCategoryAndUserId(String category, int userId) {

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_BY_CATEGORY_AND_ID)) {

            ps.setString(1, category);
            ps.setInt(2, userId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractUser(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Users> getUsersByCategory(String category) {

        List<Users> users = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_BY_CATEGORY)) {

            ps.setString(1, category);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                users.add(extractUser(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    @Override
    public List<Users> getAllUsers() {

        List<Users> users = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_ALL);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                users.add(extractUser(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    /* ================= UPDATE ================= */

    @Override
    public boolean updateUserLocation(String category, int userId, String location) {

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(UPDATE_LOCATION)) {

            ps.setString(1, location);
            ps.setString(2, category);
            ps.setInt(3, userId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateUserNumber(String category, int userId, String userNum) {

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(UPDATE_NUMBER)) {

            ps.setString(1, userNum);
            ps.setString(2, category);
            ps.setInt(3, userId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /* ================= DELETE ================= */

    @Override
    public boolean deleteUser(String category, int userId) {

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(DELETE_USER)) {

            ps.setString(1, category);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /* ================= RESULTSET → POJO ================= */

    private Users extractUser(ResultSet rs) throws SQLException {

        Users user = new Users();
        user.setUserId(rs.getInt("user_id"));
        user.setCategory(rs.getString("category"));
        user.setUserName(rs.getString("user_name"));
        
        user.setUserNum(rs.getString("user_num"));
        user.setUserEmail(rs.getString("user_email"));
        user.setPassword(rs.getString("user_pass"));
        user.setUserLocation(rs.getString("user_location"));

        return user;
    }
}

