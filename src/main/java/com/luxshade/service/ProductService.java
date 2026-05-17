package com.luxshade.service;

import com.luxshade.dao.ProductDAO;
import com.luxshade.model.Brand;
import com.luxshade.model.Category;
import com.luxshade.model.Product;

import java.math.BigDecimal;
import java.util.List;

public class ProductService {

    private final ProductDAO productDAO = new ProductDAO();

    // ─── PRODUCT METHODS ───

    public List<Product> getAllProducts() {
        return productDAO.getAllProducts();
    }

    public List<Product> getProductsByBrand(int brandId) {
        return productDAO.getProductsByBrand(brandId);
    }

    public List<Product> getProductsByCategory(int categoryId) {
        return productDAO.getProductsByCategory(categoryId);
    }

    public Product getProductById(int productId) {
        return productDAO.getProductById(productId);
    }

    public List<Product> searchProducts(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllProducts();
        }
        return productDAO.searchProducts(keyword.trim());
    }

    public List<Product> getLatestProducts(int limit) {
        return productDAO.getLatestProducts(limit);
    }

    public String addProduct(String name, String sku, String description,
                             String price, String stock, String categoryId,
                             String brandId, String image) {
        // Validate name
        if (name == null || name.trim().isEmpty()) {
            return "Product name is required.";
        }

        // Validate SKU
        if (sku == null || sku.trim().isEmpty()) {
            return "SKU is required.";
        }

        // Check SKU uniqueness
        if (productDAO.skuExists(sku.trim())) {
            return "SKU already exists. Please use a unique SKU.";
        }

        // Validate price
        BigDecimal priceDecimal;
        try {
            priceDecimal = new BigDecimal(price);
            if (priceDecimal.compareTo(BigDecimal.ZERO) <= 0) {
                return "Price must be greater than zero.";
            }
        } catch (NumberFormatException e) {
            return "Invalid price format.";
        }

        // Validate stock
        int stockInt;
        try {
            stockInt = Integer.parseInt(stock);
            if (stockInt < 0) {
                return "Stock cannot be negative.";
            }
        } catch (NumberFormatException e) {
            return "Invalid stock format.";
        }

        // Validate category and brand
        int categoryIdInt;
        int brandIdInt;
        try {
            categoryIdInt = Integer.parseInt(categoryId);
            brandIdInt    = Integer.parseInt(brandId);
        } catch (NumberFormatException e) {
            return "Please select a valid category and brand.";
        }

        Product product = new Product(
                name.trim(), sku.trim(), description,
                priceDecimal, stockInt, categoryIdInt, brandIdInt, image
        );

        boolean success = productDAO.addProduct(product);
        return success ? "success" : "Failed to add product. Please try again.";
    }

    public String updateProduct(String productIdStr, String name, String sku,
                                String description, String price, String stock,
                                String categoryId, String brandId, String image) {
        // Validate name
        if (name == null || name.trim().isEmpty()) {
            return "Product name is required.";
        }

        // Validate SKU
        if (sku == null || sku.trim().isEmpty()) {
            return "SKU is required.";
        }

        // Parse product ID
        int productId;
        try {
            productId = Integer.parseInt(productIdStr);
        } catch (NumberFormatException e) {
            return "Invalid product ID.";
        }

        // Check SKU uniqueness for other products
        if (productDAO.skuExistsForOther(sku.trim(), productId)) {
            return "SKU already exists. Please use a unique SKU.";
        }

        // Validate price
        BigDecimal priceDecimal;
        try {
            priceDecimal = new BigDecimal(price);
            if (priceDecimal.compareTo(BigDecimal.ZERO) <= 0) {
                return "Price must be greater than zero.";
            }
        } catch (NumberFormatException e) {
            return "Invalid price format.";
        }

        // Validate stock
        int stockInt;
        try {
            stockInt = Integer.parseInt(stock);
            if (stockInt < 0) {
                return "Stock cannot be negative.";
            }
        } catch (NumberFormatException e) {
            return "Invalid stock format.";
        }

        // Validate category and brand
        int categoryIdInt;
        int brandIdInt;
        try {
            categoryIdInt = Integer.parseInt(categoryId);
            brandIdInt    = Integer.parseInt(brandId);
        } catch (NumberFormatException e) {
            return "Please select a valid category and brand.";
        }

        // Get existing product to keep image if not changed
        Product existing = productDAO.getProductById(productId);
        if (existing == null) {
            return "Product not found.";
        }

        // Use existing image if no new image uploaded
        String finalImage = (image != null && !image.isEmpty()) ? image : existing.getImage();

        Product product = new Product(
                name.trim(), sku.trim(), description,
                priceDecimal, stockInt, categoryIdInt, brandIdInt, finalImage
        );
        product.setProductId(productId);

        boolean success = productDAO.updateProduct(product);
        return success ? "success" : "Failed to update product. Please try again.";
    }

    public boolean deleteProduct(int productId) {
        return productDAO.deleteProduct(productId);
    }

    // ─── BRAND METHODS ───

    public List<Brand> getAllBrands() {
        return productDAO.getAllBrands();
    }

    public boolean addBrand(String brandName, String description) {
        if (brandName == null || brandName.trim().isEmpty()) {
            return false;
        }
        Brand brand = new Brand(brandName.trim(), description);
        return productDAO.addBrand(brand);
    }

    public boolean deleteBrand(int brandId) {
        return productDAO.deleteBrand(brandId);
    }

    // ─── CATEGORY METHODS ───

    public List<Category> getAllCategories() {
        return productDAO.getAllCategories();
    }

    public boolean addCategory(String categoryName, String description) {
        if (categoryName == null || categoryName.trim().isEmpty()) {
            return false;
        }
        Category category = new Category(categoryName.trim(), description);
        return productDAO.addCategory(category);
    }

    public boolean deleteCategory(int categoryId) {
        return productDAO.deleteCategory(categoryId);
    }
}