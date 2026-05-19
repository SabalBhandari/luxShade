package com.luxshade.service;

import com.luxshade.dao.OrderDAO;
import com.luxshade.model.Order;
import com.luxshade.model.OrderItem;
import com.luxshade.model.Product;

import com.luxshade.model.Product;
import java.util.List;
import java.util.Map;

public class OrderService {

    private final OrderDAO orderDAO = new OrderDAO();

    public List<Order> getOrdersByUser(int userId) {
        return orderDAO.getOrdersByUser(userId);
    }

    public Order getOrderById(int orderId) {
        return orderDAO.getOrderById(orderId);
    }

    public List<OrderItem> getOrderItems(int orderId) {
        return orderDAO.getOrderItems(orderId);
    }

    public List<Order> getAllOrders() {
        return orderDAO.getAllOrders();
    }

    public boolean updateOrderStatus(int orderId, String status) {
        return orderDAO.updateOrderStatus(orderId, status);
    }

    public boolean cancelOrder(int orderId) {
        return orderDAO.cancelOrder(orderId);
    }

    public List<Order> getOrdersByStatus(String status) {
        return orderDAO.getOrdersByStatus(status);
    }

    public double getTotalRevenue() {
        return orderDAO.getTotalRevenue();
    }

    public int getTotalOrders() {
        return orderDAO.getTotalOrders();
    }

    public int getTotalDeliveries() {
        return orderDAO.getTotalDeliveries();
    }

    public double getAverageDailySales() {
        return orderDAO.getAverageDailySales();
    }

    public List<Product> getTopSellingProducts(int limit) {
        return orderDAO.getTopSellingProducts(limit);
    }

    public Map<String, Double> getDailySalesLast7Days() {
        return orderDAO.getDailySalesLast7Days();
    }


}