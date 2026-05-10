<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<title>Add User</title>

<style>

body{
    font-family:Arial;
    background:#f1f5f9;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
    margin:0;
    padding:20px;
}

.form-box{
    background:white;
    padding:30px;
    border-radius:15px;
    width:450px;
    box-shadow:0 4px 12px rgba(0,0,0,0.1);
}

h2{
    margin-bottom:20px;
    text-align:center;
    color:#1e293b;
}

input, select{
    width:100%;
    padding:12px;
    margin-bottom:12px;
    border:1px solid #ccc;
    border-radius:8px;
    box-sizing:border-box;
}

button{
    width:100%;
    padding:12px;
    border:none;
    background:#2563eb;
    color:white;
    border-radius:8px;
    cursor:pointer;
    font-weight:bold;
    margin-top:10px;
}

button:hover{
    background:#1d4ed8;
}

.cancel-btn{
    background:#64748b;
    margin-top:5px;
}

.cancel-btn:hover{
    background:#475569;
}

.error-message{
    background:#fee2e2;
    color:#dc2626;
    padding:10px;
    border-radius:8px;
    margin-bottom:15px;
    text-align:center;
}

label{
    display:block;
    margin-bottom:5px;
    color:#64748b;
    font-size:14px;
}

</style>

</head>

<body>

<div class="form-box">

    <h2>Add User</h2>
    
    <%
        String error = request.getParameter("error");
        if (error != null && !error.isEmpty()) {
    %>
        <div class="error-message">
            <%= error %>
        </div>
    <%
        }
    %>

    <form action="AddUserServlet" method="post" enctype="multipart/form-data">

        <!-- BASIC INFO -->
        <input type="text"
               name="name"
               placeholder="Full Name"
               required>

        <input type="email"
               name="email"
               placeholder="Email"
               required>

        <input type="password"
               name="password"
               placeholder="Password"
               required>

        <select name="role">
            <option value="CUSTOMER">CUSTOMER</option>
            <option value="ADMIN">ADMIN</option>
        </select>

        <!-- ADDRESS INFO -->
        <input type="text"
               name="address"
               placeholder="Street Address">

        <input type="text"
               name="city"
               placeholder="City">

        <input type="text"
               name="province"
               placeholder="Province">

        <!-- IMAGE -->
        <label>Profile Image (Optional)</label>
        <input type="file"
               name="image"
               accept="image/*">

        <!-- SUBMIT -->
        <button type="submit">
            Save User
        </button>
        
        <button type="button" class="cancel-btn" onclick="window.location.href='admin.jsp'">
            Cancel
        </button>

    </form>

</div>

</body>

</html>