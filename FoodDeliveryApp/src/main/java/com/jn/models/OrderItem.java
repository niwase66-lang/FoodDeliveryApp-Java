package com.jn.models;

public class OrderItem {

    private int orderItemId;
    private int orderId;
    private int itemId;
    private String itemName;
    private int quantity;
    private double totalPrice;
    private double price;
    // 🔹 No-argument constructor
    public OrderItem() {
    }

    // 🔹 Parameterized constructor
    public OrderItem( int orderId,int itemId, String itemName,
                     int quantity, double totalPrice) {
        this.itemId = itemId;
        this.orderId = orderId;
        this.itemName = itemName;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
    }

    // 🔹 Getters and Setters
    
    public double getPrice(){
    	return totalPrice/quantity;
    }
    

    public int getOrderItemId() {
        return orderItemId;
    }

    public int getItemId() {
		return itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	public void setOrderItemId(int orderItemId) {
        this.orderItemId = orderItemId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    @Override
    public String toString() {
        return "OrderItem ["  +
               "orderId=" + orderId +
               ", itemName=" + itemName +
               ", quantity=" + quantity +
               ", totalPrice=" + totalPrice + "]";
    }
}
