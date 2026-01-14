package com.jn.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.jn.dao.OrderDAO;
import com.jn.models.Order;
import com.jn.util.DBConnection;

public class OrderDAOImpl implements OrderDAO {

    private static final String INSERT_ORDER =
        "INSERT INTO orders (user_id, restaurant_id, address, payment_mode, status, order_date, total_amount) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?)";

    private static final String SELECT_BY_ID =
        "SELECT * FROM orders WHERE order_id = ?";

    private static final String SELECT_BY_USER =
        "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";

    private static final String SELECT_BY_RESTAURANT =
        "SELECT * FROM orders WHERE restaurant_id = ? ORDER BY order_date DESC";

    private static final String UPDATE_STATUS =
        "UPDATE orders SET status = ? WHERE order_id = ?";

    private static final String UPDATE_PAYMENT =
        "UPDATE orders SET payment_mode = ? WHERE order_id = ?";

    private static final String DELETE_ORDER =
        "DELETE FROM orders WHERE order_id = ?";

    // ================= CREATE ORDER =================
    @Override
    public int createOrder(Order order) {
        int orderId = 0;

        try (Connection con =DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     INSERT_ORDER, PreparedStatement.RETURN_GENERATED_KEYS)) {
//        	con.setAutoCommit(false);

            ps.setInt(1, order.getUserId());
            ps.setInt(2, order.getRestaurantId());
            ps.setString(3, order.getAddress());
            ps.setString(4, order.getPaymentMode());
            ps.setString(5, order.getStatus());
            ps.setTimestamp(6, order.getOrderDate());
            ps.setDouble(7, order.getTotalAmount());

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderId;
    }

    // ================= GET ORDER BY ID =================
    @Override
    public Order getOrderById(int orderId) {
        Order order = null;

        try (Connection con =DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_BY_ID)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                order = extractOrder(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return order;
    }

    // ================= GET ORDERS BY USER =================
    @Override
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_BY_USER)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                orders.add(extractOrder(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    // ================= GET ORDERS BY RESTAURANT =================
    @Override
    public List<Order> getOrdersByRestaurantId(int restaurantId) {
        List<Order> orders = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_BY_RESTAURANT)) {

            ps.setInt(1, restaurantId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                orders.add(extractOrder(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    // ================= UPDATE STATUS =================
    @Override
    public boolean updateOrderStatus(int orderId, String status) {
        boolean updated = false;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(UPDATE_STATUS)) {

            ps.setString(1, status);
            ps.setInt(2, orderId);

            updated = ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return updated;
    }

    // ================= UPDATE PAYMENT MODE =================
    @Override
    public boolean updatePaymentMode(int orderId, String paymentMode) {
        boolean updated = false;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(UPDATE_PAYMENT)) {

            ps.setString(1, paymentMode);
            ps.setInt(2, orderId);

            updated = ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return updated;
    }

    // ================= DELETE ORDER =================
    @Override
    public boolean deleteOrder(int orderId) {
        boolean deleted = false;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(DELETE_ORDER)) {

            ps.setInt(1, orderId);
            deleted = ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return deleted;
    }

    // ================= RESULTSET → POJO =================
    private Order extractOrder(ResultSet rs) throws SQLException {
        Order order = new Order();

        order.setOrderId(rs.getInt("order_id"));
        order.setUserId(rs.getInt("user_id"));
        order.setRestaurantId(rs.getInt("restaurant_id"));
        order.setAddress(rs.getString("address"));
        order.setPaymentMode(rs.getString("payment_mode"));
        order.setStatus(rs.getString("status"));
        order.setOrderDate(rs.getTimestamp("order_date"));
        order.setTotalAmount(rs.getDouble("total_amount"));

        return order;
    }
}
