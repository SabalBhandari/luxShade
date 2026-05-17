package com.luxshade.controller;

import com.luxshade.model.Brand;
import com.luxshade.model.Category;
import com.luxshade.model.Product;
import com.luxshade.service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/inventory"})
@MultipartConfig
public class ProductServlet extends HttpServlet {

    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // Clear session messages
        request.getSession().removeAttribute("success");
        request.getSession().removeAttribute("error");

        if ("addForm".equals(action)) {
            // Forward to Add Product form
            loadBrandsAndCategories(request);
            request.getRequestDispatcher("/pages/Admin/AddProduct.jsp")
                    .forward(request, response);

        } else if ("editForm".equals(action)) {
            // Forward to Edit Product form
            String productIdStr = request.getParameter("id");
            try {
                int productId = Integer.parseInt(productIdStr);
                Product product = productService.getProductById(productId);
                if (product == null) {
                    request.getSession().setAttribute("error", "Product not found.");
                    response.sendRedirect(request.getContextPath() + "/admin/inventory");
                    return;
                }
                request.setAttribute("product", product);
                loadBrandsAndCategories(request);
                request.getRequestDispatcher("/pages/Admin/EditProduct.jsp")
                        .forward(request, response);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/inventory");
            }

        } else {
            // Load inventory page
            List<Brand> brands = productService.getAllBrands();
            request.setAttribute("brands", brands);

            // Filter by brand if selected
            String brandParam = request.getParameter("brand");
            List<Product> products;

            if (brandParam != null && !brandParam.isEmpty()) {
                try {
                    int brandId = Integer.parseInt(brandParam);
                    products = productService.getProductsByBrand(brandId);
                } catch (NumberFormatException e) {
                    products = productService.getAllProducts();
                }
            } else {
                products = productService.getAllProducts();
            }

            request.setAttribute("products", products);
            request.getRequestDispatcher("/pages/Admin/Inventory.jsp")
                    .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            handleAddProduct(request, response);

        } else if ("edit".equals(action)) {
            handleEditProduct(request, response);

        } else if ("delete".equals(action)) {
            handleDeleteProduct(request, response);
        }
    }

    // ─── ADD PRODUCT ───
    private void handleAddProduct(HttpServletRequest request,
                                  HttpServletResponse response)
            throws ServletException, IOException {

        String name        = request.getParameter("name");
        String sku         = request.getParameter("sku");
        String description = request.getParameter("description");
        String price       = request.getParameter("price");
        String stock       = request.getParameter("stock");
        String categoryId  = request.getParameter("categoryId");
        String brandId     = request.getParameter("brandId");

        // Handle image upload
        String imagePath = handleImageUpload(request);

        String result = productService.addProduct(
                name, sku, description, price, stock, categoryId, brandId, imagePath
        );

        if ("success".equals(result)) {
            request.getSession().setAttribute("success", "Product added successfully.");
            response.sendRedirect(request.getContextPath() + "/admin/inventory");
        } else {
            // Re-populate form on error
            request.setAttribute("error", result);
            request.setAttribute("name",        name);
            request.setAttribute("sku",         sku);
            request.setAttribute("description", description);
            request.setAttribute("price",       price);
            request.setAttribute("stock",       stock);
            request.setAttribute("categoryId",  categoryId);
            request.setAttribute("brandId",     brandId);
            loadBrandsAndCategories(request);
            request.getRequestDispatcher("/pages/Admin/AddProduct.jsp")
                    .forward(request, response);
        }
    }

    // ─── EDIT PRODUCT ───
    private void handleEditProduct(HttpServletRequest request,
                                   HttpServletResponse response)
            throws ServletException, IOException {

        String productId   = request.getParameter("productId");
        String name        = request.getParameter("name");
        String sku         = request.getParameter("sku");
        String description = request.getParameter("description");
        String price       = request.getParameter("price");
        String stock       = request.getParameter("stock");
        String categoryId  = request.getParameter("categoryId");
        String brandId     = request.getParameter("brandId");

        // Handle image upload — null if no new image uploaded
        String imagePath = handleImageUpload(request);

        String result = productService.updateProduct(
                productId, name, sku, description,
                price, stock, categoryId, brandId, imagePath
        );

        if ("success".equals(result)) {
            request.getSession().setAttribute("success", "Product updated successfully.");
            response.sendRedirect(request.getContextPath() + "/admin/inventory");
        } else {
            request.setAttribute("error", result);
            Product product = productService.getProductById(Integer.parseInt(productId));
            request.setAttribute("product", product);
            loadBrandsAndCategories(request);
            request.getRequestDispatcher("/pages/Admin/EditProduct.jsp")
                    .forward(request, response);
        }
    }

    // ─── DELETE PRODUCT ───
    private void handleDeleteProduct(HttpServletRequest request,
                                     HttpServletResponse response)
            throws IOException {

        String productIdStr = request.getParameter("productId");
        try {
            int productId = Integer.parseInt(productIdStr);
            boolean success = productService.deleteProduct(productId);
            if (success) {
                request.getSession().setAttribute("success", "Product deleted successfully.");
            } else {
                request.getSession().setAttribute("error", "Failed to delete product.");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Invalid product ID.");
        }
        response.sendRedirect(request.getContextPath() + "/admin/inventory");
    }

    // ─── HELPER: Handle Image Upload ───
    private String handleImageUpload(HttpServletRequest request)
            throws IOException, ServletException {
        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String uploadDir = getServletContext().getRealPath("/pages/images/products");
            File uploadFolder = new File(uploadDir);
            if (!uploadFolder.exists()) {
                uploadFolder.mkdirs();
            }
            String fileName = System.currentTimeMillis() + "_" +
                    filePart.getSubmittedFileName();
            filePart.write(uploadDir + File.separator + fileName);
            return "pages/images/products/" + fileName;
        }
        return null;
    }

    // ─── HELPER: Load Brands and Categories ───
    private void loadBrandsAndCategories(HttpServletRequest request) {
        List<Brand> brands         = productService.getAllBrands();
        List<Category> categories  = productService.getAllCategories();
        request.setAttribute("brands",     brands);
        request.setAttribute("categories", categories);
    }
}