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
        <p>Toko mu masih sepi, unggah penjualan mu sekarang!</p>
        <a href="home?p=profile&a=1" class="btn btn-primary">Add Barang</a>
      </div>
    </section>
  </main>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>
