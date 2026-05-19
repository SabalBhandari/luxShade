package com.luxshade.dao;

import com.luxshade.model.Order;
import com.luxshade.model.OrderItem;
import com.luxshade.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.luxshade.model.Product;
import java.util.List;
import java.util.Map;
public class OrderDAO {

    // Get all orders for a user
    public List<Order> getOrdersByUser(int userId) {
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";
        List<Order> orders = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                orders.add(mapOrder(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Get order by ID
    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM orders WHERE order_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapOrder(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get order items for an order
    public List<OrderItem> getOrderItems(int orderId) {
        String sql = "SELECT oi.*, p.name, p.image, b.brand_name " +
                "FROM order_items oi " +
                "JOIN products p ON oi.product_id = p.product_id " +
                "LEFT JOIN brands b ON p.brand_id = b.brand_id " +
                "WHERE oi.order_id = ?";
        List<OrderItem> items = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setItemId(rs.getInt("item_id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setUnitPrice(rs.getBigDecimal("unit_price"));
                item.setProductName(rs.getString("name"));
                item.setProductImage(rs.getString("image"));
                item.setBrandName(rs.getString("brand_name"));
                items.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    // Get all orders (for admin)
    public List<Order> getAllOrders() {
        String sql = "SELECT o.*, u.name as user_name, u.email " +
                "FROM orders o " +
                "JOIN users u ON o.user_id = u.user_id " +
                "ORDER BY o.order_date DESC";
        List<Order> orders = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Order order = mapOrder(rs);
                order.setUserName(rs.getString("user_name"));
                order.setUserEmail(rs.getString("email"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Update order status
    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Cancel order and restore stock
    public boolean cancelOrder(int orderId) {
        String updateSql = "UPDATE orders SET status = 'cancelled' WHERE order_id = ?";
        String stockSql  = "UPDATE products SET stock = stock + ? WHERE product_id = ?";
        String itemsSql  = "SELECT * FROM order_items WHERE order_id = ?";

        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);

            // Get order items to restore stock
            PreparedStatement itemsStmt = conn.prepareStatement(itemsSql);
            itemsStmt.setInt(1, orderId);
            ResultSet rs = itemsStmt.executeQuery();

            PreparedStatement stockStmt = conn.prepareStatement(stockSql);
            while (rs.next()) {
                stockStmt.setInt(1, rs.getInt("quantity"));
                stockStmt.setInt(2, rs.getInt("product_id"));
                stockStmt.executeUpdate();
            }

            // Update order status
            PreparedStatement updateStmt = conn.prepareStatement(updateSql);
            updateStmt.setInt(1, orderId);
            updateStmt.executeUpdate();

            conn.commit();
            return true;

        } catch (SQLException e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.closeConnection(conn);
        }
    }

    // Helper
    private Order mapOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setOrderId(rs.getInt("order_id"));
        order.setUserId(rs.getInt("user_id"));
        order.setOrderDate(rs.getTimestamp("order_date"));
        order.setStatus(rs.getString("status"));
        order.setTotalPrice(rs.getBigDecimal("total_price"));
        return order;
    }

    public List<Order> getOrdersByStatus(String status) {
        String sql = "SELECT o.*, u.name as user_name, u.email " +
                "FROM orders o " +
                "JOIN users u ON o.user_id = u.user_id " +
                "WHERE o.status = ? " +
                "ORDER BY o.order_date DESC";
        List<Order> orders = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Order order = mapOrder(rs);
                order.setUserName(rs.getString("user_name"));
                order.setUserEmail(rs.getString("email"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Get total revenue
    public double getTotalRevenue() {
        String sql = "SELECT SUM(total_price) FROM orders WHERE status != 'cancelled'";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Get total orders count
    public int getTotalOrders() {
        String sql = "SELECT COUNT(*) FROM orders";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Get total deliveries
    public int getTotalDeliveries() {
        String sql = "SELECT COUNT(*) FROM orders WHERE status = 'delivered'";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Get average daily sales
    public double getAverageDailySales() {
        String sql = "SELECT AVG(daily_total) FROM (" +
                "SELECT DATE(order_date) as order_day, SUM(total_price) as daily_total " +
                "FROM orders WHERE status != 'cancelled' " +
                "GROUP BY DATE(order_date)) as daily_sales";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Get top selling products
    public List<Product> getTopSellingProducts(int limit) {
        String sql = "SELECT p.*, b.brand_name, c.category_name, " +
                "SUM(oi.quantity) as total_sold " +
                "FROM order_items oi " +
                "JOIN products p ON oi.product_id = p.product_id " +
                "LEFT JOIN brands b ON p.brand_id = b.brand_id " +
                "LEFT JOIN categories c ON p.category_id = c.category_id " +
                "GROUP BY p.product_id " +
                "ORDER BY total_sold DESC LIMIT ?";
        List<Product> products = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setSku(rs.getString("sku"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setStock(rs.getInt("stock"));
                product.setImage(rs.getString("image"));
                product.setBrandName(rs.getString("brand_name"));
                product.setCategoryName(rs.getString("category_name"));
                product.setTotalSold(rs.getInt("total_sold"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // Get daily sales for last 7 days
    public Map<String, Double> getDailySalesLast7Days() {
        String sql = "SELECT DATE(order_date) as order_day, " +
                "SUM(total_price) as daily_total " +
                "FROM orders WHERE status != 'cancelled' " +
                "AND order_date >= DATE_SUB(NOW(), INTERVAL 7 DAY) " +
                "GROUP BY DATE(order_date) " +
                "ORDER BY order_day ASC";
        Map<String, Double> dailySales = new java.util.LinkedHashMap<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                dailySales.put(rs.getString("order_day"),
                        rs.getDouble("daily_total"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dailySales;
    }
}