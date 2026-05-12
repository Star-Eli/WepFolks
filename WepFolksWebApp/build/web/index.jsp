<%@page import="entities.CartItem"%>
<%@page import="entities.User"%>
<%@page import="entities.Product"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>WepFolks - Your Premier Shopping Destination</title>

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<!-- Google Fonts -->
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
  color:#1e293b;
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
  width:45px;
  height:45px;
  background:linear-gradient(135deg, #3b82f6, #8b5cf6);
  border-radius:12px;
  display:flex;
  align-items:center;
  justify-content:center;
  position:relative;
  overflow:hidden;
  box-shadow:0 4px 15px rgba(59,130,246,0.3);
  transition:0.3s;
}

.logo-icon:hover{
  transform:scale(1.05);
  box-shadow:0 6px 20px rgba(59,130,246,0.4);
}

.logo-icon span{
  font-size:24px;
  font-weight:800;
  color:white;
  letter-spacing:1px;
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
  color:#64748b;
  -webkit-text-fill-color:#64748b;
}

.nav-links{
  display:flex;
  gap:30px;
  list-style:none;
  align-items:center;
}

.nav-links a{
  text-decoration:none;
  color:#475569;
  font-weight:600;
  transition:0.3s;
}

.nav-links a:hover{
  color:#3b82f6;
}

.welcome-text{
  color:#64748b;
  font-weight:500;
}

.welcome-text i{
  margin-right:8px;
  color:#3b82f6;
}

.cart-btn{
  background:linear-gradient(135deg, #3b82f6, #2563eb);
  color:white;
  padding:10px 20px;
  border-radius:12px;
  font-weight:700;
  transition:0.3s;
  display:inline-flex;
  align-items:center;
  gap:8px;
}

.cart-btn:hover{
  transform:translateY(-2px);
  box-shadow:0 10px 20px rgba(59,130,246,0.3);
}

.logout-btn{
  background:#ef4444;
  color:white;
  padding:8px 18px;
  border-radius:10px;
  font-weight:600;
  transition:0.3s;
}

.logout-btn:hover{
  background:#dc2626;
  transform:translateY(-2px);
}

/* HERO SECTION */
.hero{
  background:linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding:80px 8%;
  text-align:center;
  color:white;
}

.hero h1{
  font-size:52px;
  font-weight:800;
  margin-bottom:20px;
  animation:fadeInUp 0.8s ease;
}

.hero h1 .wf-highlight{
  background:linear-gradient(135deg, #fbbf24, #f59e0b);
  -webkit-background-clip:text;
  -webkit-text-fill-color:transparent;
  background-clip:text;
}

.hero p{
  font-size:20px;
  opacity:0.95;
  margin-bottom:30px;
  animation:fadeInUp 0.8s ease 0.2s forwards;
  opacity:0;
}

.shop-now{
  display:inline-block;
  background:white;
  color:#667eea;
  padding:14px 35px;
  border-radius:50px;
  text-decoration:none;
  font-weight:700;
  font-size:16px;
  transition:0.3s;
  animation:fadeInUp 0.8s ease 0.4s forwards;
  opacity:0;
}

.shop-now:hover{
  transform:translateY(-3px);
  box-shadow:0 10px 25px rgba(0,0,0,0.2);
}

/* PRODUCTS SECTION */
.products{
  padding:60px 8%;
  background:white;
}

.section-header{
  text-align:center;
  margin-bottom:50px;
}

.section-header h2{
  font-size:36px;
  font-weight:800;
  background:linear-gradient(135deg, #3b82f6, #8b5cf6);
  -webkit-background-clip:text;
  -webkit-text-fill-color:transparent;
  background-clip:text;
  margin-bottom:10px;
}

.section-header p{
  color:#64748b;
  font-size:16px;
}

.product-grid{
  display:grid;
  grid-template-columns:repeat(auto-fit,minmax(280px,1fr));
  gap:30px;
}

.product-card{
  background:white;
  border-radius:20px;
  overflow:hidden;
  box-shadow:0 10px 30px rgba(0,0,0,0.08);
  transition:all 0.3s ease;
  cursor:pointer;
  position:relative;
}

.product-card:hover{
  transform:translateY(-10px);
  box-shadow:0 20px 40px rgba(0,0,0,0.15);
}

.product-badge{
  position:absolute;
  top:15px;
  right:15px;
  background:#ef4444;
  color:white;
  padding:5px 12px;
  border-radius:20px;
  font-size:12px;
  font-weight:700;
  z-index:10;
}

.product-card img{
  width:100%;
  height:260px;
  object-fit:cover;
  transition:0.5s;
}

.product-card:hover img{
  transform:scale(1.05);
}

.product-info{
  padding:20px;
}

.product-info h3{
  font-size:18px;
  font-weight:700;
  margin-bottom:10px;
  color:#1e293b;
}

.product-info p{
  color:#64748b;
  font-size:14px;
  margin-bottom:15px;
  line-height:1.5;
}

.price{
  font-size:24px;
  font-weight:800;
  color:#3b82f6;
  margin-bottom:15px;
}

.price span{
  font-size:14px;
  color:#94a3b8;
  text-decoration:line-through;
  margin-left:8px;
}

.add-cart{
  width:100%;
  padding:12px;
  background:linear-gradient(135deg, #3b82f6, #2563eb);
  color:white;
  border:none;
  cursor:pointer;
  border-radius:12px;
  font-weight:700;
  font-size:14px;
  transition:0.3s;
  display:flex;
  align-items:center;
  justify-content:center;
  gap:8px;
}

.add-cart:hover{
  transform:scale(1.02);
  box-shadow:0 5px 15px rgba(59,130,246,0.4);
}

/* FOOTER */
.footer{
  background:#0f172a;
  color:white;
  padding:50px 8% 30px;
}

.footer-content{
  display:grid;
  grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
  gap:40px;
  margin-bottom:40px;
}

.footer-section h3{
  margin-bottom:20px;
  font-size:18px;
  display:flex;
  align-items:center;
  gap:8px;
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
  font-size:20px;
  font-weight:700;
  color:white;
}

.footer-section p{
  color:#94a3b8;
  line-height:1.6;
}

.social-links{
  display:flex;
  gap:15px;
  margin-top:15px;
}

.social-links a{
  color:#94a3b8;
  font-size:20px;
  transition:0.3s;
}

.social-links a:hover{
  color:#3b82f6;
}

.footer-bottom{
  text-align:center;
  padding-top:30px;
  border-top:1px solid #334155;
  color:#94a3b8;
}

/* ANIMATIONS */
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

.product-card{
  animation:fadeInUp 0.6s ease forwards;
  opacity:0;
}

.product-card:nth-child(1){ animation-delay:0.1s; }
.product-card:nth-child(2){ animation-delay:0.2s; }
.product-card:nth-child(3){ animation-delay:0.3s; }
.product-card:nth-child(4){ animation-delay:0.4s; }

/* RESPONSIVE */
@media(max-width:768px){
  .navbar{
    flex-direction:column;
    gap:15px;
    padding:15px 5%;
  }
  .nav-links{
    flex-wrap:wrap;
    justify-content:center;
    gap:15px;
  }
  .hero h1{
    font-size:32px;
  }
  .hero p{
    font-size:16px;
  }
  .products{
    padding:40px 5%;
  }
  .product-grid{
    gap:20px;
  }
}
</style>

</head>

<body>

<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    User user = (User) session.getAttribute("user");
    String status = (user != null) ? "loggedin" : "loggedout";
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    int qty = 0;
    if (cart != null) {
        for (CartItem item : cart) {
            qty += item.getQuantity();
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

    <ul class="nav-links">
        <li><a href="DisplayProductsServlet"><i class="fas fa-home"></i> Home</a></li>
        <% if (status.equals("loggedout")) { %>
            <li><a href="login.jsp"><i class="fas fa-sign-in-alt"></i> Login</a></li>
            <li><a href="register.jsp"><i class="fas fa-user-plus"></i> Register</a></li>
        <% } %>
        <% if (status.equals("loggedin")) { %>
            <li><a href="checkout.jsp"><i class="fas fa-credit-card"></i> Checkout</a></li>
            <li><a href="profile.jsp"><i class="fas fa-user-circle"></i> Profile</a></li>
            <li class="welcome-text"><i class="fas fa-hand-wave"></i> Welcome, <%= user.getName() %>!</li>
        <% } %>
    </ul>

    <% if (status.equals("loggedin")) { %>
        <div style="display:flex; gap:10px; align-items:center;">
            <a href="cart.jsp" class="cart-btn">
                <i class="fas fa-shopping-cart"></i> Cart (<%= qty %>)
            </a>
            <a href="LogoutServlet" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    <% } %>
</nav>

<!-- HERO SECTION -->
<div class="hero">
    <h1>Welcome to <span class="wf-highlight">WepFolks</span></h1>
    <p>Discover amazing products at unbeatable prices. Shop the latest trends with free shipping on orders over R500!</p>
    <a href="#products" class="shop-now">Shop Now <i class="fas fa-arrow-right"></i></a>
</div>

<!-- PRODUCTS SECTION -->
<div class="products" id="products">
    <div class="section-header">
        <h2><i class="fas fa-fire"></i> Featured Products</h2>
        <p>Hand-picked just for you from our latest collection</p>
    </div>

    <div class="product-grid">
        <%
            if (products == null || products.isEmpty()) {
        %>
            <div style="text-align:center; grid-column:1/-1; padding:60px;">
                <i class="fas fa-box-open" style="font-size:64px; color:#cbd5e1;"></i>
                <h3 style="margin-top:20px; color:#64748b;">No products available</h3>
                <p style="color:#94a3b8;">Check back soon for amazing deals!</p>
            </div>
        <%
            } else {
                int count = 0;
                for (Product p : products) {
                    count++;
        %>
        <div class="product-card">
            <% if(count <= 2) { %>
                <div class="product-badge">🔥 HOT</div>
            <% } %>
            <img src="ProductImageServlet?id=<%= p.getId() %>" alt="<%= p.getName() %>" onerror="this.src='https://via.placeholder.com/300x260?text=No+Image'">
            <div class="product-info">
                <h3><%= p.getName() %></h3>
                <p><%= p.getDescription() != null && p.getDescription().length() > 60 ? p.getDescription().substring(0,60) + "..." : p.getDescription() %></p>
                <div class="price">
                    R<%= p.getPrice() %>
                    <span>R<%= Math.round(p.getPrice() * 1.2) %></span>
                </div>
                <% if (status.equals("loggedin")) { %>
                <form action="AddCartServlet.do" method="post">
                    <input type="hidden" name="id" value="<%= p.getId() %>">
                    <input type="hidden" name="qty" value="1">
                    <button class="add-cart" type="submit">
                        <i class="fas fa-shopping-cart"></i> Add to Cart
                    </button>
                </form>
                <% } else { %>
                <button class="add-cart" onclick="window.location.href='login.jsp'">
                    <i class="fas fa-lock"></i> Login to Buy
                </button>
                <% } %>
            </div>
        </div>
        <%
                }
            }
        %>
    </div>
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
            <p>We are committed to providing the best shopping experience with quality products and excellent customer service.</p>
        </div>
        
        <div class="footer-section">
            <h3><i class="fas fa-map-marker-alt"></i> Contact Info</h3>
            <p><i class="fas fa-map-marker-alt"></i> 123 Main Street, Johannesburg</p>
            <p><i class="fas fa-phone"></i> +27 12 345 6789</p>
            <p><i class="fas fa-envelope"></i> info@wepfolks.co.za</p>
        </div>
    </div>
    <div class="footer-bottom">
        <p>&copy; 2024 <a href="aboutDeveloper.jsp">WepFolks</a>. All rights reserved. | Designed with <i class="fas fa-heart" style="color:#ef4444;"></i> for South Africa</p>
    </div>
</div>

</body>
</html>