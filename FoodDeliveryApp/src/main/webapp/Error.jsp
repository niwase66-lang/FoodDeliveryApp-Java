<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Something Went Wrong | FoodExpress</title>

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
  background:linear-gradient(135deg,#fdfbfb,#ebedee);
}

/* ===== ERROR CARD ===== */
.error-container{
  background:#fff;
  max-width:420px;
  width:90%;
  padding:40px 30px;
  border-radius:22px;
  text-align:center;
  box-shadow:0 20px 40px rgba(0,0,0,0.15);
  animation: popIn 0.6s ease;
}

@keyframes popIn{
  from{
    opacity:0;
    transform:scale(0.9) translateY(20px);
  }
  to{
    opacity:1;
    transform:scale(1) translateY(0);
  }
}

/* ===== ICON ===== */
.error-icon{
  font-size:64px;
  margin-bottom:15px;
  animation: shake 1.2s infinite;
}

@keyframes shake{
  0%,100%{transform:rotate(0deg);}
  25%{transform:rotate(-5deg);}
  75%{transform:rotate(5deg);}
}

/* ===== TEXT ===== */
.error-title{
  font-size:24px;
  font-weight:800;
  color:#ff5722;
  margin-bottom:10px;
}

.error-msg{
  font-size:15px;
  color:#555;
  line-height:1.6;
  margin-bottom:25px;
}

/* ===== BUTTON ===== */
.login-btn{
  display:inline-block;
  padding:14px 28px;
  border-radius:16px;
  background:#ff5722;
  color:#fff;
  text-decoration:none;
  font-weight:700;
  transition:0.3s;
}

.login-btn:hover{
  background:#e64a19;
  transform:translateY(-2px);
  box-shadow:0 10px 20px rgba(255,87,34,0.3);
}

/* ===== FOOT NOTE ===== */
.support-text{
  margin-top:18px;
  font-size:13px;
  color:#888;
}

/* ===== RESPONSIVE ===== */
@media(max-width:480px){
  .error-container{
    padding:30px 20px;
  }
  .error-title{
    font-size:22px;
  }
}
</style>
</head>

<body>

<div class="error-container">
  <div class="error-icon">😔</div>
  <div class="error-title">Oops! Something Went Wrong</div>
  <div class="error-msg">
    We’re really sorry for the inconvenience.<br>
    Something didn’t work as expected.<br>
    Please try logging in again.
  </div>

  <!-- Redirect to Login -->
  <a href="Login.jsp" class="login-btn">Go to Login</a>

  <div class="support-text">
    If the problem continues, please contact support.
  </div>
</div>

</body>
</html>
