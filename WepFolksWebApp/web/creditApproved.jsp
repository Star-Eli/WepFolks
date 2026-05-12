<%-- 
    Document   : creditApproved
    Created on : 10 May 2026, 2:08:04 PM
    Author     : Elias
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="entities.User"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Credit Approved - WepFolks</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
    display:flex;
    justify-content:center;
    align-items:center;
}
.container{
    max-width:500px;
    margin:20px;
}
.success-card{
    background:white;
    border-radius:24px;
    padding:40px;
    text-align:center;
    box-shadow:0 20px 35px rgba(0,0,0,0.1);
}
.check-icon{
    width:80px;
    height:80px;
    background:#10b981;
    border-radius:50%;
    display:flex;
    align-items:center;
    justify-content:center;
    margin:0 auto 20px;
}
.check-icon i{
    font-size:40px;
    color:white;
}
.credit-amount{
    font-size:48px;
    font-weight:800;
    color:#3b82f6;
    margin:20px 0;
}
.btn{
    display:inline-block;
    background:linear-gradient(135deg, #3b82f6, #2563eb);
    color:white;
    text-decoration:none;
    padding:12px 30px;
    border-radius:12px;
    font-weight:600;
    margin:10px;
}
.btn-outline{
    background:transparent;
    border:2px solid #3b82f6;
    color:#3b82f6;
}
</style>
</head>
<body>

<%
    User user = (User) session.getAttribute("user");
    boolean approved = request.getParameter("approved") != null;
    double limit = 0;
    if(request.getParameter("limit") != null){
        limit = Double.parseDouble(request.getParameter("limit"));
    }
%>

<div class="container">
    <div class="success-card">
        <div class="check-icon">
            <i class="fas fa-check"></i>
        </div>
        
        <h2>Congratulations!</h2>
        <p>Your credit application has been approved</p>
        
        <div class="credit-amount">
            R<%= String.format("%.0f", limit) %>
        </div>
        <p>Credit Limit</p>
        
        <div style="margin:20px 0; text-align:left; background:#f8fafc; padding:15px; border-radius:12px;">
            <p><i class="fas fa-check-circle" style="color:#10b981;"></i> <strong>Available Credit:</strong> R<%= String.format("%.2f", user.getCreditAvailable()) %></p>
            <p><i class="fas fa-calendar"></i> <strong>Repayment Terms:</strong> Up to 3 months</p>
            <p><i class="fas fa-percent"></i> <strong>Interest:</strong> 0% if paid within 30 days</p>
        </div>
        
        <a href="DisplayProductsServlet" class="btn">
            <i class="fas fa-shopping-bag"></i> Start Shopping
        </a>
        <a href="profile.jsp" class="btn btn-outline">
            <i class="fas fa-user"></i> View Profile
        </a>
    </div>
</div>

</body>
</html>
