<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login | FoodExpress</title>

<style>
*{
  margin:0;
  padding:0;
  box-sizing:border-box;
  font-family:'Segoe UI', sans-serif;
}

body{
  min-height:100vh;
  display:flex;
  justify-content:center;
  align-items:center;
  background:linear-gradient(135deg,#fff7f2,#ffe3d6);
  overflow:hidden;
  position:relative;
}

/* ===== FLOATING FOOD ICONS ===== */
.food-bg span{
  position:absolute;
  font-size:26px;
  opacity:0.12;
  animation: float 10s infinite ease-in-out;
}

.food-bg span:nth-child(1){top:10%;left:20%}
.food-bg span:nth-child(2){top:30%;left:75%}
.food-bg span:nth-child(3){top:60%;left:15%}
.food-bg span:nth-child(4){top:80%;left:80%}
.food-bg span:nth-child(5){top:50%;left:50%}

@keyframes float{
  0%{transform:translateY(0)}
  50%{transform:translateY(-25px)}
  100%{transform:translateY(0)}
}

/* ===== LOGIN CARD ===== */
.login-card{
  background:#fff;
  width:360px;
  padding:35px 30px;
  border-radius:18px;
  box-shadow:0 15px 40px rgba(0,0,0,0.15);
  animation: pop 0.7s ease;
  z-index:2;
}

@keyframes pop{
  from{transform:scale(0.9);opacity:0}
  to{transform:scale(1);opacity:1}
}

.login-card h2{
  text-align:center;
  color:#ff5722;
}

.login-card p{
  text-align:center;
  color:#777;
  font-size:14px;
  margin:8px 0 25px;
}

/* ===== INPUT ===== */
.field{
  margin-bottom:15px;
}

.field label{
  font-size:14px;
  font-weight:600;
}

.field input{
  width:100%;
  padding:10px 12px;
  margin-top:6px;
  border-radius:10px;
  border:1px solid #ccc;
  outline:none;
  transition:0.3s;
}

.field input:focus{
  border-color:#ff5722;
  box-shadow:0 0 0 3px rgba(255,87,34,0.2);
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

/*
Servlet-controlled states
Add ONE of these classes from servlet:
.user-not-found
.password-wrong
*/


.user-not-found .user-error{display:block;}
.password-wrong .pass-error{display:block;}

/* ===== LINKS ===== */
.options{
  display:flex;
  justify-content:flex-end;
  font-size:13px;
  margin-bottom:20px;
}

.options a{
  text-decoration:none;
  color:#ff5722;
  font-weight:600;
}

/* ===== BUTTON ===== */
.login-btn{
  width:100%;
  padding:11px;
  background:#ff5722;
  border:none;
  border-radius:12px;
  color:#fff;
  font-size:15px;
  font-weight:600;
  cursor:pointer;
  transition:0.3s;
  position:relative;
  overflow:hidden;
}

.login-btn::after{
  content:'';
  position:absolute;
  left:-100%;
  top:0;
  width:100%;
  height:100%;
  background:rgba(255,255,255,0.3);
  transition:0.4s;
}

.login-btn:hover::after{left:100%}
.login-btn:hover{background:#e64a19}

/* ===== SIGNUP ===== */
.signup{
  text-align:center;
  margin-top:20px;
  font-size:14px;
}

.signup a{
  color:#ff5722;
  font-weight:700;
  text-decoration:none;
}

/* ===== RESPONSIVE ===== */
@media(max-width:480px){
  .login-card{
    width:90%;
    padding:30px 20px;
  }
}
/* ===== GUEST LOGIN ===== */
.guest-login{
  margin-top:14px;
  text-align:center;
  font-size:14px;
  color:#777;
}

.guest-login span{
  display:block;
  margin-bottom:6px;
}

.guest-login a{
  color:#333;
  font-weight:600;
  text-decoration:none;
  border-bottom:2px dashed #ff5722;
  padding-bottom:2px;
  transition:0.3s;
}

.guest-login a:hover{
  color:#ff5722;
  border-bottom-style:solid;
}
</style>
</head>

<body>

<!-- Food background -->
<div class="food-bg">
  <span>🍕</span>
  <span>🍔</span>
  <span>🍩</span>
  <span>🍜</span>
  <span>🥗</span>
</div>

<!--
Servlet will add ONE class below:
class="login-card user-not-found"
class="login-card password-wrong"
-->
<div class="login-card">

  <h2>Welcome Back</h2>
  <p>Login to order your favorite food</p>

  <form method="get"  action="callLoginServlet">

    <div class="field">
      <label>User ID / Email</label>
      <input type="text" name="username" required>
      <div class="error1 user-error">User not present</div>
    </div>

    <div class="field">
      <label>Password</label>
      <input type="password" name="password" required>
      <div class="error2 pass-error">Password was wrong</div>
    </div>

    <div class="options">
      <a href="#">Forgot Password?</a>
    </div>

    <button class="login-btn">Login</button>
  </form>

  <div class="signup">
    Don’t have an account? <a href="Register.jsp">Create an account</a>
  </div>
  <div class="guest-login">
  <span>or</span>
  <a href="callRestaurantsServlet?guest=true">
    Continue as Guest
  </a>
</div>

</div>

</body>
</html>
