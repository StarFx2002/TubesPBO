<%@page import="java.util.List"%>
<%@page import="models.Products.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>MyReuseHub Profile</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <link rel="stylesheet" href="css/profile.css">
</head>
<body>
  <header>
    <div class="header-container">
      <h1 class="logo">MyReuseHub</h1>
      <nav>
        <ul class="nav-links">
          <li><a href="home">MyHome</a></li>
          <li><a href="home?p=payment">MyPayment</a></li>
          <li><a href="" class="active">MyProfile</a></li>
        </ul>
      </nav>
      <div class="search-bar">
        <input type="text" placeholder="Search">
      </div>
      <a href="logout" class="btn btn-danger">LOGOUT</a>
    </div>
  </header>

  <main>
    <section class="profile-section">
      <div class="profile-header">
        <img src="avatar-placeholder.png" alt="Profile Avatar" class="profile-avatar">
        <h2 class="profile-name"><%= username %></h2>
      </div>
      <div class="profile-actions">
        <div class="action-card">
          <img src="Dompet.png" alt="Belum Bayar">
          <p>Belum Bayar</p>
        </div>
        <div class="action-card">
          <img src="Dikemas.png" alt="Dikemas">
          <p>Dikemas</p>
        </div>
        <div class="action-card">
          <img src="dikirim.png" alt="Dikirim">
          <p>Dikirim</p>
        </div>
        <div class="action-card">
          <img src="rate.png" alt="Beri Penilaian">
          <p>Beri Penilaian</p>
        </div>
      </div>
    <div class="my-store">
        <button class="store-btn">Toko Saya</button>
        <% 
            List<Product> products = (List<Product>) request.getAttribute("soldProducts");
            if (products != null && !products.isEmpty()) {
        %>
            <div class="product-list">
                <% for (Product product : products) { %>
                    <div class="product-card">
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
            <p>Toko mu masih sepi, unggah penjualan mu sekarang!</p>
        <% } %>
        <a href="home?p=profile&a=1" class="btn btn-primary">Add Barang</a>
    </div>
    </section>
  </main>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>
