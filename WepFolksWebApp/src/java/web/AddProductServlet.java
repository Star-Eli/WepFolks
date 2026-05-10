package web;

import entities.Category;
import entities.CategoryFacadeLocal;
import entities.Product;
import entities.ProductFacadeLocal;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.servlet.http.HttpSession;

@MultipartConfig
public class AddProductServlet extends HttpServlet {

    @EJB
    private ProductFacadeLocal pfl;

    @EJB
    private CategoryFacadeLocal cfl;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Load all categories from database
        List<Category> categories = cfl.findAll();
        
        // Store categories in request attribute
        request.setAttribute("categories", categories);
        
        // Forward to addProduct.jsp
        request.getRequestDispatcher("addProduct.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            Double price = Double.parseDouble(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stockQuantity"));

            String categoryOption = request.getParameter("categoryOption");
            Category category = null;
            
            // Check if user wants to select existing category or create new one
            if ("existing".equals(categoryOption)) {
                String categoryIdParam = request.getParameter("categoryId");
                if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
                    Long categoryId = Long.parseLong(categoryIdParam);
                    category = cfl.find(categoryId);
                }
            } else if ("new".equals(categoryOption)) {
                String newCategoryName = request.getParameter("newCategoryName");
                
                if (newCategoryName != null && !newCategoryName.trim().isEmpty()) {
                    // CHECK IF CATEGORY ALREADY EXISTS
                    Category existingCategory = checkIfCategoryExists(newCategoryName.trim());
                    
                    if (existingCategory != null) {
                        // Category already exists, use existing one
                        category = existingCategory;
                        // Set error message but still proceed
                        request.getSession().setAttribute("message", "Category already exists! Using existing category: " + existingCategory.getName());
                    } else {
                        // Create new category
                        category = new Category();
                        category.setName(newCategoryName.trim());
                        cfl.create(category);
                    }
                }
            }

            // Check if category exists
            if (category == null) {
                response.sendRedirect("AddProductServlet.do?error=Please select or create a category");
                return;
            }

            // IMAGE
            Part filePart = request.getPart("image");
            byte[] imageBytes = null;

            if (filePart != null && filePart.getSize() > 0) {
                InputStream input = filePart.getInputStream();
                imageBytes = new byte[(int) filePart.getSize()];
                input.read(imageBytes);
                input.close();
            }

            // CREATE PRODUCT
            Product product = new Product();
            product.setName(name);
            product.setDescription(description);
            product.setPrice(price);
            product.setStockQuantity(stock);
            product.setCategory(category);
            product.setImage(imageBytes);

            pfl.create(product);
            
            // Update session products list
            HttpSession session = request.getSession();
            List<Product> products = pfl.findAll();
            session.setAttribute("products", products);
            
            // Get any message from session
            String message = (String) session.getAttribute("message");
            if (message != null) {
                session.removeAttribute("message");
                response.sendRedirect("admin.jsp?success=Product added successfully&message=" + message);
            } else {
                response.sendRedirect("admin.jsp?success=Product added successfully");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AddProductServlet.do?error=1");
        }
    }
    
    // Method to check if category already exists (case-insensitive)
    private Category checkIfCategoryExists(String categoryName) {
        List<Category> allCategories = cfl.findAll();
        
        for (Category cat : allCategories) {
            if (cat.getName().equalsIgnoreCase(categoryName)) {
                return cat; // Category already exists
            }
        }
        return null; // Category doesn't exist
    }
}