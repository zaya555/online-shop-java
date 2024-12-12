import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;

@WebServlet("/update_perfume_servlet")
public class UpdatePerfumeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the action to be performed (update or delete)
        String action = request.getParameter("action");

        // Database connection details

        Connection connection = null;
        PreparedStatement stmt = null;

        try {
            connection = DatabaseConnection.getConnection();

            if (action.startsWith("update_")) {
                // Update price and stock quantity for the given perfume_id
                int perfumeId = Integer.parseInt(action.substring(7)); // Extract perfume_id
                double price = Double.parseDouble(request.getParameter("price_" + perfumeId));
                int stockQuantity = Integer.parseInt(request.getParameter("stock_quantity_" + perfumeId));

                String sql = "UPDATE Perfumes SET price = ?, stock_quantity = ? WHERE perfume_id = ?";
                stmt = connection.prepareStatement(sql);
                stmt.setDouble(1, price);
                stmt.setInt(2, stockQuantity);
                stmt.setInt(3, perfumeId);
                stmt.executeUpdate();
                response.sendRedirect("seller_dashboard.jsp");

            } else if (action.startsWith("delete_")) {
                // Delete the perfume from the database
                int perfumeId = Integer.parseInt(action.substring(7)); // Extract perfume_id

                String sql = "DELETE FROM Perfumes WHERE perfume_id = ?";
                stmt = connection.prepareStatement(sql);
                stmt.setInt(1, perfumeId);
                stmt.executeUpdate();
                response.sendRedirect("seller_dashboard.jsp");
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Database error: " + ex.getMessage());
            request.getRequestDispatcher("seller_dashboard.jsp").forward(request, response);
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (connection != null) connection.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
