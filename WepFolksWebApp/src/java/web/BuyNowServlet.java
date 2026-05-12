/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web;

import entities.CartItem;
import entities.Product;
import entities.ProductFacadeLocal;
import entities.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
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
@WebServlet("/BuyNowServlet")
public class BuyNowServlet extends HttpServlet {

    @EJB
    private ProductFacadeLocal pfl;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            HttpSession session = request.getSession();

            User user = (User) session.getAttribute("user");

            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            Long id = Long.parseLong(request.getParameter("id"));

            Product product = pfl.find(id);

            if (product == null) {
                session.setAttribute("error", "Product not found");
                response.sendRedirect("cart.jsp");
                return;
            }

            List<CartItem> checkoutCart =
                    (List<CartItem>) session.getAttribute("checkoutCart");

            if (checkoutCart == null) {
                checkoutCart = new ArrayList<>();
            }

            CartItem item = new CartItem();
            item.setProduct(product);
            item.setQuantity(1);

            checkoutCart.add(item);

            session.setAttribute("checkoutCart", checkoutCart);

            response.sendRedirect("checkout.jsp");

        } catch (Exception e) {
            e.printStackTrace(); // IMPORTANT: check GlassFish logs
            throw new ServletException(e);
        }
    }
}