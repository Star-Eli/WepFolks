package web;

import entities.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {

    @EJB
    private OrderFacadeLocal ofl;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<CartItem> cart =
                (List<CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.getWriter().println("Cart is empty");
            return;
        }

        double total = 0;

        List<OrderItem> orderItems = new ArrayList<>();

        for (CartItem item : cart) {

            if (item.getProduct() == null) continue;

            OrderItem oi = new OrderItem();
            oi.setProduct(item.getProduct());
            oi.setQuantity(item.getQuantity());
            oi.setPrice(item.getProduct().getPrice());

            total += item.getProduct().getPrice() * item.getQuantity();

            orderItems.add(oi);
        }

        // CREATE ORDER (NOT PAID YET)
        Order order = new Order();
        order.setUser(user);
        order.setOrderDate(new Date());
        order.setStatus("PENDING"); // ✅ FIXED
        order.setTotal(total);
        order.setItems(orderItems);

        for (OrderItem oi : orderItems) {
            oi.setOrder(order);
        }

        ofl.create(order);

        // CLEAR CART
        session.removeAttribute("cart");

        // SAVE ORDER FOR NEXT STEPS
        session.setAttribute("currentOrder", order);

        // NEXT STEP → ADDRESS PAGE
        response.sendRedirect("checkoutAddress.jsp");
    }
}