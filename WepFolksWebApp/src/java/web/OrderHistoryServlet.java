/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web;

import entities.Order;
import entities.OrderFacadeLocal;
import entities.User;
import java.io.IOException;
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

@WebServlet("/OrderHistoryServlet")
public class OrderHistoryServlet extends HttpServlet {

    @EJB
    private OrderFacadeLocal ofl;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Get all orders for this user
            List<Order> orders = ofl.findAll();

            // Filter only this user's orders
            List<Order> userOrders = new java.util.ArrayList<>();

            for (Order o : orders) {
                if (o.getUser() != null &&
                    o.getUser().getId().equals(user.getId())) {
                    userOrders.add(o);
                }
            }

            request.setAttribute("orders", userOrders);

            request.getRequestDispatcher("orderHistory.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error loading orders");
        }
    }
}