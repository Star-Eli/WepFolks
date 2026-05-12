<%-- 
    Document   : login
    Created on : May 7, 2026, 3:08:52 AM
    Author     : Vutomi Nyarhi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <style>
            /* Page background */
            body {
                margin: 0;
                font-family: Arial, sans-serif;
                background:#f8fafc;
                color:#222;
            }

            /* Main container */
            .login-container {
                display: flex;
                width: 750px;
                margin: 80px auto;
                background: #ffffff;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 5px 20px rgba(0,0,0,0.15);
            }

            /* LEFT SIDE (form) */
            .signin {
                flex: 1;
                padding: 40px;
                background: #ffffff;
            }

            .signin h2 {
                color: #2c3e50;
                margin-bottom: 20px;
            }

            /* Inputs */
            .signin input[type="text"],
            .signin input[type="email"],
            .signin input[type="password"],
            .signin select {
                width: 100%;
                padding: 12px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 5px;
                outline: none;
            }

            /* Focus effect */
            .signin input:focus,
            .signin select:focus {
                border-color: #1abc9c;
            }

            /* Button */
            .btn-login {
                width: 100%;
                padding: 12px;
                background: #2563eb;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
            }

            .btn-login:hover {
                background: #1d4ed8;
            }

            /* Links */
            .signin p {
                text-align: center;
                margin-top: 15px;
            }

            .signin a {
                color: #2563eb;
                text-decoration: none;
            }

            .signin a:hover {
                color: #1d4ed8;
            }

            /* RIGHT SIDE INFO PANEL */
            .why-signin {
                flex: 1;
                padding: 40px;
                background: #2563eb;
                color: white;
            }

            .why-signin h2 {
                color: #1abc9c;
                margin-top: 0;
            }

            .why-signin p {
                line-height: 1.6;
            }

            /* ERROR MESSAGE */
            .error {
                color: #e74c3c;
                background: #fdecea;
                padding: 10px;
                border-radius: 5px;
                margin-bottom: 10px;
            }

            /* SUCCESS MESSAGE */
            .success {
                color: #2ecc71;
                background: #eafaf1;
                padding: 10px;
                border-radius: 5px;
                margin-bottom: 10px;
            }
        </style>
    </head>
    <body>
        
        <div id="container">
            <div class="login-container">
                <div class="signin">
                    <h2>Login</h2>
                    <form action="LoginServlet.do" method="post">
                        <input type="email" name="email" placeholder="Email" required>
                        <input type="password" name="password" placeholder="Password" required>

                        <input type="submit" value="Login" class="btn-login"> 

                        <p><a href="register.jsp">Register</a></p>
                    </form>
                </div>

                <div class="why-signin">
                    <%
                        String error =(String) request.getAttribute("error");
                        if(error != null){
                    %>
                        <p class="error"><%= error %></p>
                    <%
                        }
                    %>

                    <h2 style="color: #f8fafc;">Online Shopping</h2>
                    <p>
                        Shop easily anytime, anywhere. Browse products, add to cart, and checkout securely.
                    </p>
                </div>
            </div>
        </div>
    </body>
</html>
