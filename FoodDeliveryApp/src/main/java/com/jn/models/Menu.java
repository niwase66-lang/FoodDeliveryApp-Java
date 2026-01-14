package com.jn.models;


public class Menu {

    private int itemId;
    private int restaurantId;
    private String itemName;
    private String itemDesc;
    private float itemRating;
    private int itemPrice;
    private String itemCategory;
    private String itemImg;
    

    // ✅ No-argument constructor (required for frameworks & JDBC)
    public Menu() {
    }

    // ✅ Parameterized constructor
    public Menu(int itemId, int restaurantId, String itemName, String itemDesc,
                float itemRating, int itemPrice,String itemCategory) {
        this.itemId = itemId;
        this.restaurantId = restaurantId;
        this.itemName = itemName;
        this.itemDesc = itemDesc;
        this.itemRating = itemRating;
        this.itemPrice = itemPrice;
        this.itemCategory=itemCategory;
    }

    // ✅ Getters and Setters
    
    
    public int getItemId() {
        return itemId;
    }

    public String getItemImg() {
		return itemImg;
	}

	public void setItemImg(String itemImg) {
		this.itemImg = itemImg;
	}

	public String getItemCategory() {
		return itemCategory;
	}

	public void setItemCategory(String itemCategory) {
		this.itemCategory = itemCategory;
	}

	public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getItemDesc() {
        return itemDesc;
    }

    public void setItemDesc(String itemDesc) {
        this.itemDesc = itemDesc;
    }

    public float getItemRating() {
        return itemRating;
    }

    public void setItemRating(float itemRating) {
        this.itemRating = itemRating;
    }

    public int getItemPrice() {
        return itemPrice;
    }

    public void setItemPrice(int itemPrice) {
        this.itemPrice = itemPrice;
    }

    // ✅ Optional: toString() for debugging/logging
    @Override
    public String toString() {
        return "Menu{" +
                "itemId=" + itemId +
                ", restaurantId=" + restaurantId +
                ", itemName='" + itemName + '\'' +
                ", itemDesc='" + itemDesc + '\'' +
                ", itemRating=" + itemRating +
                ", itemPrice=" + itemPrice +
                ", itemCategory=" + itemCategory +
                '}';
    }
}

