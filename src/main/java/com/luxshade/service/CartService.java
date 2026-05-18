package com.luxshade.service;

import com.luxshade.dao.CartDAO;
import com.luxshade.dao.ProductDAO;
import com.luxshade.model.Product;
import jakarta.servlet.http.HttpSession;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CartService {

    private final CartDAO     cartDAO     = new CartDAO();
    private final ProductDAO  productDAO  = new ProductDAO();

    // ─── SESSION CART ───

    @SuppressWarnings("unchecked")
    public Map<Integer, Integer> getCart(HttpSession session) {
        Map<Integer, Integer> cart =
                (Map<Integer, Integer>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    public void addToCart(HttpSession session, int productId) {
        Map<Integer, Integer> cart = getCart(session);
        cart.put(productId, cart.getOrDefault(productId, 0) + 1);
        session.setAttribute("cart", cart);
    }

    public void removeFromCart(HttpSession session, int productId) {
        Map<Integer, Integer> cart = getCart(session);
        cart.remove(productId);
        session.setAttribute("cart", cart);
    }

    public void updateQuantity(HttpSession session, int productId, int quantity) {
        Map<Integer, Integer> cart = getCart(session);
        cart.put(productId, quantity);
        session.setAttribute("cart", cart);
    }

    public void clearCart(HttpSession session) {
        session.removeAttribute("cart");
    }

    public int getCartCount(HttpSession session) {
        Map<Integer, Integer> cart = getCart(session);
        return cart.values().stream().mapToInt(Integer::intValue).sum();
    }

    // ─── GET PRODUCTS IN CART ───
    public List<Product> getCartProducts(Map<Integer, Integer> cartItems) {
        List<Product> products = new ArrayList<>();
        for (int productId : cartItems.keySet()) {
            Product product = productDAO.getProductById(productId);
            if (product != null) {
                products.add(product);
            }
        }
        return products;
    }

    // ─── CALCULATE TOTAL ───
    public double getCartTotal(Map<Integer, Integer> cartItems,
                               List<Product> products) {
        double total = 0;
        for (Product product : products) {
            int quantity = cartItems.getOrDefault(product.getProductId(), 0);
            total += product.getPrice().doubleValue() * quantity;
        }
        return total;
    }

    // ─── CHECKOUT ───
    public boolean checkout(HttpSession session, int userId,
                            Map<Integer, Integer> cartItems) {
        List<Product> products = getCartProducts(cartItems);
        double total = getCartTotal(cartItems, products);
        return cartDAO.placeOrder(userId, cartItems, products, total);
    }
}