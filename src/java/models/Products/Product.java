package models.Products;

import models.Users.Seller;
import utilities.JDBC;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;



public class Product {
    private int IDProduk;
    private String name;
    private String deskripsi;
    private String imageURL;
    private double harga;
    private int kuantitas;
    private Seller pemilikProduk;
    private boolean deleted;
    
    public Product() {}

    public Product(int IDProduk, String name, String deskripsi, String imageURL, double harga, int kuantitas, Seller pemilikProduk) {
        this.IDProduk = IDProduk;
        this.name = name;
        this.deskripsi = deskripsi;
        this.imageURL = imageURL;
        this.harga = harga;
        this.kuantitas = kuantitas;
        this.pemilikProduk = pemilikProduk;
    }
    
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
                product.setDeleted(rs.getBoolean("deleted"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    public void loadProduct() {
        String query = "SELECT * FROM products WHERE id = ?";
        JDBC jdbc = new JDBC("myreusehub");
        try (Connection conn = jdbc.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, this.getIDProduk());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Seller seller = new Seller();
                    seller.setUserId(rs.getInt("seller_id"));
                    this.setName(rs.getString("name"));
                    this.setDeskripsi(rs.getString("description"));
                    this.setImageURL(rs.getString("image_url"));
                    this.setHarga(rs.getDouble("price"));
                    this.setKuantitas(rs.getInt("quantity"));
                    this.setPemilikProduk(seller);
                    this.setDeleted(rs.getBoolean("deleted"));
                } else {
                    System.out.println("No product found!");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getIDProduk() {
        return IDProduk;
    }

    public void setIDProduk(int IDProduk) {
        this.IDProduk = IDProduk;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDeskripsi() {
        return deskripsi;
    }

    public void setDeskripsi(String deskripsi) {
        this.deskripsi = deskripsi;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public double getHarga() {
        return harga;
    }

    public void setHarga(double harga) {
        this.harga = harga;
    }

    public int getKuantitas() {
        return kuantitas;
    }

    public void setKuantitas(int kuantitas) {
        this.kuantitas = kuantitas;
    }

    public Seller getPemilikProduk() {
        return pemilikProduk;
    }

    public void setPemilikProduk(Seller pemilikProduk) {
        this.pemilikProduk = pemilikProduk;
    }

    public boolean getDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }
    
    
}

