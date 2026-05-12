<%-- 
    Document   : editProduct
    Created on : 09 May 2026, 10:58:15 PM
    Author     : Elias
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="entities.Category"%>
<%@page import="entities.Product"%>

<%
    Product product = (Product) request.getAttribute("product");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    String error = request.getParameter("error");
    
    if (product == null) {
        response.sendRedirect("admin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Product</title>

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
    width:550px;
    box-shadow:0 4px 12px rgba(0,0,0,0.1);
    max-height:90vh;
    overflow-y:auto;
}

h2{
    margin-top:0;
    color:#1e293b;
    text-align:center;
    margin-bottom:20px;
}

.form-group{
    margin-bottom:15px;
}

label{
    display:block;
    margin-bottom:5px;
    color:#64748b;
    font-weight:500;
}

input, textarea, select{
    width:100%;
    padding:12px;
    border:1px solid #ccc;
    border-radius:8px;
    box-sizing:border-box;
    font-size:14px;
}

input:focus, textarea:focus, select:focus{
    outline:none;
    border-color:#2563eb;
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
    font-size:16px;
    margin-bottom:10px;
}

button:hover{
    background:#1d4ed8;
}

.cancel-btn{
    background:#64748b;
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

.category-option{
    margin-bottom:15px;
}

.radio-group{
    display:flex;
    gap:20px;
    margin-bottom:15px;
    padding:10px;
    background:#f8fafc;
    border-radius:8px;
}

.radio-group label{
    display:flex;
    align-items:center;
    gap:8px;
    cursor:pointer;
    margin:0;
}

.radio-group input[type="radio"]{
    width:auto;
    margin:0;
}

.hidden{
    display:none;
}

.new-category-fields{
    margin-top:10px;
    padding:15px;
    background:#f8fafc;
    border-radius:8px;
    border-left:4px solid #2563eb;
}

hr{
    margin:20px 0;
    border:none;
    border-top:1px solid #e2e8f0;
}

.button-group{
    display:flex;
    gap:10px;
}

.button-group button{
    flex:1;
}

.current-image{
    text-align:center;
    margin-bottom:15px;
    padding:10px;
    background:#f8fafc;
    border-radius:8px;
}

.current-image img{
    max-width:150px;
    max-height:150px;
    border-radius:8px;
    margin-top:10px;
}
</style>

<script>
function toggleCategoryFields() {
    var existingRadio = document.getElementById('existingRadio');
    var newRadio = document.getElementById('newRadio');
    var existingSelect = document.getElementById('existingCategoryDiv');
    var newFields = document.getElementById('newCategoryFields');
    
    if (existingRadio.checked) {
        existingSelect.classList.remove('hidden');
        newFields.classList.add('hidden');
        if(document.getElementsByName('newCategoryName')[0]) {
            document.getElementsByName('newCategoryName')[0].removeAttribute('required');
        }
        if(document.getElementsByName('categoryId')[0]) {
            document.getElementsByName('categoryId')[0].setAttribute('required', 'required');
        }
    } else if (newRadio.checked) {
        existingSelect.classList.add('hidden');
        newFields.classList.remove('hidden');
        if(document.getElementsByName('newCategoryName')[0]) {
            document.getElementsByName('newCategoryName')[0].setAttribute('required', 'required');
        }
        if(document.getElementsByName('categoryId')[0]) {
            document.getElementsByName('categoryId')[0].removeAttribute('required');
        }
    }
}

window.onload = function() {
    toggleCategoryFields();
};

function goToAdmin() {
    window.location.href = 'admin.jsp';
}
</script>

</head>
<body>

<div class="form-box">
    <h2>Edit Product</h2>
    
    <% if(error != null && error.equals("1")) { %>
        <div class="error-message">
            Error updating product. Please try again.
        </div>
    <% } %>

    <form action="ManageProductServlet.do" method="post" enctype="multipart/form-data">
        
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="productId" value="<%= product.getId() %>">
        
        <div class="form-group">
            <label>Product Name:</label>
            <input type="text" name="name" value="<%= product.getName() %>" required>
        </div>
        
        <div class="category-option">
            <label>Category:</label>
            <div class="radio-group">
                <label>
                    <input type="radio" name="categoryOption" value="existing" id="existingRadio" checked onclick="toggleCategoryFields()">
                    Select Existing Category
                </label>
                <label>
                    <input type="radio" name="categoryOption" value="new" id="newRadio" onclick="toggleCategoryFields()">
                    Add New Category
                </label>
            </div>
            
            <div id="existingCategoryDiv">
                <select name="categoryId">
                    <option value="">-- Select Category --</option>
                    <%
                        if(categories != null){
                            for(Category c : categories){
                                String selected = (product.getCategory() != null && product.getCategory().getId().equals(c.getId())) ? "selected" : "";
                    %>
                        <option value="<%= c.getId() %>" <%= selected %>>
                            <%= c.getName() %>
                        </option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>
            
            <div id="newCategoryFields" class="new-category-fields hidden">
                <input type="text" name="newCategoryName" placeholder="New Category Name">
            </div>
        </div>
        
        <div class="form-group">
            <label>Price (R):</label>
            <input type="number" step="0.01" name="price" value="<%= product.getPrice() %>" required>
        </div>
        
        <div class="form-group">
            <label>Stock Quantity:</label>
            <input type="number" name="stockQuantity" value="<%= product.getStockQuantity() %>" required>
        </div>
        
        <div class="form-group">
            <label>Description:</label>
            <textarea name="description" rows="4"><%= product.getDescription() != null ? product.getDescription() : "" %></textarea>
        </div>
        
        <div class="current-image">
            <label>Current Image:</label>
            <% if(product.getImage() != null) { %>
                <div>
                    <img src="ProductImageServlet.do?id=<%= product.getId() %>" alt="Product Image">
                </div>
            <% } else { %>
                <p style="color:#64748b; margin-top:10px;">No image uploaded</p>
            <% } %>
        </div>
        
        <div class="form-group">
            <label>Change Image (optional):</label>
            <input type="file" name="image" accept="image/*">
            <small style="color:#64748b; display:block; margin-top:5px;">Leave empty to keep current image</small>
        </div>
        
        <hr>
        
        <div class="button-group">
            <button type="submit">Update Product</button>
            <button type="button" class="cancel-btn" onclick="goToAdmin()">Cancel</button>
        </div>
        
    </form>
</div>

</body>
</html>