package models.Users;

import java.sql.*;
import utilities.JDBC;
import utilities.PasswordHash;


public class UserDB {
    private int isUserExists(String username, String email) {
        String query = "SELECT id FROM users WHERE name = ? OR email = ?";
        JDBC jdbc = new JDBC("myreusehub");
        try (Connection conn = jdbc.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            stmt.setString(2, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return rs.getInt("id"); // If a record exists, return true
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public boolean addUser(User user) {
        if (isUserExists(user.getUsername(), user.getEmail()) > -1) {
            return false;
        }
        
        JDBC jdbc = new JDBC("myreusehub");
        String query = "INSERT INTO users (email, name, password, phone_number, address) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = jdbc.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getUsername());
            stmt.setString(3, PasswordHash.hashPassword(user.getPassword()));
            stmt.setString(4, user.getPhoneNumber());
            stmt.setString(5, user.getAddress());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return true;
    }
    
    public boolean deleteUser(int id) {
        String query = "DELETE FROM users WHERE id = ?";
        JDBC jdbc = new JDBC("myreusehub");
        try (Connection conn = jdbc.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Return true if a user was deleted
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean authorizeUser(String usernameORemail, String password, User user) {
        int id = isUserExists(usernameORemail, password);
        if (id < 0) {
            return false;
        }
        
        String query = "SELECT password FROM users WHERE id = ?";
        JDBC jdbc = new JDBC("myreusehub");
        try (Connection conn = jdbc.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    user.setUserId(id);
                    String storedPasswordHash = rs.getString("password");
                    return storedPasswordHash.equals(PasswordHash.hashPassword(password)); // Compare hashes
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
}
