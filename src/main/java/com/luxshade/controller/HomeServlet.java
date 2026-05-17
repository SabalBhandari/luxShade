package com.luxshade.controller;

import com.luxshade.model.Product;
import com.luxshade.service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Load latest 4 products for New Arrivals section
        List<Product> latestProducts = productService.getLatestProducts(4);
        request.setAttribute("latestProducts", latestProducts);

        request.getRequestDispatcher("/pages/user/home.jsp")
                .forward(request, response);
    }
}