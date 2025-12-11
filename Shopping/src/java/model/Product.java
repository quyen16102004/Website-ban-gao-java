/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author HIEU PC
 */
public class Product {
    private int id;
    private String name;
    private String image;
    private double price;
    private int quantity;
    private boolean status;
    private int id_category;

    public Product(int id, String name, String image, double price, int quantity, boolean status, int id_category) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.price = price;
        this.quantity = quantity;
        this.status = status;
        this.id_category = id_category;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getImage() {
        return image;
    }

    public double getPrice() {
        return price;
    }

    public int getQuantity() {
        return quantity;
    }

    public boolean isStatus() {
        return status;
    }

    public int getId_category() {
        return id_category;
    }

    
}
