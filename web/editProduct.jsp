<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product - MyReuseHub</title>
    <!--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">-->
    <link rel="stylesheet" href="css/editProduct.css">
</head>
<body>
    <div class="main-container">
        <%@ include file="components/header.jsp" %>
        <main class="product-form-container">
            <h1>Edit Product</h1>
            <form class="add-product-form" action="home?p=profile&a=0" method="post" enctype="multipart/form-data">
                <div class="photo-upload">
                    <label for="product-photo" class="photo-placeholder" id="photo-preview-container">
                        <img 
                            id="photo-preview" 
                            src="<%= request.getAttribute("imageUrl") != null ? request.getAttribute("imageUrl") : "#" %>" 
                            alt="Product Preview" 
                            style="<%= request.getAttribute("imageUrl") != null ? "display: block; max-width: 160px; max-height: 160px;" : "display: none;" %>">
                        <span id="photo-placeholder-text" style="<%= request.getAttribute("imageUrl") != null ? "display: none;" : "" %>">+</span>
                    </label>
                    <input type="file" id="product-photo" name="product-photo" accept="image/*" style="display: none;" onchange="previewImage()">
                    <button type="button" onclick="document.getElementById('product-photo').click()">Change Photo</button>
                    <% if (request.getParameter("error") != null && request.getParameter("error").equals("invalid_file_type")) { %>
                        <p class="error">Please upload a valid image file (JPG, PNG, WEBP, or GIF).</p>
                    <% } %>
                    <p style="color: gray">*jpg, png, webp or gif</p>
                </div>
                <div class="form-fields">
                    <input type="hidden" name="id" value="<%= request.getAttribute("id") %>">
                    <label for="product-name">Nama Product</label>
                    <input 
                        type="text" 
                        id="name" 
                        name="name" 
                        placeholder="Type your product's name here..." 
                        value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>" 
                        required>

                    <label for="product-price">Harga Product</label>
                    <input 
                        type="number" 
                        id="price" 
                        name="price" 
                        placeholder="Type your product's price here..." 
                        value="<%= request.getAttribute("price") != null ? request.getAttribute("price") : "" %>" 
                        required>
                    
                    <label for="product-quantity">Quantity</label>
                    <input 
                        type="number" 
                        id="quantity" 
                        name="quantity" 
                        placeholder="Type your quantity here..." 
                        value="<%= request.getAttribute("quantity") != null ? request.getAttribute("quantity") : "" %>" 
                        required>
                    
                    <label for="product-description">Detail Product</label>
                    <textarea 
                        id="description" 
                        name="description" 
                        placeholder="Type your product's details here..." 
                        required><%= request.getAttribute("description") != null ? request.getAttribute("description") : "" %></textarea>
                </div>
                <button type="submit" class="upload-btn">Save Changes</button>
            </form>
        </main>
    </div>
</body>
<script>
    function previewImage() {
        const fileInput = document.getElementById('product-photo');
        const preview = document.getElementById('photo-preview');
        const placeholderText = document.getElementById('photo-placeholder-text');

        if (fileInput.files && fileInput.files[0]) {
            const reader = new FileReader();
            reader.onload = function (e) {
                preview.src = e.target.result;
                preview.style.display = 'block';
                placeholderText.style.display = 'none'; // Hide the "+" text
            };
            reader.readAsDataURL(fileInput.files[0]); // Convert the file to a base64 string
        }
    }
</script>
<!--<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>-->
</html>