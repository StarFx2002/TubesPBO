package models.Products;

import models.Users.Seller;



public class Product extends ProductDB{
    private int IDProduk;
    private String name;
    private String deskripsi;
    private String imageURL;
    private double harga;
    private int kuantitas;
    private Seller pemilikProduk;
    
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
    
    public void tambahProduk() {
        addProduct(this);
    }
    
    public void editProduk() {
        editProduct(this);
    }
    
    public void hapusProduk() {
        deleteProduct(IDProduk);
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
    
}

