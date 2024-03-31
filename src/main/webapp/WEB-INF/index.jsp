<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to Our Portfolio Website</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: linear-gradient(135deg, #2E3192, #1BFFFF);
            overflow: hidden;
        }

        .container {
            text-align: center;
            color: white;
            position: relative;
            z-index: 1;
        }

        h1 {
            font-size: 48px;
            margin-bottom: 20px;
            letter-spacing: 2px;
            animation: slideInLeft 1s ease forwards;
        }

        h2 {
            font-size: 24px;
            margin-bottom: 30px;
            animation: slideInRight 1s ease forwards;
        }

        p {
            font-size: 18px;
            margin-bottom: 30px;
            line-height: 1.6;
            animation: slideInUp 1s ease forwards;
        }

        .btn {
            display: inline-block;
            padding: 15px 30px;
            background-color: #FFD662;
            color: #1BFFFF;
            text-decoration: none;
            border-radius: 25px;
            transition: background-color 0.3s;
            font-size: 16px;
            margin-right: 10px;
            border: none;
            cursor: pointer;
            animation: fadeIn 1s ease forwards;
        }

        .btn:hover {
            background-color: #FEC41E;
        }

        @keyframes slideInLeft {
            from {
                transform: translateX(-100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        @keyframes slideInRight {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        @keyframes slideInUp {
            from {
                transform: translateY(100%);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to Our Portfolio Website</h1>
        <h2>Add your project or view users to hire them.</h2>
        <p>This is a platform to showcase your projects and connect with potential clients or collaborators.</p>
        <a href="login.jsp" class="btn">Login</a>
        <a href="register.jsp" class="btn">Sign Up</a>
    </div>
</body>
</html>
