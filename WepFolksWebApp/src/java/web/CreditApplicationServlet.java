package web;

import entities.User;
import entities.UserFacadeLocal;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/CreditApplicationServlet")
@MultipartConfig
public class CreditApplicationServlet extends HttpServlet {

    @EJB
    private UserFacadeLocal ufl;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        request.getRequestDispatcher("creditApplication.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            // =========================
            // FORM DATA
            // =========================
            String employmentStatus = request.getParameter("employmentStatus");
            String monthlyIncome = request.getParameter("monthlyIncome");

            double requestedAmount = safeDouble(request.getParameter("requestedAmount"));

            if (requestedAmount <= 0) {
                response.sendRedirect("creditApplication.jsp?error=Invalid amount");
                return;
            }

            // =========================
            // FILE UPLOAD (SAFE)
            // =========================
            Part filePart = request.getPart("bankStatement");
            byte[] bankStatement = null;

            if (filePart != null && filePart.getSize() > 0) {
                bankStatement = toByteArray(filePart.getInputStream());
            }

            // =========================
            // CREDIT CALCULATION
            // =========================
            double creditLimit = calculateCreditLimit(monthlyIncome, employmentStatus);

            // =========================
            // UPDATE USER
            // =========================
            user.setEmploymentStatus(employmentStatus);
            user.setMonthlyIncome(monthlyIncome);
            user.setCreditLimit(creditLimit);

            // IMPORTANT FIX: no setCreditAvailable in your entity
            user.setCreditUsed(0);

            // safer initial status
            user.setCreditStatus("PENDING");

            ufl.edit(user);
            session.setAttribute("user", user);

            response.sendRedirect("creditApproved.jsp?approved=true&limit=" + creditLimit);

        } catch (Exception e) {
            getServletContext().log("Credit application error", e);
            response.sendRedirect("creditApplication.jsp?error=Application failed");
        }
    }

    // =========================
    // CREDIT CALCULATION LOGIC
    // =========================
    private double calculateCreditLimit(String monthlyIncome, String employmentStatus) {

        double income = parseIncome(monthlyIncome);

        double limit = income * 3;

        if ("EMPLOYED".equals(employmentStatus)) {
            limit = limit;
        } else if ("SELF_EMPLOYED".equals(employmentStatus)) {
            limit = limit * 0.8;
        } else if ("STUDENT".equals(employmentStatus)) {
            limit = limit * 0.3;
        } else {
            limit = limit * 0.5;
        }

        return Math.min(limit, 50000);
    }

    // =========================
    // INCOME PARSER (SAFE)
    // =========================
    private double parseIncome(String monthlyIncome) {

        if (monthlyIncome == null) return 0;

        if (monthlyIncome.contains("5000-10000")) return 7500;
        if (monthlyIncome.contains("10000-15000")) return 12500;
        if (monthlyIncome.contains("15000-20000")) return 17500;
        if (monthlyIncome.contains("20000-30000")) return 25000;
        if (monthlyIncome.contains("30000+")) return 40000;

        return 0;
    }

    // =========================
    // SAFE DOUBLE PARSER
    // =========================
    private double safeDouble(String value) {
        try {
            return Double.parseDouble(value);
        } catch (Exception e) {
            return 0;
        }
    }

    // =========================
    // INPUTSTREAM → BYTE[]
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
}