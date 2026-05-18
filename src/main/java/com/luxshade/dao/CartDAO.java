package com.luxshade.dao;

import com.luxshade.model.Product;
import com.luxshade.util.DBUtil;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.List;

public class CartDAO {

    // Place order — inserts into orders and order_items tables
    public boolean placeOrder(int userId, Map<Integer, Integer> cartItems,
                              List<Product> products, double total) {
        String orderSql = "INSERT INTO orders (user_id, total_price, status) " +
                "VALUES (?, ?, 'pending')";
        String itemSql  = "INSERT INTO order_items (order_id, product_id, " +
                "quantity, unit_price) VALUES (?, ?, ?, ?)";
        String stockSql = "UPDATE products SET stock = stock - ? " +
                "WHERE product_id = ?";

        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false); // Transaction

            // Insert order
            PreparedStatement orderStmt = conn.prepareStatement(
                    orderSql, PreparedStatement.RETURN_GENERATED_KEYS);
            orderStmt.setInt(1, userId);
            orderStmt.setBigDecimal(2, BigDecimal.valueOf(total));
            orderStmt.executeUpdate();

            // Get generated order ID
            ResultSet rs = orderStmt.getGeneratedKeys();
            if (!rs.next()) {
                conn.rollback();
                return false;
            }
            int orderId = rs.getInt(1);

            // Insert order items and update stock
            PreparedStatement itemStmt  = conn.prepareStatement(itemSql);
            PreparedStatement stockStmt = conn.prepareStatement(stockSql);

            for (Product product : products) {
                int quantity = cartItems.get(product.getProductId());

                // Insert order item
                itemStmt.setInt(1, orderId);
                itemStmt.setInt(2, product.getProductId());
                itemStmt.setInt(3, quantity);
                itemStmt.setBigDecimal(4, product.getPrice());
                itemStmt.executeUpdate();

                // Update stock
                stockStmt.setInt(1, quantity);
                stockStmt.setInt(2, product.getProductId());
                stockStmt.executeUpdate();
            }

            conn.commit(); // Commit transaction
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
}