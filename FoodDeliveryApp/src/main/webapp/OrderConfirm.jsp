<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.jn.models.Users" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Order Confirmed | FoodExpress</title>

<style>
*{
  margin:0;
  padding:0;
  box-sizing:border-box;
  font-family:'Segoe UI', sans-serif;
}

body{
  height:100vh;
  background:linear-gradient(135deg,#ffecd2,#fcb69f);
  display:flex;
  justify-content:center;
  align-items:center;
  overflow:hidden;
}

/* ===== CONFIRMATION CARD ===== */
.success-card{
  background:#fff;
  padding:50px 40px;
  border-radius:24px;
  box-shadow:0 20px 40px rgba(0,0,0,0.15);
  text-align:center;
  max-width:420px;
  width:90%;
  animation: scaleIn 0.6s ease;
  position:relative;
  z-index:2;
}

@keyframes scaleIn{
  from{
    transform:scale(0.8);
    opacity:0;
  }
  to{
    transform:scale(1);
    opacity:1;
  }
}

/* ===== CHECK ICON ===== */
.check-circle{
  width:90px;
  height:90px;
  background:#2ecc71;
  border-radius:50%;
  display:flex;
  justify-content:center;
  align-items:center;
  margin:0 auto 20px;
  animation: pop 0.5s ease;
}

@keyframes pop{
  0%{transform:scale(0)}
  80%{transform:scale(1.2)}
  100%{transform:scale(1)}
}

.check-circle span{
  color:#fff;
  font-size:42px;
  font-weight:900;
}

/* ===== TEXT ===== */
.success-card h1{
  font-size:26px;
  margin-bottom:10px;
  color:#222;
}

.success-card p{
  font-size:15px;
  color:#555;
  margin-bottom:30px;
  line-height:1.5;
}

/* ===== BUTTON ===== */
.btn{
  display:inline-block;
  padding:14px 28px;
  background:#ff5722;
  color:#fff;
  border-radius:14px;
  font-size:15px;
  font-weight:600;
  text-decoration:none;
  transition:0.3s;
}

.btn:hover{
  background:#e64a19;
  transform:translateY(-2px);
}

/* ===== CONFETTI ===== */
.confetti{
  position:absolute;
  width:10px;
  height:20px;
  background:red;
  top:-20px;
  animation: fall 3s linear infinite;
  opacity:0.8;
}

@keyframes fall{
  to{
    transform:translateY(120vh) rotate(360deg);
    opacity:0;
  }
}

/* different colors & delays */
.confetti:nth-child(1){left:10%;background:#ff5252;animation-delay:0s}
.confetti:nth-child(2){left:20%;background:#ff9800;animation-delay:0.4s}
.confetti:nth-child(3){left:30%;background:#ffeb3b;animation-delay:0.8s}
.confetti:nth-child(4){left:40%;background:#4caf50;animation-delay:0.2s}
.confetti:nth-child(5){left:50%;background:#03a9f4;animation-delay:0.6s}
.confetti:nth-child(6){left:60%;background:#3f51b5;animation-delay:1s}
.confetti:nth-child(7){left:70%;background:#9c27b0;animation-delay:0.3s}
.confetti:nth-child(8){left:80%;background:#e91e63;animation-delay:0.7s}
.confetti:nth-child(9){left:90%;background:#00bcd4;animation-delay:0.5s}

/* ===== RESPONSIVE ===== */
@media(max-width:480px){
  .success-card{
    padding:40px 25px;
  }
  .success-card h1{
    font-size:22px;
  }
}
</style>
</head>

<body>

<!-- CONFETTI -->
<div class="confetti"></div>
<div class="confetti"></div>
<div class="confetti"></div>
<div class="confetti"></div>
<div class="confetti"></div>
<div class="confetti"></div>
<div class="confetti"></div>
<div class="confetti"></div>
<div class="confetti"></div>

<!-- SUCCESS CARD -->
<div class="success-card">

  <div class="check-circle">
    <span>✓</span>
  </div>
<%
Users user=(Users)session.getAttribute("user");
%>
  <h1>Order Confirmed 🎉</h1>

  <p>
    Hey <strong><%= user.getUserName() %></strong>,<br>
    your delicious food is on the way!<br>
    Thank you for ordering with <strong>BITEZ</strong>.
  </p>

  <a href="callRestaurantsServlet" class="btn">
    Browse Restaurants
  </a>

</div>

</body>
</html>
