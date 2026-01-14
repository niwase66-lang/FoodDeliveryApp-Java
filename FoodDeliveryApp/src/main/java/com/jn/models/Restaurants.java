package com.jn.models;

public class Restaurants {

    private int restaurantId;
    private String resName;
    private float resRating;
    private String resEta;
    private String resLocation;
    private String resImage;
    private String resDescription;

    // No-argument constructor (required for frameworks)
    public Restaurants() {
    }

    // Parameterized constructor
    public Restaurants(int restaurantId, String resName, float resRating,
                      String resEta, String resLocation, String resImage,String resDescription) {
        this.restaurantId = restaurantId;
        this.resName = resName;
        this.resRating = resRating;
        this.resEta = resEta;
        this.resLocation = resLocation;
        this.resImage = resImage;
        this.resDescription=resDescription;
    }

    // Getters and Setters
    
    
    public int getRestaurantId() {
        return restaurantId;
    }

    public String getResDescription() {
		return resDescription;
	}

	public void setResDescription(String resDescription) {
		this.resDescription = resDescription;
	}

	public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

    public String getResName() {
        return resName;
    }

    public void setResName(String resName) {
        this.resName = resName;
    }

    public float getResRating() {
        return resRating;
    }

    public void setResRating(float resRating) {
        this.resRating = resRating;
    }

    public String getResEta() {
        return resEta;
    }

    public void setResEta(String resEta) {
        this.resEta = resEta;
    }

    public String getResLocation() {
        return resLocation;
    }

    public void setResLocation(String resLocation) {
        this.resLocation = resLocation;
    }

    public String getResImage() {
        return resImage;
    }

    public void setResImage(String resImage) {
        this.resImage = resImage;
    }

    // Optional: toString() for debugging
    @Override
    public String toString() {
        return "Restaurant{" +
                "restaurantId=" + restaurantId +
                ", resName='" + resName + '\'' +
                ", resRating=" + resRating +
                ", resEta='" + resEta + '\'' +
                ", resLocation='" + resLocation + '\'' +
                ", resImage='" + resImage + '\'' +
                ", resDescription='" + resDescription + '\''+
                '}';
    }
}

