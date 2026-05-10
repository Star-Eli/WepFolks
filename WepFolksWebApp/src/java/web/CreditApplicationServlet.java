/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


package web;

import entities.User;
import entities.UserFacadeLocal;
import java.io.IOException;
import java.io.InputStream;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/CreditApplicationServlet")
@MultipartConfig
public class CreditApplicationServlet extends HttpServlet {

    @EJB
    private UserFacadeLocal ufl;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        request.getRequestDispatcher("creditApplication.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            
            // Get form data
            String employmentStatus = request.getParameter("employmentStatus");
            String monthlyIncome = request.getParameter("monthlyIncome");
            double requestedAmount = Double.parseDouble(request.getParameter("requestedAmount"));
            
            // Get bank statement file
            Part filePart = request.getPart("bankStatement");
            byte[] bankStatement = null;
            
            if (filePart != null && filePart.getSize() > 0) {
                InputStream input = filePart.getInputStream();
                bankStatement = new byte[(int) filePart.getSize()];
                input.read(bankStatement);
                input.close();
            }
            
            // Calculate credit limit based on income
            double creditLimit = calculateCreditLimit(monthlyIncome, employmentStatus);
            
            // Update user with credit application
            user.setEmploymentStatus(employmentStatus);
            user.setMonthlyIncome(monthlyIncome);
            user.setCreditLimit(creditLimit);
            user.setCreditAvailable(creditLimit);
            user.setCreditUsed(0);
            user.setCreditStatus("APPROVED"); // Auto-approve for demo
            
            ufl.edit(user);
            session.setAttribute("user", user);
            
            response.sendRedirect("creditApproved.jsp?approved=true&limit=" + creditLimit);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("creditApplication.jsp?error=Application failed");
        }
    }
    
    private double calculateCreditLimit(String monthlyIncome, String employmentStatus) {
        double limit = 0;
        
        // Parse income
        double income = 0;
        if (monthlyIncome.contains("5000-10000")) income = 7500;
        else if (monthlyIncome.contains("10000-15000")) income = 12500;
        else if (monthlyIncome.contains("15000-20000")) income = 17500;
        else if (monthlyIncome.contains("20000-30000")) income = 25000;
        else if (monthlyIncome.contains("30000+")) income = 40000;
        
        // Calculate limit (3x monthly income)
        limit = income * 3;
        
        // Adjust based on employment status
        if ("EMPLOYED".equals(employmentStatus)) limit = limit;
        else if ("SELF_EMPLOYED".equals(employmentStatus)) limit = limit * 0.8;
        else if ("STUDENT".equals(employmentStatus)) limit = limit * 0.3;
        
        return Math.min(limit, 50000); // Max limit R50000
    }
}