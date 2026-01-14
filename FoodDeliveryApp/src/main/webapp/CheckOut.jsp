<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ page import="java.util.*,com.jn.models.*,com.jn.daoimpl.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Checkout | FoodExpress</title>

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

/* ===== CHECKOUT CONTAINER ===== */
.checkout-container{
  max-width:1200px;
  margin:40px auto;
  padding:20px;
}

.checkout-title{
  font-size:28px;
  font-weight:700;
  margin-bottom:25px;
}

<%!
String isUserName="none";
String isPassword="none";
%>

<%
isUserName=(Boolean)request.getAttribute("isUserId")==null?"none":"block";
isPassword=(Boolean)request.getAttribute("isPassword")==null?"none":"block";


 %>
 
 





/* ===== ERROR MESSAGE ===== */
.error1{
  font-size:13px;
  color:#e53935;
  margin-top:6px;
  display: <%= isUserName%>;
  animation: shake 0.4s;
}

.error2{
  font-size:13px;
  color:#e53935;
  margin-top:6px;
   display: <%= isPassword%>;
  animation: shake 0.4s;
}

@keyframes shake{
  0%{transform:translateX(0)}
  25%{transform:translateX(-4px)}
  50%{transform:translateX(4px)}
  75%{transform:translateX(-4px)}
  100%{transform:translateX(0)}
}


/* ===== EMPTY CART ===== */
.empty-checkout{
  background:#fff;
  padding:60px;
  border-radius:20px;
  text-align:center;
  box-shadow:0 10px 25px rgba(0,0,0,0.1);
}

.empty-checkout p{
  color:#666;
  margin:15px 0 25px;
}

/* ===== BUTTON ===== */
.btn{
  display:inline-block;
  padding:14px 24px;
  border-radius:14px;
  background:#ff5722;
  color:#fff;
  text-decoration:none;
  font-weight:600;
  transition:0.3s;
  border:none;
  cursor:pointer;
}

.btn:hover{
  background:#e64a19;
}

 ===== CHECKOUT GRID ===== 
.checkout-grid{
  display:grid;
  grid-template-columns:2fr 1fr;
  gap:30px;
}

/* ===== CARD ===== */
.card{
  background:#fff;
  border-radius:20px;
  padding:22px;
  box-shadow:0 10px 25px rgba(0,0,0,0.1);
  margin-bottom:25px;
}

.card-title{
  font-size:20px;
  font-weight:700;
  margin-bottom:15px;
}

/* ===== ADDRESS ===== */
.address-box textarea{
  width:100%;
  padding:14px;
  border-radius:14px;
  border:1px solid #ddd;
  resize:none;
  font-size:14px;
}
/* ===== ADDRESS VIEW ===== */
.address-display{
  display:flex;
  justify-content:space-between;
  align-items:flex-start;
  gap:20px;
}

.address-line{
  display:flex;
  gap:12px;
}

.location-icon{
  font-size:22px;
}

.address-text{
  font-size:14px;
  color:#444;
  line-height:1.5;
}

/* ===== SAVED ADDRESSES ===== */
.saved-addresses{
  margin-top:20px;
}

.saved-title{
  font-weight:700;
  margin-bottom:12px;
}

.address-grid-cards{
  display:grid;
  grid-template-columns:repeat(2,1fr);
  gap:14px;
}

.address-card{
  display:flex;
  gap:10px;
  padding:14px;
  border-radius:14px;
  border:2px solid #ddd;
  cursor:pointer;
  transition:0.3s;
  background:#fff;
}

.address-card:hover{
  border-color:#ff5722;
}

.address-card input{
  accent-color:#ff5722;
  margin-top:4px;
}

.address-card p{
  font-size:13px;
  color:#555;
  margin-top:4px;
}

.btn-outline{
display:none;
 background-color: #ff5722;
 border-radius: 14px;
 padding: 5px;
 color: white;
 font-size:13px;
}

/* ===== ADDRESS EDIT ===== */
.address-edit{
  margin-top:20px;
}

.address-form-grid{
  display:grid;
  grid-template-columns:repeat(2,1fr);
  gap:14px;
  margin-bottom:20px;
}

.address-form-grid input{
  padding:12px;
  border-radius:12px;
  border:1px solid #ddd;
  font-size:14px;
}

/* ===== RESPONSIVE ===== */
@media(max-width:600px){
  .address-display{
    flex-direction:column;
  }

  .address-grid-cards{
    grid-template-columns:1fr;
  }

  .address-form-grid{
    grid-template-columns:1fr;
  }
}


/* ===== ORDER SUMMARY ===== */
.summary-row{
  display:flex;
  justify-content:space-between;
  margin-bottom:12px;
  font-size:15px;
}

.summary-row.total{
  font-weight:800;
  font-size:18px;
  color:#2ecc71;
  border-top:1px dashed #ddd;
  padding-top:12px;
}

/* ===== PAYMENT ===== */
.payment-option{
  display:flex;
  align-items:center;
  gap:10px;
  margin-bottom:12px;
}

.payment-option input{
  accent-color:#ff5722;
}

/* ===== PLACE ORDER ===== */
.place-order{
  width:100%;
  margin-top:20px;
  padding:16px;
  font-size:16px;
}

/* ===== RESPONSIVE ===== */
@media(max-width:900px){
  .checkout-grid{
    grid-template-columns:1fr;
  }
}

@media(max-width:480px){
  .checkout-title{
    font-size:24px;
  }
}

.address-card-btn{
  display:flex;
  flex-direction:column;
  gap:6px;
  padding:14px;
  border-radius:14px;
  border:2px solid #ddd;
  background:#fff;
  cursor:pointer;
  text-align:left;
  transition:0.3s;
  font-family:inherit;
}

.address-card-btn:hover{
  border-color:#ff5722;
  background:rgba(255,87,34,0.05);
}

.address-card-btn strong{
  font-size:15px;
  color:#222;
}

.address-card-btn p{
  font-size:13px;
  color:#555;
  line-height:1.4;
}

/* ===== TOAST OVERLAY ===== */
.toast-overlay{
  position:fixed;
  top:0;
  left:0;
  width:100%;
  height:100%;
  pointer-events:none;
  z-index:9999;
}

/* ===== LOGIN OVERLAY ===== */
.login-overlay{
  position:fixed;
  top:0;
  left:0;
  width:100%;
  height:100%;
  background:rgba(0,0,0,0.55);
  display:flex;
  justify-content:center;
  align-items:center;
  z-index:10000;
}

/* ===== LOGIN POPUP ===== */
.login-popup{
  background:#fff;
  padding:35px 30px;
  border-radius:24px;
  width:90%;
  max-width:380px;
  text-align:center;
  box-shadow:0 25px 50px rgba(0,0,0,0.3);
  animation: popIn 0.5s ease;
}

/* Title */
.login-popup h2{
  font-size:24px;
  color:#ff5722;
  margin-bottom:8px;
}

.login-popup p{
  font-size:14px;
  color:#666;
  margin-bottom:22px;
}

/* Inputs */
.login-popup .form-group{
  margin-bottom:16px;
}

.login-popup input{
  width:100%;
  padding:14px;
  border-radius:14px;
  border:1px solid #ddd;
  font-size:14px;
}

.login-popup input:focus{
  border-color:#ff5722;
  box-shadow:0 0 0 3px rgba(255,87,34,0.2);
}

/* Button */
.login-popup .btn{
  width:100%;
  padding:14px;
  background:#ff5722;
  border:none;
  border-radius:14px;
  color:#fff;
  font-size:15px;
  font-weight:600;
  cursor:pointer;
  transition:0.3s;
}

.login-popup .btn:hover{
  background:#e64a19;
}

/* Links */
.popup-links{
  margin-top:18px;
  font-size:13px;
}

.popup-links a{
  color:#ff5722;
  font-weight:600;
  text-decoration:none;
}

.popup-links span{
  margin:0 6px;
  color:#aaa;
}

.popup-links a:hover{
  text-decoration:underline;
}

/* ===== MOBILE FULL SCREEN ===== */
@media(max-width:600px){
  .login-popup{
    height:100%;
    max-width:100%;
    border-radius:0;
    display:flex;
    flex-direction:column;
    justify-content:center;
  }
}

/* Animation */
@keyframes popIn{
  from{
    transform:scale(0.85);
    opacity:0;
  }
  to{
    transform:scale(1);
    opacity:1;
  }
}


</style>
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar">
  <div class="logo">BITEZ</div>
  <div class="nav-links">
    <a href="callRestaurantsServlet">Home</a>
    <a href="Cart.jsp">Cart</a>
    <!--<a href="#">Profile</a>  -->
  </div>
</nav>


<div class="checkout-container">
  <h1 class="checkout-title">Checkout</h1>
  
  <%!Cart cart;
  Users user;
  Map<Integer,CartItem> cartItems;
  List<AllAddress> address;
  
  double netPay;
  %>
  
  <%
  cart=(Cart)session.getAttribute("cart");
  
 
 user=(Users)session.getAttribute("user");
  
 if(user==null){%>
  

<div class="login-overlay">

  <div class="login-popup">

    <h2>Please Login</h2>
    <p>Login is required to continue using this feature</p>

    <form action="callLoginServlet" method="get">
    
    <input type="hidden" name="fromCart" value="fromCart">

      <div class="form-group">
        <input type="email" name="username" placeholder="Email" required>
        <div class="error1 user-error">User not present</div>
      </div>

      <div class="form-group">
        <input type="password" name="password" placeholder="Password" required>
        <div class="error2 pass-error">Password was wrong</div>
      </div>

      <button type="submit" class="btn">Login</button>

    </form>

    <div class="popup-links">
      <a href="Register.jsp">Create an account</a>
      <span>|</span>
      <a href="callRestaurantsServlet?guest=true">Continue as Guest</a>
    </div>

  </div>

</div>



 <%}
 else{
  if(cart!=null){
	  cartItems=cart.getItems();
	  
  }
  %>

  <!-- ============================= -->
  <!-- IF CART IS EMPTY -->
  <!-- ============================= -->
  
  <div <%if(cart!=null && !cartItems.isEmpty()){ %> style="display: none;" <%} %>class="empty-checkout">
    <h2>Your cart is empty</h2>
    <p>Add items from your favorite restaurants</p>
    <a href="callRestaurantsServlet" class="btn">Browse Restaurants</a>
  </div>
 

  <!-- ============================= -->
  <!-- IF CART HAS ITEMS -->
  <!-- ============================= -->
  
  <%
 
	  AllAddressDAOImpl addressImpl=new AllAddressDAOImpl();
	  
	  address=addressImpl.getAddressesByUserId(user.getUserId());
	  System.out.print(address);
	  //AllAddress primaryAddress=address.get(0);
	 // AllAddress secondaryAddress=address.get(1);
	 // AllAddress thirdAddress=address.get(2);
  %>
  
  
	 
  <div class="checkout-grid">

    <!-- LEFT -->
    
    <div>

      <div class="card">
      <div>
      <form style="display: inline;" action="callAddress">
  <div class="card-title">Delivery Address</div>

  <!-- ============================= -->
  <!-- ADDRESS VIEW MODE (DEFAULT) -->
  <!-- ============================= -->
  <!-- show when user has address and NOT editing -->
  <div class="address-display">

    <div class="address-line">
      <span class="location-icon">📍</span>
      <div class="address-text">
       <input type="hidden" name="changeAddress" value="changeNeed">
        <strong><%="Home" %></strong><br>
        <%=user.getUserLocation()%><br>Contact Number:-<%=user.getUserNum() %>
      </div>
    </div>

    <button  type="submit"  class="btn-outline">Change Address</button>
  </div>
</form>
      </div>

<% 
String isChangeNeeded=(String)session.getAttribute("changeAddress");
%>
<div class="formobile" style="display:none;"><%
//if(isChangeNeeded!=null){
	

%></div>



  <div  >
    <!-- ============================= -->
  <!-- SAVED ADDRESS GRID -->
  <!-- ============================= -->
  <!-- show only when Change Address clicked -->
  <form style="display: inline;" action="callAddress">
  <div class="saved-addresses">

    <div class="saved-title">Saved Addresses</div>

    <div class="address-grid-cards">
    
    <% for(AllAddress ad:address) {
    %>

       <button 
    type="submit"
    name="selectedAddress"
    value="<%= ad.getAddress() %>"
    class="address-card-btn">

    <strong><%= ad.getAddressType() %></strong>
    <p><%= ad.getAddress() %></p>

  </button>
      <%} %>

      

    </div>

  </div>
  </form>

  <!-- ============================= -->
  <!-- ADDRESS EDIT MODE -->
  <!-- ============================= -->
  <!-- show only when Add / Edit address -->
  <form style="display: inline;" action="callAddress">
  <div class="address-edit">

    <div class="address-form-grid">
      <input type="text" name="addressType" placeholder="Home/Work"  required>
      <input type="text" name="phNum" placeholder="Contact No" required>
      <input type="text" name="houseNo" placeholder="House No" required>
      <input type="text" name="streetName" placeholder="Street Name" required>
      <input type="text" name="district" placeholder="District" required>
      <input type="text" name="state" placeholder="State" required>
      <input type="text" name="pincode" placeholder="Pincode" required>
    </div>

    <button type="submit" class="btn update-btn">Update Address</button>
  </div>
</form>
  </div>

</div>

</div>
<div class="formobile" style="display:none;"><%//} %></div>

    
<form style="display: inline;"  action="callOrders">

<!--  FOR CONFIRMED ADDRESS-->
<input type="hidden" name="confirmedAddress" value="<%=user.getUserLocation() %>">

      <!-- PAYMENT METHOD -->
      <div class="card">
        <div class="card-title">Payment Method</div>

        <label class="payment-option">
          <input type="radio" name="payment" value="Cash on Delivery" required> Cash on Delivery
        </label>

        <label class="payment-option">
          <input type="radio" name="payment" value="UPI"> UPI
        </label>

        <label class="payment-option">
          <input type="radio" name="payment" value="Credit / Debit Card"> Credit / Debit Card
        </label>
      </div>

    

    <!-- RIGHT -->
    <div>

      <!-- ORDER SUMMARY -->
      <div class="card">
        <div class="card-title">Order Summary</div>
<%
        double grandTotal=(Double)session.getAttribute("grandTotal");
        /* Tax calculation on 5% */
        double tax=(grandTotal*5)/100;
        %>
        
        <div class="summary-row">
          <span>Items Total</span>
          <span>₹<%=grandTotal%></span>
        </div>

        <div class="summary-row">
          <span>Delivery Fee</span>
          <span>₹40</span>
        </div>

        <div class="summary-row">
          <span>Taxes</span>
          <span>₹<%=tax%></span>
        </div>
        
        

        <div class="summary-row total">
          <label>Grand Total</label>
          <span>₹<%=grandTotal+40+tax%></span>
          <input type="hidden" name="grandtotal" value="<%=grandTotal+40+tax%>">
        </div>
        <button type="submit" class="btn place-order">Place Order</button>
      </div>

    </div>
</form>

  </div>

</div>
<%} %>


</body>
</html>
