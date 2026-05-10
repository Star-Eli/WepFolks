<%-- 
    Document   : profile
    Created on : May 9, 2026, 12:14:03 AM
    Author     : Vutomi Nyarhi
--%>

<%@page import="java.util.Base64"%>
<%@page import="entities.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>My Profile - WepFolks</title>

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Inter', sans-serif;
}

body{
    background:linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color:#1e293b;
    min-height:100vh;
}

.container{
    max-width:1200px;
    margin:0 auto;
    padding:30px 20px;
}

/* Top Navigation Bar */
.top-nav{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:15px 25px;
    background:rgba(255,255,255,0.95);
    border-radius:20px;
    margin-bottom:30px;
    box-shadow:0 10px 25px rgba(0,0,0,0.1);
}

/* WF LOGO STYLES */
.logo{
    display:flex;
    align-items:center;
    gap:12px;
    text-decoration:none;
}

.logo-icon{
    width:40px;
    height:40px;
    background:linear-gradient(135deg, #3b82f6, #8b5cf6);
    border-radius:10px;
    display:flex;
    align-items:center;
    justify-content:center;
    box-shadow:0 4px 10px rgba(59,130,246,0.3);
    transition:0.3s;
}

.logo-icon:hover{
    transform:scale(1.05);
}

.logo-icon span{
    font-size:20px;
    font-weight:800;
    color:white;
}

.logo-text{
    font-size:24px;
    font-weight:800;
    background:linear-gradient(135deg, #3b82f6, #8b5cf6);
    -webkit-background-clip:text;
    -webkit-text-fill-color:transparent;
    background-clip:text;
}

.logo-text span{
    font-weight:300;
    -webkit-text-fill-color:#64748b;
}

.back-btn{
    background:linear-gradient(135deg, #3b82f6, #2563eb);
    color:white;
    padding:10px 20px;
    border-radius:12px;
    text-decoration:none;
    font-weight:600;
    transition:0.3s;
    display:inline-flex;
    align-items:center;
    gap:8px;
}

.back-btn:hover{
    transform:translateX(-5px);
    box-shadow:0 5px 15px rgba(59,130,246,0.3);
}

.page-header{
    text-align:center;
    margin-bottom:40px;
}

.page-header h1{
    font-size:42px;
    font-weight:800;
    background:linear-gradient(135deg, #fff, #e0e7ff);
    -webkit-background-clip:text;
    -webkit-text-fill-color:transparent;
    background-clip:text;
    margin-bottom:10px;
}

.page-header h1 i{
    -webkit-text-fill-color:#fff;
    margin-right:12px;
}

.page-header p{
    color:#e2e8f0;
    font-size:16px;
}

.profile-grid{
    display:grid;
    grid-template-columns:350px 1fr;
    gap:30px;
}

/* Profile Card */
.profile-card{
    background:white;
    border-radius:24px;
    padding:30px;
    text-align:center;
    box-shadow:0 20px 35px rgba(0,0,0,0.1);
    transition:0.3s;
    border:1px solid rgba(255,255,255,0.2);
}

.profile-card:hover{
    transform:translateY(-5px);
}

.profile-img-container{
    position:relative;
    display:inline-block;
    margin-bottom:20px;
}

.profile-img{
    width:150px;
    height:150px;
    border-radius:50%;
    object-fit:cover;
    border:4px solid #3b82f6;
    box-shadow:0 10px 25px rgba(0,0,0,0.1);
}

.upload-icon{
    position:absolute;
    bottom:5px;
    right:5px;
    background:#3b82f6;
    border-radius:50%;
    width:40px;
    height:40px;
    display:flex;
    align-items:center;
    justify-content:center;
    cursor:pointer;
    transition:0.3s;
    border:2px solid white;
}

.upload-icon:hover{
    background:#2563eb;
    transform:scale(1.1);
}

.upload-icon i{
    color:white;
    font-size:16px;
}

#profileUpload{
    display:none;
}

.profile-card h2{
    font-size:24px;
    font-weight:700;
    color:#1e293b;
    margin-bottom:5px;
}

.profile-card .email{
    color:#64748b;
    font-size:14px;
    margin-bottom:20px;
    display:flex;
    align-items:center;
    justify-content:center;
    gap:6px;
}

/* Credit Info Section */
.credit-info{
    background:linear-gradient(135deg, #fef3c7, #fde68a);
    border-radius:16px;
    padding:15px;
    margin:15px 0;
    text-align:left;
}

.credit-info h4{
    color:#92400e;
    margin-bottom:10px;
    display:flex;
    align-items:center;
    gap:8px;
}

.credit-info p{
    font-size:13px;
    margin:8px 0;
    color:#78350f;
}

.credit-progress{
    background:#e2e8f0;
    border-radius:10px;
    margin-top:10px;
    overflow:hidden;
}

.credit-progress-bar{
    background:#f59e0b;
    height:8px;
    border-radius:10px;
    transition:width 0.5s ease;
}

.credit-status-badge{
    display:inline-block;
    padding:4px 12px;
    border-radius:20px;
    font-size:11px;
    font-weight:600;
    margin-top:10px;
}

.credit-status-approved{
    background:#d1fae5;
    color:#059669;
}

.credit-status-pending{
    background:#fef3c7;
    color:#d97706;
}

.credit-status-none{
    background:#fee2e2;
    color:#dc2626;
}

.credit-apply-btn{
    display:inline-block;
    margin-top:10px;
    background:#f59e0b;
    color:white;
    padding:8px 15px;
    border-radius:8px;
    text-decoration:none;
    font-size:12px;
    font-weight:600;
    transition:0.3s;
}

.credit-apply-btn:hover{
    background:#d97706;
    transform:translateY(-2px);
}

.continue-btn{
    display:inline-flex;
    align-items:center;
    gap:8px;
    background:linear-gradient(135deg, #10b981, #059669);
    color:white;
    text-decoration:none;
    padding:12px 24px;
    border-radius:12px;
    font-weight:600;
    margin-top:20px;
    transition:0.3s;
}

.continue-btn:hover{
    transform:translateY(-2px);
    box-shadow:0 5px 15px rgba(16,185,129,0.3);
}

/* Settings Card */
.settings-card{
    background:white;
    border-radius:24px;
    padding:30px;
    box-shadow:0 20px 35px rgba(0,0,0,0.1);
}

.form-section{
    margin-bottom:30px;
    padding-bottom:30px;
    border-bottom:2px solid #f1f5f9;
}

.form-section:last-child{
    border-bottom:none;
    margin-bottom:0;
    padding-bottom:0;
}

.section-title{
    font-size:20px;
    font-weight:700;
    color:#1e293b;
    margin-bottom:20px;
    display:flex;
    align-items:center;
    gap:10px;
}

.section-title i{
    color:#3b82f6;
    font-size:22px;
}

.form-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
    gap:20px;
    margin-bottom:20px;
}

.input-group{
    display:flex;
    flex-direction:column;
}

.input-group label{
    font-weight:600;
    color:#475569;
    margin-bottom:8px;
    font-size:13px;
    display:flex;
    align-items:center;
    gap:6px;
}

.input-group label i{
    color:#3b82f6;
    width:16px;
}

.input-group input{
    padding:12px 15px;
    border:2px solid #e2e8f0;
    border-radius:12px;
    font-size:14px;
    transition:0.3s;
}

.input-group input:focus{
    outline:none;
    border-color:#3b82f6;
    box-shadow:0 0 0 3px rgba(59,130,246,0.1);
}

.save-btn{
    background:linear-gradient(135deg, #3b82f6, #2563eb);
    color:white;
    border:none;
    padding:12px 24px;
    border-radius:12px;
    font-weight:700;
    cursor:pointer;
    transition:0.3s;
    display:inline-flex;
    align-items:center;
    gap:8px;
    font-size:14px;
}

.save-btn:hover{
    transform:translateY(-2px);
    box-shadow:0 5px 15px rgba(59,130,246,0.3);
}

/* Alerts */
.alert{
    padding:15px 20px;
    border-radius:12px;
    margin-bottom:20px;
    display:flex;
    align-items:center;
    gap:12px;
    animation:slideIn 0.4s ease;
}

.alert-success{
    background:#d1fae5;
    color:#065f46;
    border-left:4px solid #10b981;
}

.alert-error{
    background:#fee2e2;
    color:#991b1b;
    border-left:4px solid #ef4444;
}

.alert i{
    font-size:20px;
}

@keyframes slideIn{
    from{
        opacity:0;
        transform:translateY(-20px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

/* Responsive */
@media(max-width:900px){
    .profile-grid{
        grid-template-columns:1fr;
    }
    .top-nav{
        flex-direction:column;
        gap:15px;
        text-align:center;
    }
    .page-header h1{
        font-size:32px;
    }
}

/* Stats Badge */
.stats-badge{
    display:flex;
    justify-content:center;
    gap:15px;
    margin:20px 0;
}

.stats-badge span{
    background:#f1f5f9;
    padding:5px 12px;
    border-radius:20px;
    font-size:12px;
    color:#64748b;
    display:inline-flex;
    align-items:center;
    gap:5px;
}

/* Footer */
.footer{
    background:#0f172a;
    color:white;
    padding:40px 8% 20px;
    margin-top:40px;
    border-radius:30px 30px 0 0;
}

.footer-content{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
    gap:30px;
    margin-bottom:30px;
}

.footer-section h3{
    margin-bottom:15px;
    font-size:16px;
    display:flex;
    align-items:center;
    gap:8px;
}

.footer-section p{
    color:#94a3b8;
    font-size:14px;
    line-height:1.6;
}

.footer-logo{
    display:flex;
    align-items:center;
    gap:10px;
    margin-bottom:15px;
}

.footer-logo-icon{
    width:35px;
    height:35px;
    background:linear-gradient(135deg, #3b82f6, #8b5cf6);
    border-radius:10px;
    display:flex;
    align-items:center;
    justify-content:center;
}

.footer-logo-icon span{
    font-size:18px;
    font-weight:800;
    color:white;
}

.footer-logo-text{
    font-size:18px;
    font-weight:700;
    color:white;
}

.social-links{
    display:flex;
    gap:15px;
    margin-top:15px;
}

.social-links a{
    color:#94a3b8;
    font-size:18px;
    transition:0.3s;
}

.social-links a:hover{
    color:#3b82f6;
}

.footer-bottom{
    text-align:center;
    padding-top:20px;
    border-top:1px solid #334155;
    color:#94a3b8;
    font-size:13px;
}

@media(max-width:768px){
    .footer-content{
        grid-template-columns:1fr;
        text-align:center;
    }
    .footer-logo{
        justify-content:center;
    }
    .social-links{
        justify-content:center;
    }
}
</style>

</head>

<body>

<%
    User user = (User) session.getAttribute("user");
    
    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }
    
    String success = request.getParameter("success");
    String error = request.getParameter("error");
    
    String imageSrc;
    if(user.getImage() != null){
        String base64Image = Base64.getEncoder().encodeToString(user.getImage());
        imageSrc = "data:image/jpeg;base64," + base64Image;
    }else{
        imageSrc = "https://ui-avatars.com/api/?background=3b82f6&color=fff&name=" + user.getName().replace(" ", "+");
    }
    
    String creditStatus = user.getCreditStatus() != null ? user.getCreditStatus() : "NONE";
    double creditLimit = user.getCreditLimit();
    double creditUsed = user.getCreditUsed();
    double creditAvailable = user.getCreditAvailable();
    double creditUsagePercent = creditLimit > 0 ? (creditUsed / creditLimit) * 100 : 0;
%>

<div class="container">

    <!-- Top Navigation -->
    <div class="top-nav">
        <a href="DisplayProductsServlet" class="logo">
            <div class="logo-icon">
                <span>WF</span>
            </div>
            <div class="logo-text">Wep<span>Folks</span></div>
        </a>
        <a href="DisplayProductsServlet" class="back-btn">
            <i class="fas fa-arrow-left"></i> Back to Shopping
        </a>
    </div>

    <!-- Page Header -->
    <div class="page-header">
        <h1><i class="fas fa-user-circle"></i> My Profile</h1>
        <p><i class="fas fa-heart"></i> Manage your account information and preferences</p>
    </div>
    
    <% if(success != null && !success.isEmpty()){ %>
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i>
            <span><%= success %></span>
        </div>
    <% } %>
    
    <% if(error != null && !error.isEmpty()){ %>
        <div class="alert alert-error">
            <i class="fas fa-exclamation-triangle"></i>
            <span><%= error %></span>
        </div>
    <% } %>

    <div class="profile-grid">

        <!-- LEFT - PROFILE CARD -->
        <div class="profile-card">
            <div class="profile-img-container">
                <img src="<%= imageSrc %>" class="profile-img" id="profilePreview">
                <label for="profileUpload" class="upload-icon">
                    <i class="fas fa-camera"></i>
                </label>
            </div>

            <h2><%= user.getName() %></h2>
            <p class="email"><i class="fas fa-envelope"></i> <%= user.getEmail() %></p>
            
            <div class="stats-badge">
                <span><i class="fas fa-calendar-alt"></i> Member 2024</span>
                <span><i class="fas fa-shopping-bag"></i> Active</span>
            </div>

            <!-- CREDIT INFO SECTION -->
            <div class="credit-info">
                <h4><i class="fas fa-hand-holding-usd"></i> WepFolks Credit</h4>
                
                <% if("APPROVED".equals(creditStatus)) { %>
                    <p><i class="fas fa-chart-line"></i> Credit Limit: <strong>R<%= String.format("%.2f", creditLimit) %></strong></p>
                    <p><i class="fas fa-rand"></i> Used Credit: <strong>R<%= String.format("%.2f", creditUsed) %></strong></p>
                    <p><i class="fas fa-wallet"></i> Available: <strong>R<%= String.format("%.2f", creditAvailable) %></strong></p>
                    <div class="credit-progress">
                        <div class="credit-progress-bar" style="width: <%= creditUsagePercent %>%;"></div>
                    </div>
                    <span class="credit-status-badge credit-status-approved">
                        <i class="fas fa-check-circle"></i> APPROVED
                    </span>
                <% } else if("PENDING".equals(creditStatus)) { %>
                    <p><i class="fas fa-clock"></i> Your credit application is pending review.</p>
                    <span class="credit-status-badge credit-status-pending">
                        <i class="fas fa-clock"></i> PENDING
                    </span>
                <% } else { %>
                    <p><i class="fas fa-info-circle"></i> Get approved for credit up to R50,000!</p>
                    <p><i class="fas fa-percent"></i> Buy now, pay later with 0% interest for 30 days</p>
                    <span class="credit-status-badge credit-status-none">
                        <i class="fas fa-times-circle"></i> NOT APPLIED
                    </span>
                    <a href="CreditApplicationServlet" class="credit-apply-btn">
                        Apply Now <i class="fas fa-arrow-right"></i>
                    </a>
                <% } %>
            </div>

            <form action="SaveProfilePictureServlet" method="post" enctype="multipart/form-data" id="profileForm">
                <input type="file" id="profileUpload" name="image" accept="image/*" onchange="this.form.submit()">
            </form>

            <a href="DisplayProductsServlet" class="continue-btn">
                <i class="fas fa-shopping-bag"></i> Continue Shopping
            </a>
        </div>

        <!-- RIGHT - SETTINGS -->
        <div class="settings-card">

            <!-- PERSONAL INFO -->
            <div class="form-section">
                <h3 class="section-title">
                    <i class="fas fa-user-edit"></i> Personal Information
                </h3>
                <form action="SavePersonalInfoServlet" method="post">
                    <div class="form-grid">
                        <div class="input-group">
                            <label><i class="fas fa-user"></i> Full Name</label>
                            <input type="text" name="name" value="<%= user.getName() %>" required>
                        </div>
                        <div class="input-group">
                            <label><i class="fas fa-phone"></i> Phone Number</label>
                            <input type="text" name="phone" value="<%= user.getPhone() != null ? user.getPhone() : "" %>" placeholder="Enter phone number">
                        </div>
                    </div>
                    <button type="submit" class="save-btn">
                        <i class="fas fa-save"></i> Save Changes
                    </button>
                </form>
            </div>

            <!-- ADDRESS -->
            <div class="form-section">
                <h3 class="section-title">
                    <i class="fas fa-map-marker-alt"></i> Address Information
                </h3>
                <form action="SaveAddressServlet" method="post">
                    <div class="form-grid">
                        <div class="input-group">
                            <label><i class="fas fa-building"></i> Province</label>
                            <input type="text" name="province" value="<%= user.getProvince() == null ? "" : user.getProvince() %>" placeholder="e.g., Gauteng">
                        </div>
                        <div class="input-group">
                            <label><i class="fas fa-city"></i> City</label>
                            <input type="text" name="city" value="<%= user.getCity() == null ? "" : user.getCity() %>" placeholder="e.g., Johannesburg">
                        </div>
                        <div class="input-group">
                            <label><i class="fas fa-road"></i> Street Address</label>
                            <input type="text" name="address" value="<%= user.getAddress() == null ? "" : user.getAddress() %>" placeholder="Street name, building number">
                        </div>
                    </div>
                    <button type="submit" class="save-btn">
                        <i class="fas fa-save"></i> Save Address
                    </button>
                </form>
            </div>

            <!-- EMAIL -->
            <div class="form-section">
                <h3 class="section-title">
                    <i class="fas fa-envelope"></i> Email Settings
                </h3>
                <form action="SaveEmailServlet" method="post">
                    <div class="form-grid">
                        <div class="input-group">
                            <label><i class="fas fa-envelope"></i> Email Address</label>
                            <input type="email" name="email" value="<%= user.getEmail() %>" required>
                        </div>
                    </div>
                    <button type="submit" class="save-btn">
                        <i class="fas fa-save"></i> Update Email
                    </button>
                </form>
            </div>

            <!-- PASSWORD -->
            <div class="form-section">
                <h3 class="section-title">
                    <i class="fas fa-lock"></i> Change Password
                </h3>
                <form action="SavePasswordServlet" method="post" onsubmit="return validatePassword()">
                    <div class="form-grid">
                        <div class="input-group">
                            <label><i class="fas fa-key"></i> Current Password</label>
                            <input type="password" name="currentPassword" required placeholder="Enter current password">
                        </div>
                        <div class="input-group">
                            <label><i class="fas fa-lock"></i> New Password</label>
                            <input type="password" name="newPassword" id="newPassword" required placeholder="Enter new password">
                        </div>
                        <div class="input-group">
                            <label><i class="fas fa-check-circle"></i> Confirm Password</label>
                            <input type="password" name="confirmPassword" id="confirmPassword" required placeholder="Confirm new password">
                        </div>
                    </div>
                    <button type="submit" class="save-btn">
                        <i class="fas fa-key"></i> Change Password
                    </button>
                </form>
            </div>

            <!-- ACCOUNT ACTIONS - WITH CREDIT APPLICATION LINK -->
            <div class="form-section">
                <h3 class="section-title">
                    <i class="fas fa-cog"></i> Account Actions
                </h3>
                <div style="display:flex; gap:15px; flex-wrap:wrap;">
                    <a href="CreditApplicationServlet" class="save-btn" style="background:linear-gradient(135deg, #f59e0b, #d97706); text-decoration:none;">
                        <i class="fas fa-hand-holding-usd"></i> Apply for Credit
                    </a>
                    <a href="OrderHistoryServlet" class="save-btn" style="background:linear-gradient(135deg, #8b5cf6, #7c3aed); text-decoration:none;">
                        <i class="fas fa-history"></i> Order History
                    </a>
                    <a href="LogoutServlet" class="save-btn" style="background:linear-gradient(135deg, #ef4444, #dc2626); text-decoration:none;" onclick="return confirm('Are you sure you want to logout?')">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            </div>

        </div>

    </div>

</div>

<!-- FOOTER -->
<div class="footer">
    <div class="footer-content">
        <div class="footer-section">
            <div class="footer-logo">
                <div class="footer-logo-icon">
                    <span>WF</span>
                </div>
                <div class="footer-logo-text">WepFolks</div>
            </div>
            <p>Your one-stop destination for quality products at affordable prices. Shop with confidence.</p>
            <div class="social-links">
                <a href="#"><i class="fab fa-facebook"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-linkedin"></i></a>
            </div>
        </div>
        
        <div class="footer-section">
            <h3><i class="fas fa-info-circle"></i> About Us</h3>
            <p>WepFolks is committed to providing the best shopping experience with quality products and excellent customer service.</p>
        </div>
        
        <div class="footer-section">
            <h3><i class="fas fa-map-marker-alt"></i> Contact Info</h3>
            <p><i class="fas fa-map-marker-alt"></i> 123 Main Street, Johannesburg</p>
            <p><i class="fas fa-phone"></i> +27 12 345 6789</p>
            <p><i class="fas fa-envelope"></i> info@wepfolks.co.za</p>
        </div>
    </div>
    <div class="footer-bottom">
        <p>&copy; 2024 WepFolks. All rights reserved. | Designed with <i class="fas fa-heart" style="color:#ef4444;"></i> for South Africa</p>
    </div>
</div>

<script>
// Auto-submit image upload
document.getElementById("profileUpload").addEventListener("change", function(event){
    const file = event.target.files[0];
    if(file){
        const reader = new FileReader();
        reader.onload = function(e){
            document.getElementById("profilePreview").src = e.target.result;
        }
        reader.readAsDataURL(file);
    }
});

// Password validation
function validatePassword() {
    var newPass = document.getElementById("newPassword").value;
    var confirmPass = document.getElementById("confirmPassword").value;
    
    if(newPass !== confirmPass){
        alert("❌ New password and confirm password do not match!");
        return false;
    }
    if(newPass.length < 4){
        alert("❌ Password must be at least 4 characters long!");
        return false;
    }
    if(newPass.length > 0 && newPass === confirmPass){
        alert("✅ Password changed successfully!");
    }
    return true;
}
</script>

</body>
</html>