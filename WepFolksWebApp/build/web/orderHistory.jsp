<%@page import="java.util.List"%>
<%@page import="entities.Order"%>
<%@page import="entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>WepFolks - Order History</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800&display=swap" rel="stylesheet">

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
}

.logo{
    display:flex;
    align-items:center;
    gap:10px;
    text-decoration:none;
}

.logo-icon{
    width:40px;height:40px;
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

.nav-links a{
    text-decoration:none;
    margin-left:20px;
    color:#475569;
    font-weight:600;
}

/* CONTAINER */
.container{
    width:90%;
    max-width:1000px;
    margin:50px auto;
    background:white;
    padding:30px;
    border-radius:20px;
    box-shadow:0 15px 40px rgba(0,0,0,0.15);
}

/* HEADER */
h1{
    text-align:center;
    margin-bottom:25px;
    font-size:32px;
    font-weight:800;
    background:linear-gradient(135deg,#3b82f6,#8b5cf6);
    -webkit-background-clip:text;
    -webkit-text-fill-color:transparent;
}

/* BACK BUTTON */
.back{
    display:inline-block;
    margin-bottom:15px;
    text-decoration:none;
    color:#3b82f6;
    font-weight:700;
}

/* TABLE */
table{
    width:100%;
    border-collapse:collapse;
}

th, td{
    padding:14px;
    border-bottom:1px solid #e5e7eb;
    text-align:left;
}

th{
    background:#f8fafc;
}

/* STATUS BADGES */
.status{
    padding:6px 12px;
    border-radius:20px;
    font-size:12px;
    font-weight:700;
    color:white;
}

.NEW{ background:#f59e0b; }
.PAID{ background:#10b981; }
.SHIPPED{ background:#3b82f6; }
.CANCELLED{ background:#ef4444; }

.empty{
    text-align:center;
    padding:40px;
    color:#64748b;
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

    List<Order> orders =
        (List<Order>) request.getAttribute("orders");
%>

<!-- NAVBAR -->
<nav class="navbar">

    <a href="DisplayProductsServlet" class="logo">
        <div class="logo-icon">WF</div>
        <div class="logo-text">WepFolks</div>
    </a>

    <div class="nav-links">
        <a href="DisplayProductsServlet"><i class="fas fa-home"></i> Home</a>
        <a href="cart.jsp"><i class="fas fa-shopping-cart"></i> Cart</a>
        <a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>

</nav>

<!-- MAIN -->
<div class="container">

    <a href="DisplayProductsServlet" class="back">
        ← Back to Shop
    </a>

    <h1><i class="fas fa-receipt"></i> Your Orders</h1>

    <%
        if (orders == null || orders.isEmpty()) {
    %>

        <div class="empty">
            <i class="fas fa-box-open" style="font-size:50px;"></i>
            <p>No orders found yet.</p>
        </div>

    <%
        } else {
    %>

    <table>

        <thead>
            <tr>
                <th>Order ID</th>
                <th>Date</th>
                <th>Status</th>
                <th>Total (R)</th>
                <th>Items</th>
            </tr>
        </thead>

        <tbody>

        <%
            for (Order o : orders) {
        %>

            <tr>

                <td><%= o.getId() %></td>

                <td><%= o.getOrderDate() %></td>

                <td>
                    <span class="status <%= o.getStatus() %>">
                        <%= o.getStatus() %>
                    </span>
                </td>

                <td>R<%= o.getTotal() %></td>

                <td><%= (o.getItems() != null) ? o.getItems().size() : 0 %></td>

            </tr>

        <%
            }
        %>

        </tbody>

    </table>

    <%
        }
    %>

</div>

</body>
</html>