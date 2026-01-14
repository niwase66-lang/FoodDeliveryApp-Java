package com.jn.models;


public class AllAddress {

    private int addressId;
    private int userId;
    private String address;
    private String addressType;
    private String contactNumber;
    

    // 🔹 No-argument constructor
    public AllAddress() {
    }

    // 🔹 Parameterized constructor
    public AllAddress( int userId, String address, String addressType,String contactNumber) {
        this.addressId = addressId;
        this.userId = userId;
        this.address = address;
        this.addressType = addressType;
        this.contactNumber=contactNumber;
    }

    // 🔹 Getters and Setters
    
    

    public int getAddressId() {
        return addressId;
    }

    public String getContactNumber() {
		return contactNumber;
	}

	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}

	public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAddressType() {
        return addressType;
    }

    public void setAddressType(String addressType) {
        this.addressType = addressType;
    }

    @Override
    public String toString() {
        return "Address [addressId=" + addressId +
               ", userId=" + userId +
               ", address=" + address +
               ", addressType=" + addressType + "]";
    }
}

