<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Register | FoodExpress</title>

<style>
*{
  margin:0;
  padding:0;
  box-sizing:border-box;
  font-family:'Segoe UI', sans-serif;
}

body{
  min-height:100vh;
  background:linear-gradient(135deg,#ffecd2,#fcb69f);
  display:flex;
  justify-content:center;
  align-items:center;
  position:relative;
  overflow:hidden;
}

/* ===== BACKGROUND FOOD ICONS ===== */
.food{
  position:absolute;
  font-size:38px;
  opacity:0.15;
  animation: float 12s linear infinite;
}

.food:nth-child(1){top:15%;left:10%}
.food:nth-child(2){bottom:20%;left:15%}
.food:nth-child(3){top:20%;right:10%}
.food:nth-child(4){bottom:15%;right:20%}

@keyframes float{
  from{transform:translateY(0)}
  to{transform:translateY(-120vh)}
}

/* ===== REGISTER CARD ===== */
.register-card{
  background:#fff;
  width:100%;
  max-width:440px;
  padding:40px 35px;
  border-radius:24px;
  box-shadow:0 20px 40px rgba(0,0,0,0.15);
  /* animation: popIn 0.6s ease; */
  z-index:2;
}

@keyframes popIn{
  from{transform:scale(0.85);opacity:0}
  to{transform:scale(1);opacity:1}
}

.register-card h1{
  text-align:center;
  font-size:26px;
  color:#ff5722;
  margin-bottom:8px;
}

.register-card p{
  text-align:center;
  color:#666;
  font-size:14px;
  margin-bottom:25px;
}

/* ===== FORM ===== */
.form-row{
  display:flex;
  gap:12px;
}

.form-group{
  margin-bottom:16px;
  flex:1;
}

.form-group input,
.form-group textarea{
  width:100%;
  padding:14px;
  border-radius:14px;
  border:1px solid #ddd;
  font-size:14px;
  outline:none;
}

.form-group textarea{
  resize:none;
}

.form-group input:focus,
.form-group textarea:focus{
  border-color:#ff5722;
  box-shadow:0 0 0 3px rgba(255,87,34,0.2);
}

/* ===== ERROR MESSAGE ===== */
.error-text{
  margin-top:6px;
  font-size:12px;
  color:#e53935;
  font-weight:600;
}
<%!
String isUserName="block";
String isPassword="none";
%>
<%
isUserName=(Boolean)request.getAttribute("isUserExist")==null?"none":"block";
isPassword=(Boolean)request.getAttribute("isPasswordMatch")==null?"none":"block";


 %>
 
 





/* ===== ERROR MESSAGE ===== */
.error-text1{
  font-size:13px;
  color:#e53935;
  margin-top:6px;
  display: <%= isUserName%>;
  animation: shake 0.4s;
}

.error-text2{
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

/* ===== BUTTON ===== */
.btn{
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

.btn:hover{
  background:#e64a19;
}

/* ===== BOTTOM LINK ===== */
.bottom-text{
  margin-top:18px;
  text-align:center;
  font-size:14px;
  color:#555;
}

.bottom-text a{
  color:#ff5722;
  font-weight:600;
  text-decoration:none;
}

.bottom-text a:hover{
  text-decoration:underline;
}

/* ===== RESPONSIVE ===== */
@media(max-width:480px){
  .form-row{
    flex-direction:column;
  }

  .register-card{
    padding:30px 22px;
  }

  .register-card h1{
    font-size:22px;
  }
}

/* ===== SUCCESS POPUP ===== */
.success-overlay{
  position:fixed;
  top:0;
  left:0;
  width:100%;
  height:100%;
  background:rgba(0,0,0,0.45);
  display:flex;
  justify-content:center;
  align-items:center;
  z-index:9999;
  animation: fadeIn 0.4s ease;
}

.success-popup{
  background:#fff;
  padding:35px 30px;
  border-radius:22px;
  text-align:center;
  width:90%;
  max-width:380px;
  box-shadow:0 25px 50px rgba(0,0,0,0.25);
  animation: popIn 0.5s ease;
}

.success-icon{
  width:70px;
  height:70px;
  background:#2ecc71;
  color:#fff;
  border-radius:50%;
  display:flex;
  justify-content:center;
  align-items:center;
  font-size:34px;
  font-weight:800;
  margin:0 auto 15px;
}

.success-popup h2{
  color:#222;
  font-size:22px;
  margin-bottom:10px;
}

.success-popup p{
  color:#555;
  font-size:14px;
  margin-bottom:25px;
}

/* Success button tweak */
.success-btn{
  display:inline-block;
  padding:12px 26px;
  border-radius:14px;
}

/* Animations */
@keyframes fadeIn{
  from{opacity:0}
  to{opacity:1}
}

@keyframes popIn{
  from{transform:scale(0.85);opacity:0}
  to{transform:scale(1);opacity:1}
}

</style>
</head>

<body>

<!-- FOOD ICONS -->
<div class="food">🍕</div>
<div class="food">🍔</div>
<div class="food">🍜</div>
<div class="food">🍩</div>

<!-- REGISTER CARD -->
<div class="register-card">

  <h1>Create Account</h1>
  <p>Register to start ordering delicious food</p>

  <form action="callRegister" method="get">

    <!-- FIRST & LAST NAME -->
    <div class="form-row">
      <div class="form-group">
        <input type="text" name="firstName" placeholder="First Name" required>
      </div>
      <div class="form-group">
        <input type="text" name="lastName" placeholder="Last Name" required>
      </div>
    </div>

    <!-- ADDRESS -->
    <div class="form-group">
      <textarea name="address" rows="3" placeholder="Address" required></textarea>
    </div>
    
    <div class="form-group">
      <input type="tel" name="mobileNum" placeholder="Mobile Number" required>

      
        
      
    </div>

    <!-- EMAIL -->
    <div class="form-group">
      <input type="email" name="email" placeholder="Email Address" required>

      
        <div class="error-text1">User already exists with this email</div>
      
    </div>

    <!-- PASSWORD -->
    <div class="form-group">
      <input type="password" name="password" placeholder="Password" required>
    </div>

    <!-- CONFIRM PASSWORD -->
    <div class="form-group">
      <input type="password" name="confirmPassword" placeholder="Confirm Password" required>

      
        <div class="error-text2">Passwords do not match</div>
      
    </div>

    <button type="submit" class="btn">Register</button>

  </form>

  <div class="bottom-text">
    Already have an account?
    <a href="Login.jsp">Login</a>
  </div>

</div>

<%-- SUCCESS POPUP --%>
<% if(request.getAttribute("registerSuccess") != null){ %>

<div class="success-overlay">
  <div class="success-popup">

    <div class="success-icon">✓</div>

    <h2>Registration Successful</h2>
    <p>Your account has been created successfully.</p>

    <a href="Login.jsp" class="btn success-btn">Login Now</a>

  </div>
</div>

<% } %>


</body>
</html>
