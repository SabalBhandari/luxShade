package com.luxshade.controller;

import com.luxshade.model.User;
import com.luxshade.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import com.luxshade.model.Order;
import com.luxshade.model.OrderItem;
import com.luxshade.service.OrderService;
import java.util.HashMap;
import java.util.Map;

@WebServlet(urlPatterns = {"/admin/dashboard", "/admin/users", "/admin/orders", "/admin/reports"})
public class AdminServlet extends HttpServlet {

    private final UserService userService   = new UserService();
    private final OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String uri = request.getRequestURI();

        // Clear session messages
        request.getSession().removeAttribute("success");
        request.getSession().removeAttribute("error");

        if (uri.endsWith("/admin/dashboard")) {
            List<User> pendingUsers = userService.getPendingUsers();
            request.setAttribute("pendingUsers",     pendingUsers);
            request.setAttribute("totalRevenue",     orderService.getTotalRevenue());
            request.setAttribute("totalOrders",      orderService.getTotalOrders());
            request.setAttribute("totalDeliveries",  orderService.getTotalDeliveries());
            request.setAttribute("topProducts",      orderService.getTopSellingProducts(3));
            request.setAttribute("avgDailySales",    orderService.getAverageDailySales());
            request.setAttribute("dailySales", orderService.getDailySalesLast7Days());
            request.getRequestDispatcher("/pages/Admin/Dashboard.jsp")
                    .forward(request, response);
        } else if (uri.endsWith("/admin/users")) {
            String status      = request.getParameter("status");
            List<User> allUsers;
            if (status != null && !status.isEmpty()) {
                allUsers = userService.getUsersByStatus(status);
            } else {
                allUsers = userService.getAllUsers();
            }
            request.setAttribute("allUsers",      allUsers);
            request.setAttribute("totalUsers",    userService.getAllUsers().size());
            request.setAttribute("approvedUsers", userService.getUsersByStatus("approved").size());
            request.setAttribute("pendingUsers",  userService.getUsersByStatus("pending").size());
            request.setAttribute("rejectedUsers", userService.getUsersByStatus("rejected").size());
            request.getRequestDispatcher("/pages/Admin/Users.jsp")
                    .forward(request, response);

        } else if (uri.endsWith("/admin/orders")) {
            // Load all orders
            String statusFilter = request.getParameter("status");
            List<Order> orders;

            if (statusFilter != null && !statusFilter.isEmpty()) {
                orders = orderService.getOrdersByStatus(statusFilter);
            } else {
                orders = orderService.getAllOrders();
            }

            // Load order items for each order
            Map<Integer, List<OrderItem>> orderItemsMap = new HashMap<>();
            for (Order order : orders) {
                List<OrderItem> items = orderService.getOrderItems(order.getOrderId());
                orderItemsMap.put(order.getOrderId(), items);
            }

            request.setAttribute("orders",        orders);
            request.setAttribute("orderItemsMap", orderItemsMap);
            request.setAttribute("totalOrders",   orderService.getAllOrders().size());
            request.setAttribute("pendingOrders", orderService.getOrdersByStatus("pending").size());
            request.setAttribute("shippedOrders", orderService.getOrdersByStatus("shipped").size());
            request.setAttribute("deliveredOrders", orderService.getOrdersByStatus("delivered").size());

            request.getRequestDispatcher("/pages/Admin/OrderManagement.jsp")
                    .forward(request, response);
        }
         else if (uri.endsWith("/admin/reports")) {
            request.getSession().removeAttribute("success");
            request.getSession().removeAttribute("error");

            // Stats
            request.setAttribute("totalRevenue",     orderService.getTotalRevenue());
            request.setAttribute("totalOrders",      orderService.getTotalOrders());
            request.setAttribute("totalDeliveries",  orderService.getTotalDeliveries());
            request.setAttribute("avgDailySales",    orderService.getAverageDailySales());
            request.setAttribute("topProducts",      orderService.getTopSellingProducts(5));
            request.setAttribute("dailySales",       orderService.getDailySalesLast7Days());
            request.setAttribute("totalUsers",       userService.getAllUsers().size());

            request.getRequestDispatcher("/pages/Admin/Report.jsp")
                    .forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String uri    = request.getRequestURI();
        String action = request.getParameter("action");

        if (uri.endsWith("/admin/dashboard")) {
            String userIdStr = request.getParameter("userId");
            int userId = Integer.parseInt(userIdStr);
            if ("approve".equals(action)) {
                userService.updateUserStatus(userId, "approved");
            } else if ("reject".equals(action)) {
                userService.updateUserStatus(userId, "rejected");
            }
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");

        } else if (uri.endsWith("/admin/users")) {
            String userIdStr = request.getParameter("userId");
            int userId = Integer.parseInt(userIdStr);
            if ("approve".equals(action)) {
                boolean success = userService.updateUserStatus(userId, "approved");
                request.getSession().setAttribute("success",
                        success ? "User approved." : "Failed to approve user.");
            } else if ("reject".equals(action)) {
                boolean success = userService.updateUserStatus(userId, "rejected");
                request.getSession().setAttribute("success",
                        success ? "User rejected." : "Failed to reject user.");
            } else if ("delete".equals(action)) {
                boolean success = userService.deleteUser(userId);
                request.getSession().setAttribute("success",
                        success ? "User deleted." : "Failed to delete user.");
            }
            response.sendRedirect(request.getContextPath() + "/admin/users");

        } else if (uri.endsWith("/admin/orders")) {
            String orderIdStr = request.getParameter("orderId");
            int orderId = Integer.parseInt(orderIdStr);
            if ("updateStatus".equals(action)) {
                String status = request.getParameter("status");
                boolean success = orderService.updateOrderStatus(orderId, status);
                request.getSession().setAttribute("success",
                        success ? "Order status updated." : "Failed to update status.");
            } else if ("cancel".equals(action)) {
                boolean success = orderService.cancelOrder(orderId);
                request.getSession().setAttribute("success",
                        success ? "Order cancelled." : "Failed to cancel order.");
            }
            response.sendRedirect(request.getContextPath() + "/admin/orders");
        }
    }
}