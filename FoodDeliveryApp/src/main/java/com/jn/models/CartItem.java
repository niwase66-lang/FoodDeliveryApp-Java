package com.jn.models;



public class CartItem {
    private int itemId;
    private String itemName;
    private Double itemPrice;      // ✔ Double instead of int
    private int itemQuantity;
    private String restaurantName;
    private int restaurantId;

    // ✅ No-argument constructor
    public CartItem() {
    }

    // ✅ Parameterized constructor
    public CartItem(String itemName, Double itemPrice, int itemQuantity,
                String restaurantName, int restaurantId) {
        this.itemName = itemName;
        this.itemPrice = itemPrice;
        this.itemQuantity = itemQuantity;
        this.restaurantName = restaurantName;
        this.restaurantId = restaurantId;
    }

    /* ========== GETTERS & SETTERS ========== */
    

    public int getItemId() {
		return itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public Double getItemPrice() {
        return itemPrice;
    }

    public void setItemPrice(Double itemPrice) {
        this.itemPrice = itemPrice;
    }

    public int getItemQuantity() {
        return itemQuantity;
    }

    public void setItemQuantity(int itemQuantity) {
        this.itemQuantity = itemQuantity;
    }

    public String getRestaurantName() {
        return restaurantName;
    }

    public void setRestaurantName(String restaurantName) {
        this.restaurantName = restaurantName;
    }

    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

    // ✅ Utility method: calculate total price
    public Double getTotalPrice() {
        return itemPrice * itemQuantity;
    }

    @Override
    public String toString() {
        return "Cart{" +
                "itemName='" + itemName + '\'' +
                ", itemPrice=" + itemPrice +
                ", itemQuantity=" + itemQuantity +
                ", restaurantName='" + restaurantName + '\'' +
                ", restaurantId=" + restaurantId +
                '}';
    }
}

