import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AddCartServlet")
public class AddCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Retrieve the logged-in user's ID from the session
        HttpSession session = request.getSession(false);
        if (session == null) {
            out.println("<p>Error: User not logged in.</p>");
            out.println("<a href='login.jsp'>Please Login</a>");
            return;
        }

        Integer customerId = (Integer) session.getAttribute("userId");
        if (customerId == null) {
            out.println("<p>Error: User ID not found in session.</p>");
            out.println("<a href='login.jsp'>Please Login</a>");
            return;
        }

        int perfumeId = 0;
        int quantity = 0;

        try {
            // Validate and parse perfume_id and quantity
            String perfumeIdParam = request.getParameter("perfume_id");
            String quantityParam = request.getParameter("quantity");

            if (perfumeIdParam == null || perfumeIdParam.isEmpty() || quantityParam == null || quantityParam.isEmpty()) {
                throw new Exception("Perfume ID or quantity is missing.");
            }

            perfumeId = Integer.parseInt(perfumeIdParam);
            quantity = Integer.parseInt(quantityParam);

            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                // Database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/zayas", "root", "admin");

                // Check if the cart exists for the user
                String checkCartQuery = "SELECT cart_id FROM cart WHERE customer_id = ?";
                ps = conn.prepareStatement(checkCartQuery);
                ps.setInt(1, customerId);
                rs = ps.executeQuery();

                int cartId;

                if (rs.next()) {
                    // Cart already exists, get the cart ID
                    cartId = rs.getInt("cart_id");
                } else {
                    // Create a new cart for the user
                    String createCartQuery = "INSERT INTO cart (customer_id, created_at, updated_at) VALUES (?, NOW(), NOW())";
                    ps = conn.prepareStatement(createCartQuery, Statement.RETURN_GENERATED_KEYS);
                    ps.setInt(1, customerId);
                    ps.executeUpdate();
                    rs = ps.getGeneratedKeys();

                    if (rs.next()) {
                        cartId = rs.getInt(1);
                    } else {
                        throw new Exception("Failed to create cart.");
                    }
                }

                // Check if the item is already in the cart
                String checkItemQuery = "SELECT quantity FROM cart_item WHERE cart_id = ? AND perfume_id = ?";
                ps = conn.prepareStatement(checkItemQuery);
                ps.setInt(1, cartId);
                ps.setInt(2, perfumeId);
                rs = ps.executeQuery();

                if (rs.next()) {
                    // Item exists in cart, update quantity
                    int currentQuantity = rs.getInt("quantity");
                    int newQuantity = currentQuantity + 1;

                    String updateItemQuery = "UPDATE cart_item SET quantity = ?, added_at = NOW() WHERE cart_id = ? AND perfume_id = ?";
                    ps = conn.prepareStatement(updateItemQuery);
                    ps.setInt(1, newQuantity);
                    ps.setInt(2, cartId);
                    ps.setInt(3, perfumeId);
                    ps.executeUpdate();
                } else {
                    // Add new item to cart
                    String addItemQuery = "INSERT INTO cart_item (cart_id, perfume_id, quantity, added_at) VALUES (?, ?, ?, NOW())";
                    ps = conn.prepareStatement(addItemQuery);
                    ps.setInt(1, cartId);
                    ps.setInt(2, perfumeId);
                    ps.setInt(3, 1);
                    ps.executeUpdate();
                }

                out.println("<p>Item added to cart successfully!</p>");
                out.println("<a href='index.jsp'>Continue Shopping</a>");
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>There was an error adding the item to the cart: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
            out.println("<a href='index.jsp'>Go Back</a>");
        }
    }
}