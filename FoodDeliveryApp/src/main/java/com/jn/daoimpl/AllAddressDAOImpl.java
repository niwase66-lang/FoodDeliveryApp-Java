package com.jn.daoimpl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.jn.dao.AllAddressDAO;
import com.jn.models.AllAddress;
import com.jn.util.DBConnection;

public class AllAddressDAOImpl implements AllAddressDAO {

    private static final String INSERT_ADDRESS =
        "INSERT INTO all_address (user_id, address, address_type, contact_num) VALUES (?, ?, ?, ?)";

    private static final String SELECT_BY_USER =
        "SELECT * FROM all_address WHERE user_id = ? order by address_id desc limit 2";

    private static final String SELECT_BY_ID =
        "SELECT * FROM all_address WHERE address_id = ?";

    private static final String UPDATE_ADDRESS =
        "UPDATE all_address SET address = ?, address_type = ? WHERE address_id = ?";

    private static final String DELETE_ADDRESS =
        "DELETE FROM all_address WHERE address_id = ?";

    // 🔹 Add Address
    @Override
    public boolean addAddress(AllAddress address) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(INSERT_ADDRESS)) {

            ps.setInt(1, address.getUserId());
            ps.setString(2, address.getAddress());
            ps.setString(3, address.getAddressType());
            ps.setString(4, address.getContactNumber());
            

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 🔹 Get all addresses of a user
    @Override
    public List<AllAddress> getAddressesByUserId(int userId) {
        List<AllAddress> addresses = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_BY_USER)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                addresses.add(extractAddress(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return addresses;
    }

    // 🔹 Get address by ID
    @Override
    public AllAddress getAddressById(int addressId) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_BY_ID)) {

            ps.setInt(1, addressId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return extractAddress(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 🔹 Update address
    @Override
    public boolean updateAddress(AllAddress address) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(UPDATE_ADDRESS)) {

            ps.setString(1, address.getAddress());
            ps.setString(2, address.getAddressType());
            ps.setInt(3, address.getAddressId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 🔹 Delete address
    @Override
    public boolean deleteAddress(int addressId) {
        try (Connection con =DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(DELETE_ADDRESS)) {

            ps.setInt(1, addressId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 🔹 Common ResultSet mapper
    private AllAddress extractAddress(ResultSet rs) throws SQLException {
        AllAddress address = new AllAddress();
        address.setAddressId(rs.getInt("address_id"));
        address.setUserId(rs.getInt("user_id"));
        address.setAddress(rs.getString("address"));
        address.setAddressType(rs.getString("address_type"));
        return address;
    }
}
