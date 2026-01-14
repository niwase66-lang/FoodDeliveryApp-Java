package com.jn.dao;



import com.jn.models.CartItem;
import java.util.List;

public interface CartItemDAO {

    // ➕ Add item to cart (if exists, quantity should increase in impl)
    void addItem(CartItem cartItem);

    // ✏️ Update quantity using PRIMARY KEY (itemId)
    void updateItemQuantity(int itemId, int quantity);

    // ❌ Remove item using PRIMARY KEY (itemId)
    void removeItem(int itemId);

    // 🔍 Get single cart item by itemId
    CartItem getItemById(int itemId);

    // 📋 Get all cart items
    List<CartItem> getCartItems();

    // 🧹 Clear entire cart
    void clearCart();

    // 💰 Get total cart amount
    Double getTotalAmount();
}

