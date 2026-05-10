<%-- 
    Document   : creditApplication
    Created on : 10 May 2026, 2:10:03 PM
    Author     : Elias
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Apply for Credit - WepFolks</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
    min-height:100vh;
    padding:40px 20px;
}

.container{
    max-width:600px;
    margin:0 auto;
}

.application-card{
    background:white;
    border-radius:24px;
    padding:35px;
    box-shadow:0 20px 35px rgba(0,0,0,0.1);
}

h2{
    color:#1e293b;
    margin-bottom:10px;
    text-align:center;
}

h2 i{
    color:#3b82f6;
    margin-right:10px;
}

.subtitle{
    text-align:center;
    color:#64748b;
    margin-bottom:30px;
}

.form-group{
    margin-bottom:20px;
}

label{
    display:block;
    margin-bottom:8px;
    font-weight:600;
    color:#475569;
}

label i{
    margin-right:8px;
    color:#3b82f6;
}

input, select{
    width:100%;
    padding:12px 15px;
    border:2px solid #e2e8f0;
    border-radius:12px;
    font-size:14px;
    transition:0.3s;
}

input:focus, select:focus{
    outline:none;
    border-color:#3b82f6;
    box-shadow:0 0 0 3px rgba(59,130,246,0.1);
}

.info-box{
    background:#f0fdf4;
    border-left:4px solid #10b981;
    padding:15px;
    border-radius:10px;
    margin:20px 0;
}

.info-box i{
    color:#10b981;
    margin-right:10px;
}

button{
    width:100%;
    padding:14px;
    background:linear-gradient(135deg, #3b82f6, #2563eb);
    color:white;
    border:none;
    border-radius:12px;
    font-weight:700;
    font-size:16px;
    cursor:pointer;
    transition:0.3s;
    margin-top:10px;
}

button:hover{
    transform:translateY(-2px);
    box-shadow:0 5px 15px rgba(59,130,246,0.3);
}

.back-btn{
    display:block;
    text-align:center;
    margin-top:20px;
    color:#64748b;
    text-decoration:none;
}

.back-btn:hover{
    color:#3b82f6;
}

.error{
    background:#fee2e2;
    color:#dc2626;
    padding:12px;
    border-radius:10px;
    margin-bottom:20px;
}
</style>
</head>
<body>

<div class="container">
    <div class="application-card">
        <h2><i class="fas fa-hand-holding-usd"></i> Apply for Credit</h2>
        <p class="subtitle">Get instant credit approval and shop now, pay later!</p>
        
        <% if(request.getParameter("error") != null) { %>
            <div class="error">
                <i class="fas fa-exclamation-triangle"></i> <%= request.getParameter("error") %>
            </div>
        <% } %>
        
        <div class="info-box">
            <i class="fas fa-info-circle"></i>
            <strong>How it works:</strong><br>
            • Submit your information and bank statement<br>
            • Get approved for up to R50,000 credit<br>
            • Shop immediately with your credit limit<br>
            • Pay back in easy monthly installments<br>
            • No interest if paid within 30 days!
        </div>
        
        <form action="CreditApplicationServlet" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label><i class="fas fa-briefcase"></i> Employment Status</label>
                <select name="employmentStatus" required>
                    <option value="">Select employment status</option>
                    <option value="EMPLOYED">Employed - Full Time</option>
                    <option value="SELF_EMPLOYED">Self Employed</option>
                    <option value="STUDENT">Student</option>
                </select>
            </div>
            
            <div class="form-group">
                <label><i class="fas fa-rand"></i> Monthly Income</label>
                <select name="monthlyIncome" required>
                    <option value="">Select monthly income range</option>
                    <option value="5000-10000">R5,000 - R10,000</option>
                    <option value="10000-15000">R10,000 - R15,000</option>
                    <option value="15000-20000">R15,000 - R20,000</option>
                    <option value="20000-30000">R20,000 - R30,000</option>
                    <option value="30000+">R30,000+</option>
                </select>
            </div>
            
            <div class="form-group">
                <label><i class="fas fa-coins"></i> Requested Credit Amount</label>
                <select name="requestedAmount" required>
                    <option value="">Select amount</option>
                    <option value="5000">R5,000</option>
                    <option value="10000">R10,000</option>
                    <option value="15000">R15,000</option>
                    <option value="20000">R20,000</option>
                    <option value="30000">R30,000</option>
                    <option value="50000">R50,000</option>
                </select>
            </div>
            
            <div class="form-group">
                <label><i class="fas fa-file-pdf"></i> Upload Bank Statement (3 months)</label>
                <input type="file" name="bankStatement" accept=".pdf,.jpg,.png" required>
                <small style="color:#64748b;">Upload PDF or image of your latest bank statement</small>
            </div>
            
            <button type="submit">
                <i class="fas fa-paper-plane"></i> Submit Application
            </button>
        </form>
        
        <a href="profile.jsp" class="back-btn">
            <i class="fas fa-arrow-left"></i> Back to Profile
        </a>
    </div>
</div>

</body>
</html>
