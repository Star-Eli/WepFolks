<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="entities.Category"%>

<%
    // Get categories from request attribute (set by doGet method)
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
<title>Add Product</title>

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
    width:500px;
    box-shadow:0 4px 12px rgba(0,0,0,0.1);
    max-height:90vh;
    overflow-y:auto;
}

input, textarea, select{
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

h2{
    margin-top:0;
    color:#1e293b;
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

.warning-message{
    background:#fef9c3;
    color:#854d0e;
    padding:10px;
    border-radius:8px;
    margin-bottom:15px;
    text-align:center;
    font-size:14px;
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

function checkDuplicateCategory() {
    var newRadio = document.getElementById('newRadio');
    var newCategoryName = document.getElementsByName('newCategoryName')[0];
    var existingSelect = document.getElementById('categorySelect');
    var isDuplicate = false;
    var duplicateName = "";
    
    if (newRadio.checked && newCategoryName && newCategoryName.value.trim() !== "") {
        var newName = newCategoryName.value.trim().toLowerCase();
        
        // Check all existing categories in dropdown
        if (existingSelect) {
            for (var i = 0; i < existingSelect.options.length; i++) {
                var catName = existingSelect.options[i].text.toLowerCase();
                if (catName === newName && existingSelect.options[i].value !== "") {
                    isDuplicate = true;
                    duplicateName = existingSelect.options[i].text;
                    break;
                }
            }
        }
        
        if (isDuplicate) {
            alert("Category '" + duplicateName + "' already exists!\n\nPlease select it from the dropdown or use a different category name.");
            newCategoryName.value = "";
            newCategoryName.focus();
            return false;
        }
    }
    return true;
}

window.onload = function() {
    toggleCategoryFields();
    
    // Add duplicate check on form submission
    var form = document.querySelector('form');
    if (form) {
        form.onsubmit = function() {
            return checkDuplicateCategory();
        };
    }
    
    // Real-time duplicate checking as user types
    var newCategoryInput = document.getElementsByName('newCategoryName')[0];
    if (newCategoryInput) {
        newCategoryInput.addEventListener('blur', function() {
            if (document.getElementById('newRadio').checked && this.value.trim() !== "") {
                var existingSelect = document.getElementById('categorySelect');
                var newName = this.value.trim().toLowerCase();
                var isDuplicate = false;
                
                for (var i = 0; i < existingSelect.options.length; i++) {
                    if (existingSelect.options[i].text.toLowerCase() === newName && existingSelect.options[i].value !== "") {
                        isDuplicate = true;
                        break;
                    }
                }
                
                if (isDuplicate) {
                    alert("This category already exists! Please select it from the dropdown.");
                    this.value = "";
                }
            }
        });
    }
};

function goToAdmin() {
    window.location.href = 'admin.jsp';
}
</script>

</head>
<body>

<div class="form-box">
    <h2>Add New Product</h2>
    
    <% if(error != null && !error.isEmpty()) { %>
        <div class="error-message">
            Error: <%= error %>
        </div>
    <% } %>

    <form action="AddProductServlet.do" method="post" enctype="multipart/form-data">
        
        <input type="text" name="name" placeholder="Product Name" required>
        
        <div class="category-option">
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
                <select name="categoryId" id="categorySelect" required>
                    <option value="">-- Select Category --</option>
                    <%
                        if(categories != null && !categories.isEmpty()){
                            for(Category c : categories){
                    %>
                        <option value="<%= c.getId() %>">
                            <%= c.getName() %>
                        </option>
                    <%
                            }
                        } else {
                    %>
                        <option value="" disabled>No categories available</option>
                    <%
                        }
                    %>
                </select>
            </div>
            
            <div id="newCategoryFields" class="new-category-fields hidden">
                <input type="text" name="newCategoryName" placeholder="New Category Name" 
                       autocomplete="off">
                <div class="warning-message" style="font-size:12px; margin-top:-8px;">
                    Note: If category already exists, it will be reused instead of creating a duplicate.
                </div>
            </div>
        </div>
        
        <input type="number" step="0.01" name="price" placeholder="Price" required>
        <input type="number" name="stockQuantity" placeholder="Stock Quantity" required>
        <textarea name="description" placeholder="Product Description" rows="3"></textarea>
        <input type="file" name="image" accept="image/*">
        
        <hr>
        
        <div class="button-group">
            <button type="submit">Save Product</button>
            <button type="button" class="cancel-btn" onclick="goToAdmin()">Cancel</button>
        </div>
        
    </form>
</div>

</body>
</html>