<%-- 
    Document   : aboutDeveloper
    Created on : May 11, 2026, 10:06:24 PM
    Author     : Vutomi Nyarhi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>WepFolks - About Developers</title>

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

/* NAVBAR */
.navbar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:18px 8%;
    background:rgba(255,255,255,0.95);
    backdrop-filter:blur(10px);
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

.navbar a{
    margin-left:20px;
    text-decoration:none;
    color:#475569;
    font-weight:600;
}

/* CONTAINER */
.container{
    width:90%;
    max-width:1100px;
    margin:60px auto;
}

/* HEADER */
.header{
    text-align:center;
    color:white;
    margin-bottom:40px;
}

.header h1{
    font-size:40px;
    font-weight:800;
}

.header p{
    font-size:18px;
    opacity:0.9;
}

/* CARD */
.card{
    background:white;
    padding:30px;
    border-radius:20px;
    box-shadow:0 15px 40px rgba(0,0,0,0.15);
    margin-bottom:25px;
}

/* TEAM GRID */
.team{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(200px,1fr));
    gap:20px;
}

.member{
    text-align:center;
    padding:20px;
    border-radius:15px;
    background:#f8fafc;
    transition:0.3s;
}

.member:hover{
    transform:translateY(-5px);
}

.member img{
    width:100px;
    height:100px;
    border-radius:50%;
    object-fit:cover;
    margin-bottom:10px;
    border:3px solid #3b82f6;
}

.member h3{
    font-size:16px;
    margin-bottom:5px;
}

.member p{
    font-size:13px;
    color:#64748b;
}

/* GROUP IMAGE */
.group-img{
    width:100%;
    border-radius:15px;
    margin-top:15px;
}

/* LINKS */
a.github{
    display:inline-block;
    margin:8px 0;
    color:#3b82f6;
    font-weight:600;
    text-decoration:none;
}

a.github:hover{
    text-decoration:underline;
}

/* CONTACT */
.contact{
    display:flex;
    flex-wrap:wrap;
    gap:20px;
}

.contact div{
    flex:1;
    min-width:200px;
    background:#f8fafc;
    padding:15px;
    border-radius:12px;
}

.contact i{
    color:#3b82f6;
    margin-right:8px;
}

/* FOOTER TEXT */
.footer-note{
    text-align:center;
    color:white;
    margin-top:20px;
    opacity:0.9;
}
</style>

</head>

<body>

<!-- NAVBAR -->
<nav class="navbar">

    <a href="DisplayProductsServlet" class="logo">
        <div class="logo-icon">WF</div>
        <div class="logo-text">WepFolks</div>
    </a>

    <div>
        <a href="DisplayProductsServlet"><i class="fas fa-home"></i> Home</a>
        <a href="cart.jsp"><i class="fas fa-shopping-cart"></i> Cart</a>
        <a href="login.jsp"><i class="fas fa-sign-in-alt"></i> Login</a>
    </div>

</nav>

<div class="container">

    <!-- HEADER -->
    <div class="header">
        <h1>Meet Our Development Team</h1>
        <p>Tshwane University of Technology (TUT) | Supervised by Mr Memani</p>
    </div>

    <!-- GROUP IMAGE -->
    <div class="card">
        <h2><i class="fas fa-users"></i> Our Group</h2>
        <img src="images/group.jpg" alt="Group Picture" class="group-img">
        <p style="margin-top:10px; color:#64748b;">
            We are a team of 5 passionate IT students building the WepFolks e-commerce system.
        </p>
    </div>

    <!-- TEAM MEMBERS -->
    <div class="card">
        <h2><i class="fas fa-user-graduate"></i> Team Members</h2>

        <div class="team">

            <div class="member">
                <img src="vutomi.jpg">
                <h3>Vutomi Nyarhi</h3>
                <p>Full Stack Developer</p>
            </div>

            <div class="member">
                <img src="images/user2.jpg">
                <h3>Member 2</h3>
                <p>Backend Developer</p>
            </div>

            <div class="member">
                <img src="images/user3.jpg">
                <h3>Member 3</h3>
                <p>Frontend Developer</p>
            </div>

            <div class="member">
                <img src="images/user4.jpg">
                <h3>Member 4</h3>
                <p>Database Engineer</p>
            </div>

            <div class="member">
                <img src="images/user5.jpg">
                <h3>Member 5</h3>
                <p>UI/UX Designer</p>
            </div>

        </div>
    </div>

    <!-- LECTURER -->
    <div class="card">
        <h2><i class="fas fa-chalkboard-teacher"></i> Lecturer</h2>
        <p><b>Mr Memani</b> - Tshwane University of Technology</p>
        <p style="color:#64748b;">Project supervisor for WepFolks e-commerce system</p>
    </div>

    <!-- GITHUB -->
    <div class="card">
        <h2><i class="fab fa-github"></i> GitHub Repositories</h2>

        <a class="github" href="https://github.com/Star-Eli/WepFolks/commit/96e35e48c7c0565ea138774080da705afbee0c60" target="_blank">
            Project Backend Repository
        </a><br>

        <a class="github" href="https://github.com/Star-Eli/WepFolks/tree/master/WepFolksWebApp" target="_blank">
            Frontend Repository
        </a><br>

        <a class="github" href="https://github.com/Star-Eli/WepFolks" target="_blank">
            Full Project Repo
        </a>

    </div>

    <!-- CONTACT -->
    <div class="card">
        <h2><i class="fas fa-address-book"></i> Contact Us</h2>

        <div class="contact">

            <div>
                <i class="fas fa-envelope"></i>vutominyari@gmail.com
            </div>

            <div>
                <i class="fas fa-phone"></i> +27 76 088 6036
            </div>

            <div>
                <i class="fas fa-map-marker-alt"></i> Tshwane University of Technology
            </div>

        </div>
        <div class="contact">

            <div>
                <i class="fas fa-envelope"></i>vutominyari@gmail.com
            </div>

            <div>
                <i class="fas fa-phone"></i> +27 76 088 6036
            </div>

            <div>
                <i class="fas fa-map-marker-alt"></i> Tshwane University of Technology
            </div>

        </div>
        <div class="contact">

            <div>
                <i class="fas fa-envelope"></i>vutominyari@gmail.com
            </div>

            <div>
                <i class="fas fa-phone"></i> +27 76 088 6036
            </div>

            <div>
                <i class="fas fa-map-marker-alt"></i> Tshwane University of Technology
            </div>

        </div>
        <div class="contact">

            <div>
                <i class="fas fa-envelope"></i>vutominyari@gmail.com
            </div>

            <div>
                <i class="fas fa-phone"></i> +27 76 088 6036
            </div>

            <div>
                <i class="fas fa-map-marker-alt"></i> Tshwane University of Technology
            </div>

        </div>
        <div class="contact">

            <div>
                <i class="fas fa-envelope"></i>vutominyari@gmail.com
            </div>

            <div>
                <i class="fas fa-phone"></i> +27 76 088 6036
            </div>

            <div>
                <i class="fas fa-map-marker-alt"></i> Ext 6 Tsakani Langaville,Brakpan,Gauteng
            </div>

        </div>

    </div>

</div>

<div class="footer-note">
    © 2026 WepFolks Team | Built with passion at TUT
</div>

</body>
</html>
