/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web;

import entities.Product;
import entities.ProductFacadeLocal;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
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
@WebServlet("/DisplayProductsServlet")
public class DisplayProductsServlet extends HttpServlet {

    @EJB
    private ProductFacadeLocal pfl;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> products = pfl.findAll();
        
        request.setAttribute("products", products);
        
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

}
