<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Login</title>
    <style>
        /* Include your existing CSS here */
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
        <img src="perfume-login.webp" alt="Illustration">
    </div>
    <div class="right-section">
        <h2>Welcome Back</h2>
        <p>Please log in to your account</p>
        <form action="LoginServlet" method="post">
            <input type="email" name="email" placeholder="Enter your email" required>
            <input type="password" name="password" placeholder="Enter your password" required>
            <button type="submit">Log In</button>
        </form>
        <div class="links">
            <p>Don't have an account? <a href="signup.jsp">Sign Up</a></p>
            <p>Forgot your password? <a href="update.jsp">Reset Password</a></p>
        </div>
    </div>
</div>
</body>
</html>
