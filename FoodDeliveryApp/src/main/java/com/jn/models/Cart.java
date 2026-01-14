package com.jn.models;

import java.util.LinkedHashMap;
import java.util.Map;

public class Cart {
	Map<Integer,CartItem> cartItems;

	public Cart() {
		cartItems = new LinkedHashMap<Integer,CartItem>();
	}

	public Map<Integer,CartItem> getItems(){
		return cartItems;
	}
//add method
	public void addCartItems(CartItem cartItem) {
		int itemId = cartItem.getItemId();
		if(cartItems.containsKey(itemId)) {
			CartItem oldCartItem = cartItems.get(itemId);
			int oldQty=oldCartItem.getItemQuantity();
			int newQty = cartItem.getItemQuantity();

			oldCartItem.setItemQuantity(oldQty+newQty);

		}
		else {
			cartItems.put(itemId, cartItem);
		}

		System.out.println(cartItem);
	}
	
//	get cartItem

	public CartItem getCartItem(int itemId) {
		return cartItems.get(itemId);

	}
	
//	remove cart
	
	public void removeCartItem(int itemId) {
		cartItems.remove(itemId);
	}


// set cart item
	public void setCartItem(int itemId,CartItem cartItem) {
		cartItems.put(itemId, cartItem);
	}

}
