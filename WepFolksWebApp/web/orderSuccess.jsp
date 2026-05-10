<%@page import="entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Successful</title>

    <style>
        body{
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container{
            width: 60%;
            margin: 80px auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            text-align: center;
        }

        h1{
            color: green;
        }

        p{
            font-size: 18px;
        }

        .links{
            margin-top: 30px;
        }

        .links a{
            text-decoration: none;
            padding: 10px 20px;
            margin: 10px;
            background-color: #007bff;
            color: white;
            border-radius: 5px;
            display: inline-block;
        }

        .links a:hover{
            background-color: #0056b3;
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

<div class="container">

    <h1>Order Successful</h1>

    <p>
        Thank you, <b><%= user.getName() %></b>
    </p>

    <p>
        <%= message %>
    </p>

    <div class="links">

        <a href="DisplayProductsServlet">
            Continue Shopping
        </a>

        <a href="cart.jsp">
            View Cart
        </a>

        <a href="OrderHistoryServlet">
            View Orders
        </a>

    </div>

</div>

<%
    // clear flash message after display
    session.removeAttribute("message");
%>

</body>
</html>