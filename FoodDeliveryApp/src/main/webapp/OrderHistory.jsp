<%@page import="com.jn.daoimpl.OrderItemDAOImpl"%>
<%@page import="com.jn.daoimpl.RestaurantsDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ page import="java.util.*,com.jn.models.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Order History | BITEZ</title>

<style>
*{
  margin:0;
  padding:0;
  box-sizing:border-box;
  font-family:'Segoe UI', sans-serif;
}

body{
  background:linear-gradient(135deg,#fdfbfb,#ebedee);
  min-height:100vh;
}

/* ===== NAVBAR ===== */
.navbar{
  display:flex;
  justify-content:space-between;
  align-items:center;
  padding:15px 40px;
  background:#fff;
  box-shadow:0 4px 20px rgba(0,0,0,0.08);
}

.logo{
  font-size:26px;
  font-weight:800;
  color:#ff5722;
}

.nav-links a{
  margin-left:25px;
  text-decoration:none;
  color:#333;
  font-weight:600;
}

/* ===== PAGE ===== */
.container{
  max-width:1100px;
  margin:40px auto;
  padding:20px;
}

.page-title{
  font-size:28px;
  font-weight:700;
  margin-bottom:25px;
}

/* ===== EMPTY STATE ===== */
.empty-orders{
  background:#fff;
  padding:60px;
  border-radius:20px;
  text-align:center;
  box-shadow:0 10px 25px rgba(0,0,0,0.1);
}

.empty-orders p{
  color:#666;
  margin:15px 0 25px;
}

.btn{
  display:inline-block;
  padding:14px 26px;
  background:#ff5722;
  color:#fff;
  border-radius:14px;
  text-decoration:none;
  font-weight:600;
}

/* ===== ORDER GRID ===== */
.order-grid{
  display:grid;
  grid-template-columns:repeat(auto-fill,minmax(280px,1fr));
  gap:24px;
}

.order-card{
  background:#fff;
  padding:20px;
  border-radius:18px;
  text-decoration:none;
  color:#333;
  box-shadow:0 10px 25px rgba(0,0,0,0.1);
  transition:0.3s;
}

.order-card:hover{
  transform:translateY(-6px);
}

.order-card h3{
  font-size:18px;
}

.muted{
  font-size:13px;
  color:#666;
  margin:6px 0;
}

.order-info{
  display:flex;
  justify-content:space-between;
  font-size:13px;
  margin:12px 0;
}

.order-footer{
  display:flex;
  justify-content:space-between;
  align-items:center;
}

.amount{
  font-size:18px;
  font-weight:700;
  color:#ff5722;
}

.status{
  padding:4px 10px;
  border-radius:10px;
  font-size:12px;
  font-weight:600;
}

.delivered{
  background:#e8f5e9;
  color:#2e7d32;
}

/* ===== POPUP ===== */
.order-popup-overlay{
  position:fixed;
  inset:0;
  background:rgba(0,0,0,0.6);
  display:none;
  justify-content:center;
  align-items:center;
  z-index:10000;
}

.order-popup-overlay:target{
  display:flex;
}

.order-popup{
  background:#fff;
  width:90%;
  max-width:600px;
  border-radius:20px;
  padding:25px;
  position:relative;
  animation:popIn 0.4s ease;
}

.close-btn{
  position:absolute;
  top:12px;
  right:16px;
  font-size:24px;
  text-decoration:none;
  color:#333;
}

.popup-section p{
  font-size:14px;
  color:#555;
  margin-top:6px;
}

/* ===== ITEMS TABLE ===== */
.popup-items{
  margin-top:20px;
}

.popup-row{
  display:grid;
  grid-template-columns:2fr 1fr 1fr 1fr;
  padding:10px 0;
  border-bottom:1px solid #eee;
  font-size:14px;
}

.popup-row.header{
  font-weight:700;
}

.popup-total{
  margin-top:16px;
  text-align:right;
  font-size:18px;
  font-weight:800;
  color:#2ecc71;
}
/* ===== NAV LINK HOVER UNDERLINE ===== */
.nav-links a{
  position:relative;
  padding-bottom:4px;
}

/* underline */
.nav-links a::after{
  content:"";
  position:absolute;
  left:0;
  bottom:0;
  width:0;
  height:3px;
  background:#ff5722;
  transition:width 0.3s ease;
  border-radius:2px;
}

/* hover animation */
.nav-links a:hover::after{
  width:100%;
}


/* ===== ANIMATION ===== */
@keyframes popIn{
  from{transform:scale(0.9);opacity:0}
  to{transform:scale(1);opacity:1}
}

/* ===== RESPONSIVE ===== */
@media(max-width:600px){
  .popup-row{
    grid-template-columns:1.5fr 0.7fr 0.8fr 0.8fr;
    font-size:13px;
  }
}
</style>
</head>

<body>
<%
	List<Order> allOrders=(List<Order>)request.getAttribute("allOrders");
%>

<!-- NAVBAR -->
<nav class="navbar">
  <div class="logo">BITEZ</div>
  <div class="nav-links">
    <a href="callRestaurantsServlet">Home</a>
    <!-- <a href="#">Profile</a> -->
  </div>
</nav>

<div class="container">

  <h1 class="page-title">My Orders</h1>

  <!-- EMPTY STATE (show when no orders) -->
  <%if(allOrders==null || allOrders.isEmpty()) { %>
  
  <div class="empty-orders">
    <h2>No orders yet</h2>
    <p>You haven’t placed any orders yet</p>
    <a href="callRestaurantsServlet" class="btn">Browse Restaurants</a>
  </div>
  <%}
  else{
  %>
  

  <!-- ORDER GRID -->
  <div class="order-grid">
  <%
  RestaurantsDAOImpl restaurantImpl=new RestaurantsDAOImpl(); 
  
  for(Order order:allOrders){
	  
  Restaurants restaurant=restaurantImpl.getRestaurantById(order.getRestaurantId());
  
  %>

    <a href="#order-<%=order.getOrderId() %>" class="order-card">
      <h3><%=restaurant.getResName() %></h3>
      <h5>Order Id:- <%=order.getOrderId() %></h5>
      <p class="muted"><%=order.getAddress() %></p>

      <div class="order-info">
        <span>💳 <%=order.getPaymentMode() %></span>
        <span>📅 <%=order.getOrderDate() %></span>
      </div>

      <div class="order-footer">
        <span class="amount"><%=order.getTotalAmount() %></span>
        <span class="status delivered">Delivered</span>
      </div>
    </a>
    
 
  <%} %>
  </div>
</div>

<!-- for popup loops -->
<%
OrderItemDAOImpl orderItemImpl=new OrderItemDAOImpl();
for(Order order:allOrders){
	
	Restaurants restaurant=restaurantImpl.getRestaurantById(order.getRestaurantId());
%>

<!-- ORDER DETAILS POPUP -->
<div id="order-<%=order.getOrderId() %>" class="order-popup-overlay">

  <div class="order-popup">
    <a href="#" class="close-btn">×</a>

    <h2>Order Details</h2>

    <div class="popup-section">
      <strong><%=restaurant.getResName() %></strong>
      <p><%=order.getAddress() %></p>
      <p>Payment: <%=order.getPaymentMode() %></p>
      <p>Date: <%=order.getOrderDate() %></p>
    </div>

    <div class="popup-items">
      <div class="popup-row header">
        <span>Item</span>
        <span>Qty</span>
        <span>Price</span>
        <span>Total</span>
      </div>
      <%
      List<OrderItem> orderItems=orderItemImpl.getItemsByOrderId(order.getOrderId());
      
      for(OrderItem orderItem:orderItems){
      
      %>

      <div class="popup-row">
        <span><%=orderItem.getItemName() %></span>
        <span><%=orderItem.getQuantity()%></span>
        <span>₹<%=orderItem.getPrice() %></span>
        <span>₹<%=orderItem.getTotalPrice() %></span>
      </div>
      
      <!--for secondary loop  -->
      <%} %>

      
    </div>

    <div class="popup-total">
      Grand Total: ₹<%=order.getTotalAmount() %>
    </div>

  </div>

</div>


<!-- for Primary loop -->
<%} %>
 

<!--  for else-->
<%} %>

</body>
</html>
