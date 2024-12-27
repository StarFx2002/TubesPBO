/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utilities;

import java.sql.*;

public class JDBC {
    public static Connection con; 
    public static Statement stmt;
    public static PreparedStatement pstmt;
    public boolean isConnected; 
    public String message; 
    
    public JDBC(String databaseName) {
        try { 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection( "jdbc:mysql://localhost:3306/" + databaseName,"root",""); 
            pstmt = null;
            stmt = con.createStatement(); 
            isConnected = true; 
            message = "DB connected"; 
        } catch(Exception e) { 
            isConnected = false; 
            message = e.getMessage();
        } 
    }
    
    public Connection getConnection() {
        if (isConnected) {
            return this.con;
        }
        return null;
    }
    
    public void executeUpdate(String query) { 
        try { 
            int result = stmt.executeUpdate(query); 
            message = "info: " + result + " rows affected"; 
        } catch (Exception e) { 
            message = e.getMessage(); 
        } 
    }
    
    public ResultSet executeQuery(String query) { 
        ResultSet rs = null;
        try { 
            if (pstmt != null) {
                rs = pstmt.executeQuery();
            } else {
                rs = stmt.executeQuery(query);
            }
        } catch (Exception e) { 
            message = e.getMessage();
        } 
        return rs;
    }
    
    public void disconnect() {
        try { 
            stmt.close(); 
            con.close(); 
            message = "DB disconnected"; 
        } catch(Exception e) { 
            message = e.getMessage(); 
        } 
    }
}
