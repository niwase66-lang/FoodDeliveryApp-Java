package com.jn.dao;

import java.util.List;
import com.jn.models.OrderItem;

public interface OrderItemDAO {

    // 🔹 Add an item to an order
    boolean addOrderItem(OrderItem orderItem);

    // 🔹 Get all items for a specific order
    List<OrderItem> getItemsByOrderId(int orderId);

    // 🔹 Delete all items of an order (useful on order cancel)
    boolean deleteItemsByOrderId(int orderId);

    // 🔹 Delete a single item from order
    boolean deleteOrderItem(int orderItemId);
}
