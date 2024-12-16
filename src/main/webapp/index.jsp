<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    String username = (String) session.getAttribute("username");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfume Shop</title>
    <style>
        body {
            margin: 0;
            font-family: 'Arial', sans-serif;
            background-color: #f9f9f9;
            color: #333;
        }

        /* Navbar */
        header {
            background-color: #fff;
            border-bottom: 1px solid #ddd;
            width: 100%;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 100;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
            max-width: 1200px;
            height: 60px;
            margin: auto;
        }

        .navbar .menu {
            display: flex;
            align-items: center;
        }

        .navbar a {
            color: #333;
            text-decoration: none;
            margin: 0 10px;
            font-size: 16px;
            transition: color 0.3s ease;
        }

        .navbar a:hover {
            color: #007BFF;
        }

        .navbar .menu-toggle {
            display: none;
            cursor: pointer;
            font-size: 24px;
        }

        .navbar .user {
            display: flex;
            align-items: center;
        }

        .navbar .logout {
            color: #e63946;
        }

        /* Sidebar */
        .sidebar {
            position: fixed;
            top: 0;
            left: -250px;
            width: 250px;
            height: 100%;
            background-color: #fff;
            border-right: 1px solid #ddd;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            padding: 20px;
            transition: all 0.3s ease;
            z-index: 200;
        }

        .sidebar.open {
            left: 0;
        }

        .sidebar a {
            display: block;
            margin: 10px 0;
            font-size: 16px;
            color: #333;
            text-decoration: none;
        }

        .sidebar a:hover {
            color: #007BFF;
        }

        .sidebar .close-btn {
            display: block;
            margin-bottom: 20px;
            font-size: 24px;
            color: #333;
            cursor: pointer;
        }

        /* Main Content */
        .grid-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            padding: 30px 20px;
            margin: 80px auto 0 auto;
            max-width: 1200px;
        }

        .grid-item {
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            text-align: center;
            padding: 15px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .grid-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .grid-item img {
            width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: 6px;
            margin-bottom: 10px;
        }

        /* Add to Cart Button */
        .add-to-cart {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
            transition: background-color 0.3s ease;
        }

        .add-to-cart:hover {
            background-color: #0056b3;
        }

        footer {
            background-color: #fff;
            border-top: 1px solid #ddd;
            padding: 10px;
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
            color: #555;
        }

        @media (max-width: 768px) {
            .navbar .menu {
                display: none;
            }

            .navbar .menu-toggle {
                display: block;
            }
        }
    </style>
</head>
<body>

<header>
    <div class="navbar">
        <div class="menu-toggle" onclick="toggleSidebar()">☰</div>
        <div class="menu">
            <a href="/">Home</a>
            <a href="seller_dashboard.jsp">Upload</a>
        </div>
        <div class="user">
            <% if (username == null) { %>
            <a class="login" href="login.jsp">Login</a>
            <% } else { %>
            <span><%= username %></span> <a class="logout" href="logout.jsp">Logout</a>
            <% } %>
        </div>
    </div>
</header>

<div class="sidebar" id="sidebar">
    <span class="close-btn" onclick="toggleSidebar()">×</span>
    <a href="/">Home</a>
    <a href="seller_dashboard.jsp">Upload</a>
</div>

<sql:setDataSource var="dataSource"
                   driver="com.mysql.cj.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/zayas?useSSL=false&serverTimezone=UTC"
                   user="root"
                   password="admin" />

<sql:query dataSource="${dataSource}" var="perfumes">
    SELECT p.perfume_id, p.name, p.description, p.price, p.stock_quantity, c.category_name
    FROM Perfumes p
    JOIN Categories c ON p.category_id = c.category_id;
</sql:query>

<div class="grid-container">
    <c:forEach var="perfume" items="${perfumes.rows}">
        <div class="grid-item">
            <img src="/image?id=${perfume.perfume_id}" alt="${perfume.name}" />
            <p><strong>${perfume.name}</strong></p>
            <p>${perfume.description}</p>
            <p><strong>Price: $${perfume.price}</strong></p>
            <p><em>Category: ${perfume.category_name}</em></p>
            <p><em>Stock: ${perfume.stock_quantity}</em></p>

            <!-- Add to Cart Button -->
            <form action="AddCartServlet" method="post">

                <input type="hidden" name="perfume_id" value="${perfume.perfume_id}">
                <input type="hidden" name="name" value="${perfume.name}">
                <input type="hidden" name="price" value="${perfume.price}">
                <input type="hidden" name="quantity" value="${perfume.stock_quantity}">
                <button type="submit" class="add-to-cart">Add to Cart</button>
            </form>
        </div>
    </c:forEach>
</div>

<footer>
    &copy; 2024 Zaya. All rights reserved.
</footer>

<script>
    function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        sidebar.classList.toggle('open');
    }
</script>

</body>
</html>