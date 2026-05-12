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

        HttpSession session = request.getSession(true);

        /* =========================
           1. CHECK LOCK STATUS
        ========================== */
        Long lockTime = (Long) session.getAttribute("lockTime");

        if (lockTime != null) {
            long now = System.currentTimeMillis();

            // 3 minutes = 180000 ms
            if (now - lockTime < 180000) {
                request.setAttribute("error",
                        "Account locked. Try again after 3 minutes.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            } else {
                session.removeAttribute("lockTime");
                session.setAttribute("attemptCount", 0);
            }
        }

        /* =========================
           2. GET INPUT
        ========================== */
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = ufl.findByEmail(email);

        /* =========================
           3. GET ATTEMPTS
        ========================== */
        Integer attempts = (Integer) session.getAttribute("attemptCount");
        if (attempts == null) {
            attempts = 0;
        }

        /* =========================
           4. USER NOT FOUND
        ========================== */
        if (user == null) {

            attempts++;
            session.setAttribute("attemptCount", attempts);

            if (attempts >= 3) {
                session.setAttribute("lockTime", System.currentTimeMillis());
                request.setAttribute("error",
                        "Too many failed attempts. Locked for 3 minutes.");
            } else {
                request.setAttribute("error", "User not found.");
            }

            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        /* =========================
           5. WRONG PASSWORD
        ========================== */
        if (!user.getPassword().equals(password)) {

            attempts++;
            session.setAttribute("attemptCount", attempts);

            if (attempts >= 3) {
                session.setAttribute("lockTime", System.currentTimeMillis());
                request.setAttribute("error",
                        "Too many failed attempts. Locked for 3 minutes.");
            } else {
                request.setAttribute("error", "Incorrect password.");
            }

            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        /* =========================
           6. SUCCESS LOGIN
        ========================== */
        session.setAttribute("attemptCount", 0);
        session.removeAttribute("lockTime");

        session.setAttribute("user", user);

        /* =========================
           7. ROLE HANDLING
        ========================== */

        if ("CUSTOMER".equalsIgnoreCase(user.getRole())) {

            session.setAttribute("qty", 0);
            response.sendRedirect("DisplayProductsServlet");

        } else if ("ADMIN".equalsIgnoreCase(user.getRole())) {

            session.setAttribute("users", ufl.findAll());
            session.setAttribute("products", pfl.findAll());
            session.setAttribute("orders", ofl.findAll());

            response.sendRedirect("admin.jsp");

        } else {

            request.setAttribute("error", "Invalid role.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}