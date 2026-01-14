<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*,com.jn.models.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Cart | FoodExpress</title>

<link rel="stylesheet" href="Cart.css" />
</head>

<body>
<% Users user=(Users)session.getAttribute("user"); %>

<!-- NAVBAR -->
<nav class="navbar">
  <div class="logo">BITEZ</div>
  <div class="nav-links">
    <a href="callRestaurantsServlet">Home</a>
    <!-- the restaurant id = 1000 is for to get profile from menu where control comes from cart  -->
    <a href="callMenu?callFromCart=<%="Cart"%>&restaurantId=1000">Menu</a>
    <a <%if(user==null){ %> style="display: none;" <%} %> href="callRestaurantsServlet?fromProfile=true&fromCart=true">Profile</a>
  </div>
</nav>

<div class="cart-container">
  <h1 class="cart-title">My Cart</h1>
  
  <%! Map<Integer,CartItem> cartItems; 
  double grandTotal;
  %>
  
  <%Cart cart=(Cart)session.getAttribute("cart");
  if(cart!=null){
	  cartItems =cart.getItems();
	 
  }
  %>

  <!-- ============================= -->
  <!-- IF CART IS NULL / EMPTY -->
  <!-- ============================= -->
  
  <div <%if(cart!=null && !cart.getItems().isEmpty()){ %> style="display: none;" <% grandTotal=0.0; } %> class="empty-cart">
    <h2>Your cart is empty</h2>
    <p>Add some delicious food to get started</p>
    <a href="callRestaurantsServlet" class="btn">Browse Restaurants</a>
  </div>
  

  <!-- ============================= -->
  <!-- IF CART HAS ITEMS -->
  <!-- ============================= -->
  
  <% 
  if(cartItems!=null && cart!=null && !cart.getItems().isEmpty()){
	  
  %>
	  <div class="cart-grid">

    <div class="cart-header">
      <div>Item</div>
      <div>Price</div>
      <div>Quantity</div>
      <div>Total</div>
    </div>
	   <%for(CartItem cartItem: cartItems.values()){ 
	   grandTotal +=cartItem.getTotalPrice();
	   request.setAttribute("restaurantId", cartItem.getRestaurantId());
	   
	   %>
	   
		   

    <!-- ONE CART ITEM ROW -->
    <div class="cart-row">
      <div data-label="Item"><%=cartItem.getItemName() %></div>
      <div data-label="Price" class="price">₹<%=cartItem.getItemPrice() %></div>

      <div data-label="Quantity">
        <div class="qty-box">
        
           <form  action="callingCartServlet">
           <input type="hidden" name="itemId" value="<%=cartItem.getItemId() %>">
        <input type="hidden" name="restaurantId" value="<%=cartItem.getRestaurantId() %>">
  <input type="hidden" name="action" value="update">
  <input type="hidden" name="doing" value="-">
  <input type="hidden" name="callFromCartJsp" value="Cart.jsp">
  <button type="submit" class="qty-btn">−</button>
  </form>
          
          <span class="qty"><%=cartItem.getItemQuantity() %></span>
          
          <form  action="callingCartServlet">
           <input type="hidden" name="itemId" value="<%=cartItem.getItemId() %>">
        <input type="hidden" name="restaurantId" value="<%=cartItem.getRestaurantId() %>">
  <input type="hidden" name="action" value="update">
  <input type="hidden" name="doing" value="+">
  <input type="hidden" name="callFromCartJsp" value="Cart.jsp">
  <button type="submit" class="qty-btn">+</button>
  </form>
          
        </div>
        
      </div>

      <div data-label="Total" class="total">₹<%=cartItem.getTotalPrice() %></div>
      
      <div data-label="Remove">
    <form action="callingCartServlet">
      <input type="hidden" name="itemId" value="<%=cartItem.getItemId() %>">
      <input type="hidden" name="restaurantId" value="<%=cartItem.getRestaurantId() %>">
      <input type="hidden" name="action" value="remove">
      <input type="hidden" name="callFromCartJsp" value="Cart.jsp">
      <button type="submit" class="delete-btn">❌</button>
    </form>
  </div>
    </div>

    <!-- repeat cart-row for each item -->

  
	   <% }
	   session.setAttribute("grandTotal", grandTotal);
	   %>
	  </div> 
	  <%
  }
  else{
	  grandTotal=0.0;
  }
 
  %>
  

    <!-- repeat cart-row for each item -->

  </div>
  <% if(cart!=null && !cart.getItems().isEmpty()){ %>
  <!-- ===== GRAND TOTAL ===== -->
<div class="grand-total-box">
  <span class="grand-label">Grand Total</span>
  <span class="grand-amount">₹ <%=grandTotal %></span>
</div>


  <!-- ===== ACTION BUTTONS ===== -->
  <div class="cart-actions">
    <a href="callMenu?callFromCart=<%="Cart"%>" class="btn">Add More Items</a>
    <a href="CheckOut.jsp" class="btn">Checkout</a>
  </div>
  <%} %>
  
  <%if(request.getAttribute("profileOpen")!=null){ %>
<!-- PROFILE OVERLAY -->
<div class="profile-overlay">

  <!-- PROFILE PANEL -->
  <div class="profile-panel">

    <!-- HEADER -->
    <div class="profile-header">

  <!-- BACK BUTTON -->
  <a href="callRestaurantsServlet?closeProfile=true&fromCart=true" class="back-btn">←</a>
  
  

<%if(user!=null){ %>
  <div class="profile-avatar"><%=user.getUserName().charAt(0) %></div>

  <div>
    <h3><%=user.getUserName() %></h3>
    <p><%=user.getUserEmail() %></p>
  </div>

</div>


    <!-- BODY -->
    <div class="profile-body">

      <div class="profile-section">
        <h4>Account Details</h4>
        <p><strong>Phone:</strong><%=user.getUserNum() %></p>
        <p><strong>Address:</strong><%=user.getUserLocation() %></p>
      </div>

      <div class="profile-section toggle-section">
        <span>Dark Mode</span>
        <label class="switch">
          <input type="checkbox">
          <span class="slider"></span>
        </label>
      </div>

    </div>
<%} %>
    <!-- FOOTER -->
    <div class="profile-footer">
      <a href="#logout-confirm" class="logout-btn">Logout</a>
    </div>

  </div>

</div>
<%} %>
 <!-- LOGOUT CONFIRMATION MODAL -->
<div id="logout-confirm" class="logout-overlay">

  <div class="logout-modal">

    <h2>Confirm Logout</h2>
    <p>Are you sure you want to logout?</p>

    <div class="logout-actions">
      <a href="callLogout" class="btn danger">Yes, Logout</a>
      <a href="#" class="btn outline">Cancel</a>
    </div>

  </div>

</div>
  



</body>
</html>
    