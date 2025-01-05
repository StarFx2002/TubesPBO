<%@page import="models.Transactions.Transaction"%>
<%@page import="java.util.List"%>
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
            %>
                        <div class="transaksi-card">
                            <div class="image-placeholder">
                                <img src="<%= transaction.getProduk().getImageURL() %>" alt="<%= transaction.getProduk().getName() %>">
                            </div>
                            <div class="transaksi-info">
                                <h3><%= transaction.getProduk().getName() %></h3>
                                <p>ID Pembayaran: <span class="payment-id"><%= transaction.getIDTransaksi() %></span></p>
                                <p>Harga: <span class="price">Rp <%= transaction.getProduk().getHarga() %></span></p>
                                <p>Rating: 
                                    <span class="rating" id="ratingDisplay">
                                        <%= transaction.getRating() < -1 ? transaction.getRating() : "No rating yet" %>
                                    </span>
                                    <a href="#" id="ratingLink">Give the product a rating!</a>
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
          <button class="popup-button" id="submitRating">Submit</button>
        </div>
      </div>

      <script>
        const ratingLink = document.getElementById('ratingLink');
        const popupRating = document.getElementById('popupRating');
        const closePopup = document.getElementById('closePopup');
        const submitRating = document.getElementById('submitRating');
        const ratingStars = document.getElementById('ratingStars');
        const ratingDisplay = document.getElementById('ratingDisplay');
        let selectedRating = 0;

        // Show the rating popup
        ratingLink.addEventListener('click', function (e) {
            e.preventDefault();
            popupRating.style.display = 'flex';
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

        // Submit the selected rating
        submitRating.addEventListener('click', function () {
            if (selectedRating > 0) {
                const stars = '&#x2B50 '.repeat(selectedRating) + ' '.repeat(5 - selectedRating);
                ratingDisplay.textContent = stars;

                // Save to LocalStorage
                localStorage.setItem('productRating', selectedRating);

                // Close the popup
                popupRating.style.display = 'none';
            }
        });

        // Submit the selected rating
        submitRating.addEventListener('click', function () {
          if (selectedRating > 0) {
            const stars = '&#x2B50 '.repeat(selectedRating) + ' '.repeat(5 - selectedRating);
            ratingDisplay.textContent = stars;  // Save the selected rating to display
            popupRating.style.display = 'none'; // Close the popup
          }
        });
      </script>
    </body>
</html>
