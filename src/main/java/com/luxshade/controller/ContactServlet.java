import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String firstName = request.getParameter("firstName");
        String lastName  = request.getParameter("lastName");
        String email     = request.getParameter("email");
        String message   = request.getParameter("message");

        // validate, save to DB, send email, etc.

        request.setAttribute("successMsg", "Thank you " + firstName + "! We'll be in touch.");
        request.getRequestDispatcher("/pages/user/contact.jsp").forward(request, response);
    }
}