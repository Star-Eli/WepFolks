/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web;

import entities.User;
import entities.UserFacadeLocal;
import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Vutomi Nyarhi
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @EJB
    private UserFacadeLocal ufl;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = (String)request.getParameter("email");
        String password = (String)request.getParameter("password");
        String confirmPassword = (String)request.getParameter("confirmPassword");
        String role = request.getParameter("role");
        
        // 1. Match check
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 2. Length check
        if (password.length() < 6) {
            request.setAttribute("error", "Password too short (min 6 characters).");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 3. Counters
        int cntNumChar = 0;
        int cntNumDigits = 0;
        int cntNumLetters = 0;

        for (int i = 0; i < password.length(); i++) {
            char cPassword = password.charAt(i);

            if (!Character.isLetterOrDigit(cPassword)) {
                cntNumChar++;
            }

            if (Character.isLetter(cPassword)) {
                cntNumLetters++;
            }

            if (Character.isDigit(cPassword)) {
                cntNumDigits++;
            }
        }

        // 4. VALIDATION (FIXED LOGIC)
        if (cntNumLetters == 0 || cntNumDigits == 0 || cntNumChar == 0) {
            request.setAttribute("error",
                "Password must contain letters, digits, and special characters.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        
        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);
        
        ufl.create(user);
        
        request.setAttribute("msg", "User registered successfully.");
        
        response.sendRedirect("login.jsp");
        
    }

}
