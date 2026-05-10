<%-- 
    Document   : cardPayment
    Created on : May 9, 2026, 4:55:45 AM
    Author     : Vutomi Nyarhi
--%>

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
<title>Payment</title>

<style>
body{
    font-family:Arial;
    background:#f1f5f9;
    margin:0;
}

/* NAVBAR */
.navbar{
    display:flex;
    justify-content:space-between;
    padding:15px 8%;
    background:white;
    box-shadow:0 2px 10px rgba(0,0,0,0.1);
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

/* FORM */
.container{
    width:400px;
    margin:60px auto;
    background:white;
    padding:25px;
    border-radius:10px;
    box-shadow:0 2px 10px rgba(0,0,0,0.1);
}

input{
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

<!-- NAVBAR -->
<div class="navbar">
    <div class="logo">E-Commerce</div>

    <div>
        <a href="DisplayProductsServlet">Home</a>
        <a href="cart.jsp">Cart</a>
        <a href="LogoutServlet">Logout</a>
    </div>
</div>

<!-- CARD PAYMENT FORM -->
<div class="container">

    <h2>Card Payment (Demo)</h2>

    <form action="orderSuccess.jsp" method="post">

        <input type="text" name="cardName" placeholder="Card Holder Name" >

        <input type="text" name="cardNumber" placeholder="Card Number (1111 2222 3333 4444)" >

        <input type="text" name="expiry" placeholder="Expiry Date (MM/YY)" >

        <input type="password" name="cvv" placeholder="CVV" >

        <button type="submit">Pay Now</button>

    </form>

</div>

</body>
</html>