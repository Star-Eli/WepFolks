package web;

import entities.User;
import entities.UserFacadeLocal;
import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.util.List;

@WebServlet("/AddUserServlet")
@MultipartConfig
public class AddUserServlet extends HttpServlet {

    @EJB
    private UserFacadeLocal ufl;

    // ADD DELETE FUNCTIONALITY
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String userIdParam = request.getParameter("id");
        
        // Handle DELETE action
        if ("delete".equals(action) && userIdParam != null && !userIdParam.isEmpty()) {
            Long userId = Long.parseLong(userIdParam);
            User user = ufl.find(userId);
            
            if (user != null) {
                // Don't allow admin to delete themselves
                HttpSession session = request.getSession();
                User loggedUser = (User) session.getAttribute("user");
                
                if (loggedUser != null && loggedUser.getId().equals(userId)) {
                    response.sendRedirect("admin.jsp?error=You cannot delete your own account");
                    return;
                }
                
                ufl.remove(user);
                
                // Update session users list
                List<User> users = ufl.findAll();
                session.setAttribute("users", users);
                
                response.sendRedirect("admin.jsp?success=User deleted successfully");
            } else {
                response.sendRedirect("admin.jsp?error=User not found");
            }
        } else {
            response.sendRedirect("admin.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get parameters
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = request.getParameter("role");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String province = request.getParameter("province");

            // Validation
            if (name == null || name.trim().isEmpty()) {
                response.sendRedirect("addUser.jsp?error=Name is required");
                return;
            }
            
            if (email == null || email.trim().isEmpty()) {
                response.sendRedirect("addUser.jsp?error=Email is required");
                return;
            }
            
            if (password == null || password.trim().isEmpty()) {
                response.sendRedirect("addUser.jsp?error=Password is required");
                return;
            }
            
            // Check if email already exists
            User existingUser = ufl.findByEmail(email);
            if (existingUser != null) {
                response.sendRedirect("addUser.jsp?error=Email already exists");
                return;
            }

            // Create new user
            User user = new User();
            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setRole(role != null ? role.toUpperCase() : "CUSTOMER");
            user.setAddress(address);
            user.setCity(city);
            user.setProvince(province);

            // Handle image upload (optional)
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                java.io.InputStream inputStream = filePart.getInputStream();
                java.io.ByteArrayOutputStream buffer = new java.io.ByteArrayOutputStream();
                int nRead;
                byte[] data = new byte[1024];
                while ((nRead = inputStream.read(data, 0, data.length)) != -1) {
                    buffer.write(data, 0, nRead);
                }
                buffer.flush();
                user.setImage(buffer.toByteArray());
                inputStream.close();
            }

            // Save to database
            ufl.create(user);
            
            // Update session
            HttpSession session = request.getSession();
            List<User> users = ufl.findAll();
            session.setAttribute("users", users);

            response.sendRedirect("admin.jsp?success=User added successfully");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addUser.jsp?error=Error adding user: " + e.getMessage());
        }
    }
}