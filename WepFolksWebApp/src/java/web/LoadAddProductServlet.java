/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web;

import entities.CategoryFacadeLocal;
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
@WebServlet("/LoadAddProductServlet")
public class LoadAddProductServlet extends HttpServlet {

    @EJB
    private CategoryFacadeLocal cfl;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("categories", cfl.findAll());
        request.getRequestDispatcher("addProduct.jsp").forward(request, response);
    }
}