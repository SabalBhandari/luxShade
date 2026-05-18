package com.luxshade.controller;

import com.luxshade.model.Brand;
import com.luxshade.model.Category;
import com.luxshade.model.Product;
import com.luxshade.service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Comparator;
import java.util.List;

@WebServlet("/collections")
public class CollectionServlet extends HttpServlet {

    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get filter params
        String brandParam    = request.getParameter("brand");
        String categoryParam = request.getParameter("category");
        String sortParam     = request.getParameter("sort");

        // Load all products
        List<Product> products = productService.getAllProducts();

        // Filter by brand
        if (brandParam != null && !brandParam.isEmpty()) {
            try {
                int brandId = Integer.parseInt(brandParam);
                products.removeIf(p -> p.getBrandId() != brandId);
            } catch (NumberFormatException e) {
                // ignore
            }
        }

        // Filter by category
        if (categoryParam != null && !categoryParam.isEmpty()) {
            try {
                int categoryId = Integer.parseInt(categoryParam);
                products.removeIf(p -> p.getCategoryId() != categoryId);
            } catch (NumberFormatException e) {
                // ignore
            }
        }

        // Sort
        if ("price_asc".equals(sortParam)) {
            products.sort(Comparator.comparing(Product::getPrice));
        } else if ("price_desc".equals(sortParam)) {
            products.sort(Comparator.comparing(Product::getPrice).reversed());
        } else if ("name_asc".equals(sortParam)) {
            products.sort(Comparator.comparing(Product::getName));
        }

        // Load brands and categories for filters
        List<Brand>    brands     = productService.getAllBrands();
        List<Category> categories = productService.getAllCategories();

        request.setAttribute("products",   products);
        request.setAttribute("brands",     brands);
        request.setAttribute("categories", categories);
        request.setAttribute("totalCount", products.size());

        request.getRequestDispatcher("/pages/user/collections.jsp")
                .forward(request, response);
    }
}