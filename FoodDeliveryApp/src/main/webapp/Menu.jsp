<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*,com.jn.models.*" %>
    
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Restaurant Menu</title>
<link rel="stylesheet" href="Menu.css" />
</head>
<body>
<% Users user=(Users)session.getAttribute("user"); %>
  <!-- NAVBAR -->
  <!-- NAVBAR -->
  <nav class="navbar">
    <div class="logo">BITEZ</div>

    <div class="search-box">
      <input type="text" placeholder="Search menu items..." />
    </div>

    <div class="nav-links">
      <a href="callRestaurantsServlet">Home</a>
      <a href="Cart.jsp">Cart</a>
      <%System.out.println(request.getParameter("restaurantId")+"\n"); %>
      <a <%if(user==null){ %> style="display: none;" <%} %> href="callRestaurantsServlet?fromProfile=true&fromMenu=true&restaurantId=<%=request.getParameter("restaurantId")%>">Profile</a>
    </div>
  </nav>

  <!-- HEADER -->
  <div class="menu-header">
    <h1>Menu</h1>
    <p>Freshly prepared South Indian delicacies</p>
  </div>
   <!-- MENU ITEMS -->
  <div class="menu-container">
  
  <%!
  CartItem cartItem;
  %>
  <%
  
  List<Menu> menuByRestaurantId=(List<Menu>)request.getAttribute("menuByRestaurantId");
  
  for(Menu items:menuByRestaurantId)
  {
	 
	   Cart cart=(Cart)session.getAttribute("cart");
	   if(cart!=null){
		    Map<Integer,CartItem> cartItems =cart.getItems();
			  cartItem=cartItems.get(items.getItemId());
	   }
			 
	  
	  %>
	  
	 

    <div class="menu-card">
      <div class="menu-img">
        <span class=" <%if(items.getItemCategory().equalsIgnoreCase("veg")){ %> veg-badge<% } else {%>Non-veg-badge <% }%> "><%= items.getItemCategory() %></span>
        <img src="<%=items.getItemImg() %>" />
      </div>
      <div class="card-body">
        <div class="item-name"><%= items.getItemName() %></div>
        <div class="item-desc"><%= items.getItemDesc() %></div>
        <div class="rating-price">
          <span class="rating"><%= items.getItemRating() %> ★</span>
          <span class="price">₹<%= items.getItemPrice() %></span>
        </div>
        
        <form action="callingCartServlet">
        <input type="hidden" name="itemId" value="<%=items.getItemId() %>">
        <input type="hidden" name="restaurantId" value="<%=items.getRestaurantId() %>">
        <input type="hidden" name="qty" value="<%= "1"%>">
       <%if(cartItem==null){ %> <input type="hidden" name="action" value="<%= "add"%>">
       <%} %>
        
        <div class="cart-action">

  <!-- hidden checkbox -->
  <input type="checkbox" id="toggle-<%=items.getItemId()%>" class="cart-toggle">

  <!-- ADD TO CART -->
  <label  <%if(cartItem!=null){ %> style="display: none;" <%} %> for="toggle-<%=items.getItemId()%>" class="add-btn">
    Add to Cart
  </label>
  
  
  
  
  
  <!-- QUANTITY CONTROLS -->
  <div <%if(cartItem!=null){ %> style="display: flex;" <%} %>class="qty-box">
   <div class=button_align>
   
  <form  action="callingCartServlet">
  <input type="hidden" name="action" value="update">
  <input type="hidden" name="doing" value="-">
  <button type="submit" class="qty-btn">−</button>
  </form>
    
    <span class="qty"><%if(cartItem!=null){
    %>
    
    <%=cartItem.getItemQuantity() %>
    <%} else
    	{
    	%>
    	<%="-" %>
    	<%} %>
    </span>
    
    <form style="display: inline;" action="callingCartServlet">
    <input type="hidden" name="itemId" value="<%=items.getItemId() %>">
        <input type="hidden" name="restaurantId" value="<%=items.getRestaurantId() %>">
  <input type="hidden" name="action" value="update">
  <input type="hidden" name="doing" value="+">
 <button type="submit" class="qty-btn">+</button>
  </form>
    
   
  
    
   
   </div>
   <span class="totalprice">₹
   <%if(cartItem!=null){ %>
   <%=cartItem.getItemPrice()*cartItem.getItemQuantity() %>
   <%} %>
   </span>
  </div>
  
   

</div>
        
        </form>
        
        
        
      </div>
    </div>
	  
	<%  
  }
  
  %>
  <%if(request.getAttribute("profileOpen")!=null){ %>
<!-- PROFILE OVERLAY -->
<div class="profile-overlay">

  <!-- PROFILE PANEL -->
  <div class="profile-panel">

    <!-- HEADER -->
    <div class="profile-header">

  <!-- BACK BUTTON -->
  <a href="callRestaurantsServlet?closeProfile=true&fromMenu=true&restaurantId=<%=request.getParameter("restaurantId")%>" class="back-btn">←</a>

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
  

  

    

  </div>
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

