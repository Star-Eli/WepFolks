<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Admin Actions</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial, Helvetica, sans-serif;
}

body{
    background:#f1f5f9;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

.container{
    width:90%;
    max-width:900px;
}

.title{
    text-align:center;
    margin-bottom:40px;
}

.title h1{
    font-size:40px;
    color:#0f172a;
}

.cards{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(300px,1fr));
    gap:30px;
}

.card{
    background:white;
    padding:40px;
    border-radius:18px;
    box-shadow:0 4px 12px rgba(0,0,0,0.08);
    text-align:center;
    transition:0.3s;
}

.card:hover{
    transform:translateY(-5px);
}

.card h2{
    margin-bottom:15px;
    color:#0f172a;
}

.card p{
    color:#64748b;
    margin-bottom:25px;
}

.card a{
    display:inline-block;
    text-decoration:none;
    background:#2563eb;
    color:white;
    padding:12px 24px;
    border-radius:10px;
    font-weight:bold;
    transition:0.3s;
}

.card a:hover{
    background:#1d4ed8;
}

.back-link{
    display:inline-block;
    margin-top:30px;
    text-decoration:none;
    color:#64748b;
}

.back-link:hover{
    color:#2563eb;
}

</style>

</head>

<body>

<div class="container">

    <div class="title">
        <h1>Admin Management</h1>
    </div>

    <div class="cards">

        <!-- USER CARD -->
        <div class="card">
            <h2>Manage Users</h2>
            <p>Add and manage system users.</p>
            <a href="addUser.jsp">Add User</a>
        </div>

        <!-- PRODUCT CARD -->
        <div class="card">
            <h2>Manage Products</h2>
            <p>Add and manage products.</p>
            <a href="AddProductServlet.do">Add Product</a>
        </div>

    </div>
    
    <div style="text-align: center;">
        <a href="admin.jsp" class="back-link">← Back to Dashboard</a>
    </div>

</div>

</body>

</html>