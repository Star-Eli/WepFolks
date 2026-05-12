package web;

import entities.Category;
import entities.ProductFacadeLocal;
import entities.CategoryFacadeLocal;
import entities.Product;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

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
        String idParam = request.getParameter("id");

        // =========================
        // DELETE PRODUCT (FIXED)
        // =========================
        if ("delete".equals(action) && idParam != null) {

    try {
        Long id = Long.parseLong(idParam);

        Product product = pfl.find(id);

        if (product == null) {
            response.sendRedirect("admin.jsp?error=Product not found");
            return;
        }

        // ✅ FIX: facade handles merge + remove properly
        pfl.remove(product);

        HttpSession session = request.getSession();
        session.setAttribute("products", pfl.findAll());

        response.sendRedirect("admin.jsp?success=Product deleted successfully");
        return;

    } catch (Exception e) {
        getServletContext().log("Error deleting product", e);
        e.printStackTrace();
        response.sendRedirect("admin.jsp?error=Delete failed (check logs)");
    }
}

        // =========================
        // EDIT PRODUCT
        // =========================
        else if ("edit".equals(action) && idParam != null) {

            try {
                Long id = Long.parseLong(idParam);

                Product product = pfl.find(id);

                if (product == null) {
                    response.sendRedirect("admin.jsp?error=Product not found");
                    return;
                }

                List<Category> categories = cfl.findAll();

                request.setAttribute("product", product);
                request.setAttribute("categories", categories);

                request.getRequestDispatcher("editProduct.jsp").forward(request, response);

            } catch (Exception e) {
                getServletContext().log("Error loading product for edit", e);
                response.sendRedirect("admin.jsp?error=Unable to load product");
            }
        }

        else {
            response.sendRedirect("admin.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // =========================
        // UPDATE PRODUCT
        // =========================
        if ("update".equals(action)) {

            try {
                Long id = Long.parseLong(request.getParameter("productId"));

                Product product = pfl.find(id);

                if (product == null) {
                    response.sendRedirect("editProduct.jsp?error=Product not found");
                    return;
                }

                // TEXT FIELDS
                product.setName(request.getParameter("name"));
                product.setDescription(request.getParameter("description"));
                product.setPrice(safeDouble(request.getParameter("price")));
                product.setStockQuantity(safeInt(request.getParameter("stockQuantity")));

                // CATEGORY
                Long categoryId = Long.parseLong(request.getParameter("categoryId"));
                Category category = cfl.find(categoryId);

                if (category != null) {
                    product.setCategory(category);
                }

                // IMAGE (safe upload)
                Part imagePart = request.getPart("image");
                if (imagePart != null
                        && imagePart.getSize() > 0
                        && imagePart.getSubmittedFileName() != null) {

                    product.setImage(toByteArray(imagePart.getInputStream()));
                }

                pfl.edit(product);

                HttpSession session = request.getSession();
                session.setAttribute("products", pfl.findAll());

                response.sendRedirect("admin.jsp?success=Product updated successfully");

            } catch (Exception e) {
                getServletContext().log("Error updating product", e);
                response.sendRedirect("editProduct.jsp?error=Update failed");
            }
        }

        else {
            response.sendRedirect("admin.jsp");
        }
    }

    // =========================
    // STREAM → BYTE[]
    // =========================
    private byte[] toByteArray(InputStream inputStream) throws IOException {
        ByteArrayOutputStream buffer = new ByteArrayOutputStream();
        byte[] temp = new byte[8192];
        int bytesRead;

        while ((bytesRead = inputStream.read(temp)) != -1) {
            buffer.write(temp, 0, bytesRead);
        }

        return buffer.toByteArray();
    }

    // =========================
    // SAFE PARSERS
    // =========================
    private double safeDouble(String val) {
        try {
            return Double.parseDouble(val);
        } catch (Exception e) {
            return 0.0;
        }
    }

    private int safeInt(String val) {
        try {
            return Integer.parseInt(val);
        } catch (Exception e) {
            return 0;
        }
    }
}