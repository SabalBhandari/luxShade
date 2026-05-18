package com.luxshade.controller;

import com.luxshade.model.Product;
import com.luxshade.service.CartService;
import com.luxshade.service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private final CartService cartService       = new CartService();
    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if ("add".equals(action)) {
            // Add to cart
            String productIdStr = request.getParameter("productId");
            try {
                int productId = Integer.parseInt(productIdStr);
                Product product = productService.getProductById(productId);
                if (product != null && product.getStock() > 0) {
                    cartService.addToCart(session, productId);
                    session.setAttribute("cartSuccess", "Item added to cart!");
                } else {
                    session.setAttribute("cartError", "Product is out of stock.");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("cartError", "Invalid product.");
            }
            // Redirect back to collections
            String referer = request.getHeader("Referer");
            response.sendRedirect(referer != null ? referer :
                    request.getContextPath() + "/collections");

        } else if ("remove".equals(action)) {
            // Remove from cart
            String productIdStr = request.getParameter("productId");
            try {
                int productId = Integer.parseInt(productIdStr);
                cartService.removeFromCart(session, productId);
            } catch (NumberFormatException e) {
                // ignore
            }
            response.sendRedirect(request.getContextPath() + "/cart");

        } else if ("clear".equals(action)) {
            // Clear cart
            cartService.clearCart(session);
            response.sendRedirect(request.getContextPath() + "/cart");

        } else {
            // View cart
            Map<Integer, Integer> cartItems = cartService.getCart(session);
            List<Product> cartProducts      = cartService.getCartProducts(cartItems);
            double total                    = cartService.getCartTotal(cartItems, cartProducts);

            request.setAttribute("cartProducts", cartProducts);
            request.setAttribute("cartItems",    cartItems);
            request.setAttribute("cartTotal",    total);

            // Clear messages
            String cartSuccess = (String) session.getAttribute("cartSuccess");
            String cartError   = (String) session.getAttribute("cartError");
            request.setAttribute("cartSuccess", cartSuccess);
            request.setAttribute("cartError",   cartError);
            session.removeAttribute("cartSuccess");
            session.removeAttribute("cartError");

            request.getRequestDispatcher("/pages/user/cart.jsp")
                    .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if ("update".equals(action)) {
            // Update quantity
            String productIdStr = request.getParameter("productId");
            String quantityStr  = request.getParameter("quantity");
            try {
                int productId = Integer.parseInt(productIdStr);
                int quantity  = Integer.parseInt(quantityStr);
                if (quantity <= 0) {
                    cartService.removeFromCart(session, productId);
                } else {
                    cartService.updateQuantity(session, productId, quantity);
                }
            } catch (NumberFormatException e) {
                // ignore
            }
            response.sendRedirect(request.getContextPath() + "/cart");

        } else if ("checkout".equals(action)) {
            // Place order directly
            Map<Integer, Integer> cartItems = cartService.getCart(session);
            if (cartItems.isEmpty()) {
                session.setAttribute("cartError", "Your cart is empty.");
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }

            int userId = (int) session.getAttribute("userId");
            boolean success = cartService.checkout(session, userId, cartItems);

            if (success) {
                cartService.clearCart(session);
                session.setAttribute("orderSuccess",
                        "Order placed successfully! Thank you for shopping with LuxShade.");
                response.sendRedirect(request.getContextPath() + "/orders");
            } else {
                session.setAttribute("cartError",
                        "Failed to place order. Please try again.");
                response.sendRedirect(request.getContextPath() + "/cart");
            }
        }
    }
}