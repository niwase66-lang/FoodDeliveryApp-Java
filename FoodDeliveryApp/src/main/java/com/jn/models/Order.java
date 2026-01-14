package com.jn.models;


import java.sql.Timestamp;

public class Order {

    private int orderId;
    private int userId;
    private int restaurantId;
    private String address;
    private String paymentMode;
    private String status;
    private Timestamp orderDate;
    private double totalAmount;

    // 🔹 No-arg constructor
    public Order() {
    }

    // 🔹 Parameterized constructor
    public Order(int orderId, int userId, int restaurantId, String address,
                 String paymentMode, String status, Timestamp orderDate, double totalAmount) {
        this.orderId = orderId;
        this.userId = userId;
        this.restaurantId = restaurantId;
        this.address = address;
        this.paymentMode = paymentMode;
        this.status = status;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
    }
    
 // 🔹 Parameterized constructor
    public Order( int userId, int restaurantId, String address,
                 String paymentMode, String status, Timestamp orderDate, double totalAmount) {
        
        this.userId = userId;
        this.restaurantId = restaurantId;
        this.address = address;
        this.paymentMode = paymentMode;
        this.status = status;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
    }

    // 🔹 Getters and Setters

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPaymentMode() {
        return paymentMode;
    }

    public void setPaymentMode(String paymentMode) {
        this.paymentMode = paymentMode;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    @Override
    public String toString() {
        return "Order [orderId=" + orderId +
                ", userId=" + userId +
                ", restaurantId=" + restaurantId +
                ", address=" + address +
                ", paymentMode=" + paymentMode +
                ", status=" + status +
                ", orderDate=" + orderDate +
                ", totalAmount=" + totalAmount + "]";
    }
}

