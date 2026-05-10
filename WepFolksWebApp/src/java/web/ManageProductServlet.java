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
public class ManageProductServlet extends HttpServlet {

    @EJB
    private ProductFacadeLocal pfl;
    
    @EJB
    private CategoryFacadeLocal cfl;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String productIdParam = request.getParameter("id");
        
        // Handle DELETE action
        if ("delete".equals(action) && productIdParam != null && !productIdParam.isEmpty()) {
            Long productId = Long.parseLong(productIdParam);
            Product product = pfl.find(productId);
            
            if (product != null) {
                pfl.remove(product);
                
                // Update session
                HttpSession session = request.getSession();
                List<Product> products = pfl.findAll();
                session.setAttribute("products", products);
                
                response.sendRedirect("admin.jsp?success=Product deleted successfully");
            } else {
                response.sendRedirect("admin.jsp?error=Product not found");
            }
        } 
        // Handle EDIT action - show edit form
        else if ("edit".equals(action) && productIdParam != null && !productIdParam.isEmpty()) {
            Long productId = Long.parseLong(productIdParam);
            Product product = pfl.find(productId);
            List<Category> categories = cfl.findAll();
            
            request.setAttribute("product", product);
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("editProduct.jsp").forward(request, response);
        } 
        else {
            response.sendRedirect("admin.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        // Handle UPDATE action
        if ("update".equals(action)) {
            try {
                Long productId = Long.parseLong(request.getParameter("productId"));
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                Double price = Double.parseDouble(request.getParameter("price"));
                int stock = Integer.parseInt(request.getParameter("stockQuantity"));
                
                // Find existing product
                Product product = pfl.find(productId);
                
                // Update category
                String categoryOption = request.getParameter("categoryOption");
                Category category = null;
                
                if ("existing".equals(categoryOption)) {
                    Long categoryId = Long.parseLong(request.getParameter("categoryId"));
                    category = cfl.find(categoryId);
                } else if ("new".equals(categoryOption)) {
                    String newCategoryName = request.getParameter("newCategoryName");
                    if (newCategoryName != null && !newCategoryName.trim().isEmpty()) {
                        // Check if category already exists
                        List<Category> allCategories = cfl.findAll();
                        Category existingCategory = null;
                        for (Category cat : allCategories) {
                            if (cat.getName().equalsIgnoreCase(newCategoryName.trim())) {
                                existingCategory = cat;
                                break;
                            }
                        }
                        
                        if (existingCategory != null) {
                            category = existingCategory;
                        } else {
                            category = new Category();
                            category.setName(newCategoryName.trim());
                            cfl.create(category);
                        }
                    }
                }
                
                // Update image if new one is uploaded
                Part filePart = request.getPart("image");
                byte[] imageBytes = null;
                
                if (filePart != null && filePart.getSize() > 0) {
                    InputStream input = filePart.getInputStream();
                    imageBytes = new byte[(int) filePart.getSize()];
                    input.read(imageBytes);
                    input.close();
                    product.setImage(imageBytes);
                }
                
                // Update product details
                product.setName(name);
                product.setDescription(description);
                product.setPrice(price);
                product.setStockQuantity(stock);
                if (category != null) {
                    product.setCategory(category);
                }
                
                pfl.edit(product);
                
                // Update session
                HttpSession session = request.getSession();
                List<Product> products = pfl.findAll();
                session.setAttribute("products", products);
                
                response.sendRedirect("admin.jsp?success=Product updated successfully");
                
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("editProduct.jsp?error=1");
            }
        } else {
            response.sendRedirect("admin.jsp");
        }
    }
}