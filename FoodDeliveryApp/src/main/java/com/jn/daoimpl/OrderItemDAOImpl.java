package com.jn.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.jn.dao.OrderItemDAO;
import com.jn.models.OrderItem;
import com.jn.util.DBConnection;

public class OrderItemDAOImpl implements OrderItemDAO {

    private static final String INSERT_ORDER_ITEM =
        "INSERT INTO order_items (order_id,item_id, item_name, quantity, total_price) VALUES (?, ?, ?, ?, ?)";

    private static final String SELECT_BY_ORDER_ID =
        "SELECT * FROM order_items WHERE order_id = ?";

    private static final String DELETE_BY_ORDER_ID =
        "DELETE FROM order_items WHERE order_id = ?";

    private static final String DELETE_BY_ORDER_ITEM_ID =
        "DELETE FROM order_items WHERE order_item_id = ?";
    
    Connection con;

    // ================= ADD ORDER ITEM =================
    @Override
    public boolean addOrderItem(OrderItem orderItem) {
        boolean inserted = false;

        try {
        	con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(INSERT_ORDER_ITEM) ;

            ps.setInt(1, orderItem.getOrderId());
            ps.setInt(2, orderItem.getItemId());
            ps.setString(3, orderItem.getItemName());
            ps.setInt(4, orderItem.getQuantity());
            ps.setDouble(5, orderItem.getTotalPrice());

            inserted = ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
      
        

        return inserted;
    }

    // ================= GET ITEMS BY ORDER ID =================
    @Override
    public List<OrderItem> getItemsByOrderId(int orderId) {
        List<OrderItem> items = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_BY_ORDER_ID)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                items.add(extractOrderItem(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return items;
    }

    // ================= DELETE ITEMS BY ORDER ID =================
    @Override
    public boolean deleteItemsByOrderId(int orderId) {
        boolean deleted = false;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(DELETE_BY_ORDER_ID)) {

            ps.setInt(1, orderId);
            deleted = ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return deleted;
    }

    // ================= DELETE SINGLE ORDER ITEM =================
    @Override
    public boolean deleteOrderItem(int orderItemId) {
        boolean deleted = false;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(DELETE_BY_ORDER_ITEM_ID)) {

            ps.setInt(1, orderItemId);
            deleted = ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return deleted;
    }

    // ================= RESULTSET → POJO =================
    private OrderItem extractOrderItem(ResultSet rs) throws SQLException {

        OrderItem item = new OrderItem();

        item.setOrderItemId(rs.getInt("order_item_id"));
        item.setOrderId(rs.getInt("order_id"));
        item.setItemId(rs.getInt("item_id"));
        
        item.setItemName(rs.getString("item_name"));
        item.setQuantity(rs.getInt("quantity"));
        item.setTotalPrice(rs.getDouble("total_price"));

        return item;
    }
}
