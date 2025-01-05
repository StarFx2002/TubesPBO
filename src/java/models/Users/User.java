package models.Users;


import java.sql.*;
import utilities.JDBC;
import utilities.PasswordHash;


public class User extends UserDB{
    private int userId;
    protected String email;
    protected String username;
    protected String password;
    protected String phoneNumber;
    protected String address;

    public User() {
    }
    
    public User(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public User(String username, String password, String email, String phoneNumber, String address) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.address = address;
    }
    
    public boolean masukAkun() {
        return authorizeUser(username, password, this);
    }
    
    public boolean daftarAkun() {
        String query = "SELECT id FROM users WHERE name = ? OR email = ?";
        JDBC jdbc = new JDBC("myreusehub");
        int exists = -1;
        try (Connection conn = jdbc.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            stmt.setString(2, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) exists = rs.getInt("id"); // If a record exists, return true
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        if (exists > -1) {
            return false;
        }
        
        jdbc = new JDBC("myreusehub");
        query = "INSERT INTO users (email, name, password, phone_number, address) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = jdbc.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, this.getEmail());
            stmt.setString(2, this.getUsername());
            stmt.setString(3, PasswordHash.hashPassword(this.getPassword()));
            stmt.setString(4, this.getPhoneNumber());
            stmt.setString(5, this.getAddress());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return true;
    }
    
    public boolean hapusAkun() {
        return deleteUser(userId);
    }
    
    public void loadUser() {
        String query = "SELECT * FROM users WHERE id = ?";
        JDBC jdbc = new JDBC("myreusehub");
        try (Connection conn = jdbc.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, this.getUserId());
            try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                // Load data from the database into the User object
                this.setUsername(rs.getString("name"));
                this.setPassword(rs.getString("password"));
                this.setEmail(rs.getString("email"));
                this.setPhoneNumber(rs.getString("phone_number"));
                this.setAddress(rs.getString("address"));
            } else {
                System.out.println("No user found!");
            }
        }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    
    
}