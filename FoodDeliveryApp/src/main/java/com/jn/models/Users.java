package com.jn.models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.jn.util.DBConnection;

public class Users {

    // Composite Primary Key
    private int userId;
    private String category;   // DB default applies if not set

    // Other columns
    private String userName;
    private String userNum;
    private String userEmail;
    private String password;
    private String userLocation;
    
//    insert query
    private final String INSERT_INTO_ALLADDRESS="INSERT INTO all_address (user_id,address,address_type,contact_num) values (?,?,?,?)";

    // ✅ No-argument constructor (mandatory)
    public Users() {
    }

    // ✅ Constructor for registration (DB default category)
    public Users(String userName, String userNum, String userEmail, String password, String userLocation) {
        this.userNum = userNum;
        this.userEmail = userEmail;
        this.password = password;
        this.userLocation = userLocation;
        this.userName=userName;
    }

    // ✅ Constructor when category is explicitly set
    public Users(String category,String userName, String userNum, String userEmail,
                String password, String userLocation) {
        this.category = category;
        this.userNum = userNum;
        this.userEmail = userEmail;
        this.password = password;
        this.userLocation = userLocation;
        this.userName=userName;
    }

    // ✅ Full constructor (used while fetching from DB)
    public Users(int userId, String category,String userName, String userNum,
                String userEmail, String password, String userLocation) {
        this.userId = userId;
        this.category = category;
        this.userNum = userNum;
        this.userEmail = userEmail;
        this.password = password;
        this.userLocation = userLocation;
        this.userName=userName;
    }

    /* ========== GETTERS & SETTERS ========== */
    
    

    public int getUserId() {
        return userId;
    }

    public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getCategory() {
        return category;
    }

    // Optional: only set if needed
    public void setCategory(String category) {
        this.category = category;
    }

    public String getUserNum() {
        return userNum;
    }

    public void setUserNum(String userNum) {
        this.userNum = userNum;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    // ⚠️ Password should be HASHED in DAO / Service layer
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserLocation() {
        return userLocation;
    }

    public void setUserLocation(String userLocation) {
        this.userLocation = userLocation;
    }
    public void setUserLocation(String userLocation,int userId,String addressType,String contactNum) {
        this.userLocation = userLocation;
        this.userNum=contactNum;
        Connection con = DBConnection.getConnection();
        
        try {
			PreparedStatement ps = con.prepareStatement(INSERT_INTO_ALLADDRESS);
			ps.setInt(1, userId);
			ps.setString(2, userLocation);
			ps.setString(3, addressType);
			ps.setString(4, contactNum);
			
			ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

    // ❌ Avoid printing password in logs in real apps
    @Override
    public String toString() {
        return "User{" +"userName=" + userName +
                "userId=" + userId +
                ", category='" + category + '\'' +
                ", userNum='" + userNum + '\'' +
                ", userEmail='" + userEmail + '\'' +
                ", userLocation='" + userLocation + '\'' +
                '}';
    }
}

