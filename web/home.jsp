<%@page import="models.Transactions.Transaction"%>
<%@page import="models.Users.Seller"%>
<%@page import="java.util.List"%>
<%@page import="models.Products.Product"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Homepage - MyReuseHub</title>
        <link rel="stylesheet" href="css/home.css">
    </head>
    
    <body>
        <%@ include file="components/header.jsp" %>
        <div class="product-container">
            <section class="intro">
                <h2>Welcome Telyutizen!</h2>
                <p>Explore what we have for you today.</p>
            </section>

            <section class="new-arrivals">
                <h2>New Arrivals</h2>
                <div class="products" id="productsContainer">
                    <% 
                        // Retrieve the 'products' attribute from the request
                        List<Product> products = (List<Product>) request.getAttribute("products");
                        List<Transaction> transactions = (List<Transaction>) request.getAttribute("transactions"); // All transactions

                        if (products != null && products.size() > 0) {
                            for (Product product : products) {
                                if (product.getKuantitas() < 1) continue;
                                if (product.getDeleted()) continue;
                                Seller seller = product.getPemilikProduk();
                                seller.loadUser();

                                // Calculate the average rating for the product
                                double totalRating = 0;
                                int count = 0;
                                for (Transaction transaction : transactions) {
                                    if (transaction.getProduk().getIDProduk() == product.getIDProduk()) {
                                        if (transaction.getRating() > -1) { // Only consider valid ratings
                                            totalRating += transaction.getRating();
                                            count++;
                                        }
                                    }
                                }

                                double avgRating = (count > 0) ? totalRating / count : -1; // Calculate average rating
                                int fullStars = (int) avgRating;
                                int emptyStars = 5 - fullStars;
                    %>
                                <div class="product-item" data-name="<%= product.getName() %>" onclick="openPopup('<%= product.getIDProduk() %>', <%= product.getPemilikProduk().getUserId() %>, '<%= product.getImageURL() %>', '<%= product.getName() %>', 'Rp <%= product.getHarga()%>')">
                                    <img src="<%= product.getImageURL() %>" alt="Product Image">
                                    <h3><%= product.getName() %></h3>
                                    <p>Yang jualan : <%= product.getPemilikProduk().getUsername() %></p>
                                    <p>Rp. <%= product.getHarga() %></p>

                                    <!-- Display average rating as stars -->
                                    <p>Rating: 
                                        <% 
                                            if (avgRating > -1) {
                                                // Display full stars
                                                for (int i = 0; i < fullStars; i++) {
                                                    out.print("&#x2B50;"); // Full Star
                                                }
                                                // Display empty stars
                                                for (int i = 0; i < emptyStars; i++) {
                                                    out.print("&#9734;"); // Empty Star
                                                }
                                            } else {
                                                out.print("No ratings yet");
                                            }
                                        %>
                                    </p>
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
        </div>

        <!-- Pop-Up -->
        <div class="popup-overlay" id="popup">
            <div class="popup-content">
                <img id="popup-image" src="" alt="Product Image">
                <h3 id="popup-title"></h3>
                <p id="popup-price"></p>
                <!--<button class="buy-now" onclick="redirectToProduct()">Beli Sekarang</button>-->
                <form action="home" method="get" style="display: inline;">
                    <input type="hidden" name="b" value="1">
                    <input type="hidden" name="id" value="0">
                    <button type="submit" class="buy-now" id="buy-now-button">Beli Sekarang!</button>
                </form>
                <button class="close-popup" onclick="closePopup()">Tutup</button>
            </div>
        </div>
    </body>

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
                <a href="https://instagram.com/aktsar2002">Instagram</a>
                <a href="https://youtube.com/@aktsarlive">Youtube</a>
                <a href="https://x.com/aktsar2002">Twitter</a>
            </div>
        </div>
        <p>Copyright © 2024 MyReuseHub</p>
    </footer>
    
    <script>
        const buyerId = <%= session.getAttribute("id") %>
        
        // Fungsi untuk membuka pop-up
        function openPopup(productId, sellerId, image, title, price) {
            document.getElementById('popup-image').src = image;
            document.getElementById('popup-title').innerText = title;
            document.getElementById('popup-price').innerText = price;
            document.getElementById('popup').style.display = 'flex';
            const idInput = popup.querySelector('input[name="id"]');
            idInput.value = productId;
            
            console.log(buyerId)
            console.log(sellerId)
            // Disable "Beli Sekarang!" button if the product is sold by the logged-in user
            if (sellerId == buyerId) {
                document.getElementById('buy-now-button').disabled = true;
                document.getElementById('buy-now-button').innerText = 'You cannot buy your own product';
            } else {
                document.getElementById('buy-now-button').disabled = false; // Enable the button if not the same user
                document.getElementById('buy-now-button').innerText = 'Beli Sekarang!'; // Reset the button text
            }
        }

        // Fungsi untuk menutup pop-up
        function closePopup() {
            document.getElementById('popup').style.display = 'none';
        }

        // Fungsi untuk redirect ke halaman product_info.html
        function redirectToProduct() {
            window.location.href = 'home?b=1';
        }

        document.getElementById('search-bar').addEventListener('input', function (event) {
            const searchTerm = event.target.value.toLowerCase(); // Get the input value in lowercase
            const products = document.querySelectorAll('#productsContainer .product-item'); // Select all product items

            products.forEach(product => {
                const productName = product.getAttribute('data-name').toLowerCase(); // Get the product name in lowercase
                if (productName.includes(searchTerm)) {
                    product.style.display = ''; // Show the product if it matches the search term
                } else {
                    product.style.display = 'none'; // Hide the product if it doesn't match
                }
            });
        });
    </script>
</html>
