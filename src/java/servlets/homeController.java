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
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.Scanner;
import java.util.UUID;
import models.Products.ProductDB;
import models.Products.Product;
import models.Users.Seller;

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
        
        if (menu != null) {
            if (menu.equals("payment")) {
                request.getRequestDispatcher("payment.jsp").forward(request, response);
                return;
            }
            if (menu.equals("profile")) {
                if (addR != null) {
                    int add = Integer.parseInt(addR);
                    if (add == 1) {
                        request.getRequestDispatcher("addProduct.jsp").forward(request, response);
                        return;
                    }
                }
                
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }
        }
        
        ProductDB prod = new ProductDB();
        List<Product> products = prod.getAllProducts();
        request.setAttribute("products", products);
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
        
        if (menu != null) {
            if (menu.equals("profile")) {
                if (addR != null) {
                    int add = Integer.parseInt(addR);
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
                        product.addProduct(product);
                        
                        request.getRequestDispatcher("profile.jsp").forward(request, response);
                        return;
                    }
                }
                
                request.getRequestDispatcher("profile.jsp").forward(request, response);
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
