<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">MyWebsite</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#loginSection">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#aboutSection">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#faqSection">FAQ</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container mt-5">
        <div id="loginSection" class="my-5">
            <h2>Login Section</h2>
            <p>This is the login section of the website.</p>
            <a href="login" class="btn btn-primary">Go to Login</a>
        </div>

        <div id="aboutSection" class="my-5">
            <h2>About Us</h2>
            <p>We are a team of passionate developers building great things.</p>
        </div>

        <div id="faqSection" class="my-5">
            <h2>Frequently Asked Questions</h2>
            <ul>
                <li><strong>Q: What is this website about?</strong><br>A: This website is a demo for a home page with navigation.</li>
                <li><strong>Q: How do I contact support?</strong><br>A: You can reach support via our contact form.</li>
            </ul>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
