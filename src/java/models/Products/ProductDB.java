package models.Products;

import java.util.List;

import java.sql.*;
import java.util.ArrayList;
import models.Users.Seller;
import utilities.JDBC;


public class ProductDB {

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
    
    public void loadProduct(Product product) {
        String query = "SELECT * FROM products WHERE id_produk = ?";
        JDBC jdbc = new JDBC("myreusehub");
        try (Connection conn = jdbc.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, product.getIDProduk());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Seller seller = new Seller();
                    seller.setUserId(rs.getInt("seller_id"));
                    product.setName(rs.getString("name"));
                    product.setDeskripsi(rs.getString("deskripsi"));
                    product.setImageURL(rs.getString("image_url"));
                    product.setHarga(rs.getDouble("harga"));
                    product.setKuantitas(rs.getInt("kuantitas"));
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
