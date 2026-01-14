package com.jn.dao;

import java.util.List;
import com.jn.models.Order;

public interface OrderDAO {

    // 🔹 Create a new order
    int createOrder(Order order);

    // 🔹 Get order by orderId
    Order getOrderById(int orderId);

    // 🔹 Get all orders of a user
    List<Order> getOrdersByUserId(int userId);

    // 🔹 Get all orders for a restaurant
    List<Order> getOrdersByRestaurantId(int restaurantId);

    // 🔹 Update order status (Placed, Preparing, Delivered, Cancelled)
    boolean updateOrderStatus(int orderId, String status);

    // 🔹 Update payment mode
    boolean updatePaymentMode(int orderId, String paymentMode);

    // 🔹 Delete an order (optional / admin use)
    boolean deleteOrder(int orderId);
}
