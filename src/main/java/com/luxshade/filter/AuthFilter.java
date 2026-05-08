package com.luxshade.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String requestURI = httpRequest.getRequestURI();

        // Pages that don't need login
        boolean isPublicPage = requestURI.endsWith("login.jsp") ||
                requestURI.endsWith("register.jsp") ||
                requestURI.endsWith("/login") ||
                requestURI.endsWith("/register") ||
                requestURI.contains("/css/") ||
                requestURI.contains("/images/") ||
                requestURI.contains("/js/");

        // Check if user is logged in
        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);

        if (isPublicPage) {
            // If user is already logged in and tries to visit login/register
            // redirect them to landing page
            if (isLoggedIn && (requestURI.endsWith("login.jsp") ||
                    requestURI.endsWith("register.jsp"))) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/pages/user/landing.jsp");
                return;
            }
            chain.doFilter(request, response);

        } else if (isLoggedIn) {
            // User is logged in, allow access
            chain.doFilter(request, response);

        } else {
            // User is NOT logged in, redirect to login
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/pages/user/login.jsp");
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void destroy() {}
}