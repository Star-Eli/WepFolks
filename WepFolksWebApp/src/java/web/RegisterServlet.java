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
        String role = request.getParameter("role");
        
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
