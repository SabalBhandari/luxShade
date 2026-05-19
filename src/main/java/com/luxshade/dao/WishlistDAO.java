package com.luxshade.dao;

import com.luxshade.model.Product;
import com.luxshade.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WishlistDAO {

    // Add to wishlist
    public boolean addToWishlist(int userId, int productId) {
        // Check if already exists
        if (isInWishlist(userId, productId)) {
            return false;
        }
        String sql = "INSERT INTO wishlist (user_id, product_id) VALUES (?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Remove from wishlist
    public boolean removeFromWishlist(int userId, int productId) {
        String sql = "DELETE FROM wishlist WHERE user_id = ? AND product_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Check if product is in wishlist
    public boolean isInWishlist(int userId, int productId) {
        String sql = "SELECT wishlist_id FROM wishlist " +
                "WHERE user_id = ? AND product_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            return stmt.executeQuery().next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all wishlist products for a user
    public List<Product> getWishlistProducts(int userId) {
        String sql = "SELECT p.*, b.brand_name, c.category_name " +
                "FROM wishlist w " +
                "JOIN products p ON w.product_id = p.product_id " +
                "LEFT JOIN brands b ON p.brand_id = b.brand_id " +
                "LEFT JOIN categories c ON p.category_id = c.category_id " +
                "WHERE w.user_id = ? " +
                "ORDER BY w.added_at DESC";
        List<Product> products = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setSku(rs.getString("sku"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setStock(rs.getInt("stock"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setBrandId(rs.getInt("brand_id"));
                product.setImage(rs.getString("image"));
                product.setBrandName(rs.getString("brand_name"));
                product.setCategoryName(rs.getString("category_name"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
}