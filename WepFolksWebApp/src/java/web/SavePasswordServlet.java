package web;

import entities.User;
import entities.UserFacadeLocal;
import java.io.IOException;
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

@WebServlet("/SavePasswordServlet")
public class SavePasswordServlet extends HttpServlet {

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

        String currentPassword =
                request.getParameter("currentPassword");

        String newPassword =
                request.getParameter("newPassword");

        String confirmPassword =
                request.getParameter("confirmPassword");

        User user = ufl.find(sessionUser.getId());

        /* CHECK CURRENT PASSWORD */

        if (!user.getPassword().equals(currentPassword)) {

            response.getWriter().println("Current password is incorrect");
            return;
        }

        /* CHECK PASSWORD MATCH */

        if (!newPassword.equals(confirmPassword)) {

            response.getWriter().println("Passwords do not match");
            return;
        }

        user.setPassword(newPassword);

        ufl.edit(user);

        session.setAttribute("user", user);

        response.sendRedirect("profile.jsp");
    }
}