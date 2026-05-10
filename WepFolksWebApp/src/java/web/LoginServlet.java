package web;

import entities.Order;
import entities.OrderFacadeLocal;
import entities.Product;
import entities.ProductFacadeLocal;
import entities.User;
import entities.UserFacadeLocal;

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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @EJB
    private UserFacadeLocal ufl;

    @EJB
    private ProductFacadeLocal pfl;

    @EJB
    private OrderFacadeLocal ofl;

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        User user =
                ufl.findByEmail(email);

        /* USER NOT FOUND */

        if (user == null) {

            request.getSession()
                   .setAttribute("error",
                   "User not found.");

            response.sendRedirect("login.jsp");

            return;
        }

        /* WRONG PASSWORD */

        if (!user.getPassword().equals(password)) {

            request.getSession()
                   .setAttribute("error",
                   "Incorrect password.");

            response.sendRedirect("login.jsp");

            return;
        }

        /* SESSION */

        HttpSession session =
                request.getSession(true);

        session.setAttribute("user", user);

        /* CUSTOMER */

        if ("CUSTOMER".equalsIgnoreCase(user.getRole())) {

            int qty = 0;

            session.setAttribute("qty", qty);

            response.sendRedirect("DisplayProductsServlet");

        }

        /* ADMIN */

        else if ("ADMIN".equalsIgnoreCase(user.getRole())) {

            List<User> users =
                    ufl.findAll();

            List<Product> products =
                    pfl.findAll();

            List<Order> orders =
                    ofl.findAll();

            /* SAVE TO SESSION */

            session.setAttribute("users", users);

            session.setAttribute("products", products);

            session.setAttribute("orders", orders);

            response.sendRedirect("admin.jsp");

        }

        /* UNKNOWN ROLE */

        else {

            session.setAttribute("error",
                    "Invalid role.");

            response.sendRedirect("login.jsp");

        }

    }

}