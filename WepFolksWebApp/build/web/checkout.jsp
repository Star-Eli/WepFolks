<%@page import="entities.User"%>
<%@page import="entities.Product"%>
<%@page import="entities.CartItem"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout - WepFolks</title>

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
body{
    font-family: 'Inter', sans-serif;
    margin: 0;
    padding: 20px;
    background:linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height:100vh;
}

.container{
    max-width: 900px;
    margin: 0 auto;
}

.header{
    background:white;
    padding:20px;
    border-radius:15px;
    margin-bottom:20px;
    box-shadow:0 4px 12px rgba(0,0,0,0.1);
}

.header h2{
    color:#1e293b;
    margin-bottom:10px;
}

.header p{
    color:#64748b;
}

.header a{
    color:#3b82f6;
    text-decoration:none;
    margin-right:15px;
}

.header a:hover{
    text-decoration:underline;
}

.container-product{
    background:white;
    border:1px solid #e2e8f0;
    padding:20px;
    margin-bottom:15px;
    border-radius:16px;
    transition:0.3s;
    box-shadow:0 2px 8px rgba(0,0,0,0.05);
}

.container-product:hover{
    transform:translateY(-2px);
    box-shadow:0 4px 15px rgba(0,0,0,0.1);
}

.container-product h3{
    color:#1e293b;
    margin-bottom:10px;
}

.container-product p{
    color:#64748b;
    margin:5px 0;
}

.total{
    background:white;
    padding:20px;
    border-radius:16px;
    font-size:24px;
    font-weight:800;
    margin-top:20px;
    text-align:center;
    box-shadow:0 4px 12px rgba(0,0,0,0.1);
}

.total span{
    color:#3b82f6;
}

.btn{
    padding:14px 25px;
    background:linear-gradient(135deg, #3b82f6, #2563eb);
    color:white;
    border:none;
    cursor:pointer;
    border-radius:12px;
    font-size:16px;
    font-weight:600;
    width:100%;
    transition:0.3s;
}

.btn:hover{
    transform:translateY(-2px);
    box-shadow:0 5px 15px rgba(59,130,246,0.3);
}

.empty{
    text-align:center;
    padding:60px;
    background:white;
    border-radius:16px;
    font-size:18px;
    color:#64748b;
}

.payment-section{
    background:white;
    border-radius:16px;
    padding:25px;
    margin-top:20px;
    box-shadow:0 4px 12px rgba(0,0,0,0.1);
}

.payment-section h3{
    margin-bottom:20px;
    color:#1e293b;
}

.payment-option{
    border:2px solid #e2e8f0;
    border-radius:16px;
    padding:20px;
    margin:15px 0;
    cursor:pointer;
    transition:0.3s;
}

.payment-option:hover{
    border-color:#3b82f6;
    background:#f8fafc;
}

.payment-option label{
    display:flex;
    align-items:center;
    gap:15px;
    cursor:pointer;
}

.payment-icon{
    font-size:28px;
    width:50px;
}

.payment-details{
    flex:1;
}

.payment-details strong{
    display:block;
    color:#1e293b;
}

.payment-details p{
    font-size:12px;
    color:#64748b;
    margin-top:5px;
}

.credit-details{
    margin-top:15px;
    padding:20px;
    background:#fef3c7;
    border-radius:12px;
    display:none;
}

.credit-details.show{
    display:block;
}

.info-row{
    display:flex;
    justify-content:space-between;
    padding:10px 0;
    border-bottom:1px solid #fde68a;
}

.info-row:last-child{
    border-bottom:none;
}

hr{
    margin:20px 0;
    border:none;
    border-top:1px solid #e2e8f0;
}

@media(max-width:768px){
    .container{
        padding:10px;
    }
    .payment-option label{
        flex-wrap:wrap;
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

    List<CartItem> checkoutCart = (List<CartItem>) session.getAttribute("cart");
    double total = 0.0;
    
    String creditStatus = user.getCreditStatus() != null ? user.getCreditStatus() : "NONE";
    double creditLimit = user.getCreditLimit();
    double creditUsed = user.getCreditUsed();
    double creditAvailable = user.getCreditAvailable();
%>

<div class="container">

    <div class="header">
        <h2><i class="fas fa-credit-card"></i> Checkout</h2>
        <p><i class="fas fa-user"></i> Customer: <strong><%= user.getName() %></strong></p>
        <div>
            <a href="DisplayProductsServlet"><i class="fas fa-shopping-bag"></i> Continue Shopping</a>
            <a href="cart.jsp"><i class="fas fa-arrow-left"></i> Back to Cart</a>
        </div>
    </div>

    <%
        if(checkoutCart == null || checkoutCart.isEmpty()){
    %>
        <div class="empty">
            <i class="fas fa-shopping-cart" style="font-size:48px; color:#cbd5e1; margin-bottom:15px; display:block;"></i>
            No items in your cart.
            <br><br>
            <a href="DisplayProductsServlet" style="color:#3b82f6;">Start Shopping</a>
        </div>
    <%
        } else {
            for(CartItem item : checkoutCart){
                if(item != null && item.getProduct() != null){
                    Product p = item.getProduct();
                    int qty = item.getQuantity();
                    double subtotal = p.getPrice() * qty;
                    total += subtotal;
    %>
                    <div class="container-product">
                        <h3><%= p.getName() %></h3>
                        <p><%= p.getDescription() != null ? p.getDescription() : "No description" %></p>
                        <p><i class="fas fa-rand" style="color:#10b981;"></i> Price: R<%= p.getPrice() %></p>
                        <p><i class="fas fa-box"></i> Quantity: <%= qty %></p>
                        <p><strong><i class="fas fa-calculator"></i> Subtotal: R<%= String.format("%.2f", subtotal) %></strong></p>
                    </div>
    <%
                }
            }
        }
    %>

    <div class="total">
        Total Amount: <span>R<%= String.format("%.2f", total) %></span>
    </div>

    <%
        if(checkoutCart != null && !checkoutCart.isEmpty()){
    %>
    
    <!-- Payment Section -->
    <div class="payment-section">
        <h3><i class="fas fa-money-bill-wave"></i> Select Payment Method</h3>
        
        <form action="CheckoutServlet" method="post" id="checkoutForm">
            
            <!-- Regular Payment Option -->
            <div class="payment-option">
                <label>
                    <input type="radio" name="paymentMethod" value="regular" checked onclick="togglePaymentMethod()">
                    <div class="payment-icon">
                        <i class="fas fa-credit-card" style="color:#3b82f6; font-size:28px;"></i>
                    </div>
                    <div class="payment-details">
                        <strong>Pay Now</strong>
                        <p>Pay with card or EFT - Instant payment</p>
                    </div>
                </label>
            </div>
            
            <!-- Credit Payment Option -->
            <div class="payment-option">
                <label>
                    <input type="radio" name="paymentMethod" value="credit" onclick="togglePaymentMethod()">
                    <div class="payment-icon">
                        <i class="fas fa-hand-holding-usd" style="color:#f59e0b; font-size:28px;"></i>
                    </div>
                    <div class="payment-details">
                        <strong>Buy Now, Pay Later</strong>
                        <p>Use your credit limit - 0% interest for 30 days</p>
                    </div>
                </label>
            </div>
            
            <!-- Credit Details Section -->
            <div id="creditDetails" class="credit-details">
                <div class="info-row">
                    <span><i class="fas fa-wallet"></i> Credit Status:</span>
                    <span><strong><%= creditStatus %></strong></span>
                </div>
                
                <% if("APPROVED".equals(creditStatus)) { %>
                    <div class="info-row">
                        <span><i class="fas fa-chart-line"></i> Credit Limit:</span>
                        <span><strong>R<%= String.format("%.2f", creditLimit) %></strong></span>
                    </div>
                    <div class="info-row">
                        <span><i class="fas fa-rand"></i> Used Credit:</span>
                        <span><strong>R<%= String.format("%.2f", creditUsed) %></strong></span>
                    </div>
                    <div class="info-row">
                        <span><i class="fas fa-wallet"></i> Available Credit:</span>
                        <span><strong>R<%= String.format("%.2f", creditAvailable) %></strong></span>
                    </div>
                    
                    <% if(total > creditAvailable) { %>
                        <div class="info-row" style="background:#fee2e2; margin-top:10px; border-radius:10px;">
                            <span style="color:#dc2626;">
                                <i class="fas fa-exclamation-triangle"></i> Insufficient credit!
                            </span>
                        </div>
                    <% } else { %>
                        <div class="info-row" style="background:#d1fae5; margin-top:10px; border-radius:10px;">
                            <span style="color:#059669;">
                                <i class="fas fa-check-circle"></i> You have sufficient credit!
                            </span>
                        </div>
                    <% } %>
                    
                    <div style="margin-top:15px;">
                        <label>Repayment Period:</label>
                        <select name="repaymentPeriod" id="repaymentPeriod" style="width:100%; padding:10px; margin-top:10px; border-radius:10px; border:1px solid #e2e8f0;">
                            <option value="30">Pay in 30 days (0% interest)</option>
                            <option value="60">Pay in 60 days (5% interest)</option>
                            <option value="90">Pay in 90 days (10% interest)</option>
                        </select>
                    </div>
                    
                    <div id="monthlyPayment" style="margin-top:15px; font-weight:700; color:#d97706; text-align:center; padding:10px;"></div>
                    
                <% } else if("PENDING".equals(creditStatus)) { %>
                    <div class="info-row" style="background:#fef3c7; margin-top:10px; border-radius:10px;">
                        <span style="color:#d97706;">
                            <i class="fas fa-clock"></i> Your credit application is pending approval.
                            <a href="CreditApplicationServlet" style="color:#d97706;">Check status</a>
                        </span>
                    </div>
                <% } else { %>
                    <div class="info-row" style="background:#fee2e2; margin-top:10px; border-radius:10px;">
                        <span style="color:#dc2626;">
                            <i class="fas fa-info-circle"></i> No credit limit available. 
                            <a href="CreditApplicationServlet" style="color:#dc2626;">Apply for credit now!</a>
                        </span>
                    </div>
                <% } %>
            </div>
            
            <hr>
            
            <input type="hidden" name="total" value="<%= total %>">
            <input type="hidden" name="useCredit" id="useCredit" value="false">
            
            <button type="submit" class="btn" id="submitBtn">
                <i class="fas fa-check-circle"></i> Confirm Purchase
            </button>
        </form>
    </div>
    
    <%
        }
    %>

</div>

<script>
function togglePaymentMethod() {
    var creditRadio = document.querySelector('input[name="paymentMethod"][value="credit"]');
    var creditDiv = document.getElementById('creditDetails');
    var useCreditField = document.getElementById('useCredit');
    var submitBtn = document.getElementById('submitBtn');
    
    if(creditRadio && creditRadio.checked) {
        creditDiv.classList.add('show');
        useCreditField.value = 'true';
        submitBtn.innerHTML = '<i class="fas fa-hand-holding-usd"></i> Buy Now, Pay Later';
    } else {
        creditDiv.classList.remove('show');
        useCreditField.value = 'false';
        submitBtn.innerHTML = '<i class="fas fa-check-circle"></i> Confirm Purchase';
    }
}

// Calculate monthly payment on page load and when repayment period changes
function calculateMonthlyPayment() {
    var periodSelect = document.getElementById('repaymentPeriod');
    if(!periodSelect) return;
    
    var period = periodSelect.value;
    var total = <%= total %>;
    var interest = 0;
    var months = 1;
    
    if(period == 60) {
        interest = 0.05;
        months = 2;
    } else if(period == 90) {
        interest = 0.10;
        months = 3;
    } else {
        interest = 0;
        months = 1;
    }
    
    var totalWithInterest = total * (1 + interest);
    var monthly = totalWithInterest / months;
    var monthlyPaymentDiv = document.getElementById('monthlyPayment');
    
    if(monthlyPaymentDiv) {
        monthlyPaymentDiv.innerHTML = '<i class="fas fa-calendar-check"></i> Monthly Payment: R' + monthly.toFixed(2) + ' for ' + months + ' month(s)';
    }
}

// Initialize on page load
document.addEventListener('DOMContentLoaded', function() {
    var periodSelect = document.getElementById('repaymentPeriod');
    if(periodSelect) {
        periodSelect.addEventListener('change', calculateMonthlyPayment);
        calculateMonthlyPayment();
    }
});
</script>

</body>
</html>