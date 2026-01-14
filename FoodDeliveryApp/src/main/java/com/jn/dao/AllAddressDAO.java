package com.jn.dao;

import java.util.List;
import com.jn.models.AllAddress;

public interface AllAddressDAO {

    // 🔹 Add a new address
    boolean addAddress(AllAddress address);

    // 🔹 Get all addresses of a user
    List<AllAddress> getAddressesByUserId(int userId);

    // 🔹 Get single address by address_id
    AllAddress getAddressById(int addressId);

    // 🔹 Update existing address
    boolean updateAddress(AllAddress address);

    // 🔹 Delete address
    boolean deleteAddress(int addressId);
}
