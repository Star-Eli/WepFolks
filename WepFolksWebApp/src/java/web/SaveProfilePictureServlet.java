/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web;

import entities.User;
import entities.UserFacadeLocal;
import java.io.IOException;
import javax.ejb.EJB;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author Vutomi Nyarhi
 */

@WebServlet("/SaveProfilePictureServlet")
@MultipartConfig
public class SaveProfilePictureServlet extends HttpServlet {

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

        Part filePart = request.getPart("image");

        byte[] imageBytes = null;

        if (filePart != null) {

            imageBytes = new byte[(int) filePart.getSize()];

            filePart.getInputStream().read(imageBytes);
        }


        
            User u = (User)session.getAttribute("user");

            User user = ufl.find(u.getId());

            user.setImage(imageBytes);

            ufl.edit(user);

            session.setAttribute("user", user);

            response.sendRedirect("profile.jsp");

    }
}