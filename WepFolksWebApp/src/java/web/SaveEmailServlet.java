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

@WebServlet("/SaveEmailServlet")
public class SaveEmailServlet extends HttpServlet {

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

        String email = request.getParameter("email");

        User user = ufl.find(sessionUser.getId());

        user.setEmail(email);

        ufl.edit(user);

        session.setAttribute("user", user);

        response.sendRedirect("profile.jsp");
    }
}