package com.luxshade.dao;

import com.luxshade.model.Brand;
import com.luxshade.model.Category;
import com.luxshade.model.Product;
import com.luxshade.util.DBUtil;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    // ─── PRODUCT METHODS ───

    // Get all products with brand and category names
    public List<Product> getAllProducts() {
        String sql = "SELECT p.*, b.brand_name, c.category_name " +
                "FROM products p " +
                "LEFT JOIN brands b ON p.brand_id = b.brand_id " +
                "LEFT JOIN categories c ON p.category_id = c.category_id " +
                "ORDER BY p.created_at DESC";
        List<Product> products = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // Get products by brand
    public List<Product> getProductsByBrand(int brandId) {
        String sql = "SELECT p.*, b.brand_name, c.category_name " +
                "FROM products p " +
                "LEFT JOIN brands b ON p.brand_id = b.brand_id " +
                "LEFT JOIN categories c ON p.category_id = c.category_id " +
                "WHERE p.brand_id = ? " +
                "ORDER BY p.created_at DESC";
        List<Product> products = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, brandId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // Get products by category
    public List<Product> getProductsByCategory(int categoryId) {
        String sql = "SELECT p.*, b.brand_name, c.category_name " +
                "FROM products p " +
                "LEFT JOIN brands b ON p.brand_id = b.brand_id " +
                "LEFT JOIN categories c ON p.category_id = c.category_id " +
                "WHERE p.category_id = ? " +
                "ORDER BY p.created_at DESC";
        List<Product> products = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // Get product by ID
    public Product getProductById(int productId) {
        String sql = "SELECT p.*, b.brand_name, c.category_name " +
                "FROM products p " +
                "LEFT JOIN brands b ON p.brand_id = b.brand_id " +
                "LEFT JOIN categories c ON p.category_id = c.category_id " +
                "WHERE p.product_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapProduct(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Search products by name or SKU
    public List<Product> searchProducts(String keyword) {
        String sql = "SELECT p.*, b.brand_name, c.category_name " +
                "FROM products p " +
                "LEFT JOIN brands b ON p.brand_id = b.brand_id " +
                "LEFT JOIN categories c ON p.category_id = c.category_id " +
                "WHERE p.name LIKE ? OR p.sku LIKE ? " +
                "ORDER BY p.created_at DESC";
        List<Product> products = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            String search = "%" + keyword + "%";
            stmt.setString(1, search);
            stmt.setString(2, search);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // Add new product
    public boolean addProduct(Product product) {
        String sql = "INSERT INTO products (name, sku, description, price, stock, " +
                "category_id, brand_id, image) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getSku());
            stmt.setString(3, product.getDescription());
            stmt.setBigDecimal(4, product.getPrice());
            stmt.setInt(5, product.getStock());
            stmt.setInt(6, product.getCategoryId());
            stmt.setInt(7, product.getBrandId());
            stmt.setString(8, product.getImage());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update product
    public boolean updateProduct(Product product) {
        String sql = "UPDATE products SET name=?, sku=?, description=?, price=?, " +
                "stock=?, category_id=?, brand_id=?, image=? WHERE product_id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getSku());
            stmt.setString(3, product.getDescription());
            stmt.setBigDecimal(4, product.getPrice());
            stmt.setInt(5, product.getStock());
            stmt.setInt(6, product.getCategoryId());
            stmt.setInt(7, product.getBrandId());
            stmt.setString(8, product.getImage());
            stmt.setInt(9, product.getProductId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete product
    public boolean deleteProduct(int productId) {
        String sql = "DELETE FROM products WHERE product_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Check if SKU exists
    public boolean skuExists(String sku) {
        String sql = "SELECT product_id FROM products WHERE sku = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, sku);
            return stmt.executeQuery().next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Check if SKU exists for another product (for edit)
    public boolean skuExistsForOther(String sku, int productId) {
        String sql = "SELECT product_id FROM products WHERE sku = ? AND product_id != ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, sku);
            stmt.setInt(2, productId);
            return stmt.executeQuery().next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get latest products (for home page)
    public List<Product> getLatestProducts(int limit) {
        String sql = "SELECT p.*, b.brand_name, c.category_name " +
                "FROM products p " +
                "LEFT JOIN brands b ON p.brand_id = b.brand_id " +
                "LEFT JOIN categories c ON p.category_id = c.category_id " +
                "ORDER BY p.created_at DESC LIMIT ?";
        List<Product> products = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // ─── BRAND METHODS ───

    public List<Brand> getAllBrands() {
        String sql = "SELECT * FROM brands ORDER BY brand_name";
        List<Brand> brands = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Brand brand = new Brand();
                brand.setBrandId(rs.getInt("brand_id"));
                brand.setBrandName(rs.getString("brand_name"));
                brand.setDescription(rs.getString("description"));
                brands.add(brand);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return brands;
    }

    public boolean addBrand(Brand brand) {
        String sql = "INSERT INTO brands (brand_name, description) VALUES (?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, brand.getBrandName());
            stmt.setString(2, brand.getDescription());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteBrand(int brandId) {
        String sql = "DELETE FROM brands WHERE brand_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, brandId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ─── CATEGORY METHODS ───

    public List<Category> getAllCategories() {
        String sql = "SELECT * FROM categories ORDER BY category_name";
        List<Category> categories = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    public boolean addCategory(Category category) {
        String sql = "INSERT INTO categories (category_name, description) VALUES (?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, category.getCategoryName());
            stmt.setString(2, category.getDescription());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteCategory(int categoryId) {
        String sql = "DELETE FROM categories WHERE category_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ─── HELPER ───

    private Product mapProduct(ResultSet rs) throws SQLException {
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
        product.setCreatedAt(rs.getTimestamp("created_at"));
        product.setBrandName(rs.getString("brand_name"));
        product.setCategoryName(rs.getString("category_name"));
        return product;
    }
}