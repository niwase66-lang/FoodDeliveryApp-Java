package com.jn.daoimpl;



import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.jn.dao.MenuDAO;
import com.jn.models.Menu;
import com.jn.util.DBConnection;

public class MenuDAOImpl implements MenuDAO {

    private static final String INSERT_MENU =
        "INSERT INTO menu (restaurant_id, item_name, item_desc, item_rating, item_price, item_category) VALUES (?, ?, ?, ?, ?, ?)";

    private static final String UPDATE_MENU =
        "UPDATE menu SET restaurant_id=?, item_name=?, item_desc=?, item_rating=?, item_price=?, item_category=? WHERE item_id=?";

    private static final String DELETE_MENU =
        "DELETE FROM menu WHERE item_id=?";

    private static final String SELECT_BY_ID =
        "SELECT * FROM menu WHERE item_id=?";

    private static final String SELECT_ALL =
        "SELECT * FROM menu";

    private static final String SELECT_BY_RESTAURANT =
        "SELECT * FROM menu WHERE restaurant_id=?";

    private static final String SEARCH_MENU =
        "SELECT * FROM menu WHERE item_name LIKE ?";

    private static final String SELECT_BY_RATING =
        "SELECT * FROM menu WHERE item_rating >= ?";

    private static final String SELECT_BY_PRICE =
        "SELECT * FROM menu WHERE item_price <= ?";

    // ➕ Add Menu Item
    @Override
    public boolean addMenuItem(Menu menu) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(INSERT_MENU)) {

            ps.setInt(1, menu.getRestaurantId());
            ps.setString(2, menu.getItemName());
            ps.setString(3, menu.getItemDesc());
            ps.setFloat(4, menu.getItemRating());
            ps.setInt(5, menu.getItemPrice());
            ps.setString(6, menu.getItemCategory());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✏️ Update Menu Item
    @Override
    public boolean updateMenuItem(Menu menu) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(UPDATE_MENU)) {

            ps.setInt(1, menu.getRestaurantId());
            ps.setString(2, menu.getItemName());
            ps.setString(3, menu.getItemDesc());
            ps.setFloat(4, menu.getItemRating());
            ps.setInt(5, menu.getItemPrice());
            ps.setString(6, menu.getItemCategory());
            
            ps.setInt(7, menu.getItemId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ❌ Delete Menu Item
    @Override
    public boolean deleteMenuItem(int itemId) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(DELETE_MENU)) {

            ps.setInt(1, itemId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 🔍 Get Menu Item by ID
    @Override
    public Menu getMenuItemById(int itemId) {
        Menu menu = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_BY_ID)) {

            ps.setInt(1, itemId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                menu = extractMenu(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menu;
    }

    // 📋 Get All Menu Items
    @Override
    public List<Menu> getAllMenuItems() {
        List<Menu> menuList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_ALL);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                menuList.add(extractMenu(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuList;
    }

    // 🍽️ Get Menu by Restaurant ID
    @Override
    public List<Menu> getMenuByRestaurantId(int restaurantId) {
        List<Menu> menuList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_BY_RESTAURANT)) {

            ps.setInt(1, restaurantId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                menuList.add(extractMenu(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuList;
    }

    // 🔎 Search Menu Items
    @Override
    public List<Menu> searchMenuItems(String keyword) {
        List<Menu> menuList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SEARCH_MENU)) {

            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                menuList.add(extractMenu(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuList;
    }

    // ⭐ Filter by Rating
    @Override
    public List<Menu> getMenuByRating(float minRating) {
        List<Menu> menuList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_BY_RATING)) {

            ps.setFloat(1, minRating);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                menuList.add(extractMenu(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuList;
    }

    // 💰 Filter by Price
    @Override
    public List<Menu> getMenuByMaxPrice(int maxPrice) {
        List<Menu> menuList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_BY_PRICE)) {

            ps.setInt(1, maxPrice);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                menuList.add(extractMenu(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuList;
    }

    // 🔁 Utility Method to map ResultSet → Menu
    private Menu extractMenu(ResultSet rs) throws SQLException {
        Menu menu = new Menu();
        menu.setItemId(rs.getInt("item_id"));
        menu.setRestaurantId(rs.getInt("restaurant_id"));
        menu.setItemName(rs.getString("item_name"));
        menu.setItemDesc(rs.getString("item_desc"));
        menu.setItemRating(rs.getFloat("item_rating"));
        menu.setItemPrice(rs.getInt("item_price"));
        menu.setItemCategory(rs.getString("item_category"));
        menu.setItemImg(rs.getString("item_img"));
        return menu;
    }
}

