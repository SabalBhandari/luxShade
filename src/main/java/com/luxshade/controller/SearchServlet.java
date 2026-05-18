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

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("q");

        if (keyword != null && !keyword.trim().isEmpty()) {
            List<Product> results = productService.searchProducts(keyword.trim());
            request.setAttribute("results", results);
            request.setAttribute("keyword", keyword.trim());
        }

        request.getRequestDispatcher("/pages/user/search.jsp")
                .forward(request, response);
    }
}