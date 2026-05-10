package web;

import entities.User;
import entities.UserFacadeLocal;
import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/CheckOutSaveAddressServlet")
public class CheckOutSaveAddressServlet extends HttpServlet {

    @EJB
    private UserFacadeLocal ufl;

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User sessionUser = (User) session.getAttribute("user");

        if (sessionUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Form data
        String province = request.getParameter("province");
        String city = request.getParameter("city");
        String address = request.getParameter("address");

        // Basic validation
        if (province == null || city == null || address == null ||
            province.trim().isEmpty() ||
            city.trim().isEmpty() ||
            address.trim().isEmpty()) {

            session.setAttribute("message", "Please fill in all required fields.");
            response.sendRedirect("checkoutAddress.jsp");
            return;
        }

        // Load user from DB
        User user = ufl.find(sessionUser.getId());

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Update fields
        user.setProvince(province);
        user.setCity(city);
        user.setAddress(address);

        // Save to DB
        ufl.edit(user);

        // Update session
        session.setAttribute("user", user);

        // Optional message
        session.setAttribute("message", "Address saved successfully!");

        // NEXT STEP
        response.sendRedirect("cardPayment.jsp");
    }
}