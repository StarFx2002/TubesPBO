<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MyReuseHub - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="css/register.css">
</head>
<body>
    <div class="split-container">
        <!-- Left Section -->
        <div class="left-section">
            <h1>Hello Shoppers!</h1>
            <p>Welcome to MyReuseHub</p>
            <!-- Login Form -->
            <form action="register" method="post">
                <div class="mb-3">
                    <input type="text" class="form-control" placeholder="email" name="email" required>
                </div>
                <div class="mb-3">
                    <input type="text" class="form-control" placeholder="username" name="username" required>
                </div>
                <div class="mb-3">
                    <input type="text" class="form-control" placeholder="address" name="address" required>
                </div>
                <div class="mb-3">
                    <input type="number" class="form-control" placeholder="phone number" name="phoneNumber" required>
                </div>
                <div class="mb-3">
                    <input type="password" class="form-control" placeholder="password" name="password" required>
                </div>
                <button type="submit" class="btn btn-login">Register</button>
            </form>
        </div>

        <!-- Right Section -->
        <div class="right-section">
            <!-- Background image set in CSS -->
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
