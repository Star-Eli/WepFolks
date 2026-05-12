<%-- 
    Document   : orderAdmin
    Created on : May 12, 2026, 3:33:16 PM
    Author     : Vutomi Nyarhi
--%>

<%@page import="entities.Order"%>
<%@page import="entities.User"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>WepFolks - Orders</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<style>

/* =========================
   BASE
========================= */
*{
  margin:0;
  padding:0;
  box-sizing:border-box;
  font-family:'Inter', sans-serif;
}

body{
  display:flex;
  background:#f1f5f9;
  color:#222;
}

/* =========================
   SIDEBAR
========================= */
.sidebar{
  width:260px;
  height:100vh;
  background:#0f172a;
  color:white;
  position:fixed;
  padding:20px;
  overflow-y:auto;
}

.logo{
  display:flex;
  align-items:center;
  gap:10px;
  margin-bottom:30px;
  text-decoration:none;
}

.logo-icon{
  width:42px;
  height:42px;
  background:linear-gradient(135deg,#3b82f6,#8b5cf6);
  border-radius:10px;
  display:flex;
  align-items:center;
  justify-content:center;
}

.logo-icon span{
  font-weight:800;
  color:white;
}

.logo-text{
  font-size:18px;
  font-weight:700;
  color:white;
}

.logo-text span{
  color:#94a3b8;
}

/* MENU */
.menu-section{
  margin-bottom:20px;
}

.menu-title{
  font-size:11px;
  color:#94a3b8;
  margin:10px 0;
}

.menu{
  list-style:none;
}

.menu li{
  margin:6px 0;
}

.menu a{
  display:flex;
  align-items:center;
  gap:10px;
  padding:10px;
  border-radius:10px;
  text-decoration:none;
  color:#cbd5e1;
  transition:0.3s;
}

.menu a:hover{
  background:rgba(59,130,246,0.15);
  color:white;
}

.menu a i{
  width:20px;
  color:#94a3b8;
}

.menu a.active{
  background:#3b82f6;
  color:white;
}

/* =========================
   MAIN
========================= */
.main{
  margin-left:260px;
  width:calc(100% - 260px);
  padding:20px;
}

/* TOPBAR */
.topbar{
  display:flex;
  justify-content:space-between;
  align-items:center;
  background:white;
  padding:20px;
  border-radius:15px;
  margin-bottom:20px;
}

.topbar h1{
  font-size:22px;
  font-weight:800;
  color:#1e293b;
}

.admin-badge{
  background:#f1f5f9;
  padding:8px 15px;
  border-radius:20px;
  font-size:12px;
  color:#64748b;
}

/* =========================
   CARDS
========================= */
.analytics{
  display:grid;
  grid-template-columns:repeat(auto-fit,minmax(200px,1fr));
  gap:15px;
  margin-bottom:20px;
}

.card{
  background:white;
  padding:20px;
  border-radius:15px;
  box-shadow:0 2px 8px rgba(0,0,0,0.05);
}

.card-icon{
  width:45px;
  height:45px;
  border-radius:10px;
  display:flex;
  align-items:center;
  justify-content:center;
  margin-bottom:10px;
}

.card h3{
  font-size:12px;
  color:#64748b;
}

.card p{
  font-size:24px;
  font-weight:800;
}

/* ICON COLORS */
.card:nth-child(1) .card-icon{background:#dbeafe;color:#3b82f6;}
.card:nth-child(2) .card-icon{background:#fef3c7;color:#d97706;}
.card:nth-child(3) .card-icon{background:#d1fae5;color:#059669;}
.card:nth-child(4) .card-icon{background:#ede9fe;color:#8b5cf6;}

/* =========================
   SECTION
========================= */
.section{
  background:white;
  padding:20px;
  border-radius:15px;
  box-shadow:0 2px 8px rgba(0,0,0,0.05);
}

.section-header{
  margin-bottom:15px;
  display:flex;
  justify-content:space-between;
}

.section-header h2{
  font-size:18px;
}

/* TABLE */
table{
  width:100%;
  border-collapse:collapse;
}

th, td{
  padding:12px;
  border-bottom:1px solid #e2e8f0;
  text-align:left;
}

th{
  background:#f8fafc;
  font-size:12px;
  color:#475569;
}

/* STATUS */
.status-badge{
  padding:5px 10px;
  border-radius:20px;
  font-size:11px;
  font-weight:600;
}

.status-pending{background:#fef3c7;color:#d97706;}
.status-completed{background:#d1fae5;color:#059669;}
.status-shipped{background:#dbeafe;color:#2563eb;}

/* BUTTONS */
.action-btn{
  padding:6px 10px;
  border-radius:8px;
  font-size:11px;
  text-decoration:none;
  color:white;
  margin-right:5px;
}

.edit{background:#3b82f6;}
.delete{background:#dc2626;}

.action-btn:hover{
  opacity:0.85;
}

/* MOBILE */
@media(max-width:768px){
  .sidebar{width:70px;}
  .logo-text,.menu span{display:none;}
  .main{margin-left:70px;width:calc(100% - 70px);}
}

</style>

</head>

<body>

<%
    User userLogged = (User) session.getAttribute("user");
    List<Order> orders = (List<Order>) session.getAttribute("orders");
%>

<!-- SIDEBAR -->
<div class="sidebar">

    <a href="admin.jsp" class="logo">
        <div class="logo-icon"><span>WF</span></div>
        <div class="logo-text">Wep<span>Folks</span></div>
    </a>

    <div class="menu-section">
        <p class="menu-title">MAIN</p>
        <ul class="menu">
            <li><a href="admin.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
            <li><a href="orders.jsp" class="active"><i class="fas fa-shopping-cart"></i> Orders</a></li>
        </ul>
    </div>

    <div class="menu-section">
        <p class="menu-title">ACCOUNT</p>
        <ul class="menu">
            <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </ul>
    </div>

</div>

<!-- MAIN -->
<div class="main">

    <div class="topbar">
        <h1><i class="fas fa-shopping-cart"></i> Orders</h1>
        <div class="admin-badge">
            <i class="fas fa-user-shield"></i>
            <%= userLogged != null ? userLogged.getEmail() : "Admin" %>
        </div>
    </div>

    <!-- CARDS -->
    <div class="analytics">
        <div class="card"><div class="card-icon"><i class="fas fa-list"></i></div><h3>Total Orders</h3><p><%= orders == null ? 0 : orders.size() %></p></div>
        <div class="card"><div class="card-icon"><i class="fas fa-clock"></i></div><h3>Pending</h3><p>0</p></div>
        <div class="card"><div class="card-icon"><i class="fas fa-check"></i></div><h3>Completed</h3><p>0</p></div>
        <div class="card"><div class="card-icon"><i class="fas fa-truck"></i></div><h3>Shipped</h3><p>0</p></div>
    </div>

    <!-- TABLE -->
    <div class="section">

        <div class="section-header">
            <h2>All Orders</h2>
        </div>

        <table>
            <tr>
                <th>ID</th>
                <th>Customer</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>

            <%
                if (orders != null) {
                    for (Order o : orders) {
            %>

            <tr>
                <td>#<%= o.getId() %></td>
                <td><%= o.getUser() != null ? o.getUser().getName() : "Unknown" %></td>
                <td>
                    <span class="status-badge status-<%= o.getStatus().toLowerCase() %>">
                        <%= o.getStatus() %>
                    </span>
                </td>
                <td>
                    <a href="#" class="action-btn edit"><i class="fas fa-eye"></i></a>
                    <a href="#" class="action-btn delete"><i class="fas fa-trash"></i></a>
                </td>
            </tr>

            <%
                    }
                }
            %>

        </table>

    </div>

</div>

</body>
</html>