/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web;

import entities.CartItem;
import entities.Order;
import entities.OrderFacadeLocal;
import entities.OrderItem;
import entities.OrderItemFacadeLocal;
import entities.Product;
import entities.ProductFacadeLocal;
import entities.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
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
@WebServlet("/ConfirmOrderServlet")
public class ConfirmOrderServlet extends HttpServlet {

    @EJB
    private OrderFacadeLocal orderFacade;

    @EJB
    private OrderItemFacadeLocal orderItemFacade;

    @EJB
    private ProductFacadeLocal productFacade;

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

            List<CartItem> cart =
                (List<CartItem>) session.getAttribute("checkoutCart");

            if (cart == null || cart.isEmpty()) {
                response.sendRedirect("cart.jsp");
                return;
            }

            double total = 0.0;

            // CREATE ORDER
            Order order = new Order();
            order.setUser(user);
            order.setStatus("PAID");
            order.setOrderDate(new Date()); // IMPORTANT FIX

            orderFacade.create(order);

            for (CartItem ci : cart) {

                Product p = ci.getProduct();

                if (p == null) continue;

                // RELOAD product from DB (IMPORTANT FIX)
                p = productFacade.find(p.getId());

                OrderItem item = new OrderItem();

                item.setOrder(order);
                item.setProduct(p);
                item.setQuantity(ci.getQuantity());
                item.setPrice(p.getPrice());

                orderItemFacade.create(item);

                // STOCK UPDATE SAFELY
                int newStock =
                    p.getStockQuantity() - ci.getQuantity();

                if (newStock < 0) {
                    throw new RuntimeException("Insufficient stock for " + p.getName());
                }

                p.setStockQuantity(newStock);
                productFacade.edit(p);

                total += item.getPrice() * item.getQuantity();
            }

            session.removeAttribute("checkoutCart");
            session.removeAttribute("cart");

            session.setAttribute("message",
                "Order placed successfully! Total: R" + total);

            response.sendRedirect("orderSuccess.jsp");

        } catch (Exception e) {
            e.printStackTrace(); // CHECK GLASSFISH LOGS
            throw new ServletException(e);
        }
    }
}