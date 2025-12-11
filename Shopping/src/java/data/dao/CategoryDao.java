/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package data.dao;

import java.util.List;
import model.Category;

/**
 *
 * @author HIEU PC
 */
public interface CategoryDao {
    public List<Category> findAll();
    public boolean insert(String name);
    public boolean update(int id, String name);
    public boolean delete(int id);
    public Category find(int id);
}
