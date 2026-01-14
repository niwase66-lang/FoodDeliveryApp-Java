<%@page import="com.jn.daoimpl.AllAddressDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.List,com.jn.models.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Food Delivery | Restaurants</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
      background: linear-gradient(135deg, #fdfbfb, #ebedee);
      min-height: 100vh;
    }

    /* NAVBAR */
    .navbar {
      background: #fff;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 15px 40px;
      box-shadow: 0 4px 20px rgba(0,0,0,0.08);
      position: sticky;
      top: 0;
      z-index: 100;
      /* animation: slideDown 0.8s ease; */
    }

    @keyframes slideDown {
      from { transform: translateY(-100%); opacity: 0; }
      to { transform: translateY(0); opacity: 1; }
    }

    .logo {
      font-size: 26px;
      font-weight: 800;
      color: #ff5722;
    }

    .search-bar input {
      width: 360px;
      padding: 12px 18px;
      border-radius: 30px;
      border: 1px solid #ddd;
      transition: 0.3s;
    }

    .search-bar input:focus {
      outline: none;
      width: 420px;
      box-shadow: 0 0 0 3px rgba(255,87,34,0.2);
    }
    a{
    text-decoration: none;
    }
    /* Remove link styling from restaurant cards */
.restaurant-link{
  text-decoration:none;
  color:inherit;
  display:block;
}

/* Ensure child elements don't turn blue */
.restaurant-link *{
  color:inherit;
}
    
    
    /* ===== SEARCH BAR ===== */
.search-bar{
  flex:1;
  display:flex;
  justify-content:center;
}

.search-form{
  position:relative;
  width:100%;
  max-width:420px;
}

.search-form input{
  width:100%;
  padding:12px 48px 12px 18px; /* space for button */
  border-radius:30px;
  border:1px solid #ddd;
  font-size:14px;
  outline:none;
  background:#fafafa;
  transition:0.3s;
}

.search-form input:focus{
  background:#fff;
  border-color:#ff5722;
  box-shadow:0 0 0 3px rgba(255,87,34,0.2);
}

/* ===== SEARCH BUTTON ===== */
.search-btn{
  position:absolute;
  top:50%;
  right:6px;
  transform:translateY(-50%);
  width:38px;
  height:38px;
  border-radius:50%;
  border:none;
  background:#ff5722;
  color:#fff;
  font-size:16px;
  cursor:pointer;
  display:flex;
  align-items:center;
  justify-content:center;
  transition:0.3s;
}

.search-btn:hover{
  background:#e64a19;
}

/* ===== NO RESULTS ===== */
.no-results{
  display:flex;
  justify-content:center;
  align-items:center;
  padding:60px 20px;
}

.no-results-card{
  background:#fff;
  padding:50px 40px;
  border-radius:22px;
  text-align:center;
  max-width:460px;
  width:100%;
  box-shadow:0 15px 35px rgba(0,0,0,0.12);
  animation: popIn 0.4s ease;
}

.no-results-icon{
  font-size:48px;
  margin-bottom:14px;
}

.no-results-card h2{
  font-size:24px;
  margin-bottom:10px;
  color:#333;
}

.no-results-card p{
  font-size:14px;
  color:#666;
  margin-bottom:26px;
  line-height:1.5;
}

/* Button (reuse your existing .btn if present) */
.browse-btn{
  padding:14px 28px;
  border-radius:16px;
  font-size:15px;
  font-weight:700;
}

/* ===== RESPONSIVE ===== */
@media(max-width:480px){
  .no-results-card{
    padding:40px 24px;
  }

  .no-results-card h2{
    font-size:20px;
  }
}


/* ===== MOBILE ===== */
@media(max-width:768px){
  .search-form{
    max-width:100%;
  }
}
    

    .nav-links a {
      margin-left: 25px;
      text-decoration: none;
      color: #333;
      font-weight: 600;
      position: relative;
    }

    .nav-links a::after {
      content: "";
      position: absolute;
      width: 0;
      height: 3px;
      background: #ff5722;
      bottom: -6px;
      left: 0;
      transition: 0.3s;
    }
    /* ===== NAV USER ===== */
.nav-user{
  display:flex;
  align-items:center;
  gap:10px;
  cursor:pointer;
  padding:6px 6px;
  border-radius:20px;
  transition:0.3s;
}

.nav-user:hover{
  background:rgba(255,87,34,0.08);
}

/* Avatar circle */
.user-avatar{
  width:36px;
  height:36px;
  background:linear-gradient(135deg,#ff5722,#ff7043);
  border-radius:50%;
  display:flex;
  align-items:center;
  justify-content:center;
  color:#fff;
  font-size:14px;
  font-weight:700;
  text-transform:uppercase;
  box-shadow:0 4px 10px rgba(255,87,34,0.35);
}

/* Username text */
.user-name{
  font-size:14px;
  font-weight:600;
  color:#333;
  white-space:nowrap;
}

/* ===== MOBILE ===== */
@media(max-width:768px){
  .user-name{
    display:none; /* show only avatar on mobile */
  }
}
    

    .nav-links a:hover::after { width: 100%; }

    /* FILTERS */
    .filters {
      display: flex;
      gap: 15px;
      padding: 20px 60px;
      overflow-x: auto;
    }

    .filter-chip {
      padding: 8px 16px;
      background: #fff;
      border-radius: 20px;
      font-size: 14px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      cursor: pointer;
      transition: 0.3s;
      white-space: nowrap;
    }

    .filter-chip:hover,
    .filter-chip.active {
      background: #ff5722;
      color: #fff;
    }

    /* CONTENT */
    .container { padding: 40px 60px; }

    .title {
      font-size: 32px;
      margin-bottom: 30px;
      /*  animation: fadeIn 1s ease;*/
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    /* GRID */
    .restaurant-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
      gap: 30px;
    }
    
    /* Fixed image area */
.image-wrapper{
  width:100%;
  height:180px;                 /* SAME HEIGHT ALWAYS */
  background:#f3f3f3;           /* fallback background */
  border-radius:16px 16px 0 0;
  overflow:hidden;
  position:relative;
}



    /* CARD */
    .restaurant-card {
      background: #fff;
      border-radius: 18px;
      overflow: hidden;
      box-shadow: 0 10px 25px rgba(0,0,0,0.1);
      transition: 0.4s;
      /*animation: pop 0.8s ease forwards;  */
    }

    @keyframes pop {
      from { opacity: 0; transform: scale(0.9); }
      to { opacity: 1; transform: scale(1); }
    }

    .restaurant-card:hover {
      transform: translateY(-10px) scale(1.02);
      box-shadow: 0 18px 40px rgba(0,0,0,0.18);
    }

    .restaurant-card img {
      width: 100%;
      height: 180px;
      object-fit: cover;
      transition: 0.5s;
    }

    .restaurant-card:hover img { transform: scale(1.1); }

    .card-content { padding: 18px; }

    .restaurant-name {
      font-size: 20px;
      font-weight: 700;
    }

    .rating-eta {
      display: flex;
      justify-content: space-between;
      margin: 10px 0;
      font-size: 14px;
    }

    .rating {
      background: linear-gradient(135deg,#48c479,#2ecc71);
      color: #fff;
      padding: 4px 10px;
      border-radius: 8px;
    }

    .description { color: #555; font-size: 14px; }
    .location { color: #888; font-size: 13px; }

    /* RESPONSIVE */
    @media(max-width:768px){
      .navbar{flex-direction:column;gap:15px}
      .search-bar input{width:100%}
      .filters,.container{padding:20px}
      .title{text-align:center;font-size:26px}
    }

    @media(max-width:480px){
      .restaurant-card img{height:150px}
      .restaurant-name{font-size:18px}
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
    
    
    /* ===== OVERLAY (TRANSPARENT) ===== */
.login-dropdown-overlay{
  position:fixed;
  top:0;
  left:0;
  width:100%;
  height:100%;
  pointer-events:none;
  z-index:10000;
}

/* ===== LOGIN DROPDOWN ===== */
.login-dropdown{
  position:fixed;
  top:70px;          /* below navbar */
  right:20px;
  width:320px;
  background:#fff;
  padding:22px 20px;
  border-radius:18px;
  box-shadow:0 15px 40px rgba(0,0,0,0.25);
  pointer-events:auto;
  animation: slideDownFade 0.4s ease;
}

/* Title */
.login-dropdown h3{
  text-align:center;
  color:#ff5722;
  margin-bottom:14px;
}

/* Form */
.login-dropdown .form-group{
  margin-bottom:14px;
}

.login-dropdown input{
  width:100%;
  padding:12px;
  border-radius:12px;
  border:1px solid #ddd;
  font-size:14px;
}

.login-dropdown input:focus{
  border-color:#ff5722;
  box-shadow:0 0 0 3px rgba(255,87,34,0.2);
}

/* Button */
.login-dropdown .btn{
  width:100%;
  padding:12px;
  border-radius:12px;
  font-size:14px;
}

/* Links */
.login-dropdown .popup-links{
  margin-top:14px;
  font-size:12px;
  text-align:center;
}

/* Animation */
@keyframes slideDownFade{
  from{
    transform:translateY(-10px);
    opacity:0;
  }
  to{
    transform:translateY(0);
    opacity:1;
  }
}

/* ===== MOBILE: FULL SCREEN ===== */
@media(max-width:600px){
  .login-dropdown-overlay{
    background:rgba(0,0,0,0.55);
    display:flex;
    justify-content:center;
    align-items:center;
    pointer-events:auto;
  }

  .login-dropdown{
    position:relative;
    top:auto;
    right:auto;
    width:90%;
    border-radius:24px;
  }
}

/* ===== PROFILE OVERLAY ===== */
.profile-overlay{
  position:fixed;
  inset:0;
  background:rgba(0,0,0,0.55);
  z-index:10000;
  display:flex;
  justify-content:flex-end;
}

/* ===== PROFILE PANEL ===== */
.profile-panel{
  width:25%;
  min-width:320px;        /* keeps it usable on large screens */
  max-width:420px;
  height:100%;
  background:#fff;
  display:flex;
  flex-direction:column;
  animation: slideInRight 0.4s ease;
}


/* ===== HEADER ===== */
.profile-header{
  display:flex;
  gap:14px;
  align-items:center;
  padding:20px;
  border-bottom:1px solid #eee;
}

.profile-avatar{
  width:52px;
  height:52px;
  border-radius:50%;
  background:linear-gradient(135deg,#ff5722,#ff7043);
  color:#fff;
  display:flex;
  justify-content:center;
  align-items:center;
  font-weight:700;
  font-size:18px;
}

.profile-header h3{
  font-size:18px;
  margin-bottom:4px;
}

.profile-header p{
  font-size:13px;
  color:#666;
}

/* ===== BODY ===== */
.profile-body{
  flex:1;
  padding:20px;
  overflow-y:auto;
}

.profile-section{
  margin-bottom:25px;
}

.profile-section h4{
  font-size:15px;
  margin-bottom:10px;
  color:#333;
}

.profile-section p{
  font-size:14px;
  color:#555;
  margin-bottom:6px;
}

/* ===== DARK MODE TOGGLE ===== */
.toggle-section{
  display:flex;
  justify-content:space-between;
  align-items:center;
}

.switch{
  position:relative;
  width:48px;
  height:26px;
}

.switch input{
  display:none;
}

.slider{
  position:absolute;
  inset:0;
  background:#ccc;
  border-radius:26px;
  transition:0.3s;
}

.slider::before{
  content:"";
  position:absolute;
  width:20px;
  height:20px;
  background:#fff;
  border-radius:50%;
  top:3px;
  left:3px;
  transition:0.3s;
}

.switch input:checked + .slider{
  background:#ff5722;
}

.switch input:checked + .slider::before{
  transform:translateX(22px);
}

/* ===== FOOTER ===== */
.profile-footer{
  padding:20px;
  border-top:1px solid #eee;
}

.logout-btn{
  display:block;
  width:100%;
  text-align:center;
  padding:14px;
  background:#e53935;
  color:#fff;
  border-radius:12px;
  text-decoration:none;
  font-weight:600;
  transition:0.3s;
}

.logout-btn:hover{
  background:#c62828;
}

/* ===== ANIMATION ===== */
@keyframes slideInRight{
  from{
    transform:translateX(100%);
  }
  to{
    transform:translateX(0);
  }
}

/* ===== MOBILE ===== */
@media(max-width:768px){
  .profile-panel{
    width:100%;
    max-width:100%;
  }
}
/* ===== BACK BUTTON ===== */
.back-btn{
  width:36px;
  height:36px;
  border-radius:50%;
  background:#f2f2f2;
  color:#333;
  display:flex;
  align-items:center;
  justify-content:center;
  text-decoration:none;
  font-size:20px;
  font-weight:700;
  margin-right:10px;
  transition:0.3s;
}

.back-btn:hover{
  background:#ff5722;
  color:#fff;
}

/* Align header nicely */
.profile-header{
  display:flex;
  align-items:center;
  gap:12px;
}

 ===== PROFILE MENU ===== 
.profile-menu{
  padding:10px 0;
}

.profile-option{
  display:flex;
  align-items:center;
  gap:14px;
  padding:14px;
  border-radius:14px;
  text-decoration:none;
  color:#333;
  font-size:15px;
  font-weight:600;
  transition:0.3s;
}

.profile-option:hover{
  background:rgba(255,87,34,0.1);
}

.option-icon{
  font-size:18px;
}

/* ===== SAVED ADDRESSES ===== */
.address-list{
  display:flex;
  flex-direction:column;
  gap:12px;
}

.address-item{
  display:flex;
  gap:12px;
  padding:14px;
  border-radius:14px;
  background:#fafafa;
  cursor:pointer;
  transition:0.3s;
}

.address-item:hover{
  background:rgba(255,87,34,0.1);
}

.address-icon{
  font-size:20px;
}

.address-item strong{
  font-size:14px;
  color:#333;
}

.address-item p{
  font-size:13px;
  color:#666;
  margin-top:4px;
}

.add-address-btn{
  margin-top:10px;
  display:inline-block;
  font-size:14px;
  font-weight:600;
  color:#ff5722;
  text-decoration:none;
}
/* ===== HELP & SUPPORT ===== */
.help-list{
  display:flex;
  flex-direction:column;
}

.help-item{
  display:flex;
  align-items:center;
  gap:14px;
  padding:14px;
  border-radius:14px;
  text-decoration:none;
  color:#333;
  font-size:14px;
  font-weight:600;
  transition:0.3s;
}

.help-item:hover{
  background:rgba(255,87,34,0.1);
}
/* ===== LOGOUT CONFIRMATION OVERLAY ===== */
.logout-overlay{
  position:fixed;
  inset:0;
  background:rgba(0,0,0,0.6);
  display:none;
  justify-content:center;
  align-items:center;
  z-index:20000;
}

/* show when targeted */
.logout-overlay:target{
  display:flex;
}

/* ===== MODAL BOX ===== */
.logout-modal{
  background:#fff;
  padding:30px 28px;
  border-radius:20px;
  width:90%;
  max-width:380px;
  text-align:center;
  box-shadow:0 25px 50px rgba(0,0,0,0.3);
  animation: popIn 0.35s ease;
}

.logout-modal h2{
  font-size:22px;
  margin-bottom:10px;
  color:#333;
}

.logout-modal p{
  font-size:14px;
  color:#666;
  margin-bottom:25px;
}

/* ===== ACTION BUTTONS ===== */
.logout-actions{
  display:flex;
  gap:14px;
}

.logout-actions .btn{
  flex:1;
  padding:12px;
  border-radius:14px;
  font-size:14px;
  font-weight:600;
  text-decoration:none;
  text-align:center;
  transition:0.3s;
}

/* Confirm */
.btn.danger{
  background:#e53935;
  color:#fff;
}

.btn.danger:hover{
  background:#c62828;
}

/* Cancel */
.btn.outline{
  border:2px solid #ddd;
  color:#333;
  background:#fff;
}

.btn.outline:hover{
  border-color:#ff5722;
  color:#ff5722;
}

/* ===== MOBILE ===== */
@media(max-width:480px){
  .logout-modal{
    border-radius:16px;
  }
}
@keyframes popIn{
  from{transform:scale(0.9);opacity:0}
  to{transform:scale(1);opacity:1}
}

/* ===== ADD ADDRESS POPUP OVERLAY ===== */
.address-popup-overlay{
  position:fixed;
  inset:0;
  background:rgba(0,0,0,0.6);
  display:none;
  justify-content:center;
  align-items:center;
  z-index:20000;
}

/* show popup */
.address-popup-overlay:target{
  display:flex;
}

/* ===== POPUP BOX ===== */
.address-popup{
  background:#fff;
  width:90%;
  max-width:520px;
  border-radius:22px;
  padding:28px 26px;
  position:relative;
  box-shadow:0 25px 50px rgba(0,0,0,0.3);
  animation: popIn 0.35s ease;
}

/* Title */
.address-popup h2{
  font-size:22px;
  margin-bottom:20px;
  color:#ff5722;
  text-align:center;
}

/* Close button */
.address-popup .close-btn{
  position:absolute;
  top:14px;
  right:18px;
  font-size:24px;
  text-decoration:none;
  color:#333;
}

/* ===== FORM GRID ===== */
.address-form-grid{
  display:grid;
  grid-template-columns:repeat(2,1fr);
  gap:14px;
}

.address-form-grid input{
  padding:14px;
  border-radius:14px;
  border:1px solid #ddd;
  font-size:14px;
}

.address-form-grid input:focus{
  border-color:#ff5722;
  box-shadow:0 0 0 3px rgba(255,87,34,0.2);
}

/* ===== ACTION BUTTONS ===== */
.address-actions{
  display:flex;
  gap:14px;
  margin-top:22px;
}

.address-actions .btn{
  flex:1;
}

/* Outline cancel */
.btn.outline{
  background:#fff;
  border:2px solid #ddd;
  color:#333;
}

.btn.outline:hover{
  border-color:#ff5722;
  color:#ff5722;
}

/* ===== MOBILE ===== */
@media(max-width:600px){
  .address-popup{
    width:95%;
    padding:24px 20px;
  }

  .address-form-grid{
    grid-template-columns:1fr;
  }
}

.address-actions{
  display:flex;
  gap:16px;
  margin-top:26px;
}
.address-actions .btn{
  flex:1;
  padding:14px 0;
  border-radius:16px;
  background:linear-gradient(135deg,#ff5722,#ff7043);
  color:#fff;
  font-size:15px;
  font-weight:700;
  border:none;
  cursor:pointer;
  transition:all 0.3s ease;
  box-shadow:0 8px 18px rgba(255,87,34,0.35);
}

.address-actions .btn:hover{
  transform:translateY(-2px);
  box-shadow:0 12px 24px rgba(255,87,34,0.45);
}
.address-actions .btn.outline{
  background:#fff;
  color:#333;
  border:2px solid #e0e0e0;
  box-shadow:none;
}

.address-actions .btn.outline:hover{
  border-color:#ff5722;
  color:#ff5722;
  background:#fff;
}
@media(max-width:480px){
  .address-actions{
    flex-direction:column;
  }
}

/* ===== FOOTER ===== */
.app-footer{
  background:#0e0e0e;
  color:#ccc;
  margin-top:70px;
  font-family:'Segoe UI', sans-serif;
}

/* Layout */
.footer-container{
  max-width:1200px;
  margin:auto;
  padding:50px 20px;
  display:grid;
  grid-template-columns:repeat(auto-fit,minmax(260px,1fr));
  gap:40px;
}

/* Section */
.footer-section h3{
  font-size:18px;
  margin-bottom:14px;
  color:#fff;
}

.footer-section p{
  font-size:14px;
  line-height:1.6;
  color:#bbb;
  margin-bottom:14px;
}

/* List */
.footer-section ul{
  list-style:none;
}

.footer-section li{
  font-size:14px;
  margin-bottom:10px;
  color:#ccc;
}


/* Bottom bar */
.footer-bottom{
  border-top:1px solid #222;
  text-align:center;
  padding:16px;
  font-size:13px;
  color:#888;
}

/* ===== RESPONSIVE ===== */
@media(max-width:600px){
  .footer-container{
    padding:35px 18px;
  }

  .footer-section h3{
    font-size:16px;
  }

  .footer-section p,
  .footer-section li{
    font-size:13px;
  }
  
}




    
  </style>
</head>
<body>
<%
Users user=(Users)session.getAttribute("user");
%>
  <!-- Navbar -->
  <nav class="navbar">
    <div class="logo">BITEZ</div>
    
    <!-- Search Bar -->
    <div class="search-bar">
  <form action="callSearchServlet" method="get" class="search-form">
    <input type="text" name="searchLike" placeholder="Search for restaurants names and location..." />
    <button type="submit" class="search-btn">
      🔍
    </button>
  </form>
</div>

    <%if(user!=null) {%>
    <!-- USER INFO -->
<div class="nav-user">
  <div class="user-avatar">
    <span><%=user.getUserName().charAt(0) %></span>
  </div>
  <span class="user-name"><%=user.getUserName() %></span>
</div>
<%}
    else{%>
     <!-- USER INFO -->
<div class="nav-user">
  <div class="user-avatar">
    <span><%="G"%></span>
  </div>
  <span class="user-name"><%="Guest"%></span>
</div>
<%} %>
    
    
    <div class="nav-links">
    
    
      <a href="callRestaurantsServlet">Home</a>
      <a href="Cart.jsp">Cart</a>
      <a <%if(user!=null){ %> style="display: none;" <%} %> href="callRestaurantsServlet?fromRestaurantForLogin=true">Login</a>
      <a <%if(user==null){ %> style="display: none;" <%} %> href="callRestaurantsServlet?fromProfile=true">Profile</a>
    </div>
  </nav>

<%String from=(String)request.getAttribute("from"); %>
  <!-- Filters -->
  <div class="filters">
    <a style="color: black;" href="callRestaurantsServlet"><span class="filter-chip <%if(from.equals("allRestaurants")){ %>active <%} %> ">All</span></a> 
    <a style="color: black;" href="callCategory?filterType=rating"><span class="filter-chip <%if(from.equals("rating")){ %>active <%} %> ">⭐ 4.0+</span></a> 
    <a style="color: black;" href="callCategory?filterType=deliveryTime"><span class="filter-chip <%if(from.equals("deliveryTime")){ %>active <%} %> ">Fast Delivery</span></a> 
    <!-- <span class="filter-chip">Veg</span>
    <span class="filter-chip">Non-Veg</span> -->
  </div>

  <div class="container">
    <div class="title">Popular Restaurants Near You</div>

    <div class="restaurant-grid">
    
    <%
    List<Restaurants> allRestaurants=(List<Restaurants>) request.getAttribute("allRestaurants");
    
    if(!allRestaurants.isEmpty()){
    		  
    		  for(Restaurants restaurants:allRestaurants){
    			  session.setAttribute("restaurantId", restaurants.getRestaurantId());
    			  %>
    			  <a class="restaurant-link" href="callMenu?restaurantId=<%=restaurants.getRestaurantId()%>">
    			  <div class="restaurant-card">
    			  <div class="image-wrapper">
        <img src="<%= restaurants.getResImage() %>" alt="<%= restaurants.getResName() %>" />
        </div>
        <div class="card-content">
          <div class="restaurant-name"><%= restaurants.getResName() %></div>
          <div class="rating-eta">
            <span class="rating"><%=restaurants.getResRating() %>★</span>
            <span class="eta"><%=restaurants.getResEta() %> mins</span>
          </div>
          <div class="description"><%=restaurants.getResDescription()%></div>
          <div class="location"><%=restaurants.getResLocation()%></div>
        </div>
      </div>
    			  </a>
    			  <%
    			  
    		  }
    }
    else{
    	
    
    %>
<!-- NO SEARCH RESULTS -->
<div class="no-results">

  <div class="no-results-card">
    <div class="no-results-icon">🍽️</div>

    <h2>No restaurants found</h2>

    <p>
      We couldn’t find any restaurants matching your search.
      Try a different keyword or browse all restaurants.
    </p>

    <a href="callRestaurantsServlet" class="btn browse-btn">
      Browse All Restaurants
    </a>
  </div>

</div>
<%} %>
      

      
    </div>
  </div>
  <%-- LOGIN POPUP (TOP RIGHT) --%>
<% if(request.getAttribute("showLoginPopup") != null){ %>

<div class="login-dropdown-overlay">

  <div class="login-dropdown">

    <h3>Login</h3>

    <form action="callLoginServlet" method="get">
    <input type="hidden" name="fromRestaurant" value="fromRestaurant">

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

<% } %>


<%if(request.getAttribute("profileOpen")!=null){ %>
<!-- PROFILE OVERLAY -->
<div class="profile-overlay">

  <!-- PROFILE PANEL -->
  <div class="profile-panel">

    <!-- HEADER -->
    <div class="profile-header">

  <!-- BACK BUTTON -->
  <a href="callRestaurantsServlet?closeProfile=true" class="back-btn">←</a>

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
      <div class="profile-section profile-menu">

  <a href="callOrderHistory" class="profile-option">
    <span class="option-icon">📦</span>
    <span class="option-text">My Orders</span>
  </a>

</div>

<%
int userId=user.getUserId();
AllAddressDAOImpl allAddressImpl=new AllAddressDAOImpl();

List<AllAddress> allAddress=allAddressImpl.getAddressesByUserId(userId);
%>
<!-- SAVED ADDRESSES -->
<div class="profile-section">

  <h4 class="section-title">Saved Addresses</h4>

  <div class="address-list">
  <div class="address-item">
      <span class="address-icon">🏠</span>
      <div>
        <strong>Home</strong>
        <p><%=user.getUserLocation() %></p>
      </div>
    </div>
  <%
  if(allAddress!=null && !allAddress.isEmpty()){
	  
  for(AllAddress address:allAddress){
  %>

    <div class="address-item">
      <span class="address-icon">🏠</span>
      <div>
        <strong><%=address.getAddressType() %></strong>
        <p><%=address.getAddress() %></p>
      </div>
    </div>

    <%
    break;
  }
  }
    
    %>

    <a href="#add-address-popup" class="add-address-btn">+ Add New Address</a>


  </div>

</div>

      

      <div class="profile-section toggle-section">
  <span>Dark Mode</span>

  <!-- DEFAULT VALUE (LEFT / OFF) -->
  <input type="hidden" name="darkMode" value="OFF">

  <!-- TOGGLE -->
  <label class="switch">
    <input type="checkbox" name="darkMode" value="ON">
    <span class="slider"></span>
  </label>
</div>


    </div>
    <!-- HELP & SUPPORT -->
<div class="profile-section">

  <h4 class="section-title">Help & Support</h4>

  <div class="help-list">

    <a href="#" class="help-item">
      <span>❓</span>
      <span>FAQs</span>
    </a>

    <a href="#" class="help-item">
      <span>📞</span>
      <span>Contact Support</span>
    </a>

    <a href="#" class="help-item">
      <span>📄</span>
      <span>Terms & Conditions</span>
    </a>

    <a href="#" class="help-item">
      <span>🔒</span>
      <span>Privacy Policy</span>
    </a>

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

<!-- ADD ADDRESS POPUP -->
<div id="add-address-popup" class="address-popup-overlay">

  <div class="address-popup">

    <a href="#" class="close-btn">×</a>

    <h2>Add New Address</h2>

    <form action="callAddAddress" method="get">

      <div class="address-form-grid">

        <input type="text" name="addressType" placeholder="Address Type (Home / Work)" required>
        <input type="text" name="houseNo" placeholder="House No" required>

        <input type="text" name="streetName" placeholder="Street Name" required>
        <input type="text" name="district" placeholder="District" required>

        <input type="text" name="state" placeholder="State" required>
        <input type="text" name="pincode" placeholder="Pincode" required>
        <input type="text" name="contactNumber" placeholder="Contact Number" required>

      </div>

      <div class="address-actions">
        <button type="submit" class="btn">Save Address</button>
        <a href="#" class="btn outline">Cancel</a>
      </div>

    </form>

  </div>

</div>

<!-- FOOTER -->
<footer class="app-footer">

  <div class="footer-container">

    <!-- HELP & SUPPORT -->
    <div class="footer-section">
      <h3>Help & Support</h3>
      <p>
        Need assistance with your orders or account?  
        Our support team is available to help you with any issues related
        to food delivery, payments, or refunds.
      </p>

      <ul>
        <li>❓ FAQs – Quick answers to common questions</li>
        <li>📞 Contact Support – 24×7 customer assistance</li>
        <li>📄 Terms & Conditions – Usage policies & rules</li>
        <li>🔒 Privacy Policy – Your data is safe with us</li>
      </ul>
    </div>

    <!-- ABOUT -->
    <div class="footer-section">
      <h3>About BITEZ</h3>
      <p>
        BITEZ is a modern food delivery platform that connects you with
        the best restaurants near you. Enjoy fast delivery, secure payments,
        and a seamless ordering experience.
      </p>
    </div>

    <!-- TRUST & SAFETY -->
    <div class="footer-section">
      <h3>Trust & Safety</h3>
      <p>
        We follow strict hygiene and safety standards.  
        All partner restaurants are verified to ensure quality food
        and reliable service every time you order.
      </p>
    </div>

  </div>

  <div class="footer-bottom">
    © 2026 BITEZ • Delivering happiness at your doorstep
  </div>

</footer>


</body>
</html>
