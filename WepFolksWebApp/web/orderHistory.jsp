<%-- 
    Document   : orderHistory
    Created on : May 9, 2026, 4:22:23 AM
    Author     : Vutomi Nyarhi
--%>

<%@page import="java.util.List"%>
<%@page import="entities.Order"%>
<%@page import="entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Order History</title>

<style>

body{
    font-family: Arial, sans-serif;
    background:#f1f5f9;
    margin:0;
    padding:0;
}

.container{
    width:90%;
    max-width:1000px;
    margin:40px auto;
    background:white;
    padding:25px;
    border-radius:12px;
    box-shadow:0 2px 10px rgba(0,0,0,0.1);
}

h1{
    text-align:center;
    margin-bottom:20px;
    color:#0f172a;
}

.back{
    display:inline-block;
    margin-bottom:15px;
    text-decoration:none;
    color:#2563eb;
    font-weight:bold;
}

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

.status{
    padding:5px 10px;
    border-radius:6px;
    color:white;
    font-size:12px;
    font-weight:bold;
}

.NEW{ background:orange; }
.PAID{ background:green; }
.SHIPPED{ background:blue; }
.CANCELLED{ background:red; }

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

<div class="container">

    <a href="DisplayProductsServlet" class="back">
        ← Back to Shop
    </a>

    <h1>Your Order History</h1>

    <%
        if (orders == null || orders.isEmpty()) {
    %>

        <p style="text-align:center;">No orders found.</p>

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

                <td>
                    <%= o.getOrderDate() %>
                </td>

                <td>
                    <span class="status <%= o.getStatus() %>">
                        <%= o.getStatus() %>
                    </span>
                </td>

                <td>
                    R<%= o.getTotal() %>
                </td>

                <td>
                    <%= (o.getItems() != null)
                        ? o.getItems().size()
                        : 0 %>
                </td>

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
