/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web;

import entities.CartItem;
import entities.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Vutomi Nyarhi
 */
@WebServlet("/BuyAllServlet")
public class BuyAllServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Check login
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get cart
        List<CartItem> cart =
                (List<CartItem>) session.getAttribute("cart");

        // Validate cart
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp");
            return;
        }

        // Copy cart into checkout cart
        List<CartItem> checkoutCart =
                new ArrayList<>(cart);

        session.setAttribute(
                "checkoutCart",
                checkoutCart
        );

        // Redirect to checkout page
        response.sendRedirect("checkout.jsp");
    }

}
