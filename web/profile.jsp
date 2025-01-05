<%@page import="models.Products.Product"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<% 
    String username = (String) session.getAttribute("username");
%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>MyReuseHub Profile</title>
        <link rel="stylesheet" href="css/profile.css">
    </head>
    <body>
    <%@ include file="components/header.jsp" %>

        <main class="profile-container">
            <section class="profile-header">
                <form id="profile-pic-form">
                    <label for="profile-pic-input">
                        <img src="assets/images/profile_pic.jpg" alt="Profile Picture" class="profile-img" id="profile-pic">
                    </label>
                </form>
                <div class="profile-info">
                    <h2><%= username %></h2>
                    <div class="stats">
                        <span id="followers">Followers</span>
                        <span id="following">Following</span>
                    </div>
                </div>
                <a href="logout" class="logout">
                    <button>Logout</button>
                </a>
                <a href="home?p=profile&a=1" class="tambah-produk-link">
                    <button>Tambah Produk</button>
                </a>
            </section>
            <section class="profile">
                <br>
                <div class="store-title" style="margin-bottom: 40px;">Toko Saya</div>
                <% 
                    List<Product> products = (List<Product>) request.getAttribute("soldProducts");
                    if (products != null && !products.isEmpty()) {
                %>
                    <div class="products" id="productsContainer">
                        <% for (Product product : products) { %>
                            <div class="product-item" data-name="<%= product.getName() %>" >
                                <img src="<%= product.getImageURL() %>" alt="<%= product.getName() %>" class="product-image">
                                <div class="product-details">
                                    <h3><%= product.getName() %></h3>
                                    <p><%= product.getDeskripsi() %></p>
                                    <p>Harga: Rp <%= product.getHarga() %></p>
                                    <p>Stok: <%= product.getKuantitas() %></p>
                                    <div class="product-actions">
                                        <form action="home" method="get" style="display: inline;">
                                            <input type="hidden" name="p" value="profile">
                                            <input type="hidden" name="a" value="0">
                                            <input type="hidden" name="id" value="<%= product.getIDProduk() %>">
                                            <button type="submit" class="btn btn-edit">Edit</button>
                                        </form>
                                        <form action="home?p=profile&a=-1" method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to delete this product?');">
                                            <input type="hidden" name="id" value="<%= product.getIDProduk() %>">
                                            <button type="submit" class="btn btn-delete">Delete</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        <% } %>
                    </div>
                <% 
                    } else { 
                %>
                <div class="empty-store">
                    <p>Wah, toko Anda benar-benar minimalis, ya?</p>
                    <p>Kosong banget!</p>
                </div>
                <% } %>
            </section>
        </main>
        <footer>
            <div class="footer-info">
                <p>Copyright © 2024 MyReuseHub</p>
            </div>
        </footer>

        <script>
            var followers = Math.floor(Math.random() * 10000) + 1; // Between 1 and 1000
            var following = Math.floor(Math.random() * 5000) + 1; 
            function addOne() {
                followers += 1;
                document.getElementById("followers").textContent = followers + " Followers";
                document.getElementById("following").textContent =  following + " Following";
            }
            addOne();

            // Optional: Refresh stats every 5 seconds (example)
            setInterval(addOne, 5000);
            
            
            // Fungsi untuk membuka pop-up
            function openPopup(image, title, price) {
                document.getElementById('popup-image').src = image;
                document.getElementById('popup-title').innerText = title;
                document.getElementById('popup-price').innerText = price;
                document.getElementById('popup').style.display = 'flex';
            }

            // Fungsi untuk menutup pop-up
            function closePopup() {
                document.getElementById('popup').style.display = 'none';
            }

            // Fungsi untuk redirect ke halaman product_info.html
            function redirectToProduct() {
                window.location.href = 'product_info.html';
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
    </body>
</html>
