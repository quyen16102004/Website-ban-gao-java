


/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.impl;

import data.dao.ProductDao;
import data.driver.MySQLDriver;
import java.util.List;
import model.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HIEU PC
 */
public class ProductImpl implements ProductDao {

   
    @Override
    public List<Product> findAll() {
        List<Product> listProduct = new ArrayList<>();
        String sql = "select * from products";
        try (Connection con = MySQLDriver.getConnection(); PreparedStatement sttm = con.prepareStatement(sql); ResultSet rs = sttm.executeQuery()) {
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String image = rs.getString("image");
                Double price = rs.getDouble("price");
                int quantity = rs.getInt("quantity");
                boolean status = rs.getBoolean("status");
                int id_category = rs.getInt("id_category");
                listProduct.add(new Product(id, name, image, price, quantity, status, id_category));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listProduct;
    }


    public List<Product> searchProducts(String keyword) {
        List<Product> listProduct = new ArrayList<>();
        if (keyword == null) {
            keyword = ""; 
        }
        String sql = "SELECT * FROM products WHERE name LIKE ?";

        try (Connection con = MySQLDriver.getConnection(); PreparedStatement sttm = con.prepareStatement(sql)) {
            sttm.setString(1, "%" + keyword + "%"); 
            try (ResultSet rs = sttm.executeQuery()) {
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String image = rs.getString("image");
                    double price = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
                    boolean status = rs.getBoolean("status");
                    int id_category = rs.getInt("id_category");

                    listProduct.add(new Product(id, name, image, price, quantity, status, id_category));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listProduct;
    }

    @Override
    public Product getProductById(int id) {
        Product product = null;
        String sql = "SELECT * FROM products WHERE id = ?";
        try (Connection con = MySQLDriver.getConnection(); PreparedStatement sttm = con.prepareStatement(sql)) {

            sttm.setInt(1, id);
            try (ResultSet rs = sttm.executeQuery()) {
                if (rs.next()) {
                    product = new Product(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("image"),
                            rs.getDouble("price"),
                            rs.getInt("quantity"),
                            rs.getBoolean("status"),
                            rs.getInt("id_category")
                    );
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return product;
    }

    

    @Override
    public List<Product> searchProducts() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    // thêm sản phẩm
    @Override
    public boolean insert(Product p) {
        String sql = "INSERT INTO products(name, image, price, quantity, status, id_category) VALUES(?,?,?,?,?,?)";
        try (Connection conn = MySQLDriver.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getName());
            ps.setString(2, p.getImage());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getQuantity());
            ps.setBoolean(5, p.isStatus());
            ps.setInt(6, p.getId_category());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
    // 
    @Override
    public boolean update(Product p) {
        String sql = "UPDATE products SET name=?, image=?, price=?, quantity=?, status=?, id_category=? WHERE id=?";
        try (Connection conn = MySQLDriver.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getName());
            ps.setString(2, p.getImage());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getQuantity());
            ps.setBoolean(5, p.isStatus());
            ps.setInt(6, p.getId_category());
            ps.setInt(7, p.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM products WHERE id=?";
        try (Connection conn = MySQLDriver.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
