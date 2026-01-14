package com.jn.dao;



import java.util.List;
import com.jn.models.Menu;

public interface MenuDAO {

    // ➕ Add new menu item
    boolean addMenuItem(Menu menu);

    // ✏️ Update existing menu item
    boolean updateMenuItem(Menu menu);

    // ❌ Delete menu item by item_id
    boolean deleteMenuItem(int itemId);

    // 🔍 Get menu item by item_id
    Menu getMenuItemById(int itemId);

    // 📋 Get all menu items
    List<Menu> getAllMenuItems();

    // 🍽️ Get menu items by restaurant_id
    List<Menu> getMenuByRestaurantId(int restaurantId);

    // 🔎 Search menu items by name
    List<Menu> searchMenuItems(String keyword);

    // ⭐ Get menu items with minimum rating
    List<Menu> getMenuByRating(float minRating);

    // 💰 Get menu items under a price
    List<Menu> getMenuByMaxPrice(int maxPrice);
}

