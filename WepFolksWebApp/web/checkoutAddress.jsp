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
<html>
<head>
<meta charset="UTF-8">
<title>Delivery Address</title>

<style>
body {
    font-family: Arial;
    margin: 0;
    background: #f1f5f9;
}

.navbar{
    display:flex;
    justify-content:space-between;
    padding:15px 8%;
    background:white;
    box-shadow:0 2px 8px rgba(0,0,0,0.1);
}

.logo{
    font-size:22px;
    font-weight:bold;
    color:#2563eb;
}

.navbar a{
    margin-left:15px;
    text-decoration:none;
    color:#333;
}

.container{
    width:40%;
    margin:60px auto;
    background:white;
    padding:25px;
    border-radius:10px;
    box-shadow:0 2px 10px rgba(0,0,0,0.1);
}

input, textarea{
    width:100%;
    padding:12px;
    margin:10px 0;
    border:1px solid #ccc;
    border-radius:8px;
}

button{
    width:100%;
    padding:12px;
    background:#2563eb;
    color:white;
    border:none;
    border-radius:8px;
    cursor:pointer;
}
</style>

</head>

<body>

<div class="navbar">
    <div class="logo">E-Commerce</div>

    <div>
        <a href="DisplayProductsServlet">Home</a>
        <a href="cart.jsp">Cart</a>
        <a href="LogoutServlet">Logout</a>
    </div>
</div>

<div class="container">

    <h2>Delivery Address</h2>

    <!-- ✅ MUST MATCH servlet -->
    <form action="CheckOutSaveAddressServlet" method="post">


        <input type="text" name="province" placeholder="Province" required>

        <input type="text" name="city" placeholder="City" required>

        <input type="text" name="address" placeholder="Street Address" required>

        <button type="submit">Continue to Payment</button>

    </form>

</div>

</body>
</html>