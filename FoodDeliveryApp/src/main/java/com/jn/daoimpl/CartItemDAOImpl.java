package com.jn.daoimpl;


import com.jn.dao.CartItemDAO;
import com.jn.models.CartItem;

import java.util.ArrayList;
import java.util.List;

public class CartItemDAOImpl implements CartItemDAO {

    private List<CartItem> cartItems;

    // Constructor initializes empty cart
    public CartItemDAOImpl() {
        this.cartItems = new ArrayList<>();
    }

    /* ================= ADD ITEM ================= */

    @Override
    public void addItem(CartItem cartItem) {

        for (CartItem item : cartItems) {
            if (item.getItemId() == cartItem.getItemId()) {
                // Item already in cart → increase quantity
                item.setItemQuantity(
                        item.getItemQuantity() + cartItem.getItemQuantity()
                );
                return;
            }
        }
        // New item
        cartItems.add(cartItem);
    }

    /* ================= UPDATE QUANTITY ================= */

    @Override
    public void updateItemQuantity(int itemId, int quantity) {

        for (CartItem item : cartItems) {
            if (item.getItemId() == itemId) {

                if (quantity <= 0) {
                    removeItem(itemId);
                } else {
                    item.setItemQuantity(quantity);
                }
                return;
            }
        }
    }

    /* ================= REMOVE ITEM ================= */

    @Override
    public void removeItem(int itemId) {
        cartItems.removeIf(item -> item.getItemId() == itemId);
    }

    /* ================= GET ITEM ================= */

    @Override
    public CartItem getItemById(int itemId) {

        for (CartItem item : cartItems) {
            if (item.getItemId() == itemId) {
                return item;
            }
        }
        return null;
    }

    /* ================= GET ALL ITEMS ================= */

    @Override
    public List<CartItem> getCartItems() {
        return cartItems;
    }

    /* ================= CLEAR CART ================= */

    @Override
    public void clearCart() {
        cartItems.clear();
    }

    /* ================= TOTAL AMOUNT ================= */

    @Override
    public Double getTotalAmount() {

        double total = 0.0;

        for (CartItem item : cartItems) {
            total += item.getItemPrice() * item.getItemQuantity();
        }
        return total;
    }
}


