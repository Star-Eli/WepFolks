<%@page import="entities.Product"%>
<%@page import="entities.User"%>
<%@page import="entities.CartItem"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Your Cart - WepFolks</title>

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<style>

/* RESET */
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

/* NAVBAR */
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
    z-index:1000;
}

/* WF LOGO STYLES */
.logo{
    display:flex;
    align-items:center;
    gap:12px;
    text-decoration:none;
}

.logo-icon{
    width:40px;
    height:40px;
    background:linear-gradient(135deg, #3b82f6, #8b5cf6);
    border-radius:10px;
    display:flex;
    align-items:center;
    justify-content:center;
    box-shadow:0 4px 10px rgba(59,130,246,0.3);
    transition:0.3s;
}

.logo-icon:hover{
    transform:scale(1.05);
}

.logo-icon span{
    font-size:20px;
    font-weight:800;
    color:white;
}

.logo-text{
    font-size:24px;
    font-weight:800;
    background:linear-gradient(135deg, #3b82f6, #8b5cf6);
    -webkit-background-clip:text;
    -webkit-text-fill-color:transparent;
    background-clip:text;
}

.logo-text span{
    font-weight:300;
    -webkit-text-fill-color:#64748b;
}

.nav-links{
    display:flex;
    gap:25px;
    align-items:center;
}

.nav-links a{
    text-decoration:none;
    color:#475569;
    font-weight:600;
    transition:0.3s;
    display:inline-flex;
    align-items:center;
    gap:6px;
}

.nav-links a:hover{
    color:#3b82f6;
}

/* CART CONTAINER */
.container{
    max-width:1100px;
    margin:40px auto;
    padding:0 20px;
}

.cart-header{
    text-align:center;
    margin-bottom:30px;
}

.cart-header h2{
    font-size:36px;
    font-weight:800;
    background:linear-gradient(135deg, #fff, #e0e7ff);
    -webkit-background-clip:text;
    -webkit-text-fill-color:transparent;
    background-clip:text;
}

.cart-header h2 i{
    -webkit-text-fill-color:#fff;
    margin-right:12px;
}

.cart-header p{
    color:#e2e8f0;
    margin-top:10px;
}

/* CART ITEMS */
.cart-items{
    background:white;
    border-radius:24px;
    overflow:hidden;
    box-shadow:0 20px 35px rgba(0,0,0,0.1);
}

.cart-item{
    display:grid;
    grid-template-columns:100px 1fr 120px 100px 60px;
    align-items:center;
    gap:15px;
    padding:20px;
    border-bottom:1px solid #e2e8f0;
    transition:0.3s;
}

.cart-item:hover{
    background:#f8fafc;
}

.cart-item:last-child{
    border-bottom:none;
}

.item-image{
    width:80px;
    height:80px;
    border-radius:12px;
    object-fit:cover;
    background:#f1f5f9;
}

.item-details h4{
    font-size:16px;
    font-weight:700;
    color:#1e293b;
    margin-bottom:5px;
}

.item-details p{
    font-size:13px;
    color:#64748b;
    line-height:1.4;
}

.item-price{
    font-weight:700;
    color:#3b82f6;
    font-size:18px;
}

.item-quantity{
    display:flex;
    align-items:center;
    gap:10px;
}

.quantity-btn{
    width:32px;
    height:32px;
    border-radius:8px;
    border:1px solid #e2e8f0;
    background:white;
    cursor:pointer;
    transition:0.3s;
    display:flex;
    align-items:center;
    justify-content:center;
    text-decoration:none;
    color:#1e293b;
}

.quantity-btn:hover{
    background:#3b82f6;
    color:white;
    border-color:#3b82f6;
}

.qty-value{
    font-weight:600;
    min-width:30px;
    text-align:center;
}

.item-subtotal{
    font-weight:800;
    color:#1e293b;
    font-size:16px;
}

.remove-item{
    color:#ef4444;
    cursor:pointer;
    transition:0.3s;
    font-size:18px;
    text-align:center;
}

.remove-item a{
    color:#ef4444;
    text-decoration:none;
}

.remove-item:hover{
    transform:scale(1.1);
}

/* CART SUMMARY */
.cart-summary{
    background:white;
    border-radius:24px;
    padding:25px;
    margin-top:25px;
    box-shadow:0 20px 35px rgba(0,0,0,0.1);
}

.summary-row{
    display:flex;
    justify-content:space-between;
    padding:12px 0;
    border-bottom:1px solid #e2e8f0;
}

.summary-row:last-child{
    border-bottom:none;
    font-size:22px;
    font-weight:800;
    color:#3b82f6;
    padding-top:15px;
}

.summary-label{
    color:#64748b;
    font-weight:500;
}

.summary-value{
    font-weight:700;
    color:#1e293b;
}

.checkout-btn{
    width:100%;
    background:linear-gradient(135deg, #10b981, #059669);
    color:white;
    border:none;
    padding:16px;
    border-radius:14px;
    font-size:18px;
    font-weight:700;
    cursor:pointer;
    transition:0.3s;
    margin-top:20px;
    display:flex;
    align-items:center;
    justify-content:center;
    gap:10px;
}

.checkout-btn:hover{
    transform:translateY(-2px);
    box-shadow:0 10px 25px rgba(16,185,129,0.3);
}

.empty-cart{
    text-align:center;
    padding:60px 20px;
    background:white;
    border-radius:24px;
}

.empty-cart i{
    font-size:80px;
    color:#cbd5e1;
    margin-bottom:20px;
}

.empty-cart h3{
    color:#1e293b;
    margin-bottom:10px;
}

.empty-cart p{
    color:#64748b;
    margin-bottom:20px;
}

.shop-btn{
    display:inline-flex;
    align-items:center;
    gap:8px;
    background:linear-gradient(135deg, #3b82f6, #2563eb);
    color:white;
    text-decoration:none;
    padding:12px 24px;
    border-radius:12px;
    font-weight:600;
    transition:0.3s;
}

.shop-btn:hover{
    transform:translateY(-2px);
    box-shadow:0 5px 15px rgba(59,130,246,0.3);
}

/* RESPONSIVE */
@media(max-width:768px){
    .cart-item{
        grid-template-columns:1fr;
        text-align:center;
        gap:12px;
    }
    .item-image{
        margin:0 auto;
    }
    .item-quantity{
        justify-content:center;
    }
    .nav-links{
        gap:12px;
        flex-wrap:wrap;
    }
    .navbar{
        flex-direction:column;
        gap:15px;
    }
    .logo-text{
        font-size:20px;
    }
}

/* ALERTS */
.alert{
    padding:15px 20px;
    border-radius:12px;
    margin-bottom:20px;
    display:flex;
    align-items:center;
    gap:12px;
    animation:slideIn 0.4s ease;
}

.alert-success{
    background:#d1fae5;
    color:#065f46;
    border-left:4px solid #10b981;
}

@keyframes slideIn{
    from{
        opacity:0;
        transform:translateY(-20px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

/* CART COUNT BADGE */
.cart-count{
    background:#3b82f6;
    color:white;
    border-radius:50%;
    width:20px;
    height:20px;
    display:inline-flex;
    align-items:center;
    justify-content:center;
    font-size:11px;
    font-weight:700;
    margin-left:5px;
}

/* FOOTER STYLES */
.footer{
    background:#0f172a;
    color:white;
    padding:40px 8% 20px;
    margin-top:40px;
}

.footer-content{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
    gap:30px;
    margin-bottom:30px;
}

.footer-section h3{
    margin-bottom:15px;
    font-size:16px;
    display:flex;
    align-items:center;
    gap:8px;
}

.footer-section p{
    color:#94a3b8;
    font-size:14px;
    line-height:1.6;
}

.footer-logo{
    display:flex;
    align-items:center;
    gap:10px;
    margin-bottom:15px;
}

.footer-logo-icon{
    width:35px;
    height:35px;
    background:linear-gradient(135deg, #3b82f6, #8b5cf6);
    border-radius:10px;
    display:flex;
    align-items:center;
    justify-content:center;
}

.footer-logo-icon span{
    font-size:18px;
    font-weight:800;
    color:white;
}

.footer-logo-text{
    font-size:18px;
    font-weight:700;
    color:white;
}

.social-links{
    display:flex;
    gap:15px;
    margin-top:15px;
}

.social-links a{
    color:#94a3b8;
    font-size:18px;
    transition:0.3s;
}

.social-links a:hover{
    color:#3b82f6;
}

.footer-bottom{
    text-align:center;
    padding-top:20px;
    border-top:1px solid #334155;
    color:#94a3b8;
    font-size:13px;
}

@media(max-width:768px){
    .footer-content{
        grid-template-columns:1fr;
        text-align:center;
    }
    .footer-logo{
        justify-content:center;
    }
    .social-links{
        justify-content:center;
    }
}
</style>

</head>

<body>

<%
    User user = (User) session.getAttribute("user");
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    double total = 0;
    String removed = request.getParameter("removed");
    
    int cartCount = 0;
    if(cart != null){
        for(CartItem item : cart){
            cartCount += item.getQuantity();
        }
    }
%>

<!-- NAVBAR -->
<nav class="navbar">
    <a href="DisplayProductsServlet" class="logo">
        <div class="logo-icon">
            <span>WF</span>
        </div>
        <div class="logo-text">Wep<span>Folks</span></div>
    </a>
    <div class="nav-links">
        <a href="DisplayProductsServlet"><i class="fas fa-home"></i> Home</a>
        <a href="cart.jsp"><i class="fas fa-shopping-cart"></i> Cart 
            <% if(cartCount > 0){ %>
                <span class="cart-count"><%= cartCount %></span>
            <% } %>
        </a>
        <% if (user != null) { %>
            <a href="checkout.jsp"><i class="fas fa-credit-card"></i> Checkout</a>
            <a href="OrderHistoryServlet"><i class="fas fa-history"></i> Orders</a>
            <a href="profile.jsp"><i class="fas fa-user"></i> Profile</a>
            <a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a>
        <% } else { %>
            <a href="login.jsp"><i class="fas fa-sign-in-alt"></i> Login</a>
            <a href="register.jsp"><i class="fas fa-user-plus"></i> Register</a>
        <% } %>
    </div>
</nav>

<!-- CART CONTENT -->
<div class="container">

    <div class="cart-header">
        <h2><i class="fas fa-shopping-bag"></i> Your Shopping Cart</h2>
        <p><i class="fas fa-gift"></i> Review your items before checking out</p>
    </div>
    
    <% if(removed != null && removed.equals("true")){ %>
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i>
            <span>Item removed from cart successfully!</span>
        </div>
    <% } %>

    <%
    if (cart != null && !cart.isEmpty()) {
    %>

    <div class="cart-items">
        <%
            for (CartItem item : cart) {
                Product p = item.getProduct();
                if (p == null) continue;
                int qty = item.getQuantity();
                double subtotal = p.getPrice() * qty;
                total += subtotal;
        %>
        
        <div class="cart-item">
            <img src="ProductImageServlet?id=<%= p.getId() %>" class="item-image" onerror="this.src='https://via.placeholder.com/80?text=WF'">
            
            <div class="item-details">
                <h4><%= p.getName() %></h4>
                <p><%= p.getDescription() != null && p.getDescription().length() > 50 ? p.getDescription().substring(0,50) + "..." : p.getDescription() %></p>
            </div>
            
            <div class="item-price">R<%= String.format("%.2f", p.getPrice()) %></div>
            
            <div class="item-quantity">
                <a href="AddCartServlet?action=update&id=<%= p.getId() %>&change=decrease" class="quantity-btn">-</a>
                <span class="qty-value"><%= qty %></span>
                <a href="AddCartServlet?action=update&id=<%= p.getId() %>&change=increase" class="quantity-btn">+</a>
            </div>
            
            <div class="item-subtotal">R<%= String.format("%.2f", subtotal) %></div>
            
            <div class="remove-item">
                <a href="AddCartServlet?action=remove&id=<%= p.getId() %>" onclick="return confirm('Remove <%= p.getName() %> from cart?')">
                    <i class="fas fa-trash-alt"></i>
                </a>
            </div>
        </div>
        
        <%
            }
        %>
    </div>

    <!-- CART SUMMARY -->
    <div class="cart-summary">
        <div class="summary-row">
            <span class="summary-label">Subtotal</span>
            <span class="summary-value">R<%= String.format("%.2f", total) %></span>
        </div>
        <div class="summary-row">
            <span class="summary-label">Shipping</span>
            <span class="summary-value">Free</span>
        </div>
        <div class="summary-row">
            <span class="summary-label">Total</span>
            <span class="summary-value">R<%= String.format("%.2f", total) %></span>
        </div>
        
        <form action="CheckoutServlet" method="post">
            <button type="submit" class="checkout-btn">
                <i class="fas fa-arrow-right"></i> Proceed to Checkout
            </button>
        </form>
    </div>

    <%
    } else {
    %>

    <!-- EMPTY CART -->
    <div class="empty-cart">
        <i class="fas fa-shopping-cart"></i>
        <h3>Your cart is empty</h3>
        <p>Looks like you haven't added any items to your cart yet.</p>
        <a href="DisplayProductsServlet" class="shop-btn">
            <i class="fas fa-shopping-bag"></i> Start Shopping
        </a>
    </div>

    <%
    }
    %>

</div>

<!-- FOOTER -->
<div class="footer">
    <div class="footer-content">
        <div class="footer-section">
            <div class="footer-logo">
                <div class="footer-logo-icon">
                    <span>WF</span>
                </div>
                <div class="footer-logo-text">WepFolks</div>
            </div>
            <p>Your one-stop destination for quality products at affordable prices. Shop with confidence.</p>
            <div class="social-links">
                <a href="#"><i class="fab fa-facebook"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-linkedin"></i></a>
            </div>
        </div>
        
        <div class="footer-section">
            <h3><i class="fas fa-info-circle"></i> About Us</h3>
            <p>WepFolks is committed to providing the best shopping experience with quality products and excellent customer service.</p>
        </div>
        
        <div class="footer-section">
            <h3><i class="fas fa-map-marker-alt"></i> Contact Info</h3>
            <p><i class="fas fa-map-marker-alt"></i> 123 Main Street, Johannesburg</p>
            <p><i class="fas fa-phone"></i> +27 12 345 6789</p>
            <p><i class="fas fa-envelope"></i> info@wepfolks.co.za</p>
        </div>
    </div>
    <div class="footer-bottom">
        <p>&copy; 2024 WepFolks. All rights reserved. | Designed with <i class="fas fa-heart" style="color:#ef4444;"></i> for South Africa</p>
    </div>
</div>

</body>
</html>