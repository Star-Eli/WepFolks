<%@page import="entities.User"%>
<%@page import="java.util.Base64"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<title>WepFolks Profile</title>

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
    background:linear-gradient(135deg,#667eea,#764ba2);
    min-height:100vh;
}

.container{
    max-width:1100px;
    margin:auto;
    padding:30px 20px;
}

/* TOP */
.top-nav{
    display:flex;
    justify-content:space-between;
    align-items:center;
    background:#fff;
    padding:15px 20px;
    border-radius:15px;
    margin-bottom:20px;
}

.logo{
    display:flex;
    align-items:center;
    gap:10px;
    text-decoration:none;
}

.logo-icon{
    width:40px;
    height:40px;
    background:linear-gradient(135deg,#3b82f6,#8b5cf6);
    border-radius:10px;
    display:flex;
    align-items:center;
    justify-content:center;
    color:#fff;
    font-weight:800;
}

.logo-text{
    font-size:20px;
    font-weight:800;
    background:linear-gradient(135deg,#3b82f6,#8b5cf6);
    -webkit-background-clip:text;
    -webkit-text-fill-color:transparent;
}

.back-btn{
    background:#3b82f6;
    color:#fff;
    padding:10px 15px;
    border-radius:10px;
    text-decoration:none;
}

/* GRID */
.grid{
    display:grid;
    grid-template-columns:300px 1fr;
    gap:20px;
}

/* LEFT CARD */
.card{
    background:#fff;
    padding:20px;
    border-radius:20px;
    text-align:center;
}

.avatar{
    width:120px;
    height:120px;
    border-radius:50%;
    border:4px solid #3b82f6;
}

.role{
    display:inline-block;
    margin-top:10px;
    padding:5px 10px;
    border-radius:20px;
    font-size:12px;
    background:#e0f2fe;
    color:#0369a1;
}

/* ADMIN PANEL */
.admin-panel{
    margin-top:15px;
    padding:15px;
    background:#f8fafc;
    border-radius:12px;
}

.admin-panel a{
    display:block;
    margin-top:8px;
    padding:10px;
    background:#10b981;
    color:#fff;
    text-decoration:none;
    border-radius:8px;
}

/* RIGHT */
.panel{
    background:#fff;
    padding:25px;
    border-radius:20px;
}

.section{
    margin-bottom:20px;
}

.section h3{
    margin-bottom:10px;
}

input{
    width:100%;
    padding:10px;
    margin-bottom:10px;
    border:1px solid #ddd;
    border-radius:10px;
}

.btn{
    background:#3b82f6;
    color:#fff;
    padding:10px 15px;
    border:none;
    border-radius:10px;
    cursor:pointer;
}

/* ADMIN BADGE */
.admin-badge{
    background:#dcfce7;
    color:#166534;
    padding:8px 12px;
    border-radius:20px;
    font-size:12px;
}
.section input[type="password"]{
    width:100%;
    padding:12px;
    margin-bottom:10px;
    border:1px solid #e2e8f0;
    border-radius:10px;
    outline:none;
    transition:0.2s;
}

.section input[type="password"]:focus{
    border-color:#3b82f6;
    box-shadow:0 0 0 3px rgba(59,130,246,0.1);
}

</style>

</head>

<body>
    <script>
function validatePassword(){

    let newPass = document.getElementById("newPassword").value;
    let confirmPass = document.getElementById("confirmPassword").value;

    if(newPass.length < 4){
        alert("Password must be at least 4 characters");
        return false;
    }

    if(newPass !== confirmPass){
        alert("Passwords do not match");
        return false;
    }

    return true;
}
</script>

<%
    User user = (User) session.getAttribute("user");
    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }

    String role = user.getRole();
%>

<div class="container">

    <!-- TOP -->
    <div class="top-nav">

        <a href="<%= "ADMIN".equals(role) ? "admin.jsp" : "DisplayProductsServlet" %>" class="logo">
            <div class="logo-icon">WF</div>
            <div class="logo-text">WepFolks</div>
        </a>

        <a class="back-btn" href="<%= "ADMIN".equals(role) ? "admin.jsp" : "DisplayProductsServlet" %>">
            <i class="fas fa-arrow-left"></i> Back
        </a>

    </div>

    <!-- GRID -->
    <div class="grid">

        <!-- LEFT -->
        <div class="card">

            <img class="avatar"
                 src="https://ui-avatars.com/api/?name=<%= user.getName() %>">

            <h2><%= user.getName() %></h2>
            <p><%= user.getEmail() %></p>

            <span class="role"><%= role %></span>

            <!-- ADMIN PANEL -->
            <% if("ADMIN".equals(role)) { %>
            <div class="admin-panel">
                <h4>Admin Tools</h4>
                <a href="admin.jsp"><i class="fas fa-dashboard"></i> Dashboard</a>
                <a href="adminActions.jsp"><i class="fas fa-box"></i> Manage System</a>
            </div>
            <% } %>

        </div>

        <!-- RIGHT -->
        <div class="panel">

            <div class="section">
                <h3>Profile Settings</h3>

                <form action="SavePersonalInfoServlet" method="post">

                    <input type="text" name="name" value="<%= user.getName() %>">

                    <input type="email" value="<%= user.getEmail() %>" disabled>

                    <button class="btn">Save</button>

                </form>
            </div>

            <!-- ONLY FOR USERS (NOT ADMIN) -->
            <% if(!"ADMIN".equals(role)) { %>

            <div class="section">
                <h3>Address</h3>

                <form action="SaveAddressServlet.do" method="post">

                    <input type="text" name="province" placeholder="Province">
                    <input type="text" name="city" placeholder="City">
                    <input type="text" name="address" placeholder="Address">

                    <button class="btn">Save Address</button>

                </form>
            </div>
            
            <div class="section">

    <h3><i class="fas fa-lock"></i> Change Password</h3>

    <form action="SavePasswordServlet" method="post" onsubmit="return validatePassword()">

        <input type="password" name="currentPassword" placeholder="Current Password" required>

        <input type="password" name="newPassword" id="newPassword" placeholder="New Password" required>

        <input type="password" name="confirmPassword" id="confirmPassword" placeholder="Confirm Password" required>

        <button class="btn" type="submit">
            <i class="fas fa-key"></i> Update Password
        </button>

    </form>

</div>

            <div class="section">
                <h3>Account Actions</h3>

                <a class="btn" href="OrderHistoryServlet">Orders</a>
                <a class="btn" href="LogoutServlet.do" style="background:#ef4444;">Logout</a>

            </div>

            <% } else { %>

            <!-- ADMIN ACTIONS -->
            <div class="section">
                <h3>Admin Actions</h3>

                <a class="btn" href="admin.jsp">Go to Dashboard</a>
                <a class="btn" href="LogoutServlet.do" style="background:#ef4444;">Logout</a>

            </div>

            <% } %>

        </div>

    </div>

</div>

</body>
</html>