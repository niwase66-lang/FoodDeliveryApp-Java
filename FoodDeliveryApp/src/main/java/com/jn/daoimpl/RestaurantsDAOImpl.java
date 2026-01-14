package com.jn.daoimpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.jn.dao.RestaurantsDAO;
import com.jn.models.Restaurants;

public class RestaurantsDAOImpl implements RestaurantsDAO {

    private static final String URL = "jdbc:mysql://localhost:3306/fooddeliveryapp";
    private static final String USER = "root";
    private static final String PASSWORD = "Niwas@007";
    
//    Query to get Restaurants by category
    private final String GET_RESTAURANT_RATING="SELECT * FROM RESTAURANTS where res_rating > 4.0";
    private final String GET_RESTAURANT_DELIVERYTIME="SELECT * FROM restaurants where res_eta < 20";
    private static final String GET_RESTAURANT_SEARCH =
    	    "SELECT * FROM restaurants   WHERE LOWER(res_name) LIKE LOWER(?)  OR LOWER(res_location) LIKE LOWER(?)";

    
    
    // 1️⃣ Get DB Connection
    private Connection getConnection() throws SQLException {
    	try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // 2️⃣ Insert Restaurant
    @Override
    public boolean insertRestaurants(Restaurants r) {
        String sql = "INSERT INTO restaurants VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, r.getRestaurantId());
            ps.setString(2, r.getResName());
            ps.setFloat(3, r.getResRating());
            ps.setString(4, r.getResEta());
            ps.setString(5, r.getResLocation());
            ps.setString(6, r.getResImage());
            ps.setString(7, r.getResDescription());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 3️⃣ Get All Restaurants
    @Override
    public  List<Restaurants> getAllRestaurants() {
        List<Restaurants> list = new ArrayList<>();
        String sql = "SELECT * FROM restaurants";

        try (Connection con = getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                Restaurants r = new Restaurants();
                r.setRestaurantId(rs.getInt("restaurant_id"));
                r.setResName(rs.getString("res_name"));
                r.setResRating(rs.getFloat("res_rating"));
                r.setResEta(rs.getString("res_eta"));
                r.setResLocation(rs.getString("res_location"));
                r.setResImage(rs.getString("res_image"));
                r.setResDescription(rs.getString("res_description"));

                list.add(r);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 4️⃣ Get Restaurant By ID
    @Override
    public Restaurants getRestaurantById(int id) {
        String sql = "SELECT * FROM restaurants WHERE restaurant_id = ?";
        Restaurants r = null;

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                r = new Restaurants();
                r.setRestaurantId(rs.getInt("restaurant_id"));
                r.setResName(rs.getString("res_name"));
                r.setResRating(rs.getFloat("res_rating"));
                r.setResEta(rs.getString("res_eta"));
                r.setResLocation(rs.getString("res_location"));
                r.setResImage(rs.getString("res_image"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return r;
    }

    // 5️⃣ Update Restaurant
    @Override
    public boolean updateRestaurant(Restaurants r) {
        String sql = "UPDATE restaurants SET res_name=?, res_rating=?, res_eta=?, res_location=?, res_image=? WHERE restaurant_id=?";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, r.getResName());
            ps.setFloat(2, r.getResRating());
            ps.setString(3, r.getResEta());
            ps.setString(4, r.getResLocation());
            ps.setString(5, r.getResImage());
            ps.setInt(6, r.getRestaurantId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 6️⃣ Delete Restaurant
    @Override
    public boolean deleteRestaurant(int id) {
        String sql = "DELETE FROM restaurants WHERE restaurant_id=?";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 3️⃣ Get All Restaurants
    @Override
    public  List<Restaurants> getAllRestaurantsByRating() {
        List<Restaurants> list = new ArrayList<>();
      

        try (Connection con = getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(GET_RESTAURANT_RATING)) {

            while (rs.next()) {
                Restaurants r = new Restaurants();
                r.setRestaurantId(rs.getInt("restaurant_id"));
                r.setResName(rs.getString("res_name"));
                r.setResRating(rs.getFloat("res_rating"));
                r.setResEta(rs.getString("res_eta"));
                r.setResLocation(rs.getString("res_location"));
                r.setResImage(rs.getString("res_image"));
                r.setResDescription(rs.getString("res_description"));

                list.add(r);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // 3️⃣ Get All Restaurants
    @Override
    public  List<Restaurants> getAllRestaurantsByDeliveryTime() {
        List<Restaurants> list = new ArrayList<>();
        

        try (Connection con = getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(GET_RESTAURANT_DELIVERYTIME)) {

            while (rs.next()) {
                Restaurants r = new Restaurants();
                r.setRestaurantId(rs.getInt("restaurant_id"));
                r.setResName(rs.getString("res_name"));
                r.setResRating(rs.getFloat("res_rating"));
                r.setResEta(rs.getString("res_eta"));
                r.setResLocation(rs.getString("res_location"));
                r.setResImage(rs.getString("res_image"));
                r.setResDescription(rs.getString("res_description"));

                list.add(r);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
 // 3️⃣ Get All Restaurants
    @Override
    public  List<Restaurants> getAllRestaurantsBySearch(String searchLike) {
        List<Restaurants> list = new ArrayList<>();
        

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(GET_RESTAURANT_SEARCH);)
        		{
        			pst.setString(1,"%"+searchLike+"%");
            		pst.setString(2,"%"+searchLike+"%");
                 ResultSet rs = pst.executeQuery() ;

            while (rs.next()) {
                Restaurants r = new Restaurants();
                r.setRestaurantId(rs.getInt("restaurant_id"));
                r.setResName(rs.getString("res_name"));
                r.setResRating(rs.getFloat("res_rating"));
                r.setResEta(rs.getString("res_eta"));
                r.setResLocation(rs.getString("res_location"));
                r.setResImage(rs.getString("res_image"));
                r.setResDescription(rs.getString("res_description"));

                list.add(r);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}

