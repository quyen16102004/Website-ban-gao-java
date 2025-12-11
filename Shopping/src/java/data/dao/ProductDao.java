/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package data.dao;
import com.sun.jdi.connect.spi.Connection;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import data.driver.MySQLDriver;
/**
 *
 * @author HIEU PC
 */
public interface ProductDao {
    public List<Product> findAll();
    public List<Product> searchProducts();
    Product getProductById(int id); 
    public boolean insert(Product p);
    public boolean update(Product p);
    public boolean delete(int id);

    
    /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

}
