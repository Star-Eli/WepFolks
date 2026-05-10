<%@page import="entities.Order"%>
<%@page import="entities.Product"%>
<%@page import="java.util.List"%>
<%@page import="entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8"/>
<meta name="viewport"
      content="width=device-width, initial-scale=1.0"/>

<title>WepFolks - Admin Dashboard</title>

<!-- Font Awesome Icons -->
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
  display:flex;
  background:#f1f5f9;
  color:#222;
}

/* SIDEBAR */
.sidebar{
  width:250px;
  height:100vh;
  background:#0f172a;
  color:white;
  position:fixed;
  padding:20px;
  overflow-y:auto;
}

/* WF LOGO IN SIDEBAR */
.logo{
  display:flex;
  align-items:center;
  justify-content:center;
  gap:10px;
  margin-bottom:40px;
  padding:10px;
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
}

.logo-icon span{
  font-size:20px;
  font-weight:800;
  color:white;
}

.logo-text{
  font-size:20px;
  font-weight:700;
  background:linear-gradient(135deg, #fff, #e0e7ff);
  -webkit-background-clip:text;
  -webkit-text-fill-color:transparent;
  background-clip:text;
}

.logo-text span{
  font-weight:300;
  -webkit-text-fill-color:#94a3b8;
}

.menu{
  list-style:none;
}

.menu li{
  padding:12px 15px;
  margin:5px 0;
  border-radius:10px;
  cursor:pointer;
  transition:0.3s;
}

.menu li:hover{
  background:rgba(59,130,246,0.2);
}

.menu li i{
  margin-right:12px;
  width:20px;
  color:#94a3b8;
}

.menu a{
  color:white;
  text-decoration:none;
  display:block;
}

/* MAIN */
.main{
  margin-left:250px;
  width:calc(100% - 250px);
  padding:20px;
  background:#f1f5f9;
  min-height:100vh;
}

.topbar{
  display:flex;
  justify-content:space-between;
  align-items:center;
  margin-bottom:25px;
  background:white;
  padding:20px;
  border-radius:15px;
  box-shadow:0 2px 8px rgba(0,0,0,0.05);
}

.topbar h1{
  font-size:24px;
  font-weight:700;
  background:linear-gradient(135deg, #3b82f6, #8b5cf6);
  -webkit-background-clip:text;
  -webkit-text-fill-color:transparent;
  background-clip:text;
}

.topbar h1 i{
  -webkit-text-fill-color:#3b82f6;
  margin-right:12px;
}

.admin-badge{
  background:#f1f5f9;
  padding:8px 16px;
  border-radius:20px;
  font-size:12px;
  font-weight:600;
  color:#64748b;
}

.admin-badge i{
  margin-right:8px;
  color:#3b82f6;
}

/* ANALYTICS */
.analytics{
  display:grid;
  grid-template-columns:repeat(auto-fit,minmax(240px,1fr));
  gap:20px;
  margin-bottom:30px;
}

.card{
  background:white;
  padding:25px;
  border-radius:16px;
  box-shadow:0 2px 8px rgba(0,0,0,0.05);
  transition:0.3s;
  position:relative;
  overflow:hidden;
}

.card::before{
  content:'';
  position:absolute;
  top:0;
  left:0;
  width:100%;
  height:3px;
  background:linear-gradient(90deg, #3b82f6, #8b5cf6);
}

.card:hover{
  transform:translateY(-3px);
  box-shadow:0 8px 25px rgba(0,0,0,0.1);
}

.card-icon{
  width:50px;
  height:50px;
  border-radius:12px;
  display:flex;
  align-items:center;
  justify-content:center;
  margin-bottom:15px;
}

.card-icon i{
  font-size:24px;
}

.card h3{
  color:#64748b;
  margin-bottom:8px;
  font-size:13px;
  font-weight:600;
  letter-spacing:0.5px;
}

.card p{
  font-size:28px;
  font-weight:800;
  color:#1e293b;
}

/* Card Icon Colors */
.card:nth-child(1) .card-icon{ background:rgba(59,130,246,0.1); }
.card:nth-child(1) .card-icon i{ color:#3b82f6; }

.card:nth-child(2) .card-icon{ background:rgba(16,185,129,0.1); }
.card:nth-child(2) .card-icon i{ color:#10b981; }

.card:nth-child(3) .card-icon{ background:rgba(139,92,246,0.1); }
.card:nth-child(3) .card-icon i{ color:#8b5cf6; }

.card:nth-child(4) .card-icon{ background:rgba(245,158,11,0.1); }
.card:nth-child(4) .card-icon i{ color:#f59e0b; }

/* SECTION */
.section{
  background:white;
  padding:25px;
  border-radius:16px;
  margin-bottom:25px;
  box-shadow:0 2px 8px rgba(0,0,0,0.05);
}

.section-header{
  display:flex;
  justify-content:space-between;
  align-items:center;
  margin-bottom:20px;
  padding-bottom:15px;
  border-bottom:2px solid #e2e8f0;
}

.section-header h2{
  font-size:18px;
  font-weight:700;
  color:#1e293b;
}

.section-header h2 i{
  margin-right:10px;
  color:#3b82f6;
}

.section-header button{
  background:linear-gradient(135deg, #3b82f6, #2563eb);
  color:white;
  border:none;
  padding:8px 16px;
  border-radius:10px;
  cursor:pointer;
  font-weight:600;
  font-size:13px;
  transition:0.3s;
}

.section-header button i{
  margin-right:8px;
}

.section-header button:hover{
  transform:translateY(-2px);
  box-shadow:0 5px 15px rgba(59,130,246,0.3);
}

/* TABLE */
table{
  width:100%;
  border-collapse:collapse;
}

table th,
table td{
  padding:12px 15px;
  border-bottom:1px solid #e2e8f0;
  text-align:left;
}

table th{
  background:#f8fafc;
  font-weight:600;
  color:#475569;
  font-size:13px;
}

table th i{
  margin-right:8px;
  color:#3b82f6;
}

table tr{
  transition:0.3s;
}

table tr:hover{
  background:#f8fafc;
}

/* BADGES */
.role-badge{
  display:inline-block;
  padding:4px 12px;
  border-radius:20px;
  font-size:11px;
  font-weight:700;
}

.role-admin{
  background:#fef3c7;
  color:#d97706;
}

.role-customer{
  background:#dbeafe;
  color:#2563eb;
}

.status-badge{
  display:inline-block;
  padding:4px 12px;
  border-radius:20px;
  font-size:11px;
  font-weight:700;
}

.status-pending{
  background:#fef3c7;
  color:#d97706;
}

.status-completed{
  background:#d1fae5;
  color:#059669;
}

.status-shipped{
  background:#dbeafe;
  color:#2563eb;
}

/* ACTION BUTTONS */
.action-btn{
  border:none;
  padding:6px 12px;
  border-radius:8px;
  color:white;
  cursor:pointer;
  text-decoration:none;
  display:inline-block;
  font-size:11px;
  font-weight:600;
  margin:0 3px;
  transition:0.3s;
}

.action-btn i{
  margin-right:5px;
}

.edit{
  background:#0ea5e9;
}

.edit:hover{
  background:#0284c7;
  transform:translateY(-1px);
}

.delete{
  background:#dc2626;
}

.delete:hover{
  background:#b91c1c;
  transform:translateY(-1px);
}

/* MOBILE */
@media(max-width:768px){
  .sidebar{
    width:70px;
    padding:15px;
  }
  .logo-text, .menu li span{
    display:none;
  }
  .logo-icon{
    margin:0 auto;
  }
  .menu li i{
    margin-right:0;
  }
  .main{
    margin-left:70px;
    width:calc(100% - 70px);
    padding:15px;
  }
  .topbar{
    flex-direction:column;
    gap:15px;
    text-align:center;
  }
  table th, table td{
    padding:8px 10px;
    font-size:12px;
  }
  .action-btn{
    padding:4px 8px;
    font-size:10px;
  }
}

/* ALERT MESSAGES */
.success-message{
  background:#d1fae5;
  color:#065f46;
  padding:12px 18px;
  border-radius:12px;
  margin-bottom:20px;
  border-left:4px solid #10b981;
  display:flex;
  align-items:center;
  gap:12px;
  animation:slideIn 0.3s ease;
}

.error-message{
  background:#fee2e2;
  color:#991b1b;
  padding:12px 18px;
  border-radius:12px;
  margin-bottom:20px;
  border-left:4px solid #ef4444;
  display:flex;
  align-items:center;
  gap:12px;
  animation:slideIn 0.3s ease;
}

.success-message i, .error-message i{
  font-size:18px;
}

@keyframes slideIn{
  from{
    opacity:0;
    transform:translateY(-15px);
  }
  to{
    opacity:1;
    transform:translateY(0);
  }
}

/* SCROLLBAR */
.sidebar::-webkit-scrollbar{
  width:5px;
}
.sidebar::-webkit-scrollbar-track{
  background:#1e293b;
}
.sidebar::-webkit-scrollbar-thumb{
  background:#3b82f6;
  border-radius:5px;
}
</style>

</head>

<body>

<%
    User userLogged = (User) session.getAttribute("user");
    List<Product> products = (List<Product>) session.getAttribute("products");
    List<User> users = (List<User>) session.getAttribute("users");
    List<Order> orders = (List<Order>) session.getAttribute("orders");
    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>

<!-- SIDEBAR -->
<div class="sidebar">
    <a href="admin.jsp" class="logo">
        <div class="logo-icon">
            <span>WF</span>
        </div>
        <div class="logo-text">Wep<span>Folks</span></div>
    </a>
    <ul class="menu">
        <li><i class="fas fa-tachometer-alt"></i> <span>Dashboard</span></li>
        <li>
            <a href="adminActions.jsp">
                <i class="fas fa-box"></i> <span>Products/Users</span>
            </a>
        </li>
        <li>
            <a href="LogoutServlet">
                <i class="fas fa-sign-out-alt"></i> <span>Logout</span>
            </a>
        </li>
    </ul>
</div>

<!-- MAIN -->
<div class="main">

    <div class="topbar">
        <h1><i class="fas fa-chalkboard-user"></i> Admin Dashboard</h1>
        <div class="admin-badge">
            <i class="fas fa-user-shield"></i> <%= userLogged != null ? userLogged.getEmail() : "Admin" %>
        </div>
    </div>
    
    <% if(success != null) { %>
        <div class="success-message">
            <i class="fas fa-check-circle"></i> <%= success %>
        </div>
    <% } %>
    
    <% if(error != null) { %>
        <div class="error-message">
            <i class="fas fa-exclamation-triangle"></i> <%= error %>
        </div>
    <% } %>

    <!-- ANALYTICS -->
    <div class="analytics">
        <div class="card">
            <div class="card-icon">
                <i class="fas fa-dollar-sign"></i>
            </div>
            <h3>TOTAL REVENUE</h3>
            <p>R0.00</p>
        </div>
        <div class="card">
            <div class="card-icon">
                <i class="fas fa-shopping-bag"></i>
            </div>
            <h3>TOTAL ORDERS</h3>
            <p><%= orders == null ? 0 : orders.size() %></p>
        </div>
        <div class="card">
            <div class="card-icon">
                <i class="fas fa-users"></i>
            </div>
            <h3>TOTAL USERS</h3>
            <p><%= users == null ? 0 : users.size() %></p>
        </div>
        <div class="card">
            <div class="card-icon">
                <i class="fas fa-boxes"></i>
            </div>
            <h3>TOTAL PRODUCTS</h3>
            <p><%= products == null ? 0 : products.size() %></p>
        </div>
    </div>

    <!-- USERS SECTION -->
    <div class="section">
        <div class="section-header">
            <h2><i class="fas fa-users"></i> System Users</h2>
        </div>
        <table>
            <thead>
                <tr>
                    <th><i class="fas fa-user"></i> Name</th>
                    <th><i class="fas fa-envelope"></i> Email</th>
                    <th><i class="fas fa-tag"></i> Role</th>
                    <th><i class="fas fa-cog"></i> Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if(users != null && !users.isEmpty()){
                        for(User u : users){
                            boolean isCurrentUser = (userLogged != null && userLogged.getId().equals(u.getId()));
                %>
                    <tr>
                        <td><i class="fas fa-user-circle" style="margin-right:8px; color:#64748b;"></i><%= u.getName() %></td>
                        <td><i class="fas fa-envelope" style="margin-right:8px; color:#64748b;"></i><%= u.getEmail() %></td>
                        <td>
                            <% if("ADMIN".equals(u.getRole())) { %>
                                <span class="role-badge role-admin"><i class="fas fa-shield-alt"></i> ADMIN</span>
                            <% } else { %>
                                <span class="role-badge role-customer"><i class="fas fa-user"></i> CUSTOMER</span>
                            <% } %>
                        </td>
                        <td style="width: 100px;">
                            <% if(!isCurrentUser) { %>
                                <a href="AddUserServlet?action=delete&id=<%= u.getId() %>" 
                                   class="action-btn delete" 
                                   onclick="return confirm('Are you sure you want to delete user: <%= u.getName() %>?')">
                                    <i class="fas fa-trash-alt"></i> Delete
                                </a>
                            <% } else { %>
                                <span style="color:#94a3b8; font-size:11px;"><i class="fas fa-user-check"></i> You</span>
                            <% } %>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="4" style="text-align:center;"><i class="fas fa-info-circle"></i> No users found</td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

    <!-- PRODUCTS SECTION -->
    <div class="section">
        <div class="section-header">
            <h2><i class="fas fa-box"></i> Product Inventory</h2>
            <button onclick="window.location.href='AddProductServlet.do'">
                <i class="fas fa-plus"></i> Add Product
            </button>
        </div>
        <table>
            <thead>
                <tr>
                    <th><i class="fas fa-tag"></i> Product Name</th>
                    <th><i class="fas fa-folder"></i> Category</th>
                    <th><i class="fas fa-rand"></i> Price</th>
                    <th><i class="fas fa-cog"></i> Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if(products != null && !products.isEmpty()){
                        for(Product p : products){
                %>
                    <tr>
                        <td><i class="fas fa-cube" style="margin-right:8px; color:#64748b;"></i><%= p.getName() %></td>
                        <td><i class="fas fa-folder-open" style="margin-right:8px; color:#64748b;"></i><%= p.getCategory() != null ? p.getCategory().getName() : "No Category" %></td>
                        <td><i class="fas fa-rand" style="margin-right:5px; color:#10b981;"></i>R<%= p.getPrice() %></td>
                        <td>
                            <a href="ManageProductServlet.do?action=edit&id=<%= p.getId() %>" class="action-btn edit">
                                <i class="fas fa-edit"></i> Edit
                            </a>
                            <a href="ManageProductServlet.do?action=delete&id=<%= p.getId() %>" class="action-btn delete" onclick="return confirm('Delete this product?')">
                                <i class="fas fa-trash-alt"></i> Delete
                            </a>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="4" style="text-align:center;"><i class="fas fa-info-circle"></i> No products found</td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

    <!-- ORDERS SECTION -->
    <div class="section">
        <div class="section-header">
            <h2><i class="fas fa-truck"></i> Recent Orders</h2>
        </div>
        <table>
            <thead>
                <tr>
                    <th><i class="fas fa-hashtag"></i> Order ID</th>
                    <th><i class="fas fa-user"></i> Customer</th>
                    <th><i class="fas fa-info-circle"></i> Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if(orders != null && !orders.isEmpty()){
                        for(Order o : orders){
                %>
                    <tr>
                        <td><i class="fas fa-receipt" style="margin-right:8px; color:#64748b;"></i>#<%= o.getId() %></td>
                        <td><i class="fas fa-user-circle" style="margin-right:8px; color:#64748b;"></i><%= o.getUser() != null ? o.getUser().getName() : "Unknown" %></td>
                        <td>
                            <% if("PENDING".equals(o.getStatus())) { %>
                                <span class="status-badge status-pending"><i class="fas fa-clock"></i> PENDING</span>
                            <% } else if("COMPLETED".equals(o.getStatus())) { %>
                                <span class="status-badge status-completed"><i class="fas fa-check-circle"></i> COMPLETED</span>
                            <% } else { %>
                                <span class="status-badge status-shipped"><i class="fas fa-truck"></i> SHIPPED</span>
                            <% } %>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="3" style="text-align:center;"><i class="fas fa-info-circle"></i> No orders found</td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>