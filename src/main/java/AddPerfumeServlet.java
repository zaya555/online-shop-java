import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;

@WebServlet("/Add_perfume_servlet")
@MultipartConfig(
        fileSizeThreshold = 1024 *1024 * 2,
        maxFileSize = 1024 * 1024*10,
        maxRequestSize = 1024*1024 *50
)
public class AddPerfumeServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String stockQuantityStr = request.getParameter("stock_quantity");
        String categoryIdStr = request.getParameter("category_id");

        // Log the received parameters for debugging purposes
        System.out.println("Received parameters:");
        System.out.println("Name: " + name);
        System.out.println("Description: " + description);
        System.out.println("Price: " + priceStr);
        System.out.println("Stock Quantity: " + stockQuantityStr);
        System.out.println("Category ID: " + categoryIdStr);

        // Validate form data: Check for missing or empty fields
        if (name == null || name.isEmpty() || description == null || description.isEmpty() ||
                priceStr == null || priceStr.isEmpty() || stockQuantityStr == null || stockQuantityStr.isEmpty() ||
                categoryIdStr == null || categoryIdStr.isEmpty()) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("seller_dashboard.jsp").forward(request, response);
            return;
        }

        // Parse price, stock quantity, and category ID. Ensure they are valid integers.
        int price = 0;
        int stockQuantity = 0;
        int categoryId = 0;

        try {
            // Check if the price is a valid integer
            if (priceStr.matches("\\d+")) {
                price = Integer.parseInt(priceStr);
            } else {
                throw new NumberFormatException("Invalid price format.");
            }

            // Check if stock quantity is a valid integer
            if (stockQuantityStr.matches("\\d+")) {
                stockQuantity = Integer.parseInt(stockQuantityStr);
            } else {
                throw new NumberFormatException("Invalid stock quantity format.");
            }

            // Check if category ID is a valid integer
            if (categoryIdStr.matches("\\d+")) {
                categoryId = Integer.parseInt(categoryIdStr);
            } else {
                throw new NumberFormatException("Invalid category ID format.");
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid number format: " + e.getMessage());
            request.getRequestDispatcher("seller_dashboard.jsp").forward(request, response);
            return;
        }

        // Handle image upload (if any)
        Part imagePart = request.getPart("image");
        byte[] imageData = null;

        if (imagePart != null && imagePart.getSize() > 0) {
            InputStream imageInputStream = imagePart.getInputStream();
            imageData = new byte[imageInputStream.available()];
            imageInputStream.read(imageData);
            imageInputStream.close();
        }

        // SQL query to insert perfume into the database
        String sql = "INSERT INTO Perfumes (name, description, price, stock_quantity, category_id, image) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, name);
            stmt.setString(2, description);
            stmt.setInt(3, price);
            stmt.setInt(4, stockQuantity);
            stmt.setInt(5, categoryId);

            // Set the image as BLOB
            if (imageData != null) {
                stmt.setBytes(6, imageData);
            } else {
                stmt.setNull(6, Types.BLOB);
            }

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("seller_dashboard.jsp");
            } else {
                request.setAttribute("error", "Failed to add perfume!");
                request.getRequestDispatcher("seller_dashboard.jsp").forward(request, response);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Database error: " + ex.getMessage());
            request.getRequestDispatcher("seller_dashboard.jsp").forward(request, response);
        }
    }
}
