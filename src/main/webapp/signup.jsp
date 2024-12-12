<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f8f9fa;
        }

        .container {
            display: flex;
            flex-wrap: wrap;
            max-width: 900px;
            background: #ffffff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }

        .left-section {
            flex: 1;
            background-color: #f1f3f5;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px;
        }

        .left-section img {
            max-width: 100%;
            height: auto;
        }

        .right-section {
            flex: 1;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        h2 {
            font-size: 28px;
            margin-bottom: 10px;
            text-align: center;
            color: #333;
        }

        p {
            text-align: center;
            font-size: 14px;
            margin-bottom: 20px;
            color: #666;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        input {
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            width: 100%;
            background-color: #f9f9f9;
        }

        input:focus {
            border-color: #4a90e2;
            outline: none;
            box-shadow: 0 0 5px rgba(74, 144, 226, 0.5);
        }

        input::placeholder {
            color: #aaa;
        }

        button {
            padding: 12px;
            border: none;
            border-radius: 8px;
            background-color: #4a90e2;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease-in-out;
        }

        button:hover {
            background-color: #357abd;
        }

        .links {
            text-align: center;
            font-size: 14px;
            margin-top: 20px;
        }

        .links a {
            color: #4a90e2;
            text-decoration: none;
        }

        .links a:hover {
            text-decoration: underline;
        }

        .divider {
            text-align: center;
            margin: 20px 0;
            font-size: 14px;
            color: #bbb;
        }

        @media (max-width: 768px) {
            .container {
                flex-direction: column;
            }

            .left-section,
            .right-section {
                flex: none;
                width: 100%;
            }

            .left-section {
                padding: 20px;
            }

            .right-section {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="left-section">
        <!-- Replace with your own image -->
        <img src="perfume-login.webp" alt="Illustration">
    </div>
    <div class="right-section">
        <h2>Create an Account</h2>
        <p>Please fill in your details</p>
        <form action="SignupServlet" method="post">
            <input type="text" name="username" placeholder="Enter your username" required>
            <input type="email" name="email" placeholder="Enter your email" required>
            <input type="password" name="password" placeholder="Enter your password" required>
            <input type="password" name="confirmPassword" placeholder="Confirm your password" required>
            <button type="submit">Sign Up</button>
        </form>
        <div class="links">
            <p>Already have an account? <a href="login.jsp">Log In</a></p>
        </div>
    </div>
</div>
</body>
</html>
