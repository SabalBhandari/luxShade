package com.luxshade.controller;

import com.luxshade.model.Order;
import com.luxshade.model.OrderItem;
import com.luxshade.service.OrderService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {

    private final OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        int userId = (int) session.getAttribute("userId");

        // Get all orders for user
        List<Order> orders = orderService.getOrdersByUser(userId);

        // Get items for each order
        Map<Integer, List<OrderItem>> orderItemsMap = new HashMap<>();
        for (Order order : orders) {
            List<OrderItem> items = orderService.getOrderItems(order.getOrderId());
            orderItemsMap.put(order.getOrderId(), items);
        }

        request.setAttribute("orders", orders);
        request.setAttribute("orderItemsMap", orderItemsMap);

        // Pass success message if redirected from checkout
        String orderSuccess = (String) session.getAttribute("orderSuccess");
        request.setAttribute("orderSuccess", orderSuccess);
        session.removeAttribute("orderSuccess");

        request.getRequestDispatcher("/pages/user/orders.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action   = request.getParameter("action");
        String orderIdStr = request.getParameter("orderId");
        HttpSession session = request.getSession(false);
        int userId = (int) session.getAttribute("userId");

        try {
            int orderId = Integer.parseInt(orderIdStr);

            // Verify order belongs to this user
            Order order = orderService.getOrderById(orderId);
            if (order == null || order.getUserId() != userId) {
                session.setAttribute("orderError", "Order not found.");
                response.sendRedirect(request.getContextPath() + "/orders");
                return;
            }

            if ("cancel".equals(action)) {
                if ("pending".equals(order.getStatus())) {
                    boolean success = orderService.cancelOrder(orderId);
                    if (success) {
                        session.setAttribute("orderSuccess",
                                "Order #" + orderId + " cancelled successfully.");
                    } else {
                        session.setAttribute("orderError",
                                "Failed to cancel order.");
                    }
                } else {
                    session.setAttribute("orderError",
                            "Only pending orders can be cancelled.");
                }
            }

        } catch (NumberFormatException e) {
            session.setAttribute("orderError", "Invalid order.");
        }

        response.sendRedirect(request.getContextPath() + "/orders");
    }
}