package models.Products;

import java.util.List;

import java.sql.*;
import java.util.ArrayList;
import models.Users.Seller;
import utilities.JDBC;


public class ProductDB_unused {

    // Insert a new product into the database
    public void addProduct(Product product) {
        JDBC jdbc = new JDBC("myreusehub");
        String query = "INSERT INTO products (name, description, image_url, price, quantity, seller_id) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = jdbc.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDeskripsi());
            stmt.setString(3, product.getImageURL());
            stmt.setDouble(4, product.getHarga());
            stmt.setInt(5, product.getKuantitas());
            stmt.setInt(6, product.getPemilikProduk().getUserId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public boolean editProduct(Product product) {
        JDBC jdbc = new JDBC("myreusehub");
        // Query to update the product details
        String query = "UPDATE products SET name = ?, description = ?, image_url = ?, price = ?, quantity = ? WHERE id = ? AND seller_id = ?";
        try (Connection conn = jdbc.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            // Set the new values for the product
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDeskripsi());
            stmt.setString(3, product.getImageURL()); // Use the new image URL or existing one if not updated
            stmt.setDouble(4, product.getHarga());
            stmt.setInt(5, product.getKuantitas());
            stmt.setInt(6, product.getIDProduk()); // The product ID to identify which product to update
            stmt.setInt(7, product.getPemilikProduk().getUserId()); // Ensure that only the seller can update their product

            // Execute the update statement
            int rowsAffected = stmt.executeUpdate();

            // Return true if at least one row was updated
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Return false if update failed
    }

    // Retrieve all products from the database
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM products";
        JDBC jdbc = new JDBC("myreusehub");
        try (Connection conn = jdbc.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Seller seller = new Seller();
                seller.setUserId(rs.getInt("seller_id"));
                Product product = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("image_url"),
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        seller
                );
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    public List<Product> getProductsBySeller(int sellerId) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM products WHERE seller_id = ?";
        JDBC jdbc = new JDBC("myreusehub");

        try (Connection conn = jdbc.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            // Set the sellerId parameter
            stmt.setInt(1, sellerId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    // Create Seller object
                    Seller seller = new Seller();
                    seller.setUserId(rs.getInt("seller_id"));

                    // Create Product object
                    Product product = new Product(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("description"),
                            rs.getString("image_url"),
                            rs.getDouble("price"),
                            rs.getInt("quantity"),
                            seller
                    );
                    // Add product to the list
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }
    
    public boolean deleteProduct(int id) {
        String query = "DELETE FROM products WHERE id = ?";
        JDBC jdbc = new JDBC("myreusehub");
        try (Connection conn = jdbc.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Return true if a product was deleted
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public void loadProduct(Product product) {
        String query = "SELECT * FROM products WHERE id = ?";
        JDBC jdbc = new JDBC("myreusehub");
        try (Connection conn = jdbc.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, product.getIDProduk());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Seller seller = new Seller();
                    seller.setUserId(rs.getInt("seller_id"));
                    product.setName(rs.getString("name"));
                    product.setDeskripsi(rs.getString("description"));
                    product.setImageURL(rs.getString("image_url"));
                    product.setHarga(rs.getDouble("price"));
                    product.setKuantitas(rs.getInt("quantity"));
                    product.setPemilikProduk(seller);
                } else {
                    System.out.println("No product found!");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
