package com.luxshade.service;

import com.luxshade.dao.WishlistDAO;
import com.luxshade.model.Product;

import java.util.List;

public class WishlistService {

    private final WishlistDAO wishlistDAO = new WishlistDAO();

    public boolean addToWishlist(int userId, int productId) {
        return wishlistDAO.addToWishlist(userId, productId);
    }

    public boolean removeFromWishlist(int userId, int productId) {
        return wishlistDAO.removeFromWishlist(userId, productId);
    }

    public boolean isInWishlist(int userId, int productId) {
        return wishlistDAO.isInWishlist(userId, productId);
    }

    public List<Product> getWishlistProducts(int userId) {
        return wishlistDAO.getWishlistProducts(userId);
    }
}