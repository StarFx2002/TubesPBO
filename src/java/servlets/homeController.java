/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.BufferedReader;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.Scanner;
import java.util.UUID;
import models.Products.Product;
import models.Transactions.Transaction;
import models.Users.Buyer;
import models.Users.Seller;
import utilities.JDBC;
import java.sql.*;

/**
 *
 * @author aktsa_wi2suow
 */
@WebServlet(name = "home", urlPatterns = {"/home"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2 MB
    maxFileSize = 1024 * 1024 * 10,      // 10 MB
    maxRequestSize = 1024 * 1024 * 50    // 50 MB
)
public class homeController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("home_page.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession homeSession = request.getSession(false);
        if (homeSession == null || homeSession.getAttribute("username") == null) {
            response.sendRedirect("login"); // Redirect to login if not logged in
            return;
        }
        
        String menu = request.getParameter("p");
        String addR = request.getParameter("a");
        String buyR = request.getParameter("b");
        
        if (buyR != null) {
            int buy = Integer.parseInt(buyR);
            if (buy == 1) {
                int id = Integer.parseInt(request.getParameter("id"));
                Product buyProduct = new Product();
                buyProduct.setIDProduk(id);
                buyProduct.loadProduct();

                request.setAttribute("product", buyProduct);
                request.getRequestDispatcher("buyProduct.jsp").forward(request, response);
                return;
            }
        }
        
        
        if (menu != null) {
            if (menu.equals("payment")) {
                int buyerId = (int) homeSession.getAttribute("id");
                Buyer buyer = new Buyer();
                buyer.setUserId(buyerId);
                List<Transaction> transactions = buyer.listPembelian();
                request.setAttribute("transactions", transactions);
                request.getRequestDispatcher("payment.jsp").forward(request, response);
                return;
            }
            if (menu.equals("profile")) {
                if (addR != null) {
                    int add = Integer.parseInt(addR);
                    if (add == 0) {
                        int id = Integer.parseInt(request.getParameter("id"));
                        Product editProduct = new Product();
                        editProduct.setIDProduk(id);
                        editProduct.loadProduct();
                        
                        int sellerId = (int) homeSession.getAttribute("id");
                        if (editProduct.getPemilikProduk().getUserId() == sellerId) {
                            request.setAttribute("id", id);
                            request.setAttribute("name", editProduct.getName());
                            request.setAttribute("price", editProduct.getHarga());
                            request.setAttribute("quantity", editProduct.getKuantitas());
                            request.setAttribute("description", editProduct.getDeskripsi());
                            request.setAttribute("imageUrl", editProduct.getImageURL());
                            request.getRequestDispatcher("editProduct.jsp").forward(request, response);
                        } else {
                            // Handle unauthorized access (e.g., redirect to error page)
                            response.sendRedirect("error.jsp?message=Unauthorized access");
                        }
                        return;
                    }
                    if (add == 1) {
                        request.getRequestDispatcher("addProduct.jsp").forward(request, response);
                        return;
                    }
                }
                int sellerId = (int) homeSession.getAttribute("id");
                Seller seller = new Seller();
                seller.setUserId(sellerId);
                List<Product> soldProducts = seller.listProduk();
                request.setAttribute("soldProducts", soldProducts);
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }
        }
        
        Product prod = new Product();
        Transaction trans = new Transaction();
        List<Product> products = prod.getAllProducts();
        List<Transaction> transactions = trans.getAllTransactions();
        request.setAttribute("products", products);
        request.setAttribute("transactions", transactions);
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession homeSession = request.getSession(false);
        if (homeSession == null || homeSession.getAttribute("username") == null) {
            response.sendRedirect("login"); // Redirect to login if not logged in
            return;
        }
        
        String menu = request.getParameter("p");
        String addR = request.getParameter("a");
        String buyR = request.getParameter("b");
        
        if (buyR != null) {
            int buy = Integer.parseInt(buyR);
            if (buy == 1) {
                int id = Integer.parseInt(request.getParameter("id"));
                String payment = request.getParameter("paymentMethod");
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                
                int userId = (int) homeSession.getAttribute("id");
                Buyer buyer = new Buyer();
                buyer.setUserId(userId);
                
                Product buyProduct = new Product();
                buyProduct.setIDProduk(id);
                buyProduct.loadProduct();

                buyer.beliProduk(buyProduct, quantity, payment);
                response.sendRedirect("home?p=payment");
                return;
            }
        }
        
        if (menu != null) {
            if (menu.equals("profile")) {
                if (addR != null) {
                    int add = Integer.parseInt(addR);
                    if (add == -1) {
                        int id = Integer.parseInt(request.getParameter("id"));
                        int sellerId = (int) homeSession.getAttribute("id");
                        Seller seller = new Seller();
                        seller.setUserId(sellerId);
                        Product delProduct = new Product();
                        delProduct.setIDProduk(id);
                        seller.hapusProduk(delProduct);
                        
                    }
                    if (add == 0) {
                        int id = (int) homeSession.getAttribute("id");
                        Seller seller = new Seller();
                        seller.setUserId(id);

                        // Retrieve product details from the form
                        int productId = Integer.parseInt(getPartValue(request.getPart("id")));
                        String name = getPartValue(request.getPart("name"));
                        Double price = Double.valueOf(getPartValue(request.getPart("price")));
                        int quantity = Integer.parseInt(getPartValue(request.getPart("quantity")));
                        String description = getPartValue(request.getPart("description"));
                        Part photoPart = request.getPart("product-photo");

                        // Check if a new photo is uploaded
                        String fileName = photoPart.getSubmittedFileName();
                        String imageUrl = null;
                        if (fileName != null && !fileName.isEmpty()) {
                            // Pre-process the uploaded file
                            String fileExtension = getFileExtension(fileName);
                            String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

                            InputStream fileContent = photoPart.getInputStream();
                            String contentType = photoPart.getContentType();
                            if (!isImageContentType(contentType)) {
                                request.setAttribute("error", "invalid_file_type");
                                request.getRequestDispatcher("editProduct.jsp").forward(request, response);
                                return;
                            }

                            // Save the file to the specified folder
                            String uploadPath = getServletContext().getRealPath("") + File.separator + "assets" + File.separator + "uploads";
                            File uploadDir = new File(uploadPath);
                            if (!uploadDir.exists()) {
                                uploadDir.mkdirs(); // Create the directory if it doesn't exist
                            }

                            File fileToSave = new File(uploadPath, uniqueFileName);
                            Files.copy(fileContent, fileToSave.toPath(), StandardCopyOption.REPLACE_EXISTING);

                            imageUrl = "assets/uploads/" + uniqueFileName;
                        }

                        // Create a Product object and update it
                        Product product = new Product();
                        product.setIDProduk(productId); // Set the product ID
                        product.loadProduct();
                        
                        product.setName(name);
                        product.setHarga(price);
                        product.setKuantitas(quantity);
                        product.setDeskripsi(description);
                        if (imageUrl != null) {
                            product.setImageURL(imageUrl); // Update image URL only if a new image is uploaded
                        } 
                        product.setPemilikProduk(seller);
                        seller.editProduk(product);
                    }
                    if (add == 1) {
                        int id = (int) homeSession.getAttribute("id");
                        Seller seller = new Seller();
                        seller.setUserId(id);
                        
                        String name = getPartValue(request.getPart("name"));
                        Double price = Double.valueOf(getPartValue(request.getPart("price")));
                        int quantity = Integer.parseInt(getPartValue(request.getPart("quantity")));
                        String description = getPartValue(request.getPart("description"));
                        Part photoPart = request.getPart("product-photo");
                        
                        //Pre-process the file uploaded
                        String fileName = photoPart.getSubmittedFileName(); // Get the original file name
                        String fileExtension = getFileExtension(fileName);
                        String uniqueFileName = UUID.randomUUID().toString() + fileExtension;
                        
                        InputStream fileContent = photoPart.getInputStream(); // Access the file content
//                        long fileSize = photoPart.getSize(); // Get the file size
                        String contentType = photoPart.getContentType();
                        if (!isImageContentType(contentType)) {
                            request.setAttribute("error", "invalid_file_type");
                            request.getRequestDispatcher("addProduct.jsp").forward(request, response);
                            return;
                        }
                        
                        // Save the file to the folder specified
                        String uploadPath = getServletContext().getRealPath("") + File.separator  + "assets" + File.separator + "uploads";
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs(); // Create the directory if it doesn't exist
                        }
                        
                        File fileToSave = new File(uploadPath, uniqueFileName);
                        Files.copy(fileContent, fileToSave.toPath(), StandardCopyOption.REPLACE_EXISTING);
                        
                        Product product = new Product();
                        product.setName(name);
                        product.setHarga(price);
                        product.setKuantitas(quantity);
                        product.setDeskripsi(description);
                        product.setImageURL("assets/uploads/" + uniqueFileName);
                        product.setPemilikProduk(seller);
                        seller.tambahProduk(product);
                    }
                }
                
                response.sendRedirect("home?p=profile");
            }
            if (menu.equals("payment")) {
                StringBuilder sb = new StringBuilder();
                String line;

                try (BufferedReader reader = request.getReader()) {
                    while ((line = reader.readLine()) != null) {
                        sb.append(line);
                    }
                }

                String requestBody = sb.toString();

                // Manually parse the JSON string
                String transactionId = null;
                int rating = 0;

                if (requestBody.contains("\"transactionId\":") && requestBody.contains("\"rating\":")) {
                    transactionId = requestBody.split("\"transactionId\":\"")[1].split("\"")[0];
                    String ratingString = requestBody.split("\"rating\":")[1].split("}")[0].trim();
                    rating = Integer.parseInt(ratingString.replaceAll("\"", "")); // Remove extra quotes, if any
                }
                
                String query = "UPDATE transactions SET rating = ? WHERE id = ?";
                JDBC jdbc = new JDBC("myreusehub");
                boolean success = false;

                try (Connection conn = jdbc.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setFloat(1, rating);
                    stmt.setString(2, transactionId);
                    int rowsAffected = stmt.executeUpdate();
                    success = rowsAffected > 0;
                } catch (SQLException e) {
                    e.printStackTrace();
                }

                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\":" + success + "}");
            }
        }
    }
    
    private boolean isImageContentType(String contentType) {
        // Allow only specific image types
        return contentType != null && (contentType.equals("image/jpeg") ||
                                       contentType.equals("image/png") ||
                                       contentType.equals("image/webp") ||
                                       contentType.equals("image/gif"));
    }
    
    private String getFileExtension(String fileName) {
        int dotIndex = fileName.lastIndexOf('.');
        return (dotIndex == -1) ? "" : fileName.substring(dotIndex); // Return extension, including the dot
    }
    
    private String getPartValue(Part part) throws IOException {
        if (part == null) return null;
        try (InputStream inputStream = part.getInputStream();
             Scanner scanner = new Scanner(inputStream, "UTF-8")) {
            return scanner.useDelimiter("\\A").hasNext() ? scanner.next() : null;
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
