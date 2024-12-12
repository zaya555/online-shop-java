<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<sql:setDataSource var="con"
                   driver="com.mysql.cj.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/zayas"
                   user="root"
                   password="admin" />

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Seller Dashboard</title>
    <style>
        .content { display: none; text-align: center; margin: 20px; }
        .content.active { display: block; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 8px; border: 1px solid #ddd; }
        .menu { margin: 20px 0; }
        .menu-item { padding: 10px; margin: 0 5px; }
    </style>
</head>
<body>

<!-- Menu for navigation -->
<div class="menu">
    <button class="menu-item" onclick="show_content('add_perfume')">Add Perfume</button>
    <button class="menu-item" onclick="show_content('update_perfume')">Update Perfume</button>
    <button class="menu-item" onclick="window.location.href='/'">View Perfumes</button>
    <a href="logout.jsp" class="menu-item">Logout</a>
</div>

<!-- Add Perfume Form -->
<div id="add_perfume" class="content active">
    <h2>Add a New Perfume</h2>
    <form method="post" action="Add_perfume_servlet" enctype="multipart/form-data">
        <div>
            <label for="name">Perfume Name:</label>
            <input type="text" id="name" name="name" required>
        </div>
        <div>
            <label for="description">Description:</label>
            <textarea id="description" name="description" required></textarea>
        </div>
        <div>
            <label for="price">Price:</label>
            <input type="number" id="price" name="price"  required>
        </div>
        <div>
            <label for="stock_quantity">Stock Quantity:</label>
            <input type="number" id="stock_quantity" name="stock_quantity"  required>
        </div>
        <div>
            <label for="category_id">Category:</label>
            <select id="category_id" name="category_id" required>
                <option value="2" selected>Floral</option>
                <option value="3">Woody</option>
                <option value="4">Fruity</option>
                <option value="5">Spicy</option>
            </select>
        </div>
        <label for="image">Image:</label>
        <input type="file" id="image" name="image">

        <button type="submit">Add Perfume</button>
    </form>
</div>

<!-- Update Perfume Prices and Quantities -->
<div id="update_perfume" class="content">
    <h2>Update Perfume</h2>
    <form method="post" action="update_perfume_servlet">
        <table>
            <tr>
                <th>Perfume ID</th>
                <th>Name</th>
                <th>Price</th>
                <th>Stock Quantity</th>
                <th>Actions</th>
            </tr>
            <sql:query dataSource="${con}" var="perfumes">
                SELECT perfume_id, name, price, stock_quantity FROM Perfumes;
            </sql:query>

            <c:forEach var="perfume" items="${perfumes.rows}">
                <tr>
                    <td>${perfume.perfume_id}</td>
                    <td>${perfume.name}</td>
                    <td><input type="number" name="price_${perfume.perfume_id}" value="${perfume.price}" step="0.01" min="0"></td>
                    <td><input type="number" name="stock_quantity_${perfume.perfume_id}" value="${perfume.stock_quantity}" min="0"></td>
                    <td>
                        <button type="submit" name="action" value="update_${perfume.perfume_id}">Update</button>
                        <button type="submit" name="action" value="delete_${perfume.perfume_id}">Delete</button>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </form>
</div>
<% String error = (String) request.getAttribute("error");
    if (error != null) { %>
<p style="color:red;"><%= error %></p>
<% } %>

<script>
    function show_content(content_id) {
        const contents = document.querySelectorAll('.content');
        contents.forEach(content => content.classList.remove('active'));
        document.getElementById(content_id).classList.add('active');
    }
</script>
</body>
</html>
