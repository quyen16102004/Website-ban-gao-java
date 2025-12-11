package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Cart;
import model.User;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String cartKey = "cart_" + user.getId();

        List<Cart> cartList = (List<Cart>) session.getAttribute(cartKey);
        if (cartList == null) {
            cartList = new ArrayList<>();
            session.setAttribute(cartKey, cartList);
        }

        String action = request.getParameter("action");

        if ("remove".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            cartList.removeIf(c -> c.getProduct().getId() == id);
            response.sendRedirect(request.getContextPath() + "/views/cart.jsp");
            return;
        }

        if ("updateQuantity".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String type = request.getParameter("type"); // increase / decrease

            for (Cart c : cartList) {
                if (c.getProduct().getId() == id) {
                    if ("increase".equals(type)) {
                        c.setQuantity(c.getQuantity() + 1);
                    } else if ("decrease".equals(type) && c.getQuantity() > 1) {
                        c.setQuantity(c.getQuantity() - 1);
                    }
                    break;
                }
            }

            response.sendRedirect(request.getContextPath() + "/views/cart.jsp");
            return;
        }

        request.getRequestDispatcher("/views/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String cartKey = "cart_" + user.getId();

        List<Cart> cartList = (List<Cart>) session.getAttribute(cartKey);
        if (cartList == null) {
            cartList = new ArrayList<>();
            session.setAttribute(cartKey, cartList);
        }

        String action = request.getParameter("action");
        if ("remove".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("id"));
            cartList.removeIf(c -> c.getProduct().getId() == productId);
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
