package web;

import entities.CartItem;
import entities.Product;
import entities.ProductFacadeLocal;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AddCartServlet")
public class AddCartServlet extends HttpServlet {

    @EJB
    private ProductFacadeLocal pfl;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String productIdParam = request.getParameter("id");
        
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        
        if (cart == null) {
            cart = new ArrayList<>();
        }
        
        // Handle REMOVE action
        if ("remove".equals(action) && productIdParam != null && !productIdParam.isEmpty()) {
            Long productId = Long.parseLong(productIdParam);
            
            // Find and remove the item
            for (int i = 0; i < cart.size(); i++) {
                CartItem item = cart.get(i);
                if (item.getProduct().getId().equals(productId)) {
                    cart.remove(i);
                    break;
                }
            }
            
            // Update session
            session.setAttribute("cart", cart);
            
            // Calculate new cart count
            int qty = 0;
            for (CartItem item : cart) {
                qty += item.getQuantity();
            }
            session.setAttribute("qty", qty);
            
            response.sendRedirect("cart.jsp?removed=true");
            return;
        }
        
        // Handle UPDATE quantity action
        if ("update".equals(action) && productIdParam != null && !productIdParam.isEmpty()) {
            Long productId = Long.parseLong(productIdParam);
            String change = request.getParameter("change");
            
            for (CartItem item : cart) {
                if (item.getProduct().getId().equals(productId)) {
                    int currentQty = item.getQuantity();
                    if ("increase".equals(change)) {
                        item.setQuantity(currentQty + 1);
                    } else if ("decrease".equals(change) && currentQty > 1) {
                        item.setQuantity(currentQty - 1);
                    }
                    break;
                }
            }
            
            // Update session
            session.setAttribute("cart", cart);
            
            // Calculate new cart count
            int qty = 0;
            for (CartItem item : cart) {
                qty += item.getQuantity();
            }
            session.setAttribute("qty", qty);
            
            response.sendRedirect("cart.jsp");
            return;
        }
        
        // If no action, redirect to home
        response.sendRedirect("DisplayProductsServlet");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Long id = Long.valueOf(request.getParameter("id"));
            int qty = 1;

            if (request.getParameter("qty") != null) {
                qty = Integer.parseInt(request.getParameter("qty"));
            }

            if (qty <= 0) qty = 1;

            Product product = pfl.find(id);

            if (product == null) {
                response.sendRedirect("DisplayProductsServlet");
                return;
            }

            HttpSession session = request.getSession();

            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

            if (cart == null) {
                cart = new ArrayList<>();
            }

            boolean found = false;

            for (CartItem item : cart) {
                if (item.getProduct().getId().equals(id)) {
                    item.setQuantity(item.getQuantity() + qty);
                    found = true;
                    break;
                }
            }

            if (!found) {
                CartItem item = new CartItem();
                item.setProduct(product);
                item.setQuantity(qty);
                cart.add(item);
            }

            session.setAttribute("cart", cart);
            
            // Calculate total quantity
            int totalQty = 0;
            for (CartItem item : cart) {
                totalQty += item.getQuantity();
            }
            session.setAttribute("qty", totalQty);

            response.sendRedirect("DisplayProductsServlet");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}