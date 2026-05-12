<%@page import="entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Order Successful - WepFolks</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Inter', sans-serif;
}

body{
    background:linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height:100vh;
}

/* NAVBAR (same style as index) */
.navbar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:18px 8%;
    background:rgba(255,255,255,0.95);
    backdrop-filter:blur(10px);
    box-shadow:0 4px 20px rgba(0,0,0,0.1);
    position:sticky;
    top:0;
}

/* LOGO */
.logo{
    display:flex;
    align-items:center;
    gap:12px;
    text-decoration:none;
}

.logo-icon{
    width:45px;
    height:45px;
    background:linear-gradient(135deg, #3b82f6, #8b5cf6);
    border-radius:12px;
    display:flex;
    align-items:center;
    justify-content:center;
}

.logo-icon span{
    font-size:24px;
    font-weight:800;
    color:white;
}

.logo-text{
    font-size:24px;
    font-weight:800;
    background:linear-gradient(135deg, #3b82f6, #8b5cf6);
    -webkit-background-clip:text;
    -webkit-text-fill-color:transparent;
}

/* MAIN CARD */
.container{
    width:60%;
    margin:80px auto;
    background:white;
    padding:40px;
    border-radius:20px;
    box-shadow:0 20px 50px rgba(0,0,0,0.15);
    text-align:center;
    animation:fadeInUp 0.6s ease;
}

.success-icon{
    font-size:70px;
    color:#22c55e;
    margin-bottom:20px;
}

h1{
    font-size:32px;
    font-weight:800;
    color:#1e293b;
    margin-bottom:10px;
}

p{
    font-size:18px;
    color:#64748b;
    margin:10px 0;
}

/* BUTTONS */
.links{
    margin-top:30px;
    display:flex;
    justify-content:center;
    flex-wrap:wrap;
    gap:15px;
}

.links a{
    text-decoration:none;
    padding:12px 20px;
    border-radius:12px;
    font-weight:700;
    color:white;
    transition:0.3s;
    display:inline-flex;
    align-items:center;
    gap:8px;
}

/* buttons */
.shop{
    background:linear-gradient(135deg, #3b82f6, #2563eb);
}

.cart{
    background:#f59e0b;
}

.orders{
    background:#8b5cf6;
}

.links a:hover{
    transform:translateY(-3px);
    box-shadow:0 10px 20px rgba(0,0,0,0.2);
}

/* ANIMATION */
@keyframes fadeInUp{
    from{
        opacity:0;
        transform:translateY(30px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

/* RESPONSIVE */
@media(max-width:768px){
    .container{
        width:90%;
        padding:25px;
    }
}
</style>

</head>

<body>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String message = (String) session.getAttribute("message");
    if (message == null) {
        message = "Your order has been placed successfully.";
    }
%>

<!-- SIMPLE NAVBAR -->
<nav class="navbar">

    <a href="DisplayProductsServlet" class="logo">
        <div class="logo-icon">
            <span>WF</span>
        </div>
        <div class="logo-text">WepFolks</div>
    </a>

</nav>

<!-- SUCCESS CARD -->
<div class="container">

    <div class="success-icon">
        <i class="fas fa-check-circle"></i>
    </div>

    <h1>Order Successful</h1>

    <p>
        Thank you, <b><%= user.getName() %></b>
    </p>

    <p>
        <%= message %>
    </p>

    <div class="links">

        <a href="DisplayProductsServlet" class="shop">
            <i class="fas fa-shopping-bag"></i> Continue Shopping
        </a>

        <a href="cart.jsp" class="cart">
            <i class="fas fa-shopping-cart"></i> View Cart
        </a>

        <a href="OrderHistoryServlet" class="orders">
            <i class="fas fa-receipt"></i> View Orders
        </a>

    </div>

</div>

<%
    session.removeAttribute("message");
%>

</body>
</html>