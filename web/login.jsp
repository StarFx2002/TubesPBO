<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MyReuseHub - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
    <div class="split-container">
        <!-- Left Section -->
        <div class="left-section">
            <h1>Hello Shoppers!</h1>
            <p>Welcome to MyReuseHub</p>
            <!-- Login Form -->
            <form action="login" method="post">
                <div class="mb-3">
                    <input type="text" class="form-control" placeholder="email or username" name="username" required>
                </div>
                <div class="mb-3">
                    <input type="password" class="form-control" placeholder="password" name="password" required>
                </div>
                <div class="d-flex justify-content-between mb-3">
                    <a href="#" class="forgot-password">Forgot password?</a>
                </div>
                <button type="submit" class="btn btn-login">Login</button>
                <% 
                    String errorMessage = (String) request.getAttribute("errorMessage");
                    if (errorMessage != null) {
                %>
                <div class="alert alert-danger" role="alert">
                    <%= errorMessage %>
                </div>
                <% 
                    } 
                %>
                <% 
                    String successRgesiter = (String) request.getAttribute("successRgesiter");
                    if (successRgesiter != null) {
                %>
                <div class="alert alert-success" role="alert">
                    <%= successRgesiter %>
                </div>
                <% 
                    } 
                %>
                <% 
                    String failedRgesiter = (String) request.getAttribute("failedRgesiter");
                    if (failedRgesiter != null) {
                %>
                <div class="alert alert-danger" role="alert">
                    <%= failedRgesiter %>
                </div>
                <% 
                    } 
                %>
                <p class="mt-3">
                    Don’t have an account? <a href="register" class="sign-up">Sign Up</a>
                </p>
            </form>
        </div>
        <!-- Right Section -->
        <div class="right-section">
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
