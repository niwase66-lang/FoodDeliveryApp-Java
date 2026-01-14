package com.jn.dao;
import com.jn.models.Restaurants;

import java.util.List;

public interface RestaurantsDAO {
	
        // Insert new restaurant
	    boolean insertRestaurants(Restaurants restaurant);

	    // Fetch all restaurants
	    List<Restaurants> getAllRestaurants();

	    // Fetch restaurant by ID
	    Restaurants getRestaurantById(int restaurantId);

	    // Update restaurant details
	    boolean updateRestaurant(Restaurants restaurant);

	    // Delete restaurant by ID
	    boolean deleteRestaurant(int restaurantId);
	    
	    // Get restaurants by Rating
	    public  List<Restaurants> getAllRestaurantsByRating();
	    
	    // Get restaurants by Delivery time
	    public  List<Restaurants> getAllRestaurantsByDeliveryTime();
	    
	    // Search by res name and Location
	    public  List<Restaurants> getAllRestaurantsBySearch(String searchLike);

	
	    
	   
	

}
