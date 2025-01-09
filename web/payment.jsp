<%@page import="models.Users.Seller"%>
<%@page import="models.Products.Product"%>
<%@page import="models.Transactions.Transaction"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Transaksi - MyReuseHub</title>
      <link rel="stylesheet" href="css/payment.css">
    </head>
    <body>
       <%@ include file="components/header.jsp" %>

     <main>
        <div class="transaksi-container">
            <%-- Loop through the transactions in reverse order --%>
            <%
                List<Transaction> transactions = (List<Transaction>) request.getAttribute("transactions");
                if (transactions.size() > 0) {
                    for (int i = transactions.size() - 1; i >= 0; i--) {
                        Transaction transaction = transactions.get(i);
                        Product produk = transaction.getProduk();
                        produk.loadProduct();
                        Seller seller = produk.getPemilikProduk();
                        seller.loadUser();
                        transaction.setProduk(produk);
            %>
                        <div class="transaksi-card">
                            <div class="image-placeholder">
                                <img src="<%= transaction.getProduk().getImageURL() %>" alt="<%= transaction.getProduk().getName() %>">
                            </div>
                            <div class="transaksi-info">
                                <h3><%= transaction.getProduk().getName() %></h3>
                                <p>ID Pembayaran: <span class="payment-id"><%= transaction.getIDTransaksi() %></span></p>
                                <p>Harga: <span class="price">Rp <%= transaction.getProduk().getHarga() %></span></p>
                                <p>Penjual: <span class="seller"><%= transaction.getProduk().getPemilikProduk().getUsername() %></span></p>
                                <p>Rating: 
                                    <span class="rating" id="ratingDisplay-<%= transaction.getIDTransaksi() %>">
                                        <%= Math.round(transaction.getRating()) > -1 ? "★".repeat(Math.round(transaction.getRating())) + "☆".repeat(5 - Math.round(transaction.getRating())) : "No rating yet" %>
                                    </span>
                                    <a href="#" class="rating-link" data-transaction-id="<%= transaction.getIDTransaksi() %>">Give the product a rating!</a>
                                </p>
                            </div>
                        </div>
            <%
                    }
                } else {
            %>
            <div class="empty-store">
                <p>Belum pernah beli ya?</p>
                <p>Ayo coba beli barangnya</p>
            </div>
            <% } %>
        </div>
    </main>

      <!-- Rating Popup -->
      <div class="popup-overlay" id="popupRating">
        <div class="popup-container">
            <button class="close-popup" id="closePopup">&times;</button>
            <h2>Give the product a rating!</h2>
            <div class="rating-stars" id="ratingStars">
                <span class="star" data-value="1">&#x2B50</span>
                <span class="star" data-value="2">&#x2B50</span>
                <span class="star" data-value="3">&#x2B50</span>
                <span class="star" data-value="4">&#x2B50</span>
                <span class="star" data-value="5">&#x2B50</span>
            </div>
            <br>
            <input type="hidden" id="transactionId" value="">
            <button class="popup-button" id="submitRating">Submit</button>
        </div>
    </div>

      <script>
        const popupRating = document.getElementById('popupRating');
        const closePopup = document.getElementById('closePopup');
        const submitRating = document.getElementById('submitRating');
        const ratingStars = document.getElementById('ratingStars');
        const ratingDisplay = document.getElementById('ratingDisplay');
        let selectedRating = 0;
        
        document.querySelectorAll('.rating-link').forEach(ratingLink => {
            ratingLink.addEventListener('click', function (e) {
                e.preventDefault();
                const transactionId = this.dataset.transactionId;
                document.getElementById('transactionId').value = transactionId;
                popupRating.style.display = 'flex';
            });
        });

        // Close the popup
        closePopup.addEventListener('click', function () {
            popupRating.style.display = 'none';
        });

        // Handle star selection
        ratingStars.addEventListener('click', function (e) {
            if (e.target.classList.contains('star')) {
                selectedRating = e.target.dataset.value;
                const stars = ratingStars.querySelectorAll('.star');
                stars.forEach(star => {
                    star.style.color = star.dataset.value <= selectedRating ? 'gold' : 'gray';
                });
            }
        });
        
        submitRating.addEventListener('click', function () {
            if (selectedRating > 0) {
                const transactionId = document.getElementById('transactionId').value;
                console.log(JSON.stringify({
                        transactionId: transactionId,
                        rating: selectedRating,
                    }))
                // Send the rating to the server
                fetch('home?p=payment&r=1', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({
                        transactionId: transactionId,
                        rating: selectedRating,
                    }),
                })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            // Update the rating display dynamically
                            const ratingDisplay = document.getElementById(`ratingDisplay-` + transactionId);
                            const stars = '★'.repeat(selectedRating) + '☆'.repeat(5 - selectedRating);
                            ratingDisplay.textContent = stars;
                            popupRating.style.display = 'none';
                        } else {
                            alert('Failed to submit rating. Please try again.');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('An error occurred. Please try again.');
                    });
            }
        });
      </script>
    </body>
</html>
