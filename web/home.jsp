<%@page import="models.Users.Seller"%>
<%@page import="models.Products.Product"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Homepage - MyReuseHub</title>
    <link rel="stylesheet" href="css/home.css">
</head>
<body>
    <header>
        <div class="logo">
            <h1>MyReuseHub</h1>
        </div>
        <nav>
            <ul class="nav-links">
                <li><a href="" class="active">Home</a></li>
                <li><a href="home?p=payment">Payment</a></li>
                <li><a href="home?p=profile">Profile</a></li>
            </ul>
        </nav>
        <div class="search-bar">
            <input type="text" placeholder="Search...">
        </div>
    </header>

    <section class="intro">
        <h2>Welcome <%= username %>!</h2>
        <p>Explore what we have for you today.</p>
    </section>

    <section class="new-arrivals">
        <h2>New Arrivals</h2>
        <div class="products">
            <% 
                // Retrieve the 'products' attribute from the request
                List<Product> products = (List<Product>) request.getAttribute("products");
                if (products.size() > 0) {
                    for (models.Products.Product product : products) {
                    Seller seller = product.getPemilikProduk();
                    seller.loadUser(seller);
                    String sellerName = seller.getUsername();
            %>
                        <div class="product-item">
                            <img src="<%= product.getImageURL() %>" alt="Product picture">
                            <h3><%= product.getName() %></h3>
                            <p>Price: Rp <%= product.getHarga()%></p>
                            <p>Penjual: <%= sellerName%>️</p>
                            <p> <%= product.getDeskripsi() %></p>
                            <p>⭐️⭐️⭐️⭐️⭐️</p>
                        </div>
            <% 
                    }
                } else { 
            %>
                <p>No products available.</p>
            <% 
                }
            %>
        </div>
    </section>

    <footer>
        <div class="newsletter">
            <input type="email" placeholder="Enter Your Email">
            <button>Subscribe</button>
        </div>
        <div class="footer-info">
            <p>MyReuseHub</p>
            <p>Email: GreenTelyutizen@MyReuseHub.com</p>
            <p>Phone: 999-5578</p>
            <div class="social-media">
                <a href="#">Instagram</a>
                <a href="#">Twitter</a>
                <a href="#">Facebook</a>
            </div>
        </div>
        <p>Copyright © 2024 MyReuseHub</p>
    </footer>
</body>
</html>
