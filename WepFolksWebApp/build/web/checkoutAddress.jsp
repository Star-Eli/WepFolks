<%@page import="entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>WepFolks - Delivery Address</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800&display=swap" rel="stylesheet">

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Inter', sans-serif;
}

/* BACKGROUND */
body{
    background:linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height:100vh;
}

/* NAVBAR (same as index.jsp) */
.navbar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:18px 8%;
    background:rgba(255,255,255,0.95);
    backdrop-filter:blur(10px);
    position:sticky;
    top:0;
    z-index:1000;
}

.logo{
    display:flex;
    align-items:center;
    gap:10px;
    text-decoration:none;
}

.logo-icon{
    width:40px;
    height:40px;
    background:linear-gradient(135deg,#3b82f6,#8b5cf6);
    display:flex;
    align-items:center;
    justify-content:center;
    border-radius:10px;
    color:white;
    font-weight:800;
}

.logo-text{
    font-size:20px;
    font-weight:800;
    background:linear-gradient(135deg,#3b82f6,#8b5cf6);
    -webkit-background-clip:text;
    -webkit-text-fill-color:transparent;
}

.navbar a{
    margin-left:20px;
    text-decoration:none;
    color:#475569;
    font-weight:600;
}

/* FORM CARD */
.container{
    width:420px;
    margin:80px auto;
    background:white;
    padding:35px;
    border-radius:20px;
    box-shadow:0 15px 40px rgba(0,0,0,0.15);
    animation:fadeIn 0.5s ease;
}

/* TITLE */
h2{
    text-align:center;
    margin-bottom:25px;
    font-size:28px;
    font-weight:800;
    background:linear-gradient(135deg,#3b82f6,#8b5cf6);
    -webkit-background-clip:text;
    -webkit-text-fill-color:transparent;
}

/* INPUTS */
input{
    width:100%;
    padding:14px;
    margin:10px 0;
    border:1px solid #e5e7eb;
    border-radius:12px;
    font-size:14px;
    outline:none;
    transition:0.3s;
}

input:focus{
    border-color:#3b82f6;
    box-shadow:0 0 0 3px rgba(59,130,246,0.15);
}

/* BUTTON */
button{
    width:100%;
    padding:14px;
    margin-top:15px;
    background:linear-gradient(135deg,#3b82f6,#2563eb);
    color:white;
    border:none;
    border-radius:12px;
    font-weight:700;
    font-size:15px;
    cursor:pointer;
    transition:0.3s;
}

button:hover{
    transform:translateY(-2px);
    box-shadow:0 10px 20px rgba(59,130,246,0.3);
}

/* ANIMATION */
@keyframes fadeIn{
    from{opacity:0; transform:translateY(20px);}
    to{opacity:1; transform:translateY(0);}
}
</style>

</head>

<body>

<!-- NAVBAR -->
<nav class="navbar">

    <a href="DisplayProductsServlet" class="logo">
        <div class="logo-icon">WF</div>
        <div class="logo-text">WepFolks</div>
    </a>

    <div>
        <a href="DisplayProductsServlet"><i class="fas fa-home"></i> Home</a>
        <a href="cart.jsp"><i class="fas fa-shopping-cart"></i> Cart</a>
        <a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>

</nav>

<!-- FORM -->
<div class="container">

    <h2><i class="fas fa-truck"></i> Delivery Address</h2>

    <form action="CheckOutSaveAddressServlet" method="post">

        <input type="text" name="province" placeholder="Province" required>

        <input type="text" name="city" placeholder="City" required>

        <input type="text" name="address" placeholder="Street Address" required>

        <button type="submit">
            Continue to Payment <i class="fas fa-arrow-right"></i>
        </button>

    </form>

</div>

</body>
</html>