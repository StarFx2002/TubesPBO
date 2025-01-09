package models.Users;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.Products.Product;
import utilities.JDBC;

public class Seller extends User{
    private List<Product> listProduk = new ArrayList<>();
    
    public List<Product> listProduk() {
        String query = "SELECT * FROM products WHERE seller_id = ?";
        JDBC jdbc = new JDBC("myreusehub");

        try (Connection conn = jdbc.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            // Set the sellerId parameter
            stmt.setInt(1, this.getUserId());
            listProduk.clear();

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
                    product.setDeleted(rs.getBoolean("deleted"));
                    // Add product to the list
                    listProduk.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listProduk;
    }
    
    public void tambahProduk(Product produk) {
        JDBC jdbc = new JDBC("myreusehub");
        String query = "INSERT INTO products (name, description, image_url, price, quantity, seller_id) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = jdbc.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, produk.getName());
            stmt.setString(2, produk.getDeskripsi());
            stmt.setString(3, produk.getImageURL());
            stmt.setDouble(4, produk.getHarga());
            stmt.setInt(5, produk.getKuantitas());
            stmt.setInt(6, produk.getPemilikProduk().getUserId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void editProduk(Product produk) {
        JDBC jdbc = new JDBC("myreusehub");
        // Query to update the product details
        String query = "UPDATE products SET name = ?, description = ?, image_url = ?, price = ?, quantity = ? WHERE id = ? AND seller_id = ?";
        try (Connection conn = jdbc.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            // Set the new values for the product
            stmt.setString(1, produk.getName());
            stmt.setString(2, produk.getDeskripsi());
            stmt.setString(3, produk.getImageURL()); // Use the new image URL or existing one if not updated
            stmt.setDouble(4, produk.getHarga());
            stmt.setInt(5, produk.getKuantitas());
            stmt.setInt(6, produk.getIDProduk()); // The product ID to identify which product to update
            stmt.setInt(7, produk.getPemilikProduk().getUserId()); // Ensure that only the seller can update their product

            // Execute the update statement
            int rowsAffected = stmt.executeUpdate();

            // Return true if at least one row was updated
//            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
//        return false; // Return false if update failed
    }
    
    public void hapusProduk(Product produk) {
        String query = "UPDATE products SET deleted = true WHERE id = ?";
        JDBC jdbc = new JDBC("myreusehub");
        try (Connection conn = jdbc.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, produk.getIDProduk());
            int rowsAffected = stmt.executeUpdate();
            // return rowsAffected > 0; // Uncomment if you want to return a boolean
        } catch (SQLException e) {
            e.printStackTrace();
        }
//        return false;
    }
}
