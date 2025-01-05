package models.Users;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.Products.Product;
import models.Transactions.Transaction;
import utilities.JDBC;

public class Buyer extends User{
    
    List<Transaction> listPembelian = new ArrayList<>();
    
    public List<Transaction> listPembelian() {
        String query = "SELECT * FROM transactions WHERE buyer_id = ?";
        JDBC jdbc = new JDBC("myreusehub");

        try (Connection conn = jdbc.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            // Set the sellerId parameter
            stmt.setInt(1, this.getUserId());
            listPembelian.clear();

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Product produk = new Product();
                    produk.setIDProduk(rs.getInt("product_id"));
                    produk.loadProduct();
                    
                    Buyer buyer = new Buyer();
                    buyer.setUserId(rs.getInt("buyer_id"));
                    buyer.loadUser();
                    
                    Transaction transaction = new Transaction(
                            rs.getInt("id"),
                            produk,
                            buyer,
                            rs.getInt("quantity"),
                            rs.getString("payment_method"),
                            rs.getString("address"),
                            rs.getFloat("rating")
                    );
                    listPembelian.add(transaction);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listPembelian;
        
    }
    
    public void beliProduk(Product produk, int kuantitas, String payment) {
        this.loadUser();
        Transaction newTransaction = new Transaction();
        newTransaction.setProduk(produk);
        newTransaction.setPembeli(this);
        newTransaction.setKuantitas(kuantitas);
        newTransaction.setMetodePembayaran(payment);
        newTransaction.setAlamat(this.getAddress());
        newTransaction.setRating(-1);
        Seller seller = produk.getPemilikProduk();
        seller.loadUser();
        produk.setKuantitas(produk.getKuantitas() - kuantitas);
        seller.editProduk(produk);
        newTransaction.simpanTransaksi();
    }
    
}
