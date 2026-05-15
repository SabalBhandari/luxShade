package com.luxshade.filter;

import com.luxshade.model.User;
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

        HttpServletRequest httpRequest   = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        String uri = httpRequest.getRequestURI();
        String ctx = httpRequest.getContextPath();

        // Public pages — no login required
        boolean isPublic = uri.endsWith("login.jsp") ||
                uri.endsWith("register.jsp") ||
                uri.endsWith("landing.jsp") ||
                uri.endsWith("about.jsp") ||
                uri.endsWith("contact.jsp") ||
                uri.endsWith("/login") ||
                uri.endsWith("/register") ||
                uri.endsWith("/contact") ||
                uri.contains("/css/") ||
                uri.contains("/images/") ||
                uri.contains("/js/");

        HttpSession session  = httpRequest.getSession(false);
        User loggedInUser    = (session != null) ? (User) session.getAttribute("user") : null;
        boolean isLoggedIn   = (loggedInUser != null);

        // Redirect logged-in users away from login/register
        if (isLoggedIn && (uri.endsWith("login.jsp") || uri.endsWith("register.jsp"))) {
            if ("admin".equals(loggedInUser.getRole())) {
                httpResponse.sendRedirect(ctx + "/pages/admin/dashboard.jsp");
            } else {
                httpResponse.sendRedirect(ctx + "/pages/user/home.jsp");
            }
            return;
        }

        // Allow public pages through
        if (isPublic) {
            chain.doFilter(request, response);
            return;
        }

        // Block unauthenticated users
        if (!isLoggedIn) {
            httpResponse.sendRedirect(ctx + "/pages/user/login.jsp");
            return;
        }

        // Block regular users from accessing admin pages
        if (uri.contains("/admin/") && !"admin".equals(loggedInUser.getRole())) {
            httpResponse.sendRedirect(ctx + "/pages/error/403.jsp");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override public void init(FilterConfig filterConfig) throws ServletException {}
    @Override public void destroy() {}
}