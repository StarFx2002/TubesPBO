/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models.Transactions;

import models.Products.Product;
import models.Users.Buyer;
import utilities.JDBC;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class Transaction {
    
    private int IDTransaksi;
    private Product produk;
    private Buyer pembeli;
    private int kuantitas;
    private String metodePembayaran;
    private String alamat;
    private float rating;
    
    public Transaction() {
        
    }

    public Transaction(int IDTransaksi, Product produk, Buyer pembeli, int kuantitas, String metodePembayaran, String alamat, float rating) {
        this.IDTransaksi = IDTransaksi;
        this.produk = produk;
        this.pembeli = pembeli;
        this.kuantitas = kuantitas;
        this.metodePembayaran = metodePembayaran;
        this.alamat = alamat;
        this.rating = rating;
    }
    
    public List<Transaction> getAllTransactions() {
        List<Transaction> transactions = new ArrayList<>();
        String query = "SELECT * FROM transactions";
        JDBC jdbc = new JDBC("myreusehub");
        try (Connection conn = jdbc.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Buyer buyer = new Buyer();
                buyer.setUserId(rs.getInt("buyer_id"));
                buyer.loadUser();
                Product produk = new Product();
                produk.setIDProduk(rs.getInt("product_id"));
                produk.loadProduct();
                
                Transaction trans = new Transaction();
                trans.setIDTransaksi(rs.getInt("id"));
                trans.setProduk(produk);
                trans.setPembeli(buyer);
                trans.setKuantitas(rs.getInt("quantity"));
                trans.setMetodePembayaran(rs.getString("payment_method"));
                trans.setAlamat(rs.getString("address"));
                trans.setRating(rs.getFloat("rating"));
                transactions.add(trans);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return transactions;
    }
    
    public boolean simpanTransaksi() {
        JDBC jdbc = new JDBC("myreusehub");
        String query = "INSERT INTO transactions (product_id, buyer_id, quantity, payment_method, address, rating) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = jdbc.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, this.produk.getIDProduk()); 
            stmt.setInt(2, this.pembeli.getUserId()); 
            stmt.setInt(3, this.kuantitas);
            stmt.setString(4, this.metodePembayaran);
            stmt.setString(5, this.alamat);
            stmt.setFloat(6, this.rating);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return true;
    }

    public int getIDTransaksi() {
        return IDTransaksi;
    }

    public void setIDTransaksi(int IDTransaksi) {
        this.IDTransaksi = IDTransaksi;
    }

    public Product getProduk() {
        return produk;
    }

    public void setProduk(Product produk) {
        this.produk = produk;
    }

    public Buyer getPembeli() {
        return pembeli;
    }

    public void setPembeli(Buyer pembeli) {
        this.pembeli = pembeli;
    }

    public int getKuantitas() {
        return kuantitas;
    }

    public void setKuantitas(int kuantitas) {
        this.kuantitas = kuantitas;
    }

    public String getMetodePembayaran() {
        return metodePembayaran;
    }

    public void setMetodePembayaran(String metodePembayaran) {
        this.metodePembayaran = metodePembayaran;
    }

    public String getAlamat() {
        return alamat;
    }

    public void setAlamat(String alamat) {
        this.alamat = alamat;
    }

    public float getRating() {
        return rating;
    }

    public void setRating(float rating) {
        this.rating = rating;
    }
}
