package com.luxshade.controller;

import com.luxshade.model.Product;
import com.luxshade.model.User;
import com.luxshade.service.WishlistService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {

    private final WishlistService wishlistService = new WishlistService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if ("add".equals(action)) {
            String productIdStr = request.getParameter("productId");
            try {
                int productId = Integer.parseInt(productIdStr);
                boolean success = wishlistService.addToWishlist(
                        user.getUserId(), productId);
                if (success) {
                    session.setAttribute("wishlistSuccess",
                            "Item added to wishlist!");
                } else {
                    session.setAttribute("wishlistSuccess",
                            "Item already in wishlist!");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("wishlistError", "Invalid product.");
            }
            String referer = request.getHeader("Referer");
            response.sendRedirect(referer != null ? referer :
                    request.getContextPath() + "/collections");

        } else if ("remove".equals(action)) {
            String productIdStr = request.getParameter("productId");
            try {
                int productId = Integer.parseInt(productIdStr);
                wishlistService.removeFromWishlist(user.getUserId(), productId);
            } catch (NumberFormatException e) {
                // ignore
            }
            response.sendRedirect(request.getContextPath() + "/wishlist");

        } else if ("moveToCart".equals(action)) {
            String productIdStr = request.getParameter("productId");
            try {
                int productId = Integer.parseInt(productIdStr);
                // Add to cart session
                com.luxshade.service.CartService cartService =
                        new com.luxshade.service.CartService();
                cartService.addToCart(session, productId);
                // Remove from wishlist
                wishlistService.removeFromWishlist(user.getUserId(), productId);
                session.setAttribute("wishlistSuccess",
                        "Item moved to cart!");
            } catch (NumberFormatException e) {
                session.setAttribute("wishlistError", "Invalid product.");
            }
            response.sendRedirect(request.getContextPath() + "/wishlist");

        } else {
            // View wishlist
            List<Product> wishlistProducts = wishlistService.getWishlistProducts(
                    user.getUserId());
            request.setAttribute("wishlistProducts", wishlistProducts);

            // Pass messages
            String wishlistSuccess = (String) session.getAttribute("wishlistSuccess");
            String wishlistError   = (String) session.getAttribute("wishlistError");
            request.setAttribute("wishlistSuccess", wishlistSuccess);
            request.setAttribute("wishlistError",   wishlistError);
            session.removeAttribute("wishlistSuccess");
            session.removeAttribute("wishlistError");

            request.getRequestDispatcher("/pages/user/wishlist.jsp")
                    .forward(request, response);
        }
    }
}