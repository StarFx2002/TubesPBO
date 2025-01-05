<%@page import="models.Products.Product"%>
<!DOCTYPE html>
<%
    Product product = (Product) request.getAttribute("product");
%>
<html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>MyReuseHub</title>
      <link rel="stylesheet" href="css/buyProduct.css">
      <style>
        /* Hidden overlay initially */
        .popup-overlay {
          position: fixed;
          top: 0;
          left: 0;
          width: 100%;
          height: 100%;
          background: rgba(0, 0, 0, 0.5); /* Dimmed background */
          display: none; /* Initially hidden */
          justify-content: center;
          align-items: center;
          z-index: 1000;
        }

        /* Popup container */
        .popup-container {
          background: white;
          padding: 20px;
          border-radius: 10px;
          width: 90%;
          max-width: 400px;
          text-align: center;
          box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        /* Close button */
        .close-popup {
          position: absolute;
          top: 10px;
          right: 10px;
          background: transparent;
          border: none;
          font-size: 1.5rem;
          cursor: pointer;
          color: #333;
        }

        /* Popup content styles */
        .popup-code {
          font-size: 1.2rem;
          margin: 20px 0;
        }

        .popup-button {
          background: #007bff;
          color: white;
          border: none;
          padding: 10px 20px;
          border-radius: 5px;
          cursor: pointer;
        }

        .popup-button:hover {
          background: #0056b3;
        }

        .payment-success-image {
          max-width: 200px;
          margin: 20px auto;
        }
      </style>
    </head>
    <body>
        <%@ include file="components/header.jsp" %>

        <main>
          <div class="back-container">
            <button class="back-button" onclick="location.href='home'">&#8592;</button>
            <h2><%= product.getName() %></h2>
          </div>

          <!-- Popup Overlay -->
          <div class="popup-overlay" id="popup">
            <div class="popup-container" id="popup-content">
              <button class="close-popup" id="closePopup">&times;</button>
              <h2 id="popup-heading">Your Payment Code</h2>
              <p class="popup-code" id="popup-code"></p>
              <button class="popup-button" id="paidButton">I Have Paid</button>
            </div>
          </div>

          <div class="product-card">
            <div class="image-placeholder">
                <img src="<%= product.getImageURL() %>" alt="<%= product.getName() %>">
            </div>
            <div class="product-info">
                <p class="price">Rp <%= product.getHarga() %></p>
                <p>Stok : <%= product.getKuantitas() %></p>
                <p><%= product.getDeskripsi() %></p>
                <div class="order-details">
                    <p><strong>Detail Pesanan:</strong></p>
                    <label for="quantity">Jumlah</label>
                    <input type="number" id="quantity" name="quantity" required="true" oninput="checkQuantity()" placeholder="Masukkan jumlah">

                    <p>Metode Pembayaran</p>
                    <div class="payment-methods">
                        <button class="payment-button selected" onclick="selectPaymentMethod(this, 'COD')">COD</button>
                        <button class="payment-button" onclick="selectPaymentMethod(this, 'Virtual Account')">Virtual Account</button>
                        <button class="payment-button" onclick="selectPaymentMethod(this, 'Transfer')">Transfer</button>
                        <button class="payment-button" onclick="selectPaymentMethod(this, 'E-Money')">E-Money</button>
                    </div>
                    <input type="hidden" id="paymentMethodInput" name="paymentMethod" value="COD">
                </div>
                <button id="continueButton" class="continue-button" onclick="navigateToPayment()">Continue</button>
            </div>
           </div>
                
           <form id="paymentForm" action="home?b=1" method="post" style="display:none;">
                <input type="hidden" id="paymentMethod" name="paymentMethod">
                <input type="hidden" id="quantityInput" name="quantity">
                <input type="hidden" id="id" name="id" value="<%= product.getIDProduk() %>">
           </form>
        </main>

        <script>
            function generateRandomString(length) {
                const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
                let result = '';
                for (let i = 0; i < length; i++) {
                    const randomIndex = Math.floor(Math.random() * characters.length);
                    result += characters[randomIndex];
                }
                return result;
            }
            
            function checkQuantity() {
                const quantity = document.getElementById('quantity').value;
                const continueButton = document.getElementById('continueButton');
                if (quantity == 0) {
                    // Disable the button and change the text
                    continueButton.disabled = true;
                    continueButton.textContent = 'Continue';
                    continueButton.style.backgroundColor = '#d3d3d3';  // Grey out the button
                } else if (quantity > <%= product.getKuantitas() %>) {
                    // Disable the button and change the text
                    continueButton.disabled = true;
                    continueButton.textContent = 'Stock Insufficient';
                    continueButton.style.backgroundColor = '#d3d3d3';  // Grey out the button
                }   else {
                    // Enable the button and restore the text
                    continueButton.disabled = false;
                    continueButton.textContent = 'Continue';
                    continueButton.style.backgroundColor = '';  // Restore the original button color
                }

                // Update the hidden quantity input
                document.getElementById('quantityInput').value = quantity;
            }
            // Run checkQuantity on page load to handle initial button state
            window.onload = function() {
                checkQuantity();  // Check if the button needs to be greyed out
            };
            
            function selectPaymentMethod(button, method) {
                // Remove 'selected' class from all buttons
                const buttons = document.querySelectorAll('.payment-button');
                buttons.forEach(btn => btn.classList.remove('selected'));

                // Add 'selected' class to the clicked button
                button.classList.add('selected');

                // Save the selected method to the hidden input
                const paymentInput = document.getElementById('paymentMethodInput');
                paymentInput.value = method;
            }
            
            function navigateToPayment() {
                const popup = document.getElementById('popup');
                const paidButton = document.getElementById('paidButton');
                const closePopup = document.getElementById('closePopup');
                const popupHeading = document.getElementById('popup-heading');
                const popupCode = document.getElementById('popup-code');

                popup.style.display = 'flex';
                
                // Generate a random payment code and display it in the popup
                const randomCode = generateRandomString(12); // Generate a 12-character random code
                popupCode.textContent = randomCode; // Set the generated code to the popup

                // When the "I Have Paid" button is clicked, update the popup content and submit the form
                paidButton.addEventListener('click', () => {
                    popupHeading.textContent = 'Your Payment is Completed!';
                    popupCode.innerHTML = ''; // Remove the payment code
                    const successImage = document.createElement('img');
                    successImage.src = 'sukses.png'; // Use the uploaded image (sukses.png)
                    successImage.alt = 'Payment Success';
                    successImage.classList.add('payment-success-image');
                    document.querySelector('#popup-content').appendChild(successImage);
                    paidButton.style.display = 'none'; // Hide the "I Have Paid" button

                    // Populate the hidden fields with the current values
                    document.getElementById('paymentMethod').value = document.getElementById('paymentMethodInput').value;
                    document.getElementById('quantityInput').value = document.getElementById('quantity').value;

                    // Submit the form
                    document.getElementById('paymentForm').submit();
                });

                // Close the popup when the close button is clicked
                closePopup.addEventListener('click', () => {
                    popup.style.display = 'none';
                });
            }
        </script>
    </body>
</html>
